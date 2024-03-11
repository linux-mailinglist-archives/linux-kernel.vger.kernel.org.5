Return-Path: <linux-kernel+bounces-99194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 783858784B4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82167B20519
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF5A47F77;
	Mon, 11 Mar 2024 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nAhJKnZN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACADB47F63;
	Mon, 11 Mar 2024 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173626; cv=none; b=g0rwMnLzM6qYpLav9QckMgEO0tuJAdlg1DXTNx+D0eOesh2YsiswA18ZiJZYGVUjQiWpYWexBNRF3xZkFAUJnkzkHw6XnY4LrM6cBIlaiXX9yvS7Qz1Hh51eS6/O7HAkERtngRZ/KdImfbrA3B6DDYpzSkPkLWYAYwglUGvNrtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173626; c=relaxed/simple;
	bh=8MU3CTQsuoDIn1TyjjoLTr2kO4BvNKbWtiyDsSJOjyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vj/aWgLpro2fptb6tk4Tz205INwi0R67j2zZiQUEDP987j8qJ2xsSvZ8FNzhU7AGr1R1kOikW5EDEUtTsNMholuwd9Y8E78IDcW4ZxQyjQBBSmYtKToRTpuF3H5p2mozK5o90EvwW5ocrRwekfdP1U0JobAYnekDphCl3dKMmh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nAhJKnZN; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710173625; x=1741709625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8MU3CTQsuoDIn1TyjjoLTr2kO4BvNKbWtiyDsSJOjyo=;
  b=nAhJKnZNaY6hLiyO0dAQaBRr+eJBcLooMT7eOUQBYW9UTE2u9ZCStTXa
   c0enNE+tBpcL+0j0ZpP8SQ/vhUTlEyqsWf4gDte7Ya4yJGTKowogphtYw
   jNdvZtYEK/yEOIlErA0HbpvXKIUZ25CwIFxyRnBGfS4JUE+ro2YFAEUGq
   OEhVpCtZ6CRZQmfQKulgCssxSkZx5I4vyGznugnLQ4Qiszvtu9mJUBE3E
   9FEoFzTr+IVdp3DeTIUIe1wv67NZ/XQdZE/9tA1/91rWPKfRHmVw0qHaS
   fVuGct/TTl72KRroFWQoVrqW69UJ5BSxNr/uLyZgZbN8tKiEirr9LH1xr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="15407767"
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="15407767"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 09:13:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="15857568"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 09:13:43 -0700
Date: Mon, 11 Mar 2024 09:13:42 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf scripts python: Add a script to run instances of
 perf script in parallel
Message-ID: <Ze8ttn4bxBrYi63h@tassilo>
References: <20240310193502.2334-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240310193502.2334-1-adrian.hunter@intel.com>

On Sun, Mar 10, 2024 at 09:35:02PM +0200, Adrian Hunter wrote:
> Add a Python script to run a perf script command multiple times in
> parallel, using perf script options --cpu and --time so that each job
> processes a different chunk of the data.
> 
> Refer to the script's own help text at the end of the patch for more
> details.
> 
> The script is useful for Intel PT traces, that can be efficiently
> decoded by perf script when split by CPU and/or time ranges. Running
> jobs in parallel can decrease the overall decoding time.

This only optimizes for the run time of the decoder. Often when you do
analysis you have a non trivial part of it in some analysis script too,
but you currently have no directi / easy way to paralelize that. It would 
be better to support parallel pipelines.

TBH I'm not sure the script is worth it. If you need to do parallel
pipelines (which imho is the common case) it's probably better to just
write a custom shell script, which is not that difficult. It might be
better to have a helper that makes writing such scripts easier, 
e.g. figuring out reasonable options for manual parallelization
based on the input file. I think parts of your script do that, maybe
it is usable for that.

Also as a default output it would be better to just merge the 
original output in order and output it on stdout.

You should probably limit the number of jobs to some minimum
length, otherwise on systems with many CPUs there might be
inefficiently short jobs.

-Andi

