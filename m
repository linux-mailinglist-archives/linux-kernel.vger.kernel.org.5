Return-Path: <linux-kernel+bounces-106433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E46487EE99
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E9131F2553E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD045577F;
	Mon, 18 Mar 2024 17:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UgeOcfRo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573CD54FB2;
	Mon, 18 Mar 2024 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710782313; cv=none; b=B0by85MHGwVrFEZrWrG1nlUiPWbpj8lTpIWoQYTJMQN6DYQlk1jYEoDfSq1ssUt/GRGSthpmAULmm2Fk56l57lcfC5+xftopiV2s4Te+lDsa6cIausyrEC/pUgvto07GNcBqOUlFQV4gQ0H7Z0d/xybHNFoPa7FyxHHJTCGSVwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710782313; c=relaxed/simple;
	bh=kB1BfcnH1gGgRg9h/FRPbVxxSesun57koqo1O+2M/g4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AuurxW9oK2F6l5kROv2tBwA+qZmdkKJNzTu0hwxqW7OhipoLCcEVFTXAav+fSl0IDihCtzdazYUsi5XS2yjls9AsOtPcIBlesTThYubLUONMfpRx0jCwzPumJSW6cry6mkDTw+zcTlMySvngBp77tDEnQfja/exZxLmteLsumbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UgeOcfRo; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710782313; x=1742318313;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kB1BfcnH1gGgRg9h/FRPbVxxSesun57koqo1O+2M/g4=;
  b=UgeOcfRo+th22fpBtj6n+YDLT6VJX1Xixp/wBhPG9MWh6kfz9nRm94Ww
   GxYPGwMh3S6QrMLwdDV0oSSucopWVNXIox8bnoeAdCyX44FcM7aOmcyol
   IfnQpHH4ILmQ8/N3yx9gIG3KIthCk+/EfbzRTRWZf8l/eQ3LjpYQKLF86
   2qEU8T06biUc2OjNsTv1qxr4l19g29ZFXTsNnE58pSKKr31dVyZMka+mj
   eyYNkxvYNfdclVtp4YNJg2gY5iEo60Q+GDsTLAnSmrCO/rjmTrhIv+eec
   ysJ7G3xfCTUaLP6UPiU23wMw2KHkwE+jr6SAoC+ljg7KseYYStgxWxduX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5741369"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5741369"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 10:18:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="13434275"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 10:18:31 -0700
Received: from [10.213.175.69] (kliang2-mobl1.ccr.corp.intel.com [10.213.175.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 257DC580D4E;
	Mon, 18 Mar 2024 10:18:29 -0700 (PDT)
Message-ID: <0fc14528-e394-4e5b-968f-bd9c6ab6de56@linux.intel.com>
Date: Mon, 18 Mar 2024 13:18:27 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel/uncore: Fix the bits of the CHA extended
 umask for SPR
To: Ingo Molnar <mingo@kernel.org>
Cc: peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 mpetlan@redhat.com, eranian@google.com, ak@linux.intel.com,
 stable@vger.kernel.org, Ian Rogers <irogers@google.com>
References: <20240214155740.3256216-1-kan.liang@linux.intel.com>
 <CAP-5=fVeQdNYPwxc02KVCM0uAhw0u5im99gZKvAo4NTvA+nUuw@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fVeQdNYPwxc02KVCM0uAhw0u5im99gZKvAo4NTvA+nUuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-02-14 6:45 p.m., Ian Rogers wrote:
> On Wed, Feb 14, 2024 at 7:58 AM <kan.liang@linux.intel.com> wrote:
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The perf stat errors out with UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL
>> event.
>>
>>  $perf stat -e uncore_cha_55/event=0x35,umask=0x10c0008101/ -a -- ls
>>     event syntax error: '..0x35,umask=0x10c0008101/'
>>                                       \___ Bad event or PMU
>>
>> The definition of the CHA umask is config:8-15,32-55, which is 32bit.
>> However, the umask of the event is bigger than 32bit.
>> This is an error in the original uncore spec.
>>
>> Add a new umask_ext5 for the new CHA umask range.
>>
>> Fixes: 949b11381f81 ("perf/x86/intel/uncore: Add Sapphire Rapids server CHA support")
>> Closes: https://lore.kernel.org/linux-perf-users/alpine.LRH.2.20.2401300733310.11354@Diego/
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> Cc: stable@vger.kernel.org
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Hi Ingo,

Could you please take a look at the patch? If it's OK for you, could you
please merge the fix?

Thanks,
Kan

> 
> Thanks,
> Ian
> 
>> ---
>>  arch/x86/events/intel/uncore_snbep.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
>> index a96496bef678..7924f315269a 100644
>> --- a/arch/x86/events/intel/uncore_snbep.c
>> +++ b/arch/x86/events/intel/uncore_snbep.c
>> @@ -461,6 +461,7 @@
>>  #define SPR_UBOX_DID                           0x3250
>>
>>  /* SPR CHA */
>> +#define SPR_CHA_EVENT_MASK_EXT                 0xffffffff
>>  #define SPR_CHA_PMON_CTL_TID_EN                        (1 << 16)
>>  #define SPR_CHA_PMON_EVENT_MASK                        (SNBEP_PMON_RAW_EVENT_MASK | \
>>                                                  SPR_CHA_PMON_CTL_TID_EN)
>> @@ -477,6 +478,7 @@ DEFINE_UNCORE_FORMAT_ATTR(umask_ext, umask, "config:8-15,32-43,45-55");
>>  DEFINE_UNCORE_FORMAT_ATTR(umask_ext2, umask, "config:8-15,32-57");
>>  DEFINE_UNCORE_FORMAT_ATTR(umask_ext3, umask, "config:8-15,32-39");
>>  DEFINE_UNCORE_FORMAT_ATTR(umask_ext4, umask, "config:8-15,32-55");
>> +DEFINE_UNCORE_FORMAT_ATTR(umask_ext5, umask, "config:8-15,32-63");
>>  DEFINE_UNCORE_FORMAT_ATTR(qor, qor, "config:16");
>>  DEFINE_UNCORE_FORMAT_ATTR(edge, edge, "config:18");
>>  DEFINE_UNCORE_FORMAT_ATTR(tid_en, tid_en, "config:19");
>> @@ -5957,7 +5959,7 @@ static struct intel_uncore_ops spr_uncore_chabox_ops = {
>>
>>  static struct attribute *spr_uncore_cha_formats_attr[] = {
>>         &format_attr_event.attr,
>> -       &format_attr_umask_ext4.attr,
>> +       &format_attr_umask_ext5.attr,
>>         &format_attr_tid_en2.attr,
>>         &format_attr_edge.attr,
>>         &format_attr_inv.attr,
>> @@ -5993,7 +5995,7 @@ ATTRIBUTE_GROUPS(uncore_alias);
>>  static struct intel_uncore_type spr_uncore_chabox = {
>>         .name                   = "cha",
>>         .event_mask             = SPR_CHA_PMON_EVENT_MASK,
>> -       .event_mask_ext         = SPR_RAW_EVENT_MASK_EXT,
>> +       .event_mask_ext         = SPR_CHA_EVENT_MASK_EXT,
>>         .num_shared_regs        = 1,
>>         .constraints            = skx_uncore_chabox_constraints,
>>         .ops                    = &spr_uncore_chabox_ops,
>> --
>> 2.35.1
>>
> 

