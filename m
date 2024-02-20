Return-Path: <linux-kernel+bounces-72211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C324A85B0DA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52FE3284165
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49B244C73;
	Tue, 20 Feb 2024 02:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="Y2WaWeAB"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5CE1E88A
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708395982; cv=none; b=E5xzX/oOQ70TqP1Gm3hum+RYK1P6ViXhX9hR28IMc1cfzTWN4riRRWF0hHHW8gM7dQcYPvjOeYu30JXXs/G0/6pScXd8P04KAIyM1ICe/EzuH7zXK5rwS2aSa+PehaM3xKQt3Q/wdfX0fFej9TGEVtu+WYqiPGvh8htdKIpxoBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708395982; c=relaxed/simple;
	bh=Xg7TmwEMtwTA7PWJ8hSpAdgXV8UnLZGgtLdg5i/ZXsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=swZkGU8/En2/BQMRUYtAEo8r0qaIfO5EiSG3YNiTqXueimBqMm2r+wM4naUtyzfSBm8GD2I6k7AVxfaafNtfcLppsSDKTEQZ0gZRMEVC4rHfJM+wSEQe0DfmNtMtskA7pqGQx+57G+kPq55ctfqlWBDa2eP4frHTJcLK6wVcqZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=Y2WaWeAB; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bbb4806f67so3501171b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 18:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1708395980; x=1709000780; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bl4P87TtovT2U1fH2h6dxC0FJzdvIJ4lw60FMRmvk00=;
        b=Y2WaWeABaamq5r6VfJDqL581fBijSo84Vw5lNbplxTAZ8/NvaD7haI2RY1HmFSgyt3
         nVBs+RyJc7PkCzPZRdJeUfstW/OzOhxrApaqNlmNSVOf7AosTrr8nlYp8PxqbdxYamQg
         fGpXCJEBTXMmptdlmU3TqEuI2E1EuV7qZayh6rnbDkTu7dun8Y7P/j+mtm3+FTehZCY+
         Vr+t3BRQp/szBSBDxu1rYA7mVb1aCKTyA5FOPCQ/7VdAgEj8J5A806Cvcb0Qm+CXs3j8
         ratmDxMFYu45sH0Rv+/DPFQd2NH8SVPkxPJPJxvQ3VqMqcOrDzygsk0H6RUZxmv/mIew
         FSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708395980; x=1709000780;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bl4P87TtovT2U1fH2h6dxC0FJzdvIJ4lw60FMRmvk00=;
        b=MLHSDUP2LE5SkyDqBgpwtztMQiYak/4Q9dNC7G6hEOgRwvejFJD2+/ARTx95B1jpzR
         Z0g0oxzhma73aj4c2XlgV6KOHdW5XO+j1zOkBepT3SktzhD4bpy0zlQJAQR80yHf0lze
         BokGFn2C6BkGAvVbpIH0C2W1B0K+me5JwDUEkwZZ4pnAsZtUqdWCgLsgaI3ogaUV7X4L
         CfUKKdh/KD+geIxddvrcJlkw2bwYn/GITTGDhXa905lupPHbN8y2DpNCDYNHgYAExTtv
         /qrNGyWrXSFOXdNop/sTMjnCXXQT+0v3ty27InSwzOqPzsTvEopzqK/g90csPG3Ku2aC
         zGGw==
X-Forwarded-Encrypted: i=1; AJvYcCV3d5ZZWgczF2r47w3Jxe+vMqjv0IXUCCG0k3NPHtdSeY0R904G6ieo0lASxHt9dzYa0nD08P8Y6sn39dbqInLkaE9n4SY23iyMk1Nf
X-Gm-Message-State: AOJu0Yz2snmWg03IzOj2QM2oT1xgL28Fjq+rjc2wNukVlR7KSFRSK2nA
	R58ztCV9MlOMBKKzXR7Y2roJ/CqEztxbbZFIPVgnJio/rJdT1l33V1Pf5oWAkx4=
