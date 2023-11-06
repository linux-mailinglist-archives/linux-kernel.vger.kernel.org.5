Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48BB7E181A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 01:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjKFAN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 19:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKFAN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 19:13:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1685393
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 16:13:23 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699229600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cXAJ9BZo5drVO9Ek1zL6cxPlBwfYa/GlMFz6PSVAW64=;
        b=XbwclX53fKHatfiJi+lC0QjE5YW9TW7PPHKSSdyJy1XbsBMln+Jv6EVhqGrT8nQIoTi38h
        eEJ4YAV6WKxphWcYtlgxV2Xw+yJPrREy3PT4Qlpo9CuAEww4C5bBKc7cVoVJfPbReWWCc2
        aOTTumF86m62nDAG2D+EFyDXmjRW2ZL6AAbNNWZlUObEWinEPmXb3tPWN7jj+oA1y39a/M
        A8p922udvyzo8Vne3o/LkdG4IO664+lPpHAqIzVO++wpzKuuiX8exMmS2PLAUYNlbSrlJV
        i3eHgM6c7q4gu/E8jIoJBG64zMkO48u63oXNgdU15L54JaiRZCVc6JGf5182aA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699229600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cXAJ9BZo5drVO9Ek1zL6cxPlBwfYa/GlMFz6PSVAW64=;
        b=YAmlV74+FJQTd1bifrk1V2sExI5NtKC2uSPt9g6Mbcn+NmAX2ncOu24fl/DafkKMeRY55G
        Wd9sr04P6gHMe2Bg==
To:     Ben Greear <greearb@candelatech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Rodolfo Giometti <giometti@enneenne.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH/RFC] debugobjects/slub: Print slab info and backtrace.
In-Reply-To: <dc3a6aa1-bb46-666b-4cba-5345636164bc@candelatech.com>
References: <20231103013704.1232723-1-greearb@candelatech.com>
 <92a422d6-76c8-ce25-c331-0718b73dd274@candelatech.com>
 <875y2gi33n.ffs@tglx>
 <dc3a6aa1-bb46-666b-4cba-5345636164bc@candelatech.com>
Date:   Mon, 06 Nov 2023 01:13:19 +0100
Message-ID: <8734xjivs0.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05 2023 at 09:40, Ben Greear wrote:
> On 11/5/23 8:20 AM, Thomas Gleixner wrote:
>>> 16147 Nov 02 17:28:25 ct523c-2103 kernel:  worker_thread+0x38a/0x680
>> 
>> Can you please provide proper kernel dmesg output next time instead of
>> this mess?
>
> You are complaining because there are a few extra tokens put in this
> by journalctl?

Superfluous information is just distracting :)

>>>   ODEBUG: free active (active state 0) object: ffff888181c029a0 object type: timer_list hint: kobject_delayed_cleanup+0x0/0x140
>>>   WARNING: CPU: 1 PID: 104 at lib/debugobjects.c:549 debug_print_object+0xf0/0x170
>>>   CPU: 1 PID: 104 Comm: kworker/1:10 Tainted: G        W          6.6.0-rc7+ #17
>>>   Workqueue: events kobject_delayed_cleanup
>>>   RIP: 0010:debug_print_object+0xf0/0x170
>>>    debug_check_no_obj_freed+0x261/0x2b0
>>>    __kmem_cache_free+0x185/0x200
>>>    device_release+0x57/0x100
>>>    kobject_delayed_cleanup+0xdf/0x140
>>>    process_one_work+0x475/0x920
>>>    worker_thread+0x38a/0x680
>> 
>> So what happens is:
>> 
>> pps_unregister_cdev()
>>    device_destroy()
>>      put_device()
>>       device_unregister()
>>         device_del()
>>         put_device() <- Drops final reference to dev->kobj
>>           schedule_delayed_work()
>> 
>> worker thread:
>>    kobject_delayed_cleanup()
>>      device_release()
>>        pps_device_destruct()
>>          cdev_del(&pps->cdev)
>>            kobject_put(&cdev->kobj) <- Drops final reference
>>              schedule_delayed_work()
>>                init_timer(&cdev->kobj.release.timer);
>>                start_timer();
>>         ...
>>         kfree(dev);
>>         kfree(pps); <- Debug object detects the active timer to be freed
>>                        because cdev and its kobject are embedded in
>>                        struct pps_device.
>> 
>> pps_device_destruct() is unfortunately not on the call trace of the
>> debug objects splat anymore stack because kfree(pps) is a tail call.
>
> So, is this a real bug, or just false positive?

Freeing an active timer is obviously a bug, no?

>> So yes, that collected stacktrace is helpful.
>
> The one I added, or was the original code enough to find this?

The one you added. Collecting this information is useful when the object
tracked by debugobjects provides a hint which does not give any
information about the source of trouble:

   timer_list hint: kobject_delayed_cleanup+0x0/0x140

It points to the work function, but that function is useless to figure
out where the kobject belongs to. So the extra stack trace during init
provides the missing information.

Though I just looked at the patch again. This part is problematic:

> +	trace_handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);

This breaks on RT as you cannot allocate with a raw spinlock held.

Let met think about that.

Thanks,

        tglx



