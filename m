Return-Path: <linux-kernel+bounces-58894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C43384EE3B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 01:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36EE61C233F6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B0D4A39;
	Fri,  9 Feb 2024 00:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G5iSCkXe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F3A4A21;
	Fri,  9 Feb 2024 00:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707437619; cv=none; b=aNfOfeiYqeiM3IjslivHzFCbsQmiMoRcf2H3LmiEWVTIoyfX0XuhaBVYopgY1uqrfgQaJVICsvxIpt8SaXfSX8C2gjqwqe1RpejdGcYWgqc6ol6fKZY14r90tnqz4K6xWpyqaYdXQPDDe8HIplphHce3y4cgX9mpEgD+AJ0mpYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707437619; c=relaxed/simple;
	bh=bi/0TOx79W8gC2c7v4EQ3+j3O2OhN2gIGw5Zazdda3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOJ6skodFDRR20CsLxccGRB+ZNbvXGwUDQNNC9LPiUihQ47WEFYmUuhjDaSkVqsv/OWUbWy8ULIBRDNjRw/8mgt0le1q5rzP9odMBpYz87l6scfBrlYOUzQXTyDv/PO7ONfPqV/Y0yr19S70d/hw4+jwV0Jm6kS245+vWpZotEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G5iSCkXe; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707437617; x=1738973617;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bi/0TOx79W8gC2c7v4EQ3+j3O2OhN2gIGw5Zazdda3Q=;
  b=G5iSCkXeulNRRrl+EltAGHFSsZAfSTVxRWXjsUsnZHJh9zBiOXY6eB26
   dF1AO+egFOYx8KLk4kMYwJyI3oIAADBvJbjjI9ACILGfoHtf1tq5EN63K
   R0VeucnmCD0j+3cCuImS048Ex2gtKOGfL270myTsPgk5ZfVOork4EKmlV
   K8Mw0n+JQHOyInlC5Sn+ckOp1XdW70m8SHlSeJwzCzr9tbmQULzv1yecs
   LSerRpQm45kHZ/WzWnIufoRA0l6zsiXYPcfoJZErkYXflwa7OORGrT6Nr
   v8HMXHFHE9+bLSooX4LuEEMQYXYecOJS8ReE98qwJrkC1/Vd/dfP4TEIH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1501368"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="1501368"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 16:13:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="6432514"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 16:13:36 -0800
Date: Thu, 8 Feb 2024 16:13:31 -0800
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
Message-ID: <ZcVuK1nnxG18ps-a@tassilo>
References: <20240208113127.22216-1-adrian.hunter@intel.com>
 <20240208113127.22216-2-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208113127.22216-2-adrian.hunter@intel.com>

> +static void __perf_event_aux_pause(struct perf_event *event, bool pause)
> +{
> +	if (pause) {
> +		if (!READ_ONCE(event->aux_paused)) {
> +			WRITE_ONCE(event->aux_paused, 1);
> +			event->pmu->stop(event, PERF_EF_PAUSE);
> +		}
> +	} else {
> +		if (READ_ONCE(event->aux_paused)) {
> +			WRITE_ONCE(event->aux_paused, 0);
> +			event->pmu->start(event, PERF_EF_RESUME);
> +		}

This doesn't look atomic. Either the READ/WRITE once are not needed,
or you need an actually atomic construct.

> +
> +	rb = ring_buffer_get(event);
> +	if (!rb)
> +		return;
> +
> +	local_irq_save(flags);
> +	/* Guard against NMI, NMI loses here */
> +	if (READ_ONCE(rb->aux_in_pause_resume))
> +		goto out_restore;
> +	WRITE_ONCE(rb->aux_in_pause_resume, 1);


> +	barrier();
> +	__perf_event_aux_pause(event, pause);
> +	barrier();
> +	WRITE_ONCE(rb->aux_in_pause_resume, 0);

Dito.

-Andi

