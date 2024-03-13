Return-Path: <linux-kernel+bounces-100953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B46287A002
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 327CC1F22868
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765E24A01;
	Wed, 13 Mar 2024 00:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GT4TdMrI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3601D3FC7;
	Wed, 13 Mar 2024 00:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710288201; cv=none; b=lg/4lwum4XHW9k7dUibqbAZeV5Ayzxo9Whsukaf5zYcYUAfnXAgoZclqQrvPTtOzUHu25KxOAmdJzWAuQOJrWkECGKdMBzWch5VMyuRIys5v1XxE7ZxyVsAL0mvGb4lwSD/tgREhBAXiewveRwq/Y7uzyQHwnpY9qY8c9moWWGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710288201; c=relaxed/simple;
	bh=an4lj7u4rxlc8rDrEPZl5w8IO0sZqWWdvw0+g8g2qz4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eMR+BXyEDnJLISJWMVz2/YuUH3cbSL4zKW1Mjm+zI54Qgie8ldv6p0yHBMGG08Gkm2mKL/NDooDqQ7ewpsw5Hc7xPLLqXvFOtdYYKXXabectFi61686DErCboqPCfQhAxSO1AknUZ7QlKUyyBDsNahtSmcYAykdPhcXnqK/7R5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GT4TdMrI; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710288200; x=1741824200;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=an4lj7u4rxlc8rDrEPZl5w8IO0sZqWWdvw0+g8g2qz4=;
  b=GT4TdMrIXbUd3XmOqhJaVQ3acqbqbh2PWpjUb7JUO0ok7GR9ugWUu2Rh
   NfDkpn5D0yT9Msi6QB6YWfhCGsZRz2EgDKi7cGgVjap7TFafB2zU7QIAB
   vxEE5si2b2nSVcJffYd/5IjT/bhezOSft4kM6hg1r8xrwYMc6tXi/LN9p
   2sc5SCRG5Qgk4ePTC81QcElUDAarnb42j9dGkqIq4EliPkLAs6oOWlLPJ
   1pEhR7h7xMc8gdwqRcmP/YrNbI9bSGnU26nW3aP2ZchMYw+3JCpBh4Qxo
   2ScTJpEG3CxYYCC7PwuDsnXjeYTeR6iNWxLwTWGBz0Q7jVELdmjcnh4TH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="4898090"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4898090"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 17:03:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="12137585"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by orviesa006.jf.intel.com with ESMTP; 12 Mar 2024 17:03:19 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id 4B55B301066; Tue, 12 Mar 2024 17:03:19 -0700 (PDT)
From: Andi Kleen <ak@linux.intel.com>
To: weilin.wang@intel.com
Cc: Namhyung Kim <namhyung@kernel.org>,  Ian Rogers <irogers@google.com>,
  Arnaldo Carvalho de Melo <acme@kernel.org>,  Peter Zijlstra
 <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,  Alexander
 Shishkin <alexander.shishkin@linux.intel.com>,  Jiri Olsa
 <jolsa@kernel.org>,  Adrian Hunter <adrian.hunter@intel.com>,  Kan Liang
 <kan.liang@linux.intel.com>,  linux-perf-users@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Perry Taylor <perry.taylor@intel.com>,
  Samantha Alt <samantha.alt@intel.com>,  Caleb Biggers
 <caleb.biggers@intel.com>
Subject: Re: [RFC PATCH v4 2/6] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
In-Reply-To: <20240312234921.812685-3-weilin.wang@intel.com> (weilin wang's
	message of "Tue, 12 Mar 2024 19:49:17 -0400")
References: <20240312234921.812685-1-weilin.wang@intel.com>
	<20240312234921.812685-3-weilin.wang@intel.com>
Date: Tue, 12 Mar 2024 17:03:19 -0700
Message-ID: <87le6nm20o.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

weilin.wang@intel.com writes:

> From: Weilin Wang <weilin.wang@intel.com>
>
> When retire_latency value is used in a metric formula, perf stat would fork a
> perf record process with "-e" and "-W" options. Perf record will collect
> required retire_latency values in parallel while perf stat is collecting
> counting values.

How does that work when the workload is specified on the command line?
The workload would run twice? That is very inefficient and may not
work if it's a large workload.

The perf tool infrastructure is imho not up to the task of such
parallel collection.

Also it won't work for very long collections because you will get a
very large perf.data. Better to use a pipeline.

I think it would be better if you made it a separate operation that can
generate a file that is then consumed by perf stat. This is also more efficient
because often the calibration is only needed once. And it's all under
user control so no nasty surprises.

-Andi

