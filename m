Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847BF7E1488
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 17:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjKEQUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 11:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKEQUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 11:20:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5035AB0
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 08:20:31 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699201229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z5eEBnZ6LYm33J79aFU74zLjTZnhFR3gFJP08bWpn8Y=;
        b=xSOdyJWyVN7WPL5tfjWaqyK+9g0IpqvSn9syIFzh2WAPqVQjgiUeNDdi3VC6MWeM4ABQxr
        Xaja8dZ3ySwZM4YVfzuNe2CQOprIvhVbuUJ2EagEu5JTwRCBCLDVehFAbdwrhVgAu3EtSv
        zlRsdtZTvcyNfoDDdshyhk72mymUC0M3bOnP1Hr1KH7hecj1I4fMM4xB7GQLCo67eCCqMQ
        Fr/jEVwzf3oNKUHRCG/QwV8U2I9XGHjQgWBLiagaKksYCZZdroORF3W4RKUCGQ9ONK7Tye
        i1LXDWnAd3ccEr/EpdYKS4ofONCFNGFb1fOALDMMUqddWsAfSZXORczcDLhaVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699201229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z5eEBnZ6LYm33J79aFU74zLjTZnhFR3gFJP08bWpn8Y=;
        b=vY8q1GI0MAqGQtRYNyKxeY7uC/J//hj7j5uHQJ2p1LFp1Eh+0SgmVX08/QDGFDiT979ml8
        dUgZdSyBnqDAG8Bg==
To:     Ben Greear <greearb@candelatech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Rodolfo Giometti <giometti@enneenne.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH/RFC] debugobjects/slub: Print slab info and backtrace.
In-Reply-To: <92a422d6-76c8-ce25-c331-0718b73dd274@candelatech.com>
References: <20231103013704.1232723-1-greearb@candelatech.com>
 <92a422d6-76c8-ce25-c331-0718b73dd274@candelatech.com>
Date:   Sun, 05 Nov 2023 17:20:28 +0100
Message-ID: <875y2gi33n.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02 2023 at 18:49, Ben Greear wrote:
> And here is resulting splat from wireless-next tree I've been
> debugging.
>
> Note the subsequent splats from slub are due to some memory poisoning, for
> one reason or another.  Maybe slub changes should not be included in this patch, not
> sure if it can provide useful info in other cases though.
>
> If I understand this correctly, then it appears the bug is related to
> the pps driver.
>
> 16140 Nov 02 17:28:25 ct523c-2103 kernel: ODEBUG: debugobjects: debug_obj allocated at:
> 16141 Nov 02 17:28:25 ct523c-2103 kernel:  init_timer_key+0x24/0x160
> 16142 Nov 02 17:28:25 ct523c-2103 kernel:  kobject_put+0x14f/0x190
> 16143 Nov 02 17:28:25 ct523c-2103 kernel:  pps_device_destruct+0x26/0xb0
> 16144 Nov 02 17:28:25 ct523c-2103 kernel:  device_release+0x57/0x100
> 16145 Nov 02 17:28:25 ct523c-2103 kernel:  kobject_delayed_cleanup+0xdf/0x140
> 16146 Nov 02 17:28:25 ct523c-2103 kernel:  process_one_work+0x475/0x920
> 16147 Nov 02 17:28:25 ct523c-2103 kernel:  worker_thread+0x38a/0x680

Can you please provide proper kernel dmesg output next time instead of
this mess?

>  ODEBUG: free active (active state 0) object: ffff888181c029a0 object type: timer_list hint: kobject_delayed_cleanup+0x0/0x140
>  WARNING: CPU: 1 PID: 104 at lib/debugobjects.c:549 debug_print_object+0xf0/0x170
>  CPU: 1 PID: 104 Comm: kworker/1:10 Tainted: G        W          6.6.0-rc7+ #17
>  Workqueue: events kobject_delayed_cleanup
>  RIP: 0010:debug_print_object+0xf0/0x170
>   debug_check_no_obj_freed+0x261/0x2b0
>   __kmem_cache_free+0x185/0x200
>   device_release+0x57/0x100
>   kobject_delayed_cleanup+0xdf/0x140
>   process_one_work+0x475/0x920
>   worker_thread+0x38a/0x680

So what happens is:

pps_unregister_cdev()
  device_destroy()
    put_device()
     device_unregister()
       device_del()
       put_device() <- Drops final reference to dev->kobj
         schedule_delayed_work()

worker thread:
  kobject_delayed_cleanup()
    device_release()
      pps_device_destruct()
        cdev_del(&pps->cdev)
          kobject_put(&cdev->kobj) <- Drops final reference
            schedule_delayed_work()
              init_timer(&cdev->kobj.release.timer);
              start_timer();
       ...
       kfree(dev);
       kfree(pps); <- Debug object detects the active timer to be freed
                      because cdev and its kobject are embedded in
                      struct pps_device.

pps_device_destruct() is unfortunately not on the call trace of the
debug objects splat anymore stack because kfree(pps) is a tail call.

So yes, that collected stacktrace is helpful.

>> To try to improve this, store the backtrace of where the
>> debug_obj was created and print that out when problems
>> are found.
<SNIP>

Please trim your replies.

Thanks,

        tglx
