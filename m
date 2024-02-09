Return-Path: <linux-kernel+bounces-59176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AF284F298
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F441288671
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B4767C6C;
	Fri,  9 Feb 2024 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g3BgVvF3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B6366B5F;
	Fri,  9 Feb 2024 09:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707472169; cv=none; b=ScCZ+f/SgVqnw1nURwlDcbAKLc3nTxsF9Jl1AcBSK21zCVWWioAu9y+h2s35vhwFr/6rhQ9kXEQiQpEune1rPkHgU7Dl3ZjQ7I5aeaCPSdL+kYmfimqcoP0+MHTw5rmnb8LuozMaXcWwna/X60qRH8vZ1sxGqsF1ZpDnckdFULE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707472169; c=relaxed/simple;
	bh=ReUjtNoKI4AEfvdlJoQ9stY41QHkrHNfAjwN3V3muic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axfdvZcJE8LIqiKBaysmPoIp1kUHWycJXwMK2gqDdJbyq6lPoEzA4kp+6CM5jjxo7KRZmeGYnk7tdG67N5uGNr2AV8YLWV5ufcGoXh5e4gAK2Zh1dqlkfexmN1UsEGKt5H7GgcjN3wxwW0+LieVcBcGRTJB1g1njggBe7M7WSus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g3BgVvF3; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707472168; x=1739008168;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ReUjtNoKI4AEfvdlJoQ9stY41QHkrHNfAjwN3V3muic=;
  b=g3BgVvF3D08Iqb6ZrD1q+4Z8vNVYQK0zoPWj1POv8vQYbvRqUSw/2wDe
   v+G5wNFAhDscCeWGfM2cb54C7wD4gWl39E1JxK0tKAtC49pF8WhMZjtqK
   NGkf9d37VPW4AMu/q82pbFJWwSSWPC0Ujfhtw0HgyVuUj77PjWqI92FyV
   TolrVKKep+Tfr1tHL48XEXxCHvJsmf46qBQsLZve8zM41RDHtqI2OZHeH
   HLAcccKn45VVcRXoiEiqi4YkRbwmMhFmz6uwXBmdAlj8MvP8IXoAy0DYj
   cZgvYuARywZgyotdiAOJ2E/+2MEw7KtT0ariqVwVtxIQehKVWMRB2ObU3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1551781"
X-IronPort-AV: E=Sophos;i="6.05,256,1701158400"; 
   d="scan'208";a="1551781"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 01:49:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,256,1701158400"; 
   d="scan'208";a="6515835"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 01:49:27 -0800
Date: Fri, 9 Feb 2024 01:49:25 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V5 01/12] perf/core: Add aux_pause, aux_resume,
 aux_start_paused
Message-ID: <ZcX1JUyMMpngyRqd@tassilo>
References: <20240208113127.22216-1-adrian.hunter@intel.com>
 <20240208113127.22216-2-adrian.hunter@intel.com>
 <ZcVuK1nnxG18ps-a@tassilo>
 <d53ef26d-a7e6-4b3b-b593-be75425c0e77@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d53ef26d-a7e6-4b3b-b593-be75425c0e77@intel.com>

On Fri, Feb 09, 2024 at 10:14:44AM +0200, Adrian Hunter wrote:
> On 9/02/24 02:13, Andi Kleen wrote:
> >> +static void __perf_event_aux_pause(struct perf_event *event, bool pause)
> >> +{
> >> +	if (pause) {
> >> +		if (!READ_ONCE(event->aux_paused)) {
> >> +			WRITE_ONCE(event->aux_paused, 1);
> >> +			event->pmu->stop(event, PERF_EF_PAUSE);
> >> +		}
> >> +	} else {
> >> +		if (READ_ONCE(event->aux_paused)) {
> >> +			WRITE_ONCE(event->aux_paused, 0);
> >> +			event->pmu->start(event, PERF_EF_RESUME);
> >> +		}
> > 
> > This doesn't look atomic. Either the READ/WRITE once are not needed,
> > or you need an actually atomic construct.
> 
> Yes READ_ONCE / WRITE_ONCE is not really needed here.

Normally you are supposed to add a comment on what the interaction
is (similar to what is done for spinlock declarations)

-Andi

