Return-Path: <linux-kernel+bounces-102668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7A087B580
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 01:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62721C210EB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068B817C7C;
	Thu, 14 Mar 2024 00:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CmHFi9A7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0082DDDD;
	Thu, 14 Mar 2024 00:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710374442; cv=none; b=TBGDpMpGE9PZ+M/+LsJjBPvTXP00sh9+oCyV+Dw3fh6WDetfAQ0bmsvmdw7+n92Zoik8FzV9Cj60R56yEJk8GpxG0diS0s/C9dHb5CiGc8xByH166l9+P1D5JWegFGqnN9MwbWRd8kwfc3uCrkK27vQgYiKe3V47QtOcj0cfAn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710374442; c=relaxed/simple;
	bh=KOItflsOGNU21WvEz/74/Siz5rxBwRscFBQI5KDFz4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNb6Iu6bwdPD5z81TGIS7aacUscN7KnZmhRLKJcliavX0/huJqSWf5TqDFHkOoBjZb/Ab+hctS6okeSLfdXhf1gwe9JSbIhjY5w4mXUelhoneSXvZwil+B6apR/v0TMCvhS6Iqu0szyBiFYTI3jhT3fFvDufYKbrJDL0KMlXb6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CmHFi9A7; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710374441; x=1741910441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KOItflsOGNU21WvEz/74/Siz5rxBwRscFBQI5KDFz4k=;
  b=CmHFi9A7zCkgSJ6Liij5HweP+JHbKKtVMGBD50y2oHVVTqnjcK+l01On
   kmYrNoi+fuW+9NYzScXZnj4wYia1PfIAOeL1h8tKbyXOarZPnnCzAbHVI
   Kv569mHUkphQFVd+izI76kYNaVD1oKYnRdbSCkCq6vv/UN/8ey7DP/lZc
   XwDCb0JmfTDIn332mQFgJSP6OO15l4driW8W7fGixcSGDK0NCzr+GXPIf
   uoGSarFWhRqsRq5GUKRM+8JMw5l+eAMYtH8Sdf5xyj5Daiwyas9QzYLK5
   c45qEQa8fc1LL/OgJ9yPCHXLlmNHSmvfSYbwhZsjLSWhsqkM0m+4ri0a8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="27646655"
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="27646655"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 17:00:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="16793595"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 17:00:40 -0700
Date: Wed, 13 Mar 2024 17:00:38 -0700
From: Andi Kleen <ak@linux.intel.com>
To: "Wang, Weilin" <weilin.wang@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>,
	"Biggers, Caleb" <caleb.biggers@intel.com>
Subject: Re: [RFC PATCH v4 2/6] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Message-ID: <ZfI-JqTZevIhEa3o@tassilo>
References: <20240312234921.812685-1-weilin.wang@intel.com>
 <20240312234921.812685-3-weilin.wang@intel.com>
 <87le6nm20o.fsf@linux.intel.com>
 <CO6PR11MB56356A213DBE53535E9D802BEE2A2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <87edcflzkr.fsf@linux.intel.com>
 <CO6PR11MB56351D1706A9C46D80982AECEE2A2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <ZfHMYM3iWlsODtjP@tassilo>
 <CO6PR11MB5635D2EAC53C2CD2B36D4BF5EE2A2@CO6PR11MB5635.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO6PR11MB5635D2EAC53C2CD2B36D4BF5EE2A2@CO6PR11MB5635.namprd11.prod.outlook.com>

> We could use -a -C and cgroup together. I think this could be a useful use case.
> There could be other improvement to the implementation in next step. But I believe

I don't know how you would improve it. A lot of the problems are fairly
fundamental.

> current implementation could provide users the access to our new feature with 
> accurate results 
> and without adding too much overhead. 

perf record increases the overhead a lot over a perf stat! Sampling
is much more expensive than counting.

That should be at least a order of magnitude difference.
Another advantage of doing it separately.

That will also make it inaccurate.

Please do a proper implementation. This one is no good.

You can likely reuse a lot of your code:

- Add a perf calibrate to run the profile step separately that generates the JSON
- Add a --metrics option to perf to read the resulting JSON
- Add some mechanism to read a default JSON as fallback. I guess this
one could be compiled in to avoid a dependency on an installed file.

-Andi

