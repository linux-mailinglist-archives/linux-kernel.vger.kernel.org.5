Return-Path: <linux-kernel+bounces-57976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CAB84DFDD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56D671F214FE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95F16F096;
	Thu,  8 Feb 2024 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aOy9x9Rv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A336F079;
	Thu,  8 Feb 2024 11:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707392471; cv=none; b=S8K9ubfolr0iuIWEMoPkbY/4GKhUWf4m4Oc34JMCJ5rbQ8w5T3MHamdIueW8yXUBcDQ0E4PvEz+7PqyAzGwmyv1s42/PfvJD6A7Ux2wKi//xxpvAg6hIBooXruUcJ9Qt1r46+q7PH/uqeFViTtxCbLxrY2hgPfH7lKb7J2Dyewk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707392471; c=relaxed/simple;
	bh=p6MmZDZ286zVVAy/pVq6azWTqolhe5LOY18uDbtN6ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2YyoCNQo5BU+uh5BCBjMtx07nK/A5HfP/1UHtWgEDYUc6x8N6uHl5O6/K9cYtRBXzI/jGrimilzQMssZLJxYMAXg/Vat59dnKywIIt0eboBUMlWC01k0UbJMlqK5K6O/oDbHxBbYojVvW6OwB6O7+UIe0yXwv90niGIYnco9oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aOy9x9Rv; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707392469; x=1738928469;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=p6MmZDZ286zVVAy/pVq6azWTqolhe5LOY18uDbtN6ck=;
  b=aOy9x9RvczTnyD9bmX5OeCR94+C8Tnnvv2xNBYJFNc/rvJON4/MrJjmf
   Oe5SrjsCQ4NRA0JQEQcjtoK55sVouD2eSGGsbJxxhTriyP2f1d+mVaME2
   aMaVkyRCdBk4PaOw2ub9E9OdWoFX5iH1oTDSftyILXBr/Wj6dwTLznEbS
   7DHTA2JDNsMnbROxNinXpFD3ZY6FUphKJ3ComaKUbUwIO0m3IUvSaPoi9
   A4v4KJUSe/D7U7tG9MYs/52iUDPDP7D5/dDtx6Pqt3udDZJSJiJSoCcmV
   BPWp4Smyvq76t17FRuUbYpU8qJinAXgLtsvggvm+1gdx3tuKPGTWpiPYt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1091981"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1091981"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 03:41:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1914877"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.219.88])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 03:41:02 -0800
Message-ID: <86490ec4-423e-4a7d-881b-56c47b3320ce@intel.com>
Date: Thu, 8 Feb 2024 13:40:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 00/11] perf/core: Add ability for an event to "pause"
 or "resume" AUX area tracing
To: James Clark <james.clark@arm.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, Yicong Yang
 <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Will Deacon <will@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20240111081914.3123-1-adrian.hunter@intel.com>
 <31bae596-ecb1-4b9c-9f1c-aaec4bcefd38@intel.com>
 <CAP-5=fUo96EABpH6=7i2cXFmZhAB2MM=UsnG-+vL4HJtLGS=bA@mail.gmail.com>
 <a4c616ff-12bf-592b-b74d-407013a68cb7@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <a4c616ff-12bf-592b-b74d-407013a68cb7@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/02/24 18:29, James Clark wrote:
> 
> 
> On 31/01/2024 16:53, Ian Rogers wrote:
>> On Mon, Jan 29, 2024 at 4:49 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>
>>> On 11/01/24 10:19, Adrian Hunter wrote:
>>>> Hi
>>>>
>>>> Hardware traces, such as instruction traces, can produce a vast amount of
>>>> trace data, so being able to reduce tracing to more specific circumstances
>>>> can be useful.
>>>>
>>>> The ability to pause or resume tracing when another event happens, can do
>>>> that.
>>>>
>>>> These patches add such a facilty and show how it would work for Intel
>>>> Processor Trace.
>>>>
>>>> Maintainers of other AUX area tracing implementations are requested to
>>>> consider if this is something they might employ and then whether or not
>>>> the ABI would work for them.
>>>>
>>>> Changes to perf tools are now (since V4) fleshed out.
>>>>
>>>>
>>>> Changes in V4:
>>>>
>>>>     perf/core: Add aux_pause, aux_resume, aux_start_paused
>>>>       Rename aux_output_cfg -> aux_action
>>>>       Reorder aux_action bits from:
>>>>               aux_pause, aux_resume, aux_start_paused
>>>>       to:
>>>>               aux_start_paused, aux_pause, aux_resume
>>>>       Fix aux_action bits __u64 -> __u32
>>>>
>>>>     coresight: Have a stab at support for pause / resume
>>>>       Dropped
>>>>
>>>>     perf tools
>>>>       All new patches
>>>>
>>>> Changes in RFC V3:
>>>>
>>>>     coresight: Have a stab at support for pause / resume
>>>>       'mode' -> 'flags' so it at least compiles
>>>>
>>>> Changes in RFC V2:
>>>>
>>>>       Use ->stop() / ->start() instead of ->pause_resume()
>>>>       Move aux_start_paused bit into aux_output_cfg
>>>>       Tighten up when Intel PT pause / resume is allowed
>>>>       Add an example of how it might work for CoreSight
>>>
>>> Any more comments?
>>
>> I think the tools side looks good. The parsing changes match the
>> existing style. I wonder if it wouldn't be better to handle the valid
>> strings (pause, resume, etc.) in the lexer rather than a separate
>> parse function, but the pattern used matches the existing one. You can
>> have my Acked-by on the tools changes, although the subtleties of ARM
>> PMUs makes me somewhat nervous in this regard.
>>
>> Thanks,
>> Ian
> 
> Acked-by: James Clark <james.clark@arm.com>
> 
> I will get round to adding the Coresight support at some point. I
> checked the new parsing in this version and it seems to work ok.

Thanks James and Ian!

