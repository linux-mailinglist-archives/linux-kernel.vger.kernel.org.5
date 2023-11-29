Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00A97FDFBE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 19:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjK2Syq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 13:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjK2Syo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 13:54:44 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C8EA0;
        Wed, 29 Nov 2023 10:54:50 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3790B40E0173;
        Wed, 29 Nov 2023 18:54:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id o_QRVbiiKrpG; Wed, 29 Nov 2023 18:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701284086; bh=wkXF0McmkxLPOnNWE7KBeTjPtQypJV7rcm8UGbBFHQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c0wfr6cuFBnDVihD/dvDSJNrlQKegnEWbgut3ay6FbTEVf8pOBDQA7A21e7W6Eu9X
         RJ3gmg2pnf3YR3pOexA+cr5lzeqlmDIPLm1pJXLfF2wvBzqcfDx+71wLohdZbJjcpl
         0ipmtaNWI98bNqv5eTQJHvR+NOz7zku4YegeEEdFl5iCw/QkIijc1foP1vrTuvbt0t
         1BXXWlIdIrXrWMgqseJdj6abP82BTtG5HhiUBaL9MG1t51yZPGz9fJWSlMX3c4ohun
         BQJrBNdQEiKFpTSXlWunveDYGGKgo5moDbKAU36vAJ4n8M7dsMQkNTJMiINQuIrOLy
         gWWXooakpHbleHq8KpbM4YnwQO3pkafLmbMBIBuz22vxr/3CEjQDJ8KBBHS+FkHmCM
         JnBUwie7eF+Xu9sxpx2vNunpj18HPXRF+buMTYb5379auLhD/iTGrKjBcuJC2priqZ
         rJF0b0DrwDablHdggGsz8sofvfOqGgyqWYbemM+VxTH7qyEv7WKJ43H1oYdEU09Odh
         rkbVkVWdwHnIvi9LIJNH9umLTb8Quw70i9E44fbxp1z2iBqkLxrZTi/VOS7ZVA55sg
         /x7ZE9sG3Mp4ZbPM8LGQXXCLD4zwSX1kjQyAZlW+hMYuqSMhdK0Wxj4fgxigSvLaMs
         pQtwktS4Zp3O01aT3svrZaRY=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8FA0340E014B;
        Wed, 29 Nov 2023 18:54:11 +0000 (UTC)
Date:   Wed, 29 Nov 2023 19:54:06 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shuai Xue <xueshuai@linux.alibaba.com>, james.morse@arm.com
Cc:     rafael@kernel.org, wangkefeng.wang@huawei.com,
        tanxiaofei@huawei.com, mawupeng1@huawei.com, tony.luck@intel.com,
        linmiaohe@huawei.com, naoya.horiguchi@nec.com,
        gregkh@linuxfoundation.org, will@kernel.org, jarkko@kernel.org,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-edac@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
        stable@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
        ardb@kernel.org, ying.huang@intel.com, ashish.kalra@amd.com,
        baolin.wang@linux.alibaba.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, lenb@kernel.org,
        hpa@zytor.com, robert.moore@intel.com, lvying6@huawei.com,
        xiexiuqi@huawei.com, zhuo.song@linux.alibaba.com
Subject: Re: [PATCH v9 0/2] ACPI: APEI: handle synchronous errors in task
 work with proper si_code
Message-ID: <20231129185406.GBZWeIzqwgRQe7XDo/@fat_crate.local>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20231007072818.58951-1-xueshuai@linux.alibaba.com>
 <20231123150710.GEZV9qnkWMBWrggGc1@fat_crate.local>
 <9e92e600-86a4-4456-9de4-b597854b107c@linux.alibaba.com>
 <20231125121059.GAZWHkU27odMLns7TZ@fat_crate.local>
 <1048123e-b608-4db1-8d5f-456dd113d06f@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1048123e-b608-4db1-8d5f-456dd113d06f@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving James to To:

