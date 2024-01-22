Return-Path: <linux-kernel+bounces-32702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F817835F18
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280C4286E86
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9B739FFF;
	Mon, 22 Jan 2024 10:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uy+tIs16"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92001364AE;
	Mon, 22 Jan 2024 10:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705918054; cv=none; b=GJWhyFeycWmpFV478Kk1gNBIFolvwRMkPJVOMj95aD6vTCXe8bABVInExwzSnYFHYoQuZ2La+VQmtAoi2emYKsVG0/HEbybTJutdW1xLTO5ioG85AqtbLp7pW/KQYjsf1vWxJF0/eBHg5m+4flJ7Vc0xA6gJ/jEYbGoSPuppQik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705918054; c=relaxed/simple;
	bh=0wzkn/nXa4IiI3D1ZR3+O1A/pAiTo+X2iTrOpOciyHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ua8ELLXsfJTZEErDIJErFJXpOsWLWtGU0Ma1t2lJ+JdtcTaUZu5ll7UzS4IXPlpKUlidd5j0p7VIfNAWaOl7kqAJKoEEbI1CssONBNq8ussDzlVg7WmNAYTCN1ZRvQgwBy727GAIcNN2zRjQPo4SXwQhv1xIbkMyOR78aM35i6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uy+tIs16; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705918053; x=1737454053;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0wzkn/nXa4IiI3D1ZR3+O1A/pAiTo+X2iTrOpOciyHo=;
  b=Uy+tIs16rIGo20MQHNLftGdqHij9WOmERkfNOT/ygMIdGZZBYnAhJzi3
   SM0v2HRZG0D73RBip+ntk9VKtO3o69jpF8j5XevoBqngJ9yPY6M+NPQtD
   s/V8Mivtl6GNgzYWVlhkcmyvLxJebcCbttplu0VN5vRljNoZio3HJ2fic
   N8xTWTThv/WLqqnfFY63b5DKPFHrfNY/WMjDw+59msYJX8AFE/VJ+M3eN
   rg7OTL5/lGvJu9RAlbdBUXTInINe03YZPas0yY7qQcqpUFJ+O4cG3l0ha
   bCLDy3FQ0T6rNUolpfw4sOcpiejogPj2N+sRIl6RQQ8Uhs7hjYnjw5QU2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="7913630"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="7913630"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 02:07:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="875931917"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="875931917"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.40.86])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 02:07:25 -0800
Message-ID: <48426eb3-b424-43f5-8e7c-2c1b7d77e76b@intel.com>
Date: Mon, 22 Jan 2024 12:07:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 10/11] perf intel-pt: Add documentation for pause /
 resume
Content-Language: en-US
To: Namhyung Kim <namhyung@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Will Deacon
 <will@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20240111081914.3123-1-adrian.hunter@intel.com>
 <20240111081914.3123-11-adrian.hunter@intel.com>
 <87ply1lebh.fsf@linux.intel.com>
 <60cc9fa8-e714-41d0-a82d-9c8a54dfde4e@intel.com>
 <CAM9d7cg3T6DKoyDj4G7+9rQosqVKhCPpS0DZEXuLgbVwe+QM4w@mail.gmail.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAM9d7cg3T6DKoyDj4G7+9rQosqVKhCPpS0DZEXuLgbVwe+QM4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/01/24 23:28, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Jan 16, 2024 at 4:22 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 16/01/24 13:15, Andi Kleen wrote:
>>> Adrian Hunter <adrian.hunter@intel.com> writes:
>>>> +
>>>> +For example, to trace only the uname system call (sys_newuname) when running the
>>>> +command line utility uname:
>>>> +
>>>> + $ perf record --kcore -e
>>>> intel_pt/aux-action=start-paused/k,syscalls:sys_enter_newuname/aux-action=resume/,syscalls:sys_exit_newuname/aux-action=pause/
>>>> uname
>>>
>>> It's unclear if the syntax works for hardware break points, kprobes, uprobes too?
>>
>> Yes, the perf tool syntax requires only that the group leader is
>> an AUX area event like intel_pt.  Note that an attempt is made to
>> automatically group AUX area events with events with aux-action,
>> so grouping syntax like '{...}' is not always necessary.
> 
> Depends on the position, right?  Maybe there can be other events
> without aux-action mixed with aux events.

Yes it depends on position. Non-grouped events in between will get
grouped too. So:

-e intel_pt --filter=blah  -e not_grouped_event -e some_event/aux-action=resume/

would put those 3 in a group, but still allow --filter.

> 
> Thanks,
> Namhyung
> 
>>
>> Note the current kernel implementation is called from
>> __perf_event_output() which is used in nearly all cases for the
>> output of samples, the exceptions being Intel BTS (which we do not
>> support at the same time as Intel PT, but wouldn't make much sense
>> anyway) and S390 cpumsf_output_event_pid().
>>
>>> That would be most useful. If it works would be good to add examples for it.
>>
>> OK
>>


