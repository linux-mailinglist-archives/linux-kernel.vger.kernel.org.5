Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38C179F374
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjIMVIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjIMVI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:08:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D621BCA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 14:08:24 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694639302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8uMLW91YWZxr+LdoYhxEN1bJONyrj8yRppLVn3LNdRs=;
        b=EPjM9koD5IVGcK3TzNImfOwSEignNr3wXBbM/1mx0oXc/AMHbsM/V2jLbcfphOPtpLpDLW
        1OD0KY1/fBggLYeqonFD+sR/NX+1ej91c36l7x3WSri5ausglyPksuR3oVcNvNenVs7NTV
        hjKX+EquMjD1rpvvm5cRtmaXLH0rno25T2zqL2RbzrJReQCC24QO1vvoc0nkoSVIqGBJAA
        SKDNHwJUtuRN/W/xQXSQfb/78CxPXQy6pfSGLbV25z3tDvzxPFIeySMuLRQByJX2VNkyR9
        tD19jKXw5lgOFxBR6W00sv01n4Eu1qH9I8lEYLsBrW2cqNTdiWCISZpal8TU7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694639302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8uMLW91YWZxr+LdoYhxEN1bJONyrj8yRppLVn3LNdRs=;
        b=cvDKVSXEA5FFfnPE0Vg0fwwrSkqItU48RBEeJ+xGGNWPJHVyPXRNnEBwFilAPX4zKvMUq1
        Ty4mcKmEqV9H2uAw==
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Maira Canal <mairacanal@riseup.net>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        DRI <dri-devel@lists.freedesktop.org>,
        syzkaller@googlegroups.com, LKML <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Sanan Hasanov <Sanan.Hasanov@ucf.edu>
Subject: Re: drm/vkms: deadlock between dev->event_lock and timer
In-Reply-To: <CAHk-=wgb9ccWN3Nks5STYUDqQUeHZdCLsK4kA37SdDJuGZfukg@mail.gmail.com>
References: <20230913110709.6684-1-hdanton@sina.com>
 <99d99007-8385-31df-a659-665bf50193bc@I-love.SAKURA.ne.jp>
 <CAHk-=wgb9ccWN3Nks5STYUDqQUeHZdCLsK4kA37SdDJuGZfukg@mail.gmail.com>
Date:   Wed, 13 Sep 2023 23:08:21 +0200
Message-ID: <87pm2lzsqi.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13 2023 at 09:47, Linus Torvalds wrote:
> On Wed, 13 Sept 2023 at 07:21, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> Hello. A deadlock was reported in drivers/gpu/drm/vkms/ .
>> It looks like this locking pattern remains as of 6.6-rc1. Please fix.
>>
>> void drm_crtc_vblank_off(struct drm_crtc *crtc) {
>>   spin_lock_irq(&dev->event_lock);
>>   drm_vblank_disable_and_save(dev, pipe) {
>>     __disable_vblank(dev, pipe) {
>>       crtc->funcs->disable_vblank(crtc) == vkms_disable_vblank {
>>         hrtimer_cancel(&out->vblank_hrtimer) { // Retries with dev->event_lock held until lock_hrtimer_base() succeeds.
>>           ret = hrtimer_try_to_cancel(timer) {
>>             base = lock_hrtimer_base(timer, &flags); // Fails forever because vkms_vblank_simulate() is in progress.
>
> Heh. Ok. This is clearly a bug, but it does seem to be limited to just
> the vkms driver, and literally only to the "simulate vblank" case.
>
> The worst part about it is that it's so subtle and not obvious.
>
> Some light grepping seems to show that amdgpu has almost the exact
> same pattern in its own vkms thing, except it uses
>
>         hrtimer_try_to_cancel(&amdgpu_crtc->vblank_timer);
>
> directly, which presumably fixes the livelock, but means that the
> cancel will fail if it's currently running.
>
> So just doing the same thing in the vkms driver probably fixes things.
>
> Maybe the vkms people need to add a flag to say "it's canceled" so
> that it doesn't then get re-enabled?  Or maybe it doesn't matter
> and/or already happens for some reason I didn't look into.

Maybe the VKMS people need to understand locking in the first place. The
first thing I saw in this code is:

static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
{
   ...
   mutex_unlock(&output->enabled_lock);

What?

Unlocking a mutex in the context of a hrtimer callback is simply
violating all mutex locking rules.

How has this code ever survived lock debugging without triggering a big
fat warning?

Thanks,

        tglx
