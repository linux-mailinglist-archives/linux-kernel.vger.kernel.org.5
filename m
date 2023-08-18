Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49DD7806E8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358466AbjHRIKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358464AbjHRIKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:10:37 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6DA2D64
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:10:36 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id F259F60174;
        Fri, 18 Aug 2023 10:10:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1692346233; bh=j2l3scpFFwyB3EysYwAp+deXj739oVC5K6taqZ2TZ+Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=0A2f0KOY4ohzxD853JCQ9sFWdokPsSKWJRBsDEqhPSdC/B4PtOIjTdbkcRPC25ykx
         BBoTgz8E4lT+PO1jq/Usricui/zqKJuZ/rYTrqQPqqLI+WuNWSzWo9ik/gp4NZQiNw
         02HIPQASBGdbbdI8hULYsNlz4m3v7HsBGFI9S4NXb5hFTwIA7KA46StIGQAJAnIs8T
         z5ytPUYB73UPutBTCcxpDGCn7teHHKDqVw3n2spXLAMgY5Pw2c3/OvKyWyslkcIuzE
         BVX9vBSQZSs/x2Az5l1jo4D+IuJEXQlK4IETCDhhnnuXxwFZSPLkcpMa6/R/1Kb2kq
         /HyI06Si4Z/YA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SkbTJiIF-YB0; Fri, 18 Aug 2023 10:10:30 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id E45666015E;
        Fri, 18 Aug 2023 10:10:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1692346230; bh=j2l3scpFFwyB3EysYwAp+deXj739oVC5K6taqZ2TZ+Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=0icHGmNvm/ySZ7zg43TN/vHpOc3p14+Wqejm0HpI3rcOzpf3SoZK7qrfbheoZ5gw+
         cKPqL3KZGT+R0GpahAqXTC2FYQSaO1OueKkLytrg+6zJ091iT/Y47CF6aE3+HaVCy4
         WWtqrhUtAR2LN7j3BkXXfxuRzOf5tCnwe3zdP6FuH+VlMtBVrDwOPPu3/IXniSQVKz
         BPN/8fITlZBtz0CfEkK4ZItHrdC1xJUqOnGAT6HH0qQpNk1ED1HoU6Ct2C1bDlwBQH
         eYJuw7Qe6okP0/gLOtk1qdwrtHs9io2ulZe4v4eAEsyWqKbgWv1voFcBy2ocBLHZK2
         JshF/RKmvwY5A==
Message-ID: <897214a4-ab16-a275-1023-4d38c3700b7d@alu.unizg.hr>
Date:   Fri, 18 Aug 2023 10:10:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [BUG] KCSAN: data-race in process_one_work / process_one_work
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
References: <6057c45f-d045-4772-db7c-3d706ada654f@alu.unizg.hr>
 <ZN6YVG114AZv9Yp8@slm.duckdns.org>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZN6YVG114AZv9Yp8@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/17/23 23:59, Tejun Heo wrote:
> On Thu, Aug 17, 2023 at 09:24:28PM +0200, Mirsad Todorovac wrote:
>> Hi,
>>
>> This is your friendly bug reporter.
>>
>> The environment is vanilla torvalds tree kernel on Ubuntu 22.04 LTS and on a Ryzen 7950X
>> assembled box.
>>
>> The kernel reports G taint "properietary module loaded", but I know of no module since
>> the boot state when the status was "Not tainted".
>>
>> Please find the complete dmesg output (or what's left in the ring buffer) and lshw output
>> attached.
>>
>> Here is the dmesg output excerpt:
>>
>> [ 6849.221584] ==================================================================
>> [ 6849.221607] BUG: KCSAN: data-race in process_one_work / process_one_work
>>
>> [ 6849.221635] write to 0xffff9b7440151398 of 8 bytes by task 6364 on cpu 7:
>> [ 6849.221647]  process_one_work+0x504/0x930
>> [ 6849.221660]  worker_thread+0x311/0x7e0
>> [ 6849.221673]  kthread+0x18b/0x1d0
>> [ 6849.221683]  ret_from_fork+0x43/0x70
>> [ 6849.221695]  ret_from_fork_asm+0x1b/0x30
>>
>> [ 6849.221712] read to 0xffff9b7440151398 of 8 bytes by task 5586 on cpu 28:
>> [ 6849.221724]  process_one_work+0x4e8/0x930
>> [ 6849.221737]  worker_thread+0x519/0x7e0
>> [ 6849.221749]  kthread+0x18b/0x1d0
>> [ 6849.221759]  ret_from_fork+0x43/0x70
>> [ 6849.221770]  ret_from_fork_asm+0x1b/0x30
>>
>> [ 6849.221786] value changed: 0x00000000000154d0 -> 0x00000000000154d1
>>
>> [ 6849.221802] Reported by Kernel Concurrency Sanitizer on:
>> [ 6849.221811] CPU: 28 PID: 5586 Comm: kworker/u64:0 Tainted: G             L     6.5.0-rc6-net-cfg-kcsan-00038-g16931859a650 #35
>> [ 6849.221825] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
>> [ 6849.221833] Workqueue: events_unbound wq_barrier_func
>> [ 6849.221846] ==================================================================
> 
> That looks like the PENDING bit. The setting is atomic. Maybe there's a raw
> read? Can you map the addresses to lines?
> 
> Thanks.

Good news:

[ 1863.554079] ==================================================================
[ 1863.554118] BUG: KCSAN: data-race in process_one_work / process_one_work

[ 1863.554142] write to 0xffff963d99d79998 of 8 bytes by task 5394 on cpu 27:
[ 1863.554154] process_one_work (kernel/workqueue.c:2598)
[ 1863.554166] worker_thread (./include/linux/list.h:292 kernel/workqueue.c:2752)
[ 1863.554177] kthread (kernel/kthread.c:389)
[ 1863.554186] ret_from_fork (arch/x86/kernel/process.c:145)
[ 1863.554197] ret_from_fork_asm (arch/x86/entry/entry_64.S:312)

[ 1863.554213] read to 0xffff963d99d79998 of 8 bytes by task 5450 on cpu 12:
[ 1863.554224] process_one_work (kernel/workqueue.c:2598)
[ 1863.554235] worker_thread (./include/linux/list.h:292 kernel/workqueue.c:2752)
[ 1863.554247] kthread (kernel/kthread.c:389)
[ 1863.554255] ret_from_fork (arch/x86/kernel/process.c:145)
[ 1863.554266] ret_from_fork_asm (arch/x86/entry/entry_64.S:312)

[ 1863.554280] value changed: 0x0000000000001766 -> 0x000000000000176a

[ 1863.554295] Reported by Kernel Concurrency Sanitizer on:
[ 1863.554303] CPU: 12 PID: 5450 Comm: kworker/u64:1 Tainted: G             L     6.5.0-rc6+ #44
[ 1863.554314] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
[ 1863.554322] Workqueue: btrfs-endio btrfs_end_bio_work [btrfs]
[ 1863.554941] ==================================================================


	lockdep_invariant_state(true);
:	pwq->stats[PWQ_STAT_STARTED]++;
	trace_workqueue_execute_start(work);
	worker->current_func(work);

Best regards,
Mirsad Todorovac
