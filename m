Return-Path: <linux-kernel+bounces-70639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B941859A93
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 02:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA5ABB20C2B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 01:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00CE1FC4;
	Mon, 19 Feb 2024 01:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ujAijiCv"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC04394;
	Mon, 19 Feb 2024 01:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708307235; cv=none; b=qiEwk+tND5eGam+PCqRg7zDD72jNuw3RzkkOz2JAek51PLU6o5N96Zo4cWF+U/tuGllnqp1gb+8n5wTJsM2Du3tVxuVSkyL317R2SQOgHtQsvPlINn+rCcya9LTKcST0n8+p+ev2WeBafPyPknvNxNAiMrQJTJx2Cvb+8lri4/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708307235; c=relaxed/simple;
	bh=ksaa4UwMu7iSxFJGBgVO7PBzq/jdvj9fS1T+/SOrN1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tp7N3ME8jyMakltPf9jW2L2Q7pteHbFyRr+diHO+WxmMIgsipPRncgIWHeMIZlcSFTVhQi0RGkX9IE9bIcrw5uKFAU0kxhoWpX5KOFsAIRYVdTpxBi5Mx36hlnHigrSNp2ssjGsNPmzFNPIGDDhj4CX7GljmLY9hcc91CNUymDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ujAijiCv; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708307223; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6cJ+ZJtAysi52r932E530yoSx3LcIwhYcvRHFW0VzE4=;
	b=ujAijiCvDp6hEHrozPJG+eXFZ5O2d0T23S6rqg3/YkEXDSjQKMG7D0mqPNE0tCAhnaOu5uhDQTRbmp8TEQeveL4W5t3q6ZvgqghYjRqtESGgOxQag4AbT/0q8ud3WOYhOyq3RXCOfZno/6+XcuOaNa8AZCfOIKl8H64U/IwU3n8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=32;SR=0;TI=SMTPD_---0W0mV91Q_1708307218;
Received: from 30.240.113.204(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0W0mV91Q_1708307218)
          by smtp.aliyun-inc.com;
          Mon, 19 Feb 2024 09:47:01 +0800
Message-ID: <a1a6d101-1c08-4cd0-860f-af905869c573@linux.alibaba.com>
Date: Mon, 19 Feb 2024 09:46:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/3] ACPI: APEI: handle synchronous exceptions in task
 work to send correct SIGBUS si_code
To: bp@alien8.de, rafael@kernel.org, wangkefeng.wang@huawei.com,
 tanxiaofei@huawei.com, mawupeng1@huawei.com, tony.luck@intel.com,
 linmiaohe@huawei.com, naoya.horiguchi@nec.com, james.morse@arm.com,
 gregkh@linuxfoundation.org, will@kernel.org, jarkko@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 linux-edac@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
 ardb@kernel.org, ying.huang@intel.com, ashish.kalra@amd.com,
 baolin.wang@linux.alibaba.com, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
 robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
 zhuo.song@linux.alibaba.com
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20240204080144.7977-1-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20240204080144.7977-1-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, James and Borislav,

Gentle Ping. Any feedback to this new version?

Thank you.

Best Regards,
Shuai