X-Google-Smtp-Source: AGHT+IFx26q560TEh4r015vSPWlqilySdqyCvYpFd+66XstQzyQooYAU/yw8XB8QOO1qxzrHa+R8rA==
X-Received: by 2002:a05:6808:109:b0:3bf:e036:f0e7 with SMTP id b9-20020a056808010900b003bfe036f0e7mr14044334oie.56.1708395980184;
        Mon, 19 Feb 2024 18:26:20 -0800 (PST)
Received: from [10.54.24.74] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id fc34-20020a056a002e2200b006e1079d6765sm5570883pfb.46.2024.02.19.18.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 18:26:19 -0800 (PST)
Message-ID: <cb6764a9-73f4-48b2-bffe-1851b6904b0a@shopee.com>
Date: Tue, 20 Feb 2024 10:26:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: Add tracepoint for llc_occupancy tracking
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: fenghua.yu@intel.com, babu.moger@amd.com, peternewman@google.com,
 james.morse@arm.com, x86@kernel.org, linux-kernel@vger.kernel.org
References: <20240126130213.159339-1-haifeng.xu@shopee.com>
 <255118a7-73e6-4b7c-b3b4-c93eaa7cbdd9@intel.com>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <255118a7-73e6-4b7c-b3b4-c93eaa7cbdd9@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/2/6 03:36, Reinette Chatre wrote:
