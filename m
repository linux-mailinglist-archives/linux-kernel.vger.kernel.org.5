Return-Path: <linux-kernel+bounces-119514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D7088C9DA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB9941C63717
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFCA1AAC4;
	Tue, 26 Mar 2024 16:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ICDIhL6y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F4C1CD29;
	Tue, 26 Mar 2024 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471941; cv=none; b=eHEkgmMz6tuiFNq6Sb763uQu6y2+UsE+a7feLhzT13SCH8Nul6VGWq12KugOsEkDfqd6eZaxye9GRIIeY2L9V86tE96VAYroROWxpniHzE+tgWnpqXkR2fh6YP3X3efd3Dc058iyghXAdKkNMS2IF/JxzRi/JetV+IDc92giJBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471941; c=relaxed/simple;
	bh=N+Dt/iZigqeoumWIy2r6MS6eRcAIzZrAUwOHaXrom4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ixUQ1iCoGHcvzXiiwYhb0OTRNUdCRJfm51bqTCC6F3edn4P7FUac24rmRzYBq1uedYROCUBIenTX1n83WeljZxOSitQNLVUFPQL8Ionb8lg3u3GbLZ5dLMbyiWa7RuoFrYMEUS0viOwMZMnAV7sTL8g8w1TUzxc20u2hFhZ1ZU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ICDIhL6y; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711471940; x=1743007940;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N+Dt/iZigqeoumWIy2r6MS6eRcAIzZrAUwOHaXrom4Y=;
  b=ICDIhL6yDrtG3KM6LA2QU2thT7mXG9wCqQW06So2+c3I2+FJfkjD5AjE
   j1+x2ThgR5tkPDo19LHXn5umrLoXIRL8oj187gWhtsbwr4ILBW/kZVi2L
   O2OpFbgf+bICGBOpDghhlx2RB4iGHurjJNg7s6Ojkhk9jNKLB/yvd/oJ2
   KthA3iMZ5A3nYsZU6Xvf7qcoHM7ShQL7bxqAnMju14mxosX9b89i2TmEd
   HGYbEirvFhExF13XoSn0WKQ4vt7t9+RBt2Ianlmq8bw1PD7+IjLrROE3H
   gM9KnbP/yIrLdo/G/KcM5DVmxB50HAG/JNBv0l1S/MJcj1kZrj0o3GIis
   w==;
X-CSE-ConnectionGUID: okyzKbozTKyavVp4rsR2Rw==
X-CSE-MsgGUID: NkvSWpJ4SN+3XBPEoohgkw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="17267365"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="17267365"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 09:52:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="16076898"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.38.215])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 09:52:17 -0700
Message-ID: <d7b31967-0820-4eef-8746-db0299af154f@intel.com>
Date: Tue, 26 Mar 2024 18:52:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf intel-pt: Fix unassigned instruction op
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20240320162619.1272015-1-irogers@google.com>
 <20240326083223.10883-1-adrian.hunter@intel.com>
 <CAP-5=fVbR8xvFvG_cnzq6==QbZ1wX9mPT-RWHEMgaTp6ic0jNA@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fVbR8xvFvG_cnzq6==QbZ1wX9mPT-RWHEMgaTp6ic0jNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/03/24 18:13, Ian Rogers wrote:
> On Tue, Mar 26, 2024 at 1:32 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> MemorySanitizer discovered instances where the instruction op value was
>> not assigned.:
>>
>>   WARNING: MemorySanitizer: use-of-uninitialized-value
>>     #0 0x5581c00a76b3 in intel_pt_sample_flags tools/perf/util/intel-pt.c:1527:17
>>   Uninitialized value was stored to memory at
>>     #0 0x5581c005ddf8 in intel_pt_walk_insn tools/perf/util/intel-pt-decoder/intel-pt-decoder.c:1256:25
>>
>> The op value is used to set branch flags for branch instructions
>> encountered when walking the code, so fix by setting op to
>> INTEL_PT_OP_OTHER in other cases.
>>
>> Reported-by: Ian Rogers <irogers@google.com>
>> Closes: https://lore.kernel.org/linux-perf-users/20240320162619.1272015-1-irogers@google.com/
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Great, thanks! Should it have a Fixes tag like:
> 
> Fixes: 4c761d805bb2 ("perf intel-pt: Fix intel_pt_fup_event()
> assumptions about setting state type")

Yes, I should have put a fixes tag, cc stable.  I think the issue
has always been there, so:

Fixes: 90e457f7be087 ("perf tools: Add Intel PT support")
Cc: stable@vger.kernel.org

> 
> Tested-by: Ian Rogers <irogers@google.com>
> 
> Ian
> 
>> ---
>>  tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 2 ++
>>  tools/perf/util/intel-pt.c                          | 2 ++
>>  2 files changed, 4 insertions(+)
>>
>> diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
>> index b450178e3420..e733f6b1f7ac 100644
>> --- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
>> +++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
>> @@ -1319,6 +1319,8 @@ static bool intel_pt_fup_event(struct intel_pt_decoder *decoder, bool no_tip)
>>         bool ret = false;
>>
>>         decoder->state.type &= ~INTEL_PT_BRANCH;
>> +       decoder->state.insn_op = INTEL_PT_OP_OTHER;
>> +       decoder->state.insn_len = 0;
>>
>>         if (decoder->set_fup_cfe_ip || decoder->set_fup_cfe) {
>>                 bool ip = decoder->set_fup_cfe_ip;
>> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
>> index f38893e0b036..4db9a098f592 100644
>> --- a/tools/perf/util/intel-pt.c
>> +++ b/tools/perf/util/intel-pt.c
>> @@ -764,6 +764,7 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
>>
>>         addr_location__init(&al);
>>         intel_pt_insn->length = 0;
>> +       intel_pt_insn->op = INTEL_PT_OP_OTHER;
>>
>>         if (to_ip && *ip == to_ip)
>>                 goto out_no_cache;
>> @@ -898,6 +899,7 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
>>
>>                         if (to_ip && *ip == to_ip) {
>>                                 intel_pt_insn->length = 0;
>> +                               intel_pt_insn->op = INTEL_PT_OP_OTHER;
>>                                 goto out_no_cache;
>>                         }
>>
>> --
>> 2.34.1
>>


