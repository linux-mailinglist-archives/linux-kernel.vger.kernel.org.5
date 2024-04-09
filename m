Return-Path: <linux-kernel+bounces-137481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DFA89E2BC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09FBD283D6E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3720156F45;
	Tue,  9 Apr 2024 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bcdkYf9l"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE1879CF;
	Tue,  9 Apr 2024 18:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712688627; cv=none; b=QJL7Le5SJoeY5Gao7cqfIe4Fff0+K2Eqzyn3dOjJWMl6OLcs+ZmS6W5J/CXfT324y8+JDWLlK1XZLJJBagekLGYkQvVJ7S3BfA+Dr81pFjgus4IEYY3xjjzwARKg9qXTd5jFFnJEV9bqH4sUn2ta7ZdqG80mZt9BF3vY9kugk9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712688627; c=relaxed/simple;
	bh=FguMz23FW6ZbatJSy5rT04Y4YJTScx64eYTx+iYHe4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c2RFwHhFllfLanWJ+1gA5AO/nhu/UfEIcw+CQyQTsuctokbR0ZlMXMVFsrYFk6quqDL893cnBJ7Z13/oGsEKNdjseDm+YlantrjG5ti+KC5wwRHq0rDDUZy6v4noJFo/Kqlrn070IM7UsK4J3sQ5v9SdNDHzcCOzs5IWAYiGueQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bcdkYf9l; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712688626; x=1744224626;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FguMz23FW6ZbatJSy5rT04Y4YJTScx64eYTx+iYHe4I=;
  b=bcdkYf9l2xoJ1kVddAWQiqb964ILlT6xX2Y1RGa72NwO7umrkoHxhl9m
   QB2bPuB/WM2NIGxZaXTzbYTllRBxV08BAYYAuAG0bNn6cnjC7j+d0wQGQ
   IImAwWUgXhAdIFGjrcfVwOLSLeElL4GWzALi64oZQomn66Qjavdi9gRUh
   EleuYMuJmpATfxDY0V0i3r/j3KxwZVs//uOVCfXI10QHCqE4+DVUEtr/Q
   rayoS/xOqGPd2IP7r8B1Vf4L9nod34R4yML+vqBmwsObNosU0QlnTQioo
   MiaiqG7XUz8OXt6nZ5P/EcrgfvyncP/gvEBFZKUSxqLON+0wx3yif6ypf
   A==;
X-CSE-ConnectionGUID: O/cGXXdeR7ehozucopAiqg==
X-CSE-MsgGUID: 1fbEFCJ0QZSq/gV0YGgtDg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="25523567"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25523567"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 11:50:25 -0700
X-CSE-ConnectionGUID: 4F9BKsHOTVqt98KLthO6/w==
X-CSE-MsgGUID: g/MFK4g8T6yQSBn6LV4O7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="43544562"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 11:50:25 -0700
Received: from [10.213.177.168] (kliang2-mobl1.ccr.corp.intel.com [10.213.177.168])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id C1D1F20B573A;
	Tue,  9 Apr 2024 11:50:22 -0700 (PDT)
Message-ID: <8fb7e240-07af-4c7e-8eac-60731d837bd7@linux.intel.com>
Date: Tue, 9 Apr 2024 14:50:21 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf stat: Remove evlist__add_default_attrs use
 strings
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@arm.com>, Yang Jihong <yangjihong1@huawei.com>,
 Kaige Ye <ye@kaige.org>, Yicong Yang <yangyicong@hisilicon.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240406073804.1932415-1-irogers@google.com>
 <0d498870-b235-4860-9563-befcddf0ec3e@linux.intel.com>
 <CAP-5=fU=bEvzWw+62HxL=5kOSqQxaBYeDBomv8Fdu+R+fNv5sw@mail.gmail.com>
 <cd4b5229-b938-44ef-822a-68d29c463aa7@linux.intel.com>
 <CAP-5=fUNTiju7sv5R3P+=rUm-BzL_HmaEicdhCuBVPKooPHWeA@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fUNTiju7sv5R3P+=rUm-BzL_HmaEicdhCuBVPKooPHWeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-04-09 12:04 p.m., Ian Rogers wrote:
> On Tue, Apr 9, 2024 at 9:00 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2024-04-09 11:20 a.m., Ian Rogers wrote:
>>>>> +             ret = parse_events(evlist,
>>>>> +                             "context-switches,"
>>>>> +                             "cpu-migrations,"
>>>>> +                             "page-faults,"
>>>>> +                             "instructions,"
>>>>> +                             "cycles,"
>>>> "cycles",
>>>> "instructions",
>>>>
>>>> It's better to keep the original order.
>>> So the original order was:
>>> "cycles,"
>>> "stalled-cycles-frontend,"
>>> "stalled-cycles-backend,"
>>> "instructions"
>>>
>>
>> Right. The stalled-* events are added between default_attrs0 and
>> default_attrs1.
>>
>>
>>> but many/most/all core PMUs don't provide the stalled-* events. At the
>>> programmer level instructions is the most fundamental thing, so having
>>> it last felt wrong hence moving it to be the first after the software
>>> events. My thought was, if we're going to reorder things then let's
>>> not do a half measure like:
>>> "cycles,"
>>> "instructions,"
>>> "stalled-cycles-frontend,"
>>> "stalled-cycles-backend"
>>>
>>> let's just put things into their best order. It is obviously easy to
>>> change but having this way wasn't an accident. There's obviously
>>> subjectivity about whether cycles is more fundamental than
>>> instructions, my thought is that you get taught instructions first and
>>> that these take some number of cycles to execute, hence thinking
>>> instructions should have some priority in the output over cycles -
>>> some people may not even know what cycles means, it is hard enough
>>> when you do given the variety of different clocks 🙂
>>>
>>
>> My concern is that there may be someone who still relies on the std
>> output of perf stat default. So the output format/order matters for
>> them. Their scripts probably be broken if the order is changed.
> 
> I think making everyone suffer for the case of a tool that may behave
> in this way doesn't make sense. The tool should transition to not care
> or to say the json output, or at least contribute a test. There is
> precedent for this attitude, the default metrics for topdown removed
> the event names in perf stat default output - no one screamed, and I
> expect that to be the case here.
> 

They did, but that happened after the change was merged. And there was
no test case for the output at that time.

I agree that if the order is important, there should be a test for it.
I've emailed the tool owners I know and see if the change impacts them.
But they are all out of office this week and should be back next week.
I will let you know regarding their feedback. If the order is important,
I will update the stat+std_output.sh.

Thanks,
Kan