> Hi Haifeng,
> 
> Thank you for proposing this feature. I think it is a useful addition.
> I tried it out after removing a monitor group and it was insightful
> to be able to see how the cache occupancy of a removed group
> shrinks over time.
> 
> On 1/26/2024 5:02 AM, Haifeng Xu wrote:
>> If llc_occupany is enabled, the rmid may not be freed immediately unless
> 
> (llc_occupany -> llc_occupancy ... one more instance below)
> 
> Please use caps (RMID) for acronym.
> 
>> its llc_occupany is less than the resctrl_rmid_realloc_threshold.
> 
> I think it will help to highlight that this is related to monitor group
> removal.
> 
>>
>> In our production environment, those unused rmids get stuck in the limbo
>> list forever because their llc_occupancy are larger than the threshold.
>> After turning it up, we can successfully free unused rmids and create
>> new monitor groups. In order to acquire the llc_occupancy of rmids in
>> each rdt domain, we use perf tool to track and filter the log manually.
> 
> Could you please elaborate how you "use perf tool to track and
> filter the log manually"?
> 
>>
>> It's not efficient enough. Therefore, we can add a new tracepoint that
> 
> "It's not efficient enough." is a vague statement. How was efficiency measured?
> and what is "enough"?
> 
> Please do not impersonate code ("we can add a new ...") and stick to the 
> imperative tone. Please see the "Changelog" section in 
> Documentation/process/maintainer-tip.rst for more details.
> 
> 
>> shows the llc_occupancy of busy rmids when scanning the limbo list. It
>> can help us to adjust the resctrl_rmid_realloc_threshold to a reasonable
>> value.
>>
>> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
>> ---
>>  arch/x86/kernel/cpu/resctrl/Makefile        |  1 +
>>  arch/x86/kernel/cpu/resctrl/monitor.c       |  5 ++++
>>  arch/x86/kernel/cpu/resctrl/monitor_event.h | 30 +++++++++++++++++++++
>>  3 files changed, 36 insertions(+)
>>  create mode 100644 arch/x86/kernel/cpu/resctrl/monitor_event.h
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/Makefile b/arch/x86/kernel/cpu/resctrl/Makefile
>> index 4a06c37b9cf1..0d3031850d26 100644
>> --- a/arch/x86/kernel/cpu/resctrl/Makefile
>> +++ b/arch/x86/kernel/cpu/resctrl/Makefile
>> @@ -1,4 +1,5 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  obj-$(CONFIG_X86_CPU_RESCTRL)	+= core.o rdtgroup.o monitor.o
>>  obj-$(CONFIG_X86_CPU_RESCTRL)	+= ctrlmondata.o pseudo_lock.o
>> +CFLAGS_monitor.o = -I$(src)
>>  CFLAGS_pseudo_lock.o = -I$(src)
> 
> From what I understand only one of the c files should define CREATE_TRACE_POINTS
> and it is that c file that should have its CFLAGS modified.
> 
> I do not think it is necessary to preemptively fragment the resctrl tracing by creating
> a separate header file for the monitor tracepoints. This is something that may be
> needed as part of current re-design but I think it best to have a simple start that
> places all tracepoints in the same header file.
> 
> I would thus like to propose that this work starts by renaming pseudo_lock_event.h
> to a more generic (trace.h?) that will contain all the tracepoints. pseudo-lock.c
> is the file that define's CREATE_TRACE_POINTS so it should remain as the only
> one with its CFLAGS modified. monitor.c should be able to just include "trace.h"
> (after "trace.h" is updated with the new tracepoint) without needing to define
> CREATE_TRACE_POINTS.
> 
> 
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index f136ac046851..a6f94fcae174 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -24,6 +24,10 @@
>>  
>>  #include "internal.h"
>>  
>> +#define CREATE_TRACE_POINTS
>> +#include "monitor_event.h"
>> +#undef CREATE_TRACE_POINTS
>> +
>>  struct rmid_entry {
>>  	u32				rmid;
>>  	int				busy;
>> @@ -302,6 +306,7 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>>  			}
>>  		}
>>  		crmid = nrmid + 1;
>> +		trace_rmid_llc_occupancy(nrmid, d->id, val);
>>  	}
>>  }
>>  
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor_event.h b/arch/x86/kernel/cpu/resctrl/monitor_event.h
>> new file mode 100644
>> index 000000000000..91265a2dd2c9
>> --- /dev/null
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor_event.h
>> @@ -0,0 +1,30 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#undef TRACE_SYSTEM
>> +#define TRACE_SYSTEM resctrl
>> +
>> +#if !defined(_TRACE_MONITOR_H) || defined(TRACE_HEADER_MULTI_READ)
>> +#define _TRACE_MONITOR_H
>> +
>> +#include <linux/tracepoint.h>
>> +
>> +TRACE_EVENT(rmid_llc_occupancy,
>> +	    TP_PROTO(u32 rmid, int id, u64 occupancy),
>> +	    TP_ARGS(rmid, id, occupancy),
>> +	    TP_STRUCT__entry(__field(u32, rmid)
>> +			     __field(int, id)
>> +			     __field(u64, occupancy)),
>> +	    TP_fast_assign(__entry->rmid = rmid;
>> +			   __entry->id = id;
>> +			   __entry->occupancy = occupancy;),
>> +	    TP_printk("rmid=%u domain=%d occupancy=%llu",
>> +		      __entry->rmid, __entry->id, __entry->occupancy)
>> +	   );
>> +
> 
> Naming is always complicated but I would like to make two proposals with
> motivation:
> a) Please prefix this event with "mon_" as the first member of a new
>    "monitor" category of resctrl tracepoints. Users can then interact
>    with monitor tracepoints with convenience of "mon*". Later we could
>    perhaps add a new "alloc*" category.
> b) Please replace all "rmid" exposure to user space with a more generic
>    "mon_hw_id", or if "mon" is clear, just "hw_id". For reference you
>    can search for "mon_hw_id" in Documentation/arch/x86/resctrl.rst.
>    This is needed because resctrl is in the process of being able to
>    be an interface for Arm's MPAM and "rmid" is an x86 specific term.
> 
> Considering this, what do you think of something like:
> tracepoint name: mon_llc_occupancy_limbo
> print: "mon_hw_id=%u domain=%d llc_occupancy=%llu"
> 
>> +#endif /* _TRACE_MONITOR_H */
>> +
>> +#undef TRACE_INCLUDE_PATH
>> +#define TRACE_INCLUDE_PATH .
>> +#define TRACE_INCLUDE_FILE monitor_event
>> +
>> +/* This part must be outside protection */
>> +#include <trace/define_trace.h>
> 
> Thank you.
> 
> Reinette


Thanks for your suggestions and I'll post a new version later.

