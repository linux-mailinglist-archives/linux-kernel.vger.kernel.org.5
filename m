Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE24A79FC0E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 08:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbjINGdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 02:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjINGdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 02:33:49 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A44C1BB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 23:33:45 -0700 (PDT)
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 38E6Xhrr082763;
        Thu, 14 Sep 2023 15:33:43 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Thu, 14 Sep 2023 15:33:43 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 38E6XhTd082760
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 14 Sep 2023 15:33:43 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <167ee2ad-6a7e-876c-f5c9-f0a227070a78@I-love.SAKURA.ne.jp>
Date:   Thu, 14 Sep 2023 15:33:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: drm/vkms: deadlock between dev->event_lock and timer
Content-Language: en-US
To:     Maira Canal <mairacanal@riseup.net>,
        Arthur Grillo <arthurgrillo@riseup.net>
Cc:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
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
References: <20230913110709.6684-1-hdanton@sina.com>
 <99d99007-8385-31df-a659-665bf50193bc@I-love.SAKURA.ne.jp>
 <CAHk-=wgb9ccWN3Nks5STYUDqQUeHZdCLsK4kA37SdDJuGZfukg@mail.gmail.com>
 <87pm2lzsqi.ffs@tglx>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <87pm2lzsqi.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/09/14 6:08, Thomas Gleixner wrote:
> Maybe the VKMS people need to understand locking in the first place. The
> first thing I saw in this code is:
> 
> static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
> {
>    ...
>    mutex_unlock(&output->enabled_lock);
> 
> What?
> 
> Unlocking a mutex in the context of a hrtimer callback is simply
> violating all mutex locking rules.
> 
> How has this code ever survived lock debugging without triggering a big
> fat warning?

Commit a0e6a017ab56936c ("drm/vkms: Fix race-condition between the hrtimer
and the atomic commit") in 6.6-rc1 replaced spinlock with mutex. So we haven't
tested with the lock debugging yet...

Maíra and Arthur, mutex_unlock() from interrupt context is not permitted.
Please revert that patch immediately.
I guess that a semaphore (down()/up()) could be used instead of a mutex.

