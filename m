Return-Path: <linux-kernel+bounces-142322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5307A8A2A27
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6759B1C20FF5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA955102F;
	Fri, 12 Apr 2024 08:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gjOxXuCj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135A11C6B6
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712911827; cv=none; b=Di181ERbJKcU24oxnkx09oQJZ03FlvC0z5MKocVorDmHZSwkY+5kVsKG+t2MrvFkm57DaEdLW4eK2RMhK+MDP6TbSHzQynVH13H1yOPgBS2eSvgLvFKW9xzELTJawl15Z4D+Sc9zBpHvRYZV3ElQ4NSnQ0HYoD2VB527VOD3uM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712911827; c=relaxed/simple;
	bh=bf4dIkV9LetyoNL/ouarPVJQ/zgpxdgdmJYWy/jU+ko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EIzKrz61Z6ScmrT6yZprAwFEKPtMOVb29sE+CMAB2lwvgt5SAzlaj4SXZDfKGCZDCuvPt/g+JuiKJpMrcLR4y8tnf4uBMqN/apGh6XY5YtCjjnO+VfKPKMvUiVXaakKgNTG8ta8UYnRdXFDun6ngV9vqh9gMRF3okn0VQDdXp7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gjOxXuCj; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712911826; x=1744447826;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=bf4dIkV9LetyoNL/ouarPVJQ/zgpxdgdmJYWy/jU+ko=;
  b=gjOxXuCj+H/w6pUCcLcag3MhEEPg1bBkzPF9x+2UMCb396X+lsLGDv3h
   JUV91dbJncDR1HWYISI2cS4F71bNqdSeL7GzxLLw3ZnZXHngc7zqnDZIf
   sFCxjaJhlUO/bbfWaxg7Beybg/xdSgZzVlamHtZH54mEPEM/5zni0zkdg
   gkjy7CYRkzBzJYhf7z/U6/TS8KH74/HwYYNMlzKUhTnAxrUy5miSW1EOj
   X6xpqLm8kLQTiN6GkiJR7vBEhSywVb1GL0PPm1r1WIqQaAjknNmQpZsKN
   4z5ySh3hz6ZFWLO18W8ONHQK9c860uvWoBkn2oYfX6doT8c/u3xms5d2b
   Q==;
X-CSE-ConnectionGUID: i206SMPxQGG55mOo+0OV6g==
X-CSE-MsgGUID: G6U7T1gzRwaLh+r707862g==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8220018"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="8220018"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 01:50:25 -0700
X-CSE-ConnectionGUID: NcyoHsMzR8WZSAfF4z+NKg==
X-CSE-MsgGUID: Usq70mwITMKMCYii2RGu6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="52331444"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 01:50:22 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Bharata B Rao <bharata@amd.com>
Cc: <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>,
  <akpm@linux-foundation.org>,  <mingo@redhat.com>,
  <peterz@infradead.org>,  <mgorman@techsingularity.net>,
  <raghavendra.kt@amd.com>,  <dave.hansen@linux.intel.com>,
  <hannes@cmpxchg.org>
Subject: Re: [RFC PATCH 0/2] Hot page promotion optimization for large
 address space
In-Reply-To: <8b073658-268d-4d3e-bd94-3fe95c948bd9@amd.com> (Bharata B. Rao's
	message of "Fri, 12 Apr 2024 13:46:12 +0530")
References: <20240327160237.2355-1-bharata@amd.com>
	<87il16lxzl.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<dd2bc563-7654-4d83-896e-49a7291dd1aa@amd.com>
	<87edbulwom.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<929b22ca-bb51-4307-855f-9b4ae0a102e3@amd.com>
	<875xx5lu05.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<7e373c71-b2dc-4ae4-9746-c840f2a513a5@amd.com>
	<87o7asfrm1.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<9ec3b04b-bde8-42ce-be1b-34f7d8e6762d@amd.com>
	<87il0yet4z.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<8692d514-d1c8-4fbf-84d7-1ad609480070@amd.com>
	<87cyqv59bj.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<8b073658-268d-4d3e-bd94-3fe95c948bd9@amd.com>
Date: Fri, 12 Apr 2024 16:48:29 +0800
Message-ID: <874jc755lu.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Bharata B Rao <bharata@amd.com> writes:

> On 12-Apr-24 12:58 PM, Huang, Ying wrote:
>> Bharata B Rao <bharata@amd.com> writes:
>> 
>>> On 03-Apr-24 2:10 PM, Huang, Ying wrote:
>>>>> Here are the numbers for the 192nd chunk:
>>>>>
>>>>> Each iteration of 262144 random accesses takes around ~10ms
>>>>> 512 such iterations are taking ~5s
>>>>> numa_scan_seq is 16 when this chunk is accessed.
>>>>> And no page promotions were done from this chunk. All the
>>>>> time should_numa_migrate_memory() found the NUMA hint fault
>>>>> latency to be higher than threshold.
>>>>>
>>>>> Are these time periods considered too short for the pages
>>>>> to be detected as hot and promoted?
>>>>
>>>> Yes.  I think so.  This is burst accessing, not repeated accessing.
>>>> IIUC, NUMA balancing based promotion only works for repeated accessing
>>>> for long time, for example, >100s.
>>>
>>> Hmm... When a page is accessed 512 times over a period of 5s and it is
>>> still not detected as hot. This is understandable if fresh scanning couldn't
>>> be done as the accesses were bursty and hence they couldn't be captured via
>>> NUMA hint faults. But here the access captured via hint fault is being rejected
>>> as not hot because the scanning was done a while back. But I do see the challenge
>>> here since we depend on scanning time to obtain the frequency-of-access metric.
>> 
>> Consider some pages that will be accessed once every 1 hour, should we
>> consider it hot or not?  Will your proposed method deal with that
>> correctly?
>
> The proposed method removes the absolute time as a factor for the decision and instead
> relies on the number of hint faults that have occurred since that page was scanned last.
> As long as there are enough hint faults happening in that 1 hour (which means a lot many
> other accesses have been captured in that 1 hour), that page shouldn't be considered as
> hot. You did mention earlier about hint fault rate varying a lot and one thing I haven't
> tried yet is to vary the fault threshold based on current or historical fault rate.

In your original example, if a lot many other accesses between NUMA
balancing page table scanning and 512 page accesses, you cannot identify
the page as hot too, right?

If the NUMA balancing page table scanning period is much longer than 5s,
it's high possible that we cannot distinguish between 1 and 512 page
accesses within 5s with your method and the original method.

Better discuss the behavior with a more detail example, for example,
when the page is scanned, how many pages are accessed, how long between
accesses, etc.

--
Best Regards,
Huang, Ying

