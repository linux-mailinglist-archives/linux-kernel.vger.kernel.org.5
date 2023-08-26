Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA40789603
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 12:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjHZKf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 06:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjHZKfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 06:35:22 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AC21FEC
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 03:35:19 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 148A76015F;
        Sat, 26 Aug 2023 12:35:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1693046117; bh=OMPR7AQr6j4wBeS1GbxiBRi+mqMxGvmW8mUDrG3OcAQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QtHYXmwxw3NCSm/sbod3v42hLK0QtjnPhiL5qyFNpadoPus5B7PK4SVXhIub1k112
         JimueK4xi7jiaJczPCbdqRTN701rutq+xmJShzn6rbWGIGYzKoyNt5spbpQ3CI053f
         Ir/eg3TH2uLSCUDieSizUSUBItFQK8VvJDxEjYLBCz7ur1Ej/YbCi7oIU6g2pdFWkz
         /dCkYXoIWLxSL/QTM6D3Pm0P/EamCfl0EEFvwnBbTlqFHEwFCT0PG8uIVF9rGoeNFF
         O4J44rpmlhAtL8itdnwNym3IT+ngtSb4PQS9TBkLB3f8m7ORWrQzwjIlZlYR7ZClSC
         P6zfXhWQDjskA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id McbbDVxUvXO7; Sat, 26 Aug 2023 12:35:14 +0200 (CEST)
Received: from [192.168.1.4] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 66A196015E;
        Sat, 26 Aug 2023 12:35:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1693046114; bh=OMPR7AQr6j4wBeS1GbxiBRi+mqMxGvmW8mUDrG3OcAQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UML+El88iJBf/rnDBJJkJMtNeLkVRo+6tXWyZKsFxU8JAPW7DTTPryj9lX1AhQoTK
         AOYUHPy7RPBfH+yne0skS0zC4M4jVrdW8tzyrq9Ac2cLxv+slikjPenONxacGxBisj
         3ISkvFQyKer9AjMMgaCbQwJl/HbOxoz3kX1Hh2yb44l1CUPZSvmg3sdcexejvznvQU
         n8L6gAGghEaadigEvnZeKLkCo+hj2uT4b+xw8/+E2VKjXSWSZA1SVC2uC/JOwHb0Jt
         8j0X5hZySQOaEAeq4+ySEKBjoEeYuUiub2nxunPOwtOYow+A9Ah4q0+RadRphizhnz
         q5iUyE4rx2B+A==
Message-ID: <e580d43e-7f7c-6251-981a-c3c285ee8af1@alu.unizg.hr>
Date:   Sat, 26 Aug 2023 12:35:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/1] workqueue: make the increment pwq->stats[]
 increment atomic
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
References: <20230818194448.29672-1-mirsad.todorovac@alu.unizg.hr>
 <CAJhGHyAF0LR=sOudW9Rd=GmpZ_LrnZAa_bb7jKBojwE8LGtVNg@mail.gmail.com>
Content-Language: en-US, hr
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <CAJhGHyAF0LR=sOudW9Rd=GmpZ_LrnZAa_bb7jKBojwE8LGtVNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26. 08. 2023. 03:13, Lai Jiangshan wrote:
> On Sat, Aug 19, 2023 at 3:45 AM Mirsad Goran Todorovac
> <mirsad.todorovac@alu.unizg.hr> wrote:
>>
>> KCSAN has discovered a data race in kernel/workqueue.c:2598:
>>
>> [ 1863.554079] ==================================================================
>> [ 1863.554118] BUG: KCSAN: data-race in process_one_work / process_one_work
>>
>> [ 1863.554142] write to 0xffff963d99d79998 of 8 bytes by task 5394 on cpu 27:
>> [ 1863.554154] process_one_work (kernel/workqueue.c:2598)
>> [ 1863.554166] worker_thread (./include/linux/list.h:292 kernel/workqueue.c:2752)
>> [ 1863.554177] kthread (kernel/kthread.c:389)
>> [ 1863.554186] ret_from_fork (arch/x86/kernel/process.c:145)
>> [ 1863.554197] ret_from_fork_asm (arch/x86/entry/entry_64.S:312)
>>
>> [ 1863.554213] read to 0xffff963d99d79998 of 8 bytes by task 5450 on cpu 12:
>> [ 1863.554224] process_one_work (kernel/workqueue.c:2598)
>> [ 1863.554235] worker_thread (./include/linux/list.h:292 kernel/workqueue.c:2752)
>> [ 1863.554247] kthread (kernel/kthread.c:389)
>> [ 1863.554255] ret_from_fork (arch/x86/kernel/process.c:145)
>> [ 1863.554266] ret_from_fork_asm (arch/x86/entry/entry_64.S:312)
>>
>> [ 1863.554280] value changed: 0x0000000000001766 -> 0x000000000000176a
>>
>> [ 1863.554295] Reported by Kernel Concurrency Sanitizer on:
>> [ 1863.554303] CPU: 12 PID: 5450 Comm: kworker/u64:1 Tainted: G             L     6.5.0-rc6+ #44
>> [ 1863.554314] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
>> [ 1863.554322] Workqueue: btrfs-endio btrfs_end_bio_work [btrfs]
>> [ 1863.554941] ==================================================================
>>
>>     lockdep_invariant_state(true);
>> →   pwq->stats[PWQ_STAT_STARTED]++;
>>     trace_workqueue_execute_start(work);
>>     worker->current_func(work);
>>
>> The quick and dirty solution is to use atomic_inc():
> 
> Great thanks for reporting the problem.
> 
> IMO, the best way to fix it is just to move the line
> "pwq->stats[PWQ_STAT_STARTED]++;" up and above the line
> "raw_spin_unlock_irq(&pool->lock);"
> 
> Thanks
> Lai

Great news, no problem.

Kind regards,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

"I see something approaching fast ... Will it be friends with me?"

