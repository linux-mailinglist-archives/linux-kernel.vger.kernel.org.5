Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037AC7E1589
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 18:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjKERka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 12:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjKERk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 12:40:28 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B165ADE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 09:40:25 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 97962A80074;
        Sun,  5 Nov 2023 17:40:22 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.34.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 224F913C2B0;
        Sun,  5 Nov 2023 09:40:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 224F913C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1699206021;
        bh=yG3bOIDfNjr0j95daIG4pMwHZ9mKy4vCuzTqn1EsjjQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sucLemUbJvDuSkte90i9AN99xDW228GqYrazjQ0/hTteVgLw9ZZbwfXvGHKE2zE07
         mmNwxMLksATOX+rnwY+lhSlsMfjo2mVHe5yJ8Q+nXm0By3uEBf2vY0jU9QdQytJzzN
         nyQXdmSyJG8mBcGnsh//tagxjaxcQAptwijePBro=
Subject: Re: [PATCH/RFC] debugobjects/slub: Print slab info and backtrace.
To:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Rodolfo Giometti <giometti@enneenne.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20231103013704.1232723-1-greearb@candelatech.com>
 <92a422d6-76c8-ce25-c331-0718b73dd274@candelatech.com> <875y2gi33n.ffs@tglx>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <dc3a6aa1-bb46-666b-4cba-5345636164bc@candelatech.com>
Date:   Sun, 5 Nov 2023 09:40:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <875y2gi33n.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1699206023-VJc4Nu14S7rw
X-MDID-O: us5;ut7;1699206023;VJc4Nu14S7rw;<greearb@candelatech.com>;5668d583b30e73300b5449d2ade3070d
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/23 8:20 AM, Thomas Gleixner wrote:
> On Thu, Nov 02 2023 at 18:49, Ben Greear wrote:
>> And here is resulting splat from wireless-next tree I've been
>> debugging.
>>
>> Note the subsequent splats from slub are due to some memory poisoning, for
>> one reason or another.  Maybe slub changes should not be included in this patch, not
>> sure if it can provide useful info in other cases though.
>>
>> If I understand this correctly, then it appears the bug is related to
>> the pps driver.
>>
>> 16140 Nov 02 17:28:25 ct523c-2103 kernel: ODEBUG: debugobjects: debug_obj allocated at:
>> 16141 Nov 02 17:28:25 ct523c-2103 kernel:  init_timer_key+0x24/0x160
>> 16142 Nov 02 17:28:25 ct523c-2103 kernel:  kobject_put+0x14f/0x190
>> 16143 Nov 02 17:28:25 ct523c-2103 kernel:  pps_device_destruct+0x26/0xb0
>> 16144 Nov 02 17:28:25 ct523c-2103 kernel:  device_release+0x57/0x100
>> 16145 Nov 02 17:28:25 ct523c-2103 kernel:  kobject_delayed_cleanup+0xdf/0x140
>> 16146 Nov 02 17:28:25 ct523c-2103 kernel:  process_one_work+0x475/0x920
>> 16147 Nov 02 17:28:25 ct523c-2103 kernel:  worker_thread+0x38a/0x680
> 
> Can you please provide proper kernel dmesg output next time instead of
> this mess?

You are complaining because there are a few extra tokens put in this
by journalctl?

> 
>>   ODEBUG: free active (active state 0) object: ffff888181c029a0 object type: timer_list hint: kobject_delayed_cleanup+0x0/0x140
>>   WARNING: CPU: 1 PID: 104 at lib/debugobjects.c:549 debug_print_object+0xf0/0x170
>>   CPU: 1 PID: 104 Comm: kworker/1:10 Tainted: G        W          6.6.0-rc7+ #17
>>   Workqueue: events kobject_delayed_cleanup
>>   RIP: 0010:debug_print_object+0xf0/0x170
>>    debug_check_no_obj_freed+0x261/0x2b0
>>    __kmem_cache_free+0x185/0x200
>>    device_release+0x57/0x100
>>    kobject_delayed_cleanup+0xdf/0x140
>>    process_one_work+0x475/0x920
>>    worker_thread+0x38a/0x680
> 
> So what happens is:
> 
> pps_unregister_cdev()
>    device_destroy()
>      put_device()
>       device_unregister()
>         device_del()
>         put_device() <- Drops final reference to dev->kobj
>           schedule_delayed_work()
> 
> worker thread:
>    kobject_delayed_cleanup()
>      device_release()
>        pps_device_destruct()
>          cdev_del(&pps->cdev)
>            kobject_put(&cdev->kobj) <- Drops final reference
>              schedule_delayed_work()
>                init_timer(&cdev->kobj.release.timer);
>                start_timer();
>         ...
>         kfree(dev);
>         kfree(pps); <- Debug object detects the active timer to be freed
>                        because cdev and its kobject are embedded in
>                        struct pps_device.
> 
> pps_device_destruct() is unfortunately not on the call trace of the
> debug objects splat anymore stack because kfree(pps) is a tail call.

So, is this a real bug, or just false positive?

> 
> So yes, that collected stacktrace is helpful.

The one I added, or was the original code enough to find this?

I don't really understand the debugobjects code well, never heard of pps driver
before I started looking into this.  I hacked in the backtrace code by copying from
existing code in the kernel.

If you are happy with current debug-objects and pps related warning splat is understood,
happy to just drop my patch.  Once I hacked around another bug in wifi, my kernel
has been stable, so whatever pps is doing, doesn't seem to be actively harmful
on my system.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
