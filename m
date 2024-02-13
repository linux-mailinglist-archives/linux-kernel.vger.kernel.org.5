Return-Path: <linux-kernel+bounces-63674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A46585330F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D9B1C21836
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A8157887;
	Tue, 13 Feb 2024 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PI6ZwoYq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D95755E72;
	Tue, 13 Feb 2024 14:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834505; cv=none; b=gwaT1vjSMSzOpWnQ/VqeQz2jeeHoUFCsWHBwfD82+USKDRiQuD2g3EKxRAIvjih8ptqPz1x1g3mO9LvDFU2Ry6JPcHHq4716MXeFIweW7JalehvshdKYC/vwxPnPhR8IUXhNgrfAciQnI7X6vBli7LaLeXx/0m/glum5t/Ry7Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834505; c=relaxed/simple;
	bh=I4IhygYKCgjk5I1/Tq5xU8MeghV4sj+uPYFSq/0BdHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=afjxCbSwAlHlfx1fGj/yIBKdiXChbgNEH0mMA9/fu3MrwRJWsGHLG80cICUZqVYJ01gJeo46I4+QnQJL4kKU3HANZf/dhPqgx3WuBPebZGm+n/olGdvKmRI/CfYYu0kP79r0bIzGJPsyhNAbL6vJ4IX+OxxXxVR1vMncVgbSnmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PI6ZwoYq; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707834505; x=1739370505;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=I4IhygYKCgjk5I1/Tq5xU8MeghV4sj+uPYFSq/0BdHo=;
  b=PI6ZwoYqizsG6XHs9XCJzrpS6/gpXIs+xMWEnJ0t1JcPjh3DqJtXBNjw
   rGFvwK2RNF94YOUjZagzXnmPpOfv9vwQBguUV1Y3WrmZcpui9Su8KL+a+
   qnh7TxWm5TK8ZfpjCDLcuh6Dl5z1zv6mMa0UfGLSAcTPHnM8ZbdsfAcV4
   2FnCne5Yb/LFK/f3qPgU3Pl+iPpbrG3FXH1LTOq1M/mN8QuWs1xMgO4m/
   4LCTeUXrM8PKWnnF6hCbqFEvEdRZA1r2UvEEJHFNO98JfpduccWX6z25s
   EtR8voJMcIuqNTDdfDxenNpQ1KjknBlljbDmILY2xy1Bpmy9svypQKiZa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="13236487"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="13236487"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 06:28:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="2853604"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 06:28:23 -0800
Received: from [10.213.163.172] (kliang2-mobl1.ccr.corp.intel.com [10.213.163.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id E980F580CB7;
	Tue, 13 Feb 2024 06:28:20 -0800 (PST)
Message-ID: <7c3e08e8-899b-416c-a0b8-341f00fa9da9@linux.intel.com>
Date: Tue, 13 Feb 2024 09:28:19 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] Fixes/improvements to metric output
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 John Garry <john.g.garry@oracle.com>, James Clark <james.clark@arm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Kaige Ye <ye@kaige.org>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240209204947.3873294-1-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240209204947.3873294-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-02-09 3:49 p.m., Ian Rogers wrote:
> A small addition to allow NaNs to be encoded in metrics and then 3
> fixes to various metric related issues.
> 
> Ian Rogers (4):
>   perf expr: Allow NaN to be a valid number
>   perf expr: Fix "has_event" function for metric style events
>   perf stat: Avoid metric-only segv
>   perf metric: Don't remove scale from counts
>

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan


>  tools/perf/util/expr.c         | 20 +++++++++++++++++++-
>  tools/perf/util/expr.l         |  9 +++++++++
>  tools/perf/util/stat-display.c |  2 +-
>  tools/perf/util/stat-shadow.c  |  7 +------
>  4 files changed, 30 insertions(+), 8 deletions(-)
> 