On Sun, Nov 26, 2023 at 08:25:38PM +0800, Shuai Xue wrote:
> > On Sat, Nov 25, 2023 at 02:44:52PM +0800, Shuai Xue wrote:
> >> - an AR error consumed by current process is deferred to handle in a
> >>   dedicated kernel thread, but memory_failure() assumes that it runs in the
> >>   current context
> > 
> > On x86? ARM?
> > 
> > Pease point to the exact code flow.
> 
> An AR error consumed by current process is deferred to handle in a
> dedicated kernel thread on ARM platform. The AR error is handled in bellow
> flow:
> 
> -----------------------------------------------------------------------------
> [usr space task einj_mem_uc consumd data poison, CPU 3]         STEP 0
> 
> -----------------------------------------------------------------------------
> [ghes_sdei_critical_callback: current einj_mem_uc, CPU 3]		STEP 1
> ghes_sdei_critical_callback
>     => __ghes_sdei_callback
>         => ghes_in_nmi_queue_one_entry 		// peak and read estatus
>         => irq_work_queue(&ghes_proc_irq_work) <=> ghes_proc_in_irq // irq_work
> [ghes_sdei_critical_callback: return]
> -----------------------------------------------------------------------------
> [ghes_proc_in_irq: current einj_mem_uc, CPU 3]			        STEP 2
>             => ghes_do_proc
>                 => ghes_handle_memory_failure
>                     => ghes_do_memory_failure
>                         => memory_failure_queue	 // put work task on current CPU
>                             => if (kfifo_put(&mf_cpu->fifo, entry))
>                                   schedule_work_on(smp_processor_id(), &mf_cpu->work);
>             => task_work_add(current, &estatus_node->task_work, TWA_RESUME);
> [ghes_proc_in_irq: return]
> -----------------------------------------------------------------------------
> // kworker preempts einj_mem_uc on CPU 3 due to RESCHED flag	STEP 3
> [memory_failure_work_func: current kworker, CPU 3]	
>      => memory_failure_work_func(&mf_cpu->work)
>         => while kfifo_get(&mf_cpu->fifo, &entry);	// until get no work
>             => memory_failure(entry.pfn, entry.flags);

From the comment above that function:

 * The function is primarily of use for corruptions that
 * happen outside the current execution context (e.g. when
 * detected by a background scrubber)
 *
 * Must run in process context (e.g. a work queue) with interrupts
 * enabled and no spinlocks held.

> -----------------------------------------------------------------------------
> [ghes_kick_task_work: current einj_mem_uc, other cpu]           STEP 4
>                 => memory_failure_queue_kick
>                     => cancel_work_sync - waiting memory_failure_work_func finish
>                     => memory_failure_work_func(&mf_cpu->work)
>                         => kfifo_get(&mf_cpu->fifo, &entry); // no work
> -----------------------------------------------------------------------------
> [einj_mem_uc resume at the same PC, trigger a page fault        STEP 5
> 
> STEP 0: A user space task, named einj_mem_uc consume a poison. The firmware
> notifies hardware error to kernel through is SDEI
> (ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED).
> 
> STEP 1: The swapper running on CPU 3 is interrupted. irq_work_queue() rasie
> a irq_work to handle hardware errors in IRQ context
> 
> STEP2: In IRQ context, ghes_proc_in_irq() queues memory failure work on
> current CPU in workqueue and add task work to sync with the workqueue.
> 
> STEP3: The kworker preempts the current running thread and get CPU 3. Then
> memory_failure() is processed in kworker.

See above.

> STEP4: ghes_kick_task_work() is called as task_work to ensure any queued
> workqueue has been done before returning to user-space.
> 
> STEP5: Upon returning to user-space, the task einj_mem_uc resumes at the
> current instruction, because the poison page is unmapped by
> memory_failure() in step 3, so a page fault will be triggered.
> 
> memory_failure() assumes that it runs in the current context on both x86
> and ARM platform.
> 
> 
> for example:
> 	memory_failure() in mm/memory-failure.c:
> 
> 		if (flags & MF_ACTION_REQUIRED) {
> 			folio = page_folio(p);
> 			res = kill_accessing_process(current, folio_pfn(folio), flags);
> 		}

And?

Do you see the check above it?

	if (TestSetPageHWPoison(p)) {

test_and_set_bit() returns true only when the page was poisoned already.

 * This function is intended to handle "Action Required" MCEs on already
 * hardware poisoned pages. They could happen, for example, when
 * memory_failure() failed to unmap the error page at the first call, or
 * when multiple local machine checks happened on different CPUs.

And that's kill_accessing_process().

So AFAIU, the kworker running memory_failure() would only mark the page
as poison.

The killing happens when memory_failure() runs again and the process
touches the page again.

But I'd let James confirm here.

I still don't know what you're fixing here.

Is this something you're encountering on some machine or you simply
stared at code?

What does that

"Both Alibaba and Huawei met the same issue in products, and we hope it
could be fixed ASAP."

mean?

What did you meet?

What was the problem?

I still note that you're avoiding answering the question what the issue
is and if you keep avoiding it, I'll ignore this whole thread.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
