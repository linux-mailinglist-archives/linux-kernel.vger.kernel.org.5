Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FC2780CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 15:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377253AbjHRNoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 09:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377294AbjHRNoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:44:11 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E1D30F5;
        Fri, 18 Aug 2023 06:44:10 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id BC11A60174;
        Fri, 18 Aug 2023 15:44:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1692366248; bh=xSfY2UzYI4RssfZmtKiJXJxurnZ4X525t6hOGi9oMWc=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=RYiV6fJdzmf+zsHGDecdSeWPpy+92DoXhE290ODsf4wK0c0UaTakO5cFdv1M85Vkn
         S6t4YBiwk8fyPxq+LSnYPNXKxPVeh3IEXoRO9XbWgLYhemMZKp7awSEPPC5TssMEmi
         KSFSDbvasc1x9e3fy3Nkds5nvb4eAwHeNXQSmi4PvM1vuRtDtUQEeofkSbEaurxVEh
         MhP07CuhU1r4DDgw4F6hnpCXvqGYVRvKQCLJh1DXrnhhq9MCobiEIU1E7UKbq+Myye
         X5GktbKqtVxL5pjpxK9RaQgN2/niOjSaGvkU8e57xS+J8yVSi/Ey5r0hyxyW7IWYBM
         z51WGvoCbhZGg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 89ZjR8dfquSh; Fri, 18 Aug 2023 15:44:05 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 3B16A6015E;
        Fri, 18 Aug 2023 15:44:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1692366245; bh=xSfY2UzYI4RssfZmtKiJXJxurnZ4X525t6hOGi9oMWc=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=ypkhfbw8MvudjNwAvMqAgxUgG6GhboaJ9j2Mfh3+VtT2x3kZxzrJPkjmjCXDn3zTL
         OtZUI3CKxb0wVxnT1IDzTolP7ObX2HmcyvAPEGQ1Wsh+FBk3XalzAriqo+dD5+IWaF
         arh0q4ilpwddr1VwE/1g4uIa1Rq5PVX/oab3XiHXUS559jLMkVvEu99rzS1QbDKUGw
         szsapq917z/R9cxfZOM9zegci6yW+ISFjR92DRve5XPNzijuX0HB0aG0nXa1012paI
         Co8HA5oOnVJoFFRUttkwfMPG7Nm/TM52CYlQxBdFTVVAepvvImdUe3h0+GNyXzjJBk
         h0S1UzFQgnepg==
Message-ID: <36b4e667-c287-1614-fe1f-5e772850d1fb@alu.unizg.hr>
Date:   Fri, 18 Aug 2023 15:44:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [BUG] KCSAN: data-race in drm_sched_entity_is_ready [gpu_sched] /
 drm_sched_entity_push_job [gpu_sched]
Content-Language: en-US
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     linux-kernel@vger.kernel.org
Cc:     Luben Tuikov <luben.tuikov@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
References: <43668e49-c2c0-9979-9de3-b4904c2a8f82@alu.unizg.hr>
In-Reply-To: <43668e49-c2c0-9979-9de3-b4904c2a8f82@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/23 21:54, Mirsad Todorovac wrote:
> Hi,
> 
> This is your friendly bug reporter.
> 
> The environment is vanilla torvalds tree kernel on Ubuntu 22.04 LTS and a Ryzen 7950X box.
> 
> Please find attached the complete dmesg output from the ring buffer and lshw output.
> 
> NOTE: The kernel reports tainted kernel, but to my knowledge there are no proprietary (G) modules,
>        but this taint is turned on by the previous bugs.
> 
> dmesg excerpt:
> 
> [ 8791.864576] ==================================================================
> [ 8791.864648] BUG: KCSAN: data-race in drm_sched_entity_is_ready [gpu_sched] / drm_sched_entity_push_job [gpu_sched]
> 
> [ 8791.864776] write (marked) to 0xffff9b74491b7c40 of 8 bytes by task 3807 on cpu 18:
> [ 8791.864788]  drm_sched_entity_push_job+0xf4/0x2a0 [gpu_sched]
> [ 8791.864852]  amdgpu_cs_ioctl+0x3888/0x3de0 [amdgpu]
> [ 8791.868731]  drm_ioctl_kernel+0x127/0x210 [drm]
> [ 8791.869222]  drm_ioctl+0x38f/0x6f0 [drm]
> [ 8791.869711]  amdgpu_drm_ioctl+0x7e/0xe0 [amdgpu]
> [ 8791.873660]  __x64_sys_ioctl+0xd2/0x120
> [ 8791.873676]  do_syscall_64+0x58/0x90
> [ 8791.873688]  entry_SYSCALL_64_after_hwframe+0x73/0xdd
> 
> [ 8791.873710] read to 0xffff9b74491b7c40 of 8 bytes by task 1119 on cpu 27:
> [ 8791.873722]  drm_sched_entity_is_ready+0x16/0x50 [gpu_sched]
> [ 8791.873786]  drm_sched_select_entity+0x1c7/0x220 [gpu_sched]
> [ 8791.873849]  drm_sched_main+0xd2/0x500 [gpu_sched]
> [ 8791.873912]  kthread+0x18b/0x1d0
> [ 8791.873924]  ret_from_fork+0x43/0x70
> [ 8791.873939]  ret_from_fork_asm+0x1b/0x30
> 
> [ 8791.873955] value changed: 0x0000000000000000 -> 0xffff9b750ebcfc00
> 
> [ 8791.873971] Reported by Kernel Concurrency Sanitizer on:
> [ 8791.873980] CPU: 27 PID: 1119 Comm: gfx_0.0.0 Tainted: G             L     6.5.0-rc6-net-cfg-kcsan-00038-g16931859a650 #35
> [ 8791.873994] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
> [ 8791.874002] ==================================================================

