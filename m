Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B94179FDF5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbjINIMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235932AbjINIMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:12:45 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36501FC2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:12:40 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31c49de7a41so81635f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1694679159; x=1695283959; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HHw2XsNcRlVELEAxaY2CyeaC60IpexjAe/+ZJCzphyI=;
        b=gulYvIXFEHMvkEhlHb9YrUPkDsCy5R386ftjtWXwnjm1vJv077QHAjcCU7VMWM1i2d
         v2O7wRvHgJeSqQDpT6xRgZqfOhzKS8Z4iKAFDZRjEgqZfG8ncenYIlDaleJGjlS5Fy26
         H/qVFHhE3Y49Fux6mMjcbBGVTDBcjxT7zOKdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694679159; x=1695283959;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHw2XsNcRlVELEAxaY2CyeaC60IpexjAe/+ZJCzphyI=;
        b=YoANk2Fi7pLNiJ6i3mLN4HSz4d7qbrBT5BB0zJgecRAxy7JmXtaCPRT0Bc969qX84e
         aTe2dV+7g4XcSYzBnWGj8tF+NivWf5pfCEoMIzXcCP5DoCY4GQwWMGz5xKqfqEoVOWrr
         MCAJmNo+arqOtzS5D7d/hmsl2k65U+wzAAeEW09B7vn6BC+yu/rK483L+Ub9DCWpXuKW
         shoG3F/jRmgwokfcjDAL7ulF/pKyAUX5A29qOZcu5i4EmK4gQhv/M7llSgH+0985mt6U
         WG2EMRLetoGpG8UvSUw66nE10MSSetKjpRBSkk380CwYJO3zQBmibwEvUSVg0Ombg8pY
         UzOQ==
X-Gm-Message-State: AOJu0YxLqt0PGV8+giqfacqfcDMxAGx8diUpez7+jG8cRyI0DxJ+0m3r
        GdnZGDm1KKZRUL5XOsCAkkj5hA==
X-Google-Smtp-Source: AGHT+IHN2a6TwrIOVLfCi68jJ9geuUGpqTwLp+ol8pEIkVlcXlsuXbwKUZUyXrF/UalV/WH2tI9/7g==
X-Received: by 2002:adf:fd4d:0:b0:317:3a23:4855 with SMTP id h13-20020adffd4d000000b003173a234855mr4119411wrs.2.1694679158926;
        Thu, 14 Sep 2023 01:12:38 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id k3-20020a056000004300b0031fba0a746bsm1071942wrx.9.2023.09.14.01.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 01:12:37 -0700 (PDT)
Date:   Thu, 14 Sep 2023 10:12:35 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Maira Canal <mairacanal@riseup.net>,
        Arthur Grillo <arthurgrillo@riseup.net>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        DRI <dri-devel@lists.freedesktop.org>,
        syzkaller@googlegroups.com, LKML <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Sanan Hasanov <Sanan.Hasanov@ucf.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: drm/vkms: deadlock between dev->event_lock and timer
Message-ID: <ZQLAc/Fwkv/GiVoK@phenom.ffwll.local>
Mail-Followup-To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Maira Canal <mairacanal@riseup.net>,
        Arthur Grillo <arthurgrillo@riseup.net>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@gmail.com>,
        DRI <dri-devel@lists.freedesktop.org>, syzkaller@googlegroups.com,
        LKML <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Sanan Hasanov <Sanan.Hasanov@ucf.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20230913110709.6684-1-hdanton@sina.com>
 <99d99007-8385-31df-a659-665bf50193bc@I-love.SAKURA.ne.jp>
 <CAHk-=wgb9ccWN3Nks5STYUDqQUeHZdCLsK4kA37SdDJuGZfukg@mail.gmail.com>
 <87pm2lzsqi.ffs@tglx>
 <167ee2ad-6a7e-876c-f5c9-f0a227070a78@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <167ee2ad-6a7e-876c-f5c9-f0a227070a78@I-love.SAKURA.ne.jp>
X-Operating-System: Linux phenom 6.4.0-3-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 03:33:41PM +0900, Tetsuo Handa wrote:
> On 2023/09/14 6:08, Thomas Gleixner wrote:
> > Maybe the VKMS people need to understand locking in the first place. The
> > first thing I saw in this code is:
> > 
> > static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
> > {
> >    ...
> >    mutex_unlock(&output->enabled_lock);
> > 
> > What?
> > 
> > Unlocking a mutex in the context of a hrtimer callback is simply
> > violating all mutex locking rules.
> > 
> > How has this code ever survived lock debugging without triggering a big
> > fat warning?
> 
> Commit a0e6a017ab56936c ("drm/vkms: Fix race-condition between the hrtimer
> and the atomic commit") in 6.6-rc1 replaced spinlock with mutex. So we haven't
> tested with the lock debugging yet...

Yeah that needs an immediate revert, there's not much that looks legit in
that patch. I'll chat with Maira.

Also yes how that landed without anyone running lockdep is ... not good. I
guess we need a lockdep enabled drm ci target that runs vkms tests asap
:-)

> Maíra and Arthur, mutex_unlock() from interrupt context is not permitted.
> Please revert that patch immediately.
> I guess that a semaphore (down()/up()) could be used instead of a mutex.

From a quick look this smells like a classic "try to use locking when you
want synchronization primitives", so semaphore here doesn't look any
better. The vkms_set_composer() function was originally for crc
generation, where it's userspace's job to make sure they wait for all the
crc they need to be generated before they shut it down again. But for
writeback the kernel must guarantee that the compositiona actually
happens, and the current function just doesn't make any such guarantees.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
