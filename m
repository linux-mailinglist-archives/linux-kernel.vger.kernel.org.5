Return-Path: <linux-kernel+bounces-88865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1217786E7B6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9F55B28E49
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E1F11C88;
	Fri,  1 Mar 2024 17:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tgpy2GH4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E2410A26;
	Fri,  1 Mar 2024 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709315398; cv=none; b=fZM364JTisRU5nfsiMIFZvULWJrSqYv630Nwy2VWzW0cjLwOcdXKLmUNb/3yGi0+d0nvzbZ8RlqHlWpRrHRzPm5yQJUp4r3FGTHk1BLqWfkdi603jH6vh/jcw8gDY1qngS9zyNo6GHF3cCmr1ZdK5lYJ2bVefBo5FdVuajEnwkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709315398; c=relaxed/simple;
	bh=8/Y/XDxLandSPlCC4m1v59y5UXjkcBey2CL+Iq3VD04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YD5RnDAuuTGwEYjKWryCZC3qO+7V9xHSl0MDfbUgPXFYmN0dSQEQxmdWylSI4vomrwYVDHqJaz/cEbYfVGEtU7XE+y5yMPxgE1cn97Du+O+2w1UsnFds24lp06g3rObB6i/DlI1i9y1wnCuJTaD0LaFVzbXDyomKWm34mwMgcHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tgpy2GH4; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709315397; x=1740851397;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8/Y/XDxLandSPlCC4m1v59y5UXjkcBey2CL+Iq3VD04=;
  b=Tgpy2GH4/7e8PoT6ITtbPp3SpA7E8Q2pn7kjE4R8jrOry/pI4EuDI54t
   cL2wE6dPiYHE+Z5eIsDGCkppD3pUtI4tDGIK5dMX4DMgZ7sx5JoPVOMpk
   WhRZTEiwkwaHN1UVrdM7kw1OI+v4/ujE35m1aVl03sq3c5eEUDRgF8PC7
   kOKXVN/iYZf/8BzRCQZibJXVk6JRjgVvY5vXzACBn6HoupL7Q+rIqXhOx
   wh/NZhn/+9K9x4mdQbpa77k3kmXbOc7inXOvczxSge96vr6T5HxIDsGkI
   C5B/raOrvjKh8hb2WcAfYVXTuWlKDIIiX18AyuraStR3WIVLcIQoPyTo5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="3989035"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="3989035"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 09:49:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="12855371"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 09:49:56 -0800
Date: Fri, 1 Mar 2024 09:49:54 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Ian Rogers <irogers@google.com>
Cc: Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Edward Baker <edward.baker@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 02/20] perf jevents: Add idle metric for Intel models
Message-ID: <ZeIVQhfDMP7_bSJ8@tassilo>
References: <20240229001806.4158429-1-irogers@google.com>
 <20240229001806.4158429-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229001806.4158429-3-irogers@google.com>

> +def Idle() -> Metric:
> +  cyc = Event("msr/mperf/")
> +  tsc = Event("msr/tsc/")
> +  low = max(tsc - cyc, 0)
> +  return Metric(
> +      "idle",
> +      "Percentage of total wallclock cycles where CPUs are in low power state (C1 or deeper sleep state)",
> +      d_ratio(low, tsc), "100%")

TBH I fail to see the advantage over the JSON. That's much more verbose
and we don't expect to have really complex metrics anyways.

And then we have a gigantic patch kit for what gain?

The motivation was the lack of comments in JSON? We could just add some
to the parser (e.g. with /* */ ).  And we could allow an JSON array for the
expression to get multiple lines.


-Andi

