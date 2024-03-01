Return-Path: <linux-kernel+bounces-88863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7277E86E7B0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2289A285B0E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4DA38F9B;
	Fri,  1 Mar 2024 17:47:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C92438DE0
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 17:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709315276; cv=none; b=ql/QQE5EsH2GX1MCfd7LGJIMP1gFz7ZmZCDNM4BFBlU/9rYNuTOMyUsPcTr2UWrgko6XfgEdPQ54D4kVue10ZbVU5Y4HsEQLwfQMq4mHd/4rKHOgHBjRT8qpsLd9gy9IQ2gjnys1HlX+0UtHYMLpc2OcC4eL+CU6TLSPbexSHvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709315276; c=relaxed/simple;
	bh=zy6gKC5LaLAogYlc3Rxu42cn3/EbxoV68OcLob1wRvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pks3j2HtXuGUIg62+DVFLdQACJorkK8k9787zStu1eIRyq1PLRxNmg/SL/KF8crMkejdTGeb0Im/ssWzQJjBwFB3xW9spEDyZlvPsUTO1MRJ0tXq0wMouYqq4B2jP+sjUyPRnh06e6zUb74KQrZ9ollaqstC6nB0qYoX5g2NnuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9429711FB;
	Fri,  1 Mar 2024 09:48:31 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3942C3F6C4;
	Fri,  1 Mar 2024 09:47:52 -0800 (PST)
Message-ID: <4ddba36d-3c7d-4412-8b09-d55af493423e@arm.com>
Date: Fri, 1 Mar 2024 17:47:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/resctrl: Add tracepoint for llc_occupancy
 tracking
Content-Language: en-GB
To: Haifeng Xu <haifeng.xu@shopee.com>, reinette.chatre@intel.com
Cc: fenghua.yu@intel.com, babu.moger@amd.com, peternewman@google.com,
 x86@kernel.org, linux-kernel@vger.kernel.org
References: <20240229071125.100991-1-haifeng.xu@shopee.com>
 <20240229071125.100991-3-haifeng.xu@shopee.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <20240229071125.100991-3-haifeng.xu@shopee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello!

On 29/02/2024 07:11, Haifeng Xu wrote:
> In our production environment, after removing monitor groups, those unused
> RMIDs get stuck in the limbo list forever because their llc_occupancy are
> always larger than the threshold. But the unused RMIDs can be successfully
> freed by turning up the threshold.
> 
> In order to know how much the threshold should be, perf can be used to acquire
> the llc_occupancy of RMIDs in each rdt domain.
> 
> Instead of using perf tool to track llc_occupancy and filter the log manually,
> it is more convenient for users to use tracepoint to do this work. So add a new
> tracepoint that shows the llc_occupancy of busy RMIDs when scanning the limbo
> list.

> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index c34a35ec0f03..ada392ca75b2 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -362,6 +363,13 @@ void __check_limbo(struct rdt_domain *d, bool force_free)

[expanded the diff hunk for better context]
>               entry = __rmid_entry(idx);
>               if (resctrl_arch_rmid_read(r, d, entry->closid, entry->rmid,
>                                          QOS_L3_OCCUP_EVENT_ID, &val,
>                                          arch_mon_ctx)) {
>                       rmid_dirty = true;
>               } else {
>                       rmid_dirty = (val >= resctrl_rmid_realloc_threshold);
>               }
>
>               if (force_free || !rmid_dirty) {
>                       clear_bit(idx, d->rmid_busy_llc);
>                       if (!--entry->busy)
>  				limbo_release_entry(entry);
>  		}

>  		cur_idx = idx + 1;

Ideally this would be the last line in the loop, its how the iterator advances to the next
bit in the bitmap.


> +		/* x86's CLOSID and RMID are independent numbers, so the entry's
> +		 * closid is a invalid CLOSID. But on arm64, the RMID value isn't
> +		 * a unique number for each CLOSID. It's necessary to track both
> +		 * CLOSID and RMID because there may be dependencies between each
> +		 * other on some architectures */
> +		trace_mon_llc_occupancy_limbo(entry->closid, entry->rmid, d->id, val);

I agree outputting both these values is the right thing to do.

resctrl_arch_rmid_read() could return an error, in which case val here is either
uninitialised, or the value of another RMID.
Could you put the tracepoint in the 'else' section of the if/else after
resctrl_arch_rmid_read()? This way it will only output a value to user-space if it is correct.


> diff --git a/arch/x86/kernel/cpu/resctrl/trace.h b/arch/x86/kernel/cpu/resctrl/trace.h
> index 495fb90c8572..35149a75c951 100644
> --- a/arch/x86/kernel/cpu/resctrl/trace.h
> +++ b/arch/x86/kernel/cpu/resctrl/trace.h
> @@ -35,6 +35,21 @@ TRACE_EVENT(pseudo_lock_l3,
>  	    TP_printk("hits=%llu miss=%llu",
>  		      __entry->l3_hits, __entry->l3_miss));
>  
> +TRACE_EVENT(mon_llc_occupancy_limbo,
> +	    TP_PROTO(u32 ctrl_hw_id, u32 mon_hw_id, int id, u64 occupancy),
> +	    TP_ARGS(ctrl_hw_id, mon_hw_id, id, occupancy),
> +	    TP_STRUCT__entry(__field(u32, ctrl_hw_id)
> +			     __field(u32, mon_hw_id)

> +			     __field(int, id)

Nit: Could we call this 'domain_id'? We've got two other ids already, so we should be
clear what each one is!


> +			     __field(u64, occupancy)),

Nit: 'occupancy_bytes'? Just to avoid user-space thinking it needs to convert from the
hardware unit in Intel's SDM ... and just in case we ever have to add another parameter
that is sort of occupancy too.


> +	    TP_fast_assign(__entry->ctrl_hw_id = ctrl_hw_id;
> +			   __entry->mon_hw_id = mon_hw_id;
> +			   __entry->id = id;
> +			   __entry->occupancy = occupancy;),
> +	    TP_printk("ctrl_hw_id=%u mon_hw_id=%u domain=%d llc_occupancy=%llu",
> +		      __entry->ctrl_hw_id, __entry->mon_hw_id, __entry->id, __entry->occupancy)
> +	   );
> +

Tracepoints always expose some implicit details of the kernel internals which can make
supporting them a headache. In this case - I've had some discussion with folk about future
work to defer the limbo work as late as possible - until a new control or monitor group is
allocated. This would be to avoid interrupting user-space tasks to update the limbo list
when the result isn't needed until alloc time.

In this case the tracepoint wouldn't be hit unless user-space made a mkdir() syscall to
force an update - I think this can just be a documentation problem.

I also don't think we should commit to this outputting values for all dirty RMID - which
it does today. If group creation were to fail because there weren't any free RMID you'd
get all the values, I think this is the only case where user-space would care.

Could we document the properties of the the trace-point that can be relied on in
Documentation/arch/x86/resctrl.rst ?

Something like:
| This tracepoint gives you the precise occupancy values for a subset of RMID that are not
| immediately available for allocation. This can't be relied on to produce output every
| second, it may be necessary to attempt to create an empty monitor group to force an
| update. Output may only be produced if creation of a control or monitor group fails.

I think we'll always walk a list of dirty RMID before failing to allocate an RMID, so this
should be future proof.


With the val and documentation bits:
Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James

