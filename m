Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E17379EB1F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241134AbjIMOay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239984AbjIMOax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:30:53 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043A692
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:30:48 -0700 (PDT)
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 38DEUPHH067887;
        Wed, 13 Sep 2023 23:30:25 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Wed, 13 Sep 2023 23:30:25 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 38DEUOWw067884
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 13 Sep 2023 23:30:25 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <15f8fbd8-2dbc-3df7-c748-c76e3479e227@I-love.SAKURA.ne.jp>
Date:   Wed, 13 Sep 2023 23:30:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: BUG: soft lockup in smp_call_function
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>,
        Sanan Hasanov <Sanan.Hasanov@ucf.edu>,
        Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        syzkaller@googlegroups.com, LKML <linux-kernel@vger.kernel.org>
References: <20230913110709.6684-1-hdanton@sina.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20230913110709.6684-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/09/13 20:07, Hillf Danton wrote:
> 
> 	cpu1			cpu4 (see below)
> 	====			====
> 	drm_crtc_vblank_off	__run_hrtimer
> 	spin_lock_irq(&dev->event_lock);
> 	...
> 				drm_handle_vblank
> 	hrtimer_cancel		spin_lock_irqsave(&dev->event_lock, irqflags);
> 
> 
> Deadlock should have been reported instead provided the lockdep_map in
> struct timer_list were added also to hrtimer, so it is highly appreciated
> if Tetsuo or Thomas adds it before 6.8 or 6.10.

Not me. ;-)

Since hrtimer_cancel() retries forever until lock_hrtimer_base() succeeds,
we want to add a lockdep annotation into hrtimer_cancel() so that we can
detect this type of deadlock?

