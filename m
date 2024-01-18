Return-Path: <linux-kernel+bounces-29783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9597D83135B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAA9C1C21438
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CC5C154;
	Thu, 18 Jan 2024 07:52:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5B61170A;
	Thu, 18 Jan 2024 07:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564331; cv=none; b=OMrOj7D8NprDEeiQwV00wwXNbeGKOUZ743mDRUoqsbltx+alXEjcCVDtShMsmhRGnQF9mwCcCtHoaHEZ3M4FxFoAI3i8X19BjYGlFGWxewoxzObg1+yhcgN1pI1QEdItOLITEDkr96+VFS5iT4SqFLU4M8qB+KY/bwkvadak9oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564331; c=relaxed/simple;
	bh=2Fh9Tp3AdRnRiIVKXLJf0SM4987XhL95PCJwebTGEO8=;
	h=Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=MVJ31UwfQiaexQXq20iAogV5OMqYwwue31C/3hXOxZQcPmelDtZ0QjJnn7vObEz8vY+6cgApqoz34NXjPudWDGbJXFCWa08o4yM6HsZYuIh1wYRDIKWSTwB/89GkGCsXMz2qHmDA+KB10OTJNZbZErhNqnEVDA2qWxOSLH/7rKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72857C433C7;
	Thu, 18 Jan 2024 07:52:09 +0000 (UTC)
Message-ID: <e9f42704-2f99-4f2c-ade5-f952e5fd53e5@xs4all.nl>
Date: Thu, 18 Jan 2024 08:52:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux Kernel Bugs] KASAN: slab-use-after-free Read in
 cec_queue_msg_fh and 4 other crashes in the cec device (`cec_ioctl`)
Content-Language: en-US, nl
To: "Zhao, Zijie" <zijie4@illinois.edu>,
 "jani.nikula@intel.com" <jani.nikula@intel.com>,
 "mchehab@kernel.org" <mchehab@kernel.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
 "Zhang, Lingming" <lingming@illinois.edu>, "Yang, Chenyuan"
 <cy54@illinois.edu>
References: <PH7PR11MB57688E64ADE4FE82E658D86DA09EA@PH7PR11MB5768.namprd11.prod.outlook.com>
 <SN6PR11MB345527101A2C8A1AC99B04B5FA712@SN6PR11MB3455.namprd11.prod.outlook.com>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <SN6PR11MB345527101A2C8A1AC99B04B5FA712@SN6PR11MB3455.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/01/2024 05:25, Zhao, Zijie wrote:
> Dear Developers,
> 
> We hope this email finds you well. We took a deeper look at the first crash KASAN: slab-use-after-free Read in cec_queue_msg_fh. We believe the cause is that one thread took the lock of a `struct
> cec_fh` but another thread freed it:
> 
> One thread takes the lock of the `fh` of type `struct cec_fh`first (https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-adap.c#L219);
> Another thread frees this `fh` without checking if any other thread is holding the lock (https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-api.c#L684);
> Then KASAN is triggered when the first thread tries to access `fh->msgs` (https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-adap.c#L224).
> 
> 
> While this particular reproducer seems harmless, we think the free might cause more problems when paired with threads running other functions that work on `fh`and then KASAN is disabled. We also think
> the `struct cec_fh` (https://elixir.bootlin.com/linux/v6.7-rc7/source/include/media/cec.h#L90) is worth attention since it stores many function pointers (e.g. `fh->adap->ops` stores
> https://elixir.bootlin.com/linux/v6.7-rc7/source/include/media/cec.h#L115 and `fh->adap->pin->ops` stores https://elixir.bootlin.com/linux/v6.7-rc7/source/include/media/cec-pin.h#L36).
> 
> Could you please kindly take a look at the crashes as you have more expertise in them?

I've been looking at these on and off whenever I have some time. I found two issues and am
on the trail of a third. Once I have a patch for the third I was planning to post the patches
and ask you to retest. Some of the issues you found might all relate to the same root cause
(esp. the locking issue), so it would be great if you could help with that.

Regards,

	Hans

> 
> Thank you for your time!
> --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> *From:* Yang, Chenyuan <cy54@illinois.edu>
> *Sent:* Wednesday, December 27, 2023 8:33 PM
> *To:* linux-media@vger.kernel.org <linux-media@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
> *Cc:* jani.nikula@intel.com <jani.nikula@intel.com>; hverkuil-cisco@xs4all.nl <hverkuil-cisco@xs4all.nl>; syzkaller@googlegroups.com <syzkaller@googlegroups.com>; mchehab@kernel.org
> <mchehab@kernel.org>; Zhao, Zijie <zijie4@illinois.edu>; Zhang, Lingming <lingming@illinois.edu>
> *Subject:* [Linux Kernel Bugs] KASAN: slab-use-after-free Read in cec_queue_msg_fh and 4 other crashes in the cec device (`cec_ioctl`)
>  
> 
> Hello,
> 
>  
> 
> We encountered 5 different crashes in the cec device by using our generated syscall specification for it, here are the descriptions of these 5 crashes and the related files are attached:
> 
> 1. KASAN: slab-use-after-free Read in cec_queue_msg_fh (Reproducible)
> 
> 2. WARNING: ODEBUG bug in cec_transmit_msg_fh
> 
> 3. WARNING in cec_data_cancel
> 
> 4. INFO: task hung in cec_claim_log_addrs (Reproducible)
> 
> 5. general protection fault in cec_transmit_done_ts
> 
>  
> 
> For “KASAN: slab-use-after-free Read in cec_queue_msg_fh”, we attached a syzkaller program to reproduce it. This crash is caused by ` list_add_tail(&entry->list, &fh->msgs);`
> (https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-adap.c#L224 <https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-adap.c#L224>), which reads a
> variable freed by `kfree(fh);` (https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-api.c#L684
> <https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-api.c#L684>). The reproducible program is a Syzkaller program, which can be executed following this document:
> https://github.com/google/syzkaller/blob/master/docs/executing_syzkaller_programs.md <https://github.com/google/syzkaller/blob/master/docs/executing_syzkaller_programs.md>.
> 
>  
> 
> For “WARNING: ODEBUG bug in cec_transmit_msg_fh”, unfortunately we failed to reproduce it but we indeed trigger this crash almost every time when we fuzz the cec device only. We attached the report
> and log for this bug. It tries freeing an active object by using `kfree(data);` (https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-adap.c#L930
> <https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-adap.c#L930>).
> 
>  
> 
> For “WARNING in cec_data_cancel”, it is an internal warning used in cec_data_cancel (https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-adap.c#L365
> <https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-adap.c#L365>), which checks whether the transmit is the current or pending. Unfortunately, we also don't have the
> reproducible program for this bug, but we attach the report and log.
> 
>  
> 
> For “INFO: task hung in cec_claim_log_addrs”, the kernel hangs when the cec device ` wait_for_completion(&adap->config_completion);`
> (https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-adap.c#L1579 <https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-adap.c#L1579>). We have a
> reproducible C program for this.
> 
>  
> 
> For “general protection fault in cec_transmit_done_ts”, the cec device tries derefencing a non-canonical address 0xdffffc00000000e0: 0000 [#1], which is related to the invocation `
> cec_transmit_attempt_done_ts ` (https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-adap.c#L697
> <https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-adap.c#L697>). It seems that the address of cec_adapter is totally wrong. We do not have a reproducible program for this
> bug, but the log and report for it are attached.
> 
>  
> 
> If you have any questions or require more information, please feel free to contact us.
> 
>  
> 
> Best,
> 
> Chenyuan
> 


