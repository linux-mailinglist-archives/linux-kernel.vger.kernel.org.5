Return-Path: <linux-kernel+bounces-132098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2665898F93
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41DDD28B9D5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C812F137C37;
	Thu,  4 Apr 2024 20:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZUb3Q7Wg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4881F74BE5;
	Thu,  4 Apr 2024 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712262580; cv=none; b=tsdzmBLU58lVH6nlivm3S+5CX/XBjZV+/mskX8geA9DfxTLt8SLhugATPSVUiGoQ7LCiY1IVa+rKVtzQWZ5puxRrwCkj9/mtDoNqus1A0bg9DKQakHM3EV+M4KbzLqwXEaUj/bzi7staYvGBAPODFu3Ubkx9Qw/GpRRtJlYSxBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712262580; c=relaxed/simple;
	bh=wqNFfj9b3aR76gtBX0p3eNz5eYoSoJSspbSMEOy53yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BFslgyCHffhLWSUVBQy133Rjdy3J9GepixyBVMD0w5/AURdHnYROH9XCWOvx3YZttLUPtaxDY40k4wsdT9RrNI0ofFGTDIplkaSedHS3gQpvgicnZcPyBGwX/yA3v69wHHCb1anOX/DW/QaosW8garb0gZ9le666Vt3VLXL7+RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZUb3Q7Wg; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712262578; x=1743798578;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wqNFfj9b3aR76gtBX0p3eNz5eYoSoJSspbSMEOy53yg=;
  b=ZUb3Q7WgaLtMCQdOQdUZH2vdVhvvLEq3/bamidyEHzvYsKhysGYiI557
   pMg7rskUtuzOOL73aHa9cz2jMfjCmMNY6nzL6fjs+qGK3R8qarDXfM5Hj
   IzTigOKwo9ZzP0vqDX+lYokVisOk7D4lpThThyOSi2aOt0yxQI+SEHgEO
   kDRRtW1zprXnkzbsr1lAtDj0biWjMYDGHMCiwatMhJO8c6QN9zpcD/TgQ
   cemUofeN6O+YZupMVDBiaIf3gwsXSBwNxWqj4r/5Gxdi3YQwAi4IHS31W
   WQw8UHgNfQEkWTlWAbuIiu/6X9yHHvrHQHoXEHDWS3xHUuezIHvJLcKpa
   w==;
X-CSE-ConnectionGUID: 2OQW+aMbT6KahUkqishkbg==
X-CSE-MsgGUID: sOxIEY1uQEGyUHvhh3uXng==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="18135113"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="18135113"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 13:29:37 -0700
X-CSE-ConnectionGUID: 1PJ/Bl/mRJyO7DOGslCA4A==
X-CSE-MsgGUID: lRm9VEgGSN2Hr8AVvf6RPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="23597732"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 13:29:38 -0700
Received: from [10.212.51.158] (kliang2-mobl1.ccr.corp.intel.com [10.212.51.158])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 1E75F206DFCB;
	Thu,  4 Apr 2024 13:29:36 -0700 (PDT)
Message-ID: <ceca5922-6b83-464f-9e64-e8999068f734@linux.intel.com>
Date: Thu, 4 Apr 2024 16:29:34 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf metrics: Remove the "No_group" metric group
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andi Kleen <ak@linux.intel.com>
References: <20240403164636.3429091-1-irogers@google.com>
 <dcb0121f-611d-4104-80b9-941d535c5fd2@linux.intel.com>
 <CAP-5=fUgiafmLEKEUJ5r5_tK+jqv30P0TGFCMvR8DkW7J4qYsQ@mail.gmail.com>
 <b9868e97-e353-45e0-83b7-aa28bc35dd67@linux.intel.com>
 <CAP-5=fX+YuEgD4pF-2YRcqgD2cwLw_7Z4ak+wszctvagPS+Xbw@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fX+YuEgD4pF-2YRcqgD2cwLw_7Z4ak+wszctvagPS+Xbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-04-03 4:26 p.m., Ian Rogers wrote:
> On Wed, Apr 3, 2024 at 11:57 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2024-04-03 2:31 p.m., Ian Rogers wrote:
>>> On Wed, Apr 3, 2024 at 10:59 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2024-04-03 12:46 p.m., Ian Rogers wrote:
>>>>> Rather than place metrics without a metric group in "No_group" place
>>>>> them in a a metric group that is their name. Still allow such metrics
>>>>> to be selected if "No_group" is passed, this change just impacts perf
>>>>> list.
>>>>
>>>> So it looks like the "No_group" is not completely removed.
>>>> They are just not seen in the perf list, but users can still use it via
>>>> perf stat -M No_group, right?
>>>>
>>>> If so, why we want to remove it from perf list? Where can the end user
>>>> know which metrics are included in the No_group?
>>>>
>>>> If the No_group is useless, why not completely remove it?
>>>
>>> Agreed. For command line argument deprecation we usually keep the
>>> option but hide it from help with PARSE_OPT_HIDDEN, so I was trying to
>>> follow that pattern albeit that a metric group isn't a command line
>>> option it's an option to an option.
>>>
>>
>> Perf list has a deprecated option to show the deprecated events.
>> The "No_group" should be a deprecated metrics group.
>>
>> If so, to follow the same pattern, I think perf list should still
>> display the "No_group" with the --deprecated option at least.
> 
> Such metrics would be shown twice, once under No_group and once under
> a metric group of their name.
You mean with the --deprecated option?
Yes, that's because the old/deprecated metrics group (No_group) is not
complete removed. So both the new name and old/deprecated name are shown
with the --deprecated option. The metrics which belong to both groups
will be shown twice.

Without the --deprecated option, only the new group and its members are
shown.

> With deprecated events this isn't the
> case, you can only see them with --deprecated. Given we can see the
> metric without the No_group grouping, what is being added by having a
> No_group grouping? It feels entirely redundant and something we don't
> need to advertise.

I just want to have a generic pattern for deprecating a metrics/metrics
group that everybody can follow.

I treat the "No_group" as a normal metrics group name. So this patch is
to introduce a new name, and hide the old name. Both new and old names
can still be used.

If it's for a deprecated event, the expectation is to only see the new
name by default, and see both new name and old name with the
--deprecated option.

Now, if it's a generic deprecated metrics group, what's the expected
behavior? I prefer to follow the same pattern as a deprecated event.
If we do so, yes, there will be some redundancy with the --deprecated
option, since some members may belong to both old and new groups.
But I don't think it's an issue. It's normal that metrics belong to
different groups.

Thanks,
Kan

