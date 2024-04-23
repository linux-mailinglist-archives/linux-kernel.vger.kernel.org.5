Return-Path: <linux-kernel+bounces-156014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B96AE8AFCA2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B662828B6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C022644366;
	Tue, 23 Apr 2024 23:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S4MudUzQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740EF3D0D5;
	Tue, 23 Apr 2024 23:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713915237; cv=none; b=FZCsXevuQA4keBLcbbSWlzfN3u3L40ylP/k9iv7Xa0vc2teilYHfrTz2fbUoOkEc0jGkWNW2oPoCHrC10u6Qrs4NeVE3rPHT+/+B+10a2Fzl67dZm6eycRgufKKzjbFJkhO7JESgVhgyQrwGBftk3ZTsBQFh8arWMW/vcPdI+dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713915237; c=relaxed/simple;
	bh=pZMvugS9OqaVXkiu1xLb3KyRdXtqZcAifDivlF02aAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTWk70mWPRijxRXvbXYFY1r6bk/32vb622lrYR4DbyuYeFaktq1/ryrC5qi595FjBnApTuo3sLXenpuyXLQeW9JRkeBKh7DCOvkO3dEJo7UGX+JC/jlVMYreE4PHVHjoTkAskQXyqill3Tat0brMPJTo/vIQaLORCk4okJKNr3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S4MudUzQ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713915236; x=1745451236;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pZMvugS9OqaVXkiu1xLb3KyRdXtqZcAifDivlF02aAE=;
  b=S4MudUzQWJXA+mwTdIBps4Y3IiQjHDwEi7fGmMiqqYQORGa8MuqLh4ke
   UsFwOShHxEdU4ktv4D922EhuM4AbgfCy7s7vYvqNg4NJgeFM4NlkdvI9U
   il0LgBTljlPhQ7fAJi7Yfnk2ujiy/cg46q8SH7MC92aWoHu10rdzgdvHW
   JdYWj+cRBzmpsirZ7nEQLfkt5fXSVhCYF1TlNuBFA/Z0NBPGMFiGEzD2C
   LrHRpBLWgcsxvAOmxAbSAzStNGAeUmORUYbho7FfBq560jsLGd68A7R7x
   PlXH5qfVD/VOuQcUvt3cxx5/cHghii1roTq3jc3GHcR4iychiTqthz94r
   w==;
X-CSE-ConnectionGUID: SMK2Vb+NRPaUpsmpTT69YQ==
X-CSE-MsgGUID: j8Kk0zKfQE+cXxBs/S/1sQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="34924752"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="34924752"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 16:33:55 -0700
X-CSE-ConnectionGUID: lKHs73H4Q0Kq18x1X5IDHg==
X-CSE-MsgGUID: p2Q1wPQ2TkCz/Uvxypdd9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="28966876"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 16:33:54 -0700
Date: Tue, 23 Apr 2024 16:33:53 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V3] perf scripts python: Add a script to run instances of
 perf script in parallel
Message-ID: <ZihFYbdrnarNFWOd@tassilo>
References: <20240423133248.10206-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423133248.10206-1-adrian.hunter@intel.com>

On Tue, Apr 23, 2024 at 04:32:48PM +0300, Adrian Hunter wrote:
> Add a Python script to run a perf script command multiple times in
> parallel, using perf script options --cpu and --time so that each job
> processes a different chunk of the data.
> 
> Extend perf script tests to test also the new script.
> 
> The script supports the use of normal perf script options like
>  --dlfilter and --script, so that the benefit of running parallel jobs
> naturally extends to them also. In addition, a command can be provided
> (refer --pipe-to option) to pipe standard output to a custom command.
> 
> Refer to the script's own help text at the end of the patch for more
> details.
> 
> The script is useful for Intel PT traces, that can be efficiently
> decoded by perf script when split by CPU and/or time ranges. Running
> jobs in parallel can decrease the overall decoding time.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Andi Kleen <ak@linux.intel.com>