On 2024/2/4 16:01, Shuai Xue wrote:
> ## Changes Log
> changes since v10:
> - rebase to v6.8-rc2
> 
> changes since v9:
> - split patch 2 to address exactly one issue in one patch (per Borislav)
> - rewrite commit log according to template (per Borislav)
> - pickup reviewed-by tag of patch 1 from James Morse
> - alloc and free twcb through gen_pool_{alloc, free) (Per James)
> - rewrite cover letter
> 
> changes since v8:
> - remove the bug fix tag of patch 2 (per Jarkko Sakkinen)
> - remove the declaration of memory_failure_queue_kick (per Naoya Horiguchi)
> - rewrite the return value comments of memory_failure (per Naoya Horiguchi)
> 
> changes since v7:
> - rebase to Linux v6.6-rc2 (no code changed)
> - rewritten the cover letter to explain the motivation of this patchset
> 
> changes since v6:
> - add more explicty error message suggested by Xiaofei
> - pick up reviewed-by tag from Xiaofei
> - pick up internal reviewed-by tag from Baolin
> 
> changes since v5 by addressing comments from Kefeng:
> - document return value of memory_failure()
> - drop redundant comments in call site of memory_failure() 
> - make ghes_do_proc void and handle abnormal case within it
> - pick up reviewed-by tag from Kefeng Wang 
> 
> changes since v4 by addressing comments from Xiaofei:
> - do a force kill only for abnormal sync errors
> 
> changes since v3 by addressing comments from Xiaofei:
> - do a force kill for abnormal memory failure error such as invalid PA,
> unexpected severity, OOM, etc
> - pcik up tested-by tag from Ma Wupeng
> 
> changes since v2 by addressing comments from Naoya:
> - rename mce_task_work to sync_task_work
> - drop ACPI_HEST_NOTIFY_MCE case in is_hest_sync_notify()
> - add steps to reproduce this problem in cover letter
> 
> changes since v1:
> - synchronous events by notify type
> - Link: https://lore.kernel.org/lkml/20221206153354.92394-3-xueshuai@linux.alibaba.com/
> 
> ## Cover Letter
> 
> There are two major types of uncorrected recoverable (UCR) errors :
> 
> - Synchronous error: The error is detected and raised at the point of the
>   consumption in the execution flow, e.g. when a CPU tries to access
>   a poisoned cache line. The CPU will take a synchronous error exception
>   such as Synchronous External Abort (SEA) on Arm64 and Machine Check
>   Exception (MCE) on X86. OS requires to take action (for example, offline
>   failure page/kill failure thread) to recover this uncorrectable error.
> 
> - Asynchronous error: The error is detected out of processor execution
>   context, e.g. when an error is detected by a background scrubber. Some data
>   in the memory are corrupted. But the data have not been consumed. OS is
>   optional to take action to recover this uncorrectable error.
> 
> Since commit a70297d22132 ("ACPI: APEI: set memory failure flags as
> MF_ACTION_REQUIRED on synchronous events")', the flag MF_ACTION_REQUIRED
> could be used to determine whether a synchronous exception occurs on ARM64
> platform. When a synchronous exception is detected, the kernel should
> terminate the current process which accessing the poisoned page. This is
> done by sending a SIGBUS signal with an error code BUS_MCEERR_AR,
> indicating an action-required machine check error on read.
> 
> However, the memory failure recovery is incorrectly sending a SIGBUS
> with wrong error code BUS_MCEERR_AO for synchronous errors in early kill
> mode, even MF_ACTION_REQUIRED is set. The main problem is that
> synchronous errors are queued as a memory_failure() work, and are
> executed within a kernel thread context, not the user-space process that
> encountered the corrupted memory on ARM64 platform. As a result, when
> kill_proc() is called to terminate the process, it sends the incorrect
> SIGBUS error code because the context in which it operates is not the
> one where the error was triggered.
> 
> To this end, fix the problem by:
> 
> - Patch 1: performing a force kill if no memory_failure() work is queued for
> 	   synchronous errors.
> - Patch 2: a minor comments improvement.
> - Patch 3: queue memory_failure() as a task_work so that it runs in the
> 	   context of the process that is actually consuming the poisoned
> 	   data, and it will send SIBBUS with si_code BUS_MCEERR_AR.
> 
> Lv Ying and XiuQi from Huawei also proposed to address similar problem[2][4].
> Acknowledge to discussion with them.
> 
> ## Steps to Reproduce This Problem
> 
> To reproduce this problem:
> 
> 	# STEP1: enable early kill mode
> 	#sysctl -w vm.memory_failure_early_kill=1
> 	vm.memory_failure_early_kill = 1
> 
> 	# STEP2: inject an UCE error and consume it to trigger a synchronous error
> 	#einj_mem_uc single
> 	0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
> 	injecting ...
> 	triggering ...
> 	signal 7 code 5 addr 0xffffb0d75000
> 	page not present
> 	Test passed
> 
> The si_code (code 5) from einj_mem_uc indicates that it is BUS_MCEERR_AO error
> and it is not fact.
> 
> After this patch set:
> 
> 	# STEP1: enable early kill mode
> 	#sysctl -w vm.memory_failure_early_kill=1
> 	vm.memory_failure_early_kill = 1
> 
> 	# STEP2: inject an UCE error and consume it to trigger a synchronous error
> 	#einj_mem_uc single
> 	0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
> 	injecting ...
> 	triggering ...
> 	signal 7 code 4 addr 0xffffb0d75000
> 	page not present
> 	Test passed
> 
> The si_code (code 4) from einj_mem_uc indicates that it is BUS_MCEERR_AR error
> as we expected.
> 
> [1] Add ARMv8 RAS virtualization support in QEMU https://patchew.org/QEMU/20200512030609.19593-1-gengdongjiu@huawei.com/
> [2] https://lore.kernel.org/lkml/20221205115111.131568-3-lvying6@huawei.com/
> [3] https://lkml.kernel.org/r/20220914064935.7851-1-xueshuai@linux.alibaba.com
> [4] https://lore.kernel.org/lkml/20221209095407.383211-1-lvying6@huawei.com/
> 
> Shuai Xue (3):
>   ACPI: APEI: send SIGBUS to current task if synchronous memory error
>     not recovered
>   mm: memory-failure: move return value documentation to function
>     declaration
>   ACPI: APEI: handle synchronous exceptions in task work to send correct
>     SIGBUS si_code
> 
>  arch/x86/kernel/cpu/mce/core.c |  9 +---
>  drivers/acpi/apei/ghes.c       | 84 +++++++++++++++++++++-------------
>  include/acpi/ghes.h            |  3 --
>  mm/memory-failure.c            | 22 +++------
>  4 files changed, 59 insertions(+), 59 deletions(-)
> 

