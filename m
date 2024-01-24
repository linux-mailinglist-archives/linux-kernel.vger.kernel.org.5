Return-Path: <linux-kernel+bounces-36208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D52839D86
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D79E2B26A78
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D0D7E5;
	Wed, 24 Jan 2024 00:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kkUNzGNn"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B4415A8;
	Wed, 24 Jan 2024 00:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706055142; cv=none; b=uRd/nRC9Jo36NGVv64Hfn+1170XLtTakgEvIToBZwt4daSyHur/fAO2tEVWIzXPd5ERM5uNs8E4v8ek0z4upOBRHo8VFM70CBB9WN+KMT2UxCWJg+hQ48VBoY0SRJu+C1IoBMlTY8MS/ZD0QaaWpSVLPN+qYpkH4ORc02Q7RuAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706055142; c=relaxed/simple;
	bh=AUPCht/vvj3EeOeUyYmWkGuAC+hNLyOsPWRb4uvr6g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAKr02R7Deh2mU7cDFTN5Vg85RFuSV1frzWQHZZE+T+8OR4T8bxRFZcKCifcXWPz023AAIKpFqCvfDOhUCjyX65DJlxCuH8v9y3kubiHdu+luDc+djQGjJFTtZmXY/Is4MMfQpO6+qPtmzGiI/nAppFJ7UO9ZQgqbEfyRqUMras=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kkUNzGNn; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706055141; x=1737591141;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AUPCht/vvj3EeOeUyYmWkGuAC+hNLyOsPWRb4uvr6g0=;
  b=kkUNzGNn6P6jh0hRN10+5vISJ/C/HTTTorQJxyTXEN3cIkn2HMFCk9KT
   ElB+ueUefnNa7yiLTkVKXcOZ+HaM/p79wKetHE72iDT5UNGlEJPg5bo7v
   r3BfG1a07zABQVtsuLp9+g6vPBI/1gnSi+x9ct6WIUuT+/cUPdEpvhPB8
   z93O1cGYS6SNq3px7Z30Y8T+7aT1HO57zUMW8CwBCTUVuXRkbn/AVYke4
   3NW5kOdqdGf4xX1aRDumySE2KSuvBQ+eLHDoSj6gj1yrBZoOs+D+N/WyA
   WSMmjQMqRwj4grrsmHWzNgU63SCP8NrVgjUflpNRUWGfHI3REORSyVcjD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="400558089"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="400558089"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 16:12:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="1705113"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 16:12:18 -0800
Date: Tue, 23 Jan 2024 16:12:16 -0800
From: Tony Luck <tony.luck@intel.com>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	rostedt@goodmis.org, bp@alien8.de, x86@kernel.org,
	linux-kernel@vger.kernel.org, yazen.ghannam@amd.com,
	avadnaik@amd.com
Subject: Re: [PATCH] tracing: Include PPIN in mce_record tracepoint
Message-ID: <ZbBV4EGrZw6hJ5IE@agluck-desk3>
References: <20240123235150.3744089-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123235150.3744089-1-avadhut.naik@amd.com>

On Tue, Jan 23, 2024 at 05:51:50PM -0600, Avadhut Naik wrote:
> Machine Check Error information from struct mce is exported to userspace
> through the mce_record tracepoint.
> 
> Currently, however, the PPIN (Protected Processor Inventory Number) field
> of struct mce is not exported through the tracepoint.
> 
> Export PPIN through the tracepoint as it may provide useful information
> for debug and analysis.

Awesome. I've been meaning to update the tracepoint for ages, but
it never gets to the top of the queue.

But some questions:

1) Are tracepoints a user visible ABI? Adding a new field in the middle
feels like it might be problematic. I asked this question many years
ago and Steven Rostedt said there was some tracing library in the works
that would make this OK for appplications using that library.

2) While you are adding to the tracepoint, should we batch up all
the useful changes that have been made to "struct mce". I think the
new fields that might be of use are:

        __u64 synd;             /* MCA_SYND MSR: only valid on SMCA systems */
        __u64 ipid;             /* MCA_IPID MSR: only valid on SMCA systems */
        __u64 ppin;             /* Protected Processor Inventory Number */
        __u32 microcode;        /* Microcode revision */

> 
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> ---
>  include/trace/events/mce.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
> index 1391ada0da3b..657b93ec8176 100644
> --- a/include/trace/events/mce.h
> +++ b/include/trace/events/mce.h
> @@ -25,6 +25,7 @@ TRACE_EVENT(mce_record,
>  		__field(	u64,		ipid		)
>  		__field(	u64,		ip		)
>  		__field(	u64,		tsc		)
> +		__field(	u64,		ppin	)
>  		__field(	u64,		walltime	)
>  		__field(	u32,		cpu		)
>  		__field(	u32,		cpuid		)
> @@ -45,6 +46,7 @@ TRACE_EVENT(mce_record,
>  		__entry->ipid		= m->ipid;
>  		__entry->ip		= m->ip;
>  		__entry->tsc		= m->tsc;
> +		__entry->ppin		= m->ppin;
>  		__entry->walltime	= m->time;
>  		__entry->cpu		= m->extcpu;
>  		__entry->cpuid		= m->cpuid;
> @@ -55,7 +57,7 @@ TRACE_EVENT(mce_record,
>  		__entry->cpuvendor	= m->cpuvendor;
>  	),

.. rest of patch trimmed.

-Tony

