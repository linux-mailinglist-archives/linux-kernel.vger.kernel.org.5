Return-Path: <linux-kernel+bounces-27299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE0182ED7D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9417B23068
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DA21B7F9;
	Tue, 16 Jan 2024 11:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NNWWAf/T"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0991B7ED;
	Tue, 16 Jan 2024 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705403716; x=1736939716;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=KGj83XYIkXNIHgAxpE7C2tWJ2jS/Hwvrh3NCtwWmTmE=;
  b=NNWWAf/TaCm1MF71uSKFnneZgyBVD3sLebhrmg99BpYLeefTOIKp31jD
   cVJ7NtnOMHu+PRk7XfDnEWKrHqkQrk8DYhFlEAEggQK3Co2zURM3NkhCJ
   R8+Tbojx92/Io7yIvHAW0KZva5+9p2o9IwS5k4FH2AjRuV3gOdBFXxNcz
   tjMQpMS1rsI4Jy7BDmZe2gIQF7jkOJUgkHpdKEmEgRnv+g+EBdgByniz0
   gndPMmH7XRCH7jeyfTL/WjFP6eLfc+sOGuhc9NScVPXlnV39L9qvKZjT2
   PPoLjwfs60UFfKEHSe8VeJ7jFpgA9Gpc/u9lxgP7l7ERcfrvJQoydP5gV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="7214109"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="7214109"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 03:15:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="32419003"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by orviesa001.jf.intel.com with ESMTP; 16 Jan 2024 03:15:15 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id C1371301BD1; Tue, 16 Jan 2024 03:15:14 -0800 (PST)
From: Andi Kleen <ak@linux.intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,
  Mark Rutland <mark.rutland@arm.com>,  Alexander Shishkin
 <alexander.shishkin@linux.intel.com>,  Heiko Carstens <hca@linux.ibm.com>,
  Thomas Richter <tmricht@linux.ibm.com>,  Hendrik Brueckner
 <brueckner@linux.ibm.com>,  Suzuki K Poulose <suzuki.poulose@arm.com>,
  Mike Leach <mike.leach@linaro.org>,  James Clark <james.clark@arm.com>,
  coresight@lists.linaro.org,  linux-arm-kernel@lists.infradead.org,
  Yicong Yang <yangyicong@hisilicon.com>,  Jonathan Cameron
 <jonathan.cameron@huawei.com>,  Will Deacon <will@kernel.org>,  Arnaldo
 Carvalho de Melo <acme@kernel.org>,  Jiri Olsa <jolsa@kernel.org>,
  Namhyung Kim <namhyung@kernel.org>,  Ian Rogers <irogers@google.com>,
  linux-kernel@vger.kernel.org,  linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V4 10/11] perf intel-pt: Add documentation for pause /
 resume
In-Reply-To: <20240111081914.3123-11-adrian.hunter@intel.com> (Adrian Hunter's
	message of "Thu, 11 Jan 2024 10:19:13 +0200")
References: <20240111081914.3123-1-adrian.hunter@intel.com>
	<20240111081914.3123-11-adrian.hunter@intel.com>
Date: Tue, 16 Jan 2024 03:15:14 -0800
Message-ID: <87ply1lebh.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Hunter <adrian.hunter@intel.com> writes:
> +
> +For example, to trace only the uname system call (sys_newuname) when running the
> +command line utility uname:
> +
> + $ perf record --kcore -e
> intel_pt/aux-action=start-paused/k,syscalls:sys_enter_newuname/aux-action=resume/,syscalls:sys_exit_newuname/aux-action=pause/
> uname

It's unclear if the syntax works for hardware break points, kprobes, uprobes too?
That would be most useful. If it works would be good to add examples for it.

-Andi


