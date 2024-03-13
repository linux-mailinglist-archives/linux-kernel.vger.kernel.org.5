Return-Path: <linux-kernel+bounces-100984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B3F87A072
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 532D01F2258B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E727BE66;
	Wed, 13 Mar 2024 00:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V4bdSoyF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FDEBA27;
	Wed, 13 Mar 2024 00:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710291369; cv=none; b=vCiNPJQsRLGklTNxUmuu4KfrS5wSVXSzvtF8ao4VcGtztN1LeLNNN5rnuk4K2GzWtPKxyGn0/ZzDEwwtOLPcybXFqx2uMJM3mublppGq7sxaaxOisE/L8f0KZOBRUcBqngr+onOO4Unmq+AgHepd4pt6GofOHwF5vp/2aw2VEiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710291369; c=relaxed/simple;
	bh=W2WJ8Yf5fBQg5Da9WYcCzog1dMgKBINweuFPZ+nOGJY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cYFRJNlplXk6k+kVkOm7gDsi0k5SMACUj+N9T4H4gQX6mQjDuWRaWzhV/1JKhjysSf4cuEsAPRUSxhK7E3Xm6Y1gjEn0SxRUS90wIwvOzGEUFNoyFYXIBYGEgttZIlWfIsvg4dvBOe2xJmmclakW/XmTHjXT1gU5C0Sr7iIyRnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V4bdSoyF; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710291366; x=1741827366;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=W2WJ8Yf5fBQg5Da9WYcCzog1dMgKBINweuFPZ+nOGJY=;
  b=V4bdSoyFLrbecOSZZB3IneKmpYtUQzNtmF8jZ7Lu41kU+k7klHCkcx/+
   41GHMucBSoWZDD/OhN6eOSK62He3oJY07qPrhelWk8dkZ0Qi4VVkWfUEA
   oIHd/90lQsqfZQZyjUZuC6kZJtF3RsjIvNPPvYEyYDKA9oY/AUwe8Bi1k
   2NLqvVVFLgqTSSjwG4Lix8edI5qexvVleX7UhRE4GF7WH8MPyOpzAb+DE
   7DijAE9WU4Ic3G3CMV3Acio2L9VmG90i9hfpUXIApbDTbmoUO4cWpzXCe
   cXQrkq843wbX8ZiSO9rydm0fMcq35WnRTeug0wGtTrme039ZJGfdUOj5T
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="8852382"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="8852382"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 17:56:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="11770736"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by orviesa009.jf.intel.com with ESMTP; 12 Mar 2024 17:56:05 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id 9BF24301066; Tue, 12 Mar 2024 17:56:04 -0700 (PDT)
From: Andi Kleen <ak@linux.intel.com>
To: "Wang, Weilin" <weilin.wang@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>,  Ian Rogers <irogers@google.com>,
  Arnaldo Carvalho de Melo <acme@kernel.org>,  Peter Zijlstra
 <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,  Alexander
 Shishkin <alexander.shishkin@linux.intel.com>,  Jiri Olsa
 <jolsa@kernel.org>,  "Hunter, Adrian" <adrian.hunter@intel.com>,  Kan
 Liang <kan.liang@linux.intel.com>,  "linux-perf-users@vger.kernel.org"
 <linux-perf-users@vger.kernel.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,  "Taylor, Perry" <perry.taylor@intel.com>,
  "Alt, Samantha" <samantha.alt@intel.com>,  "Biggers, Caleb"
 <caleb.biggers@intel.com>
Subject: Re: [RFC PATCH v4 2/6] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
In-Reply-To: <CO6PR11MB56356A213DBE53535E9D802BEE2A2@CO6PR11MB5635.namprd11.prod.outlook.com>
	(Weilin Wang's message of "Wed, 13 Mar 2024 00:26:26 +0000")
References: <20240312234921.812685-1-weilin.wang@intel.com>
	<20240312234921.812685-3-weilin.wang@intel.com>
	<87le6nm20o.fsf@linux.intel.com>
	<CO6PR11MB56356A213DBE53535E9D802BEE2A2@CO6PR11MB5635.namprd11.prod.outlook.com>
Date: Tue, 12 Mar 2024 17:56:04 -0700
Message-ID: <87edcflzkr.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Wang, Weilin" <weilin.wang@intel.com> writes:

>> -----Original Message-----
>> From: Andi Kleen <ak@linux.intel.com>
>> Sent: Tuesday, March 12, 2024 5:03 PM
>> To: Wang, Weilin <weilin.wang@intel.com>
>> Cc: Namhyung Kim <namhyung@kernel.org>; Ian Rogers
>> <irogers@google.com>; Arnaldo Carvalho de Melo <acme@kernel.org>; Peter
>> Zijlstra <peterz@infradead.org>; Ingo Molnar <mingo@redhat.com>;
>> Alexander Shishkin <alexander.shishkin@linux.intel.com>; Jiri Olsa
>> <jolsa@kernel.org>; Hunter, Adrian <adrian.hunter@intel.com>; Kan Liang
>> <kan.liang@linux.intel.com>; linux-perf-users@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Taylor, Perry <perry.taylor@intel.com>; Alt, Samantha
>> <samantha.alt@intel.com>; Biggers, Caleb <caleb.biggers@intel.com>
>> Subject: Re: [RFC PATCH v4 2/6] perf stat: Fork and launch perf record when
>> perf stat needs to get retire latency value for a metric.
>> 
>> weilin.wang@intel.com writes:
>> 
>> > From: Weilin Wang <weilin.wang@intel.com>
>> >
>> > When retire_latency value is used in a metric formula, perf stat would fork a
>> > perf record process with "-e" and "-W" options. Perf record will collect
>> > required retire_latency values in parallel while perf stat is collecting
>> > counting values.
>> 
>> How does that work when the workload is specified on the command line?
>> The workload would run twice? That is very inefficient and may not
>> work if it's a large workload.
>> 
>> The perf tool infrastructure is imho not up to the task of such
>> parallel collection.
>> 
>> Also it won't work for very long collections because you will get a
>> very large perf.data. Better to use a pipeline.
>> 
>> I think it would be better if you made it a separate operation that can
>> generate a file that is then consumed by perf stat. This is also more efficient
>> because often the calibration is only needed once. And it's all under
>> user control so no nasty surprises.
>> 
>
> Workload runs only once with perf stat. Perf record is forked by perf stat and run
> in parallel with perf stat. Perf stat will send perf record a signal to terminate after 
> perf stat stops collecting count value.

I don't understand how the perf record filters on the workload created by
the perf stat. At a minimum you would need -p to connect to the pid
of the parent, but IIRC -p doesnt follow children, so if it forked
it wouldn't work.

I think your approach may only work with -a, but perhaps I'm missing
something (-a is often not usable due to restrictions)

Also if perf stat runs in interval mode and you only get the data
at the end how would that work?

iirc i wrestled with all these questions for toplev (which has a
similar feature) and in the end i concluded doing it automatically
has far too many problems.

-Andi

