Return-Path: <linux-kernel+bounces-88861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9FA86E7AA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C730A1F26F23
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EED10A26;
	Fri,  1 Mar 2024 17:47:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A304C99
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 17:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709315267; cv=none; b=pWbyo5kxgcSG9PuTS1dz+QfFvrC80Le0p0tGI8YHoA6Fx+mVCbUAmQnP5CpOw9hia/mDWPann8iDTHC1rUmgYZemsLOVMX8cCx+d5N45HE7pGaGc9+vF+IrdgxlQvMdkKVIkhEukXihMRaDoLyjcjgf6XtMYlS7EgoymNGTy3UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709315267; c=relaxed/simple;
	bh=j7SJrlITQfpEw1xODC/JECxRyDSYKsKUHLg8ugRnjqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CsEY4TGO877k88p9ySv2dEQqFVhTXEfC/PvxHCitTwDkF5e5Wj3duiP0Ra364jrlqUfW0yrejiyE1ep2XPpeX2+NHO0nrLLSfVBR2S92DesAVRjH9dwWIJzGgeNc3665/LrW6JKvbA/SJB3G62mR/gCNrYiAXsuRhu6E8pkRKsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 248991FB;
	Fri,  1 Mar 2024 09:48:18 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97FE43F6C4;
	Fri,  1 Mar 2024 09:47:38 -0800 (PST)
Message-ID: <3d9251ba-f9fd-4648-82bb-df23b9995452@arm.com>
Date: Fri, 1 Mar 2024 17:47:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] x86/resctrl: Add tracepoint for llc_occupancy
 tracking
Content-Language: en-GB
To: Reinette Chatre <reinette.chatre@intel.com>,
 Haifeng Xu <haifeng.xu@shopee.com>
Cc: fenghua.yu@intel.com, babu.moger@amd.com, peternewman@google.com,
 x86@kernel.org, linux-kernel@vger.kernel.org
References: <20240221092101.90740-1-haifeng.xu@shopee.com>
 <20240221092101.90740-3-haifeng.xu@shopee.com>
 <371242fb-dce2-4de0-bba9-4d85475d5d9a@intel.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <371242fb-dce2-4de0-bba9-4d85475d5d9a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 23/02/2024 19:41, Reinette Chatre wrote:
> On 2/21/2024 1:21 AM, Haifeng Xu wrote:
>> In our production environment, after removing monitor groups, those unused
>> RMIDs get stuck in the limbo list forever because their llc_occupancy are
>> always larger than the threshold. But the unused RMIDs can be successfully
>> freed by turning up the threshold.
>>
>> In order to know how much the threshold should be, the following steps can
>> be taken to acquire the llc_occupancy of RMIDs in each rdt domain:
>>
>> 1) perf probe -a '__rmid_read eventid rmid'
>>    perf probe -a '__rmid_read%return $retval'
>> 2) perf record -e probe:__rmid_read -e probe:__rmid_read__return -aR sleep 10
>> 3) perf script > __rmid_read.txt
>> 4) cat __rmid_read.txt | grep "eventid=0x1 " -A 1 | grep "kworker" > llc_occupnacy.txt

Ah, this ftrace trickery. It wouldn't be portable - I agree a tracepoint is much better!


> The details on how perf can be used was useful during the discussion of this
> work but can be omitted from this changelog.
> 
>> Instead of using perf tool to track llc_occupancy and filter the log manually,
>> it is more convenient for users to use tracepoint to do this work. So add a new
>> tracepoint that shows the llc_occupancy of busy RMIDs when scanning the limbo
>> list.

>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index f136ac046851..1533b1932b49 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -23,6 +23,7 @@
>>  #include <asm/resctrl.h>
>>  
>>  #include "internal.h"
>> +#include "trace.h"
>>  
>>  struct rmid_entry {
>>  	u32				rmid;
>> @@ -302,6 +303,7 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>>  			}
>>  		}
>>  		crmid = nrmid + 1;
>> +		trace_mon_llc_occupancy_limbo(nrmid, d->id, val);

> This area recently received some changes (you can find the latest on the
> x86/cache branch of the tip repo). Please see [1] for a good
> description of the new "index". For this tracing to be useful to MPAM
> I thus expect that the tracepoint will need to print the MPAM equivalent
> to CLOSID, the PARTID. We can refer to this CLOSID/PARTID value as
> "ctrl_hw_id".
> 
> This snippet can then change to use the new resctrl_arch_rmid_idx_decode()
> to learn the "ctrl_hw_id" and "mon_hw_id" and print it as part of
> tracepoint:
> "ctrl_hw_id=%u mon_hw_id=%u domain=%d llc_occupancy=%llu"
> 
> This will be filesystem code so it cannot know how an architecture
> treats these numbers. Consequently, this may look strange to x86 users
> when ctrl_hw_id will always be X86_RESCTRL_EMPTY_CLOSID ... but it should
> be clear that it is invalid? 


> James, what do you think? Any thoughts on how MPAM will use the limbo handler
> to understand what information can be useful to the user here?

Initially it will be exactly the same, and this certainly works. I agree outputting both
the CLOSID and RMID (with more portable names) is the right thing to do.

I'll reply in more detail on what appears to be v3.
lore.kernel.org/r/20240229071125.100991-1-haifeng.xu@shopee.com


Thanks,

James