P.S.

According to Mr. Heo's instructions, I am adding the unwound trace here:

[ 1879.706518] ==================================================================
[ 1879.706616] BUG: KCSAN: data-race in drm_sched_entity_is_ready [gpu_sched] / drm_sched_entity_push_job [gpu_sched]

[ 1879.706737] write (marked) to 0xffff8f3672748c40 of 8 bytes by task 4087 on cpu 10:
[ 1879.706748] drm_sched_entity_push_job (./include/drm/spsc_queue.h:74 drivers/gpu/drm/scheduler/sched_entity.c:574) gpu_sched
[ 1879.706808] amdgpu_cs_ioctl (drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:1375 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:1469) amdgpu
[ 1879.710589] drm_ioctl_kernel (drivers/gpu/drm/drm_ioctl.c:788) drm
[ 1879.711068] drm_ioctl (drivers/gpu/drm/drm_ioctl.c:892) drm
[ 1879.711551] amdgpu_drm_ioctl (drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:2748) amdgpu
[ 1879.715319] __x64_sys_ioctl (fs/ioctl.c:51 fs/ioctl.c:870 fs/ioctl.c:856 fs/ioctl.c:856)
[ 1879.715334] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
[ 1879.715345] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)

[ 1879.715365] read to 0xffff8f3672748c40 of 8 bytes by task 1098 on cpu 11:
[ 1879.715376] drm_sched_entity_is_ready (drivers/gpu/drm/scheduler/sched_entity.c:134) gpu_sched
[ 1879.715435] drm_sched_select_entity (drivers/gpu/drm/scheduler/sched_main.c:248 drivers/gpu/drm/scheduler/sched_main.c:893) gpu_sched
[ 1879.715495] drm_sched_main (drivers/gpu/drm/scheduler/sched_main.c:1019) gpu_sched
[ 1879.715554] kthread (kernel/kthread.c:389)
[ 1879.715563] ret_from_fork (arch/x86/kernel/process.c:145)
[ 1879.715575] ret_from_fork_asm (arch/x86/entry/entry_64.S:312)

[ 1879.715590] value changed: 0x0000000000000000 -> 0xffff8f360663dc00

[ 1879.715604] Reported by Kernel Concurrency Sanitizer on:
[ 1879.715612] CPU: 11 PID: 1098 Comm: gfx_0.0.0 Tainted: G             L     6.5.0-rc6+ #47
[ 1879.715624] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
[ 1879.715631] ==================================================================

It seems that the line in question might be:

	first = spsc_queue_push(&entity->job_queue, &sched_job->queue_node);

which expands to:

static inline bool spsc_queue_push(struct spsc_queue *queue, struct spsc_node *node)
{
	struct spsc_node **tail;

	node->next = NULL;

	preempt_disable();

	tail = (struct spsc_node **)atomic_long_xchg(&queue->tail, (long)&node->next);
	WRITE_ONCE(*tail, node);
	atomic_inc(&queue->job_count);

	/*
	 * In case of first element verify new node will be visible to the consumer
	 * thread when we ping the kernel thread that there is new work to do.
	 */
	smp_wmb();

	preempt_enable();

	return tail == &queue->head;
}

According to the manual, preempt_disable() only guaranteed exclusion on a single CPU/core/thread, so
we might be plagued with the slow, old fashioned locking unless anyone had a better idea.

Best regards,
Mirsad Todorovac
