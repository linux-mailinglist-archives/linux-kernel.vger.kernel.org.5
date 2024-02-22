Return-Path: <linux-kernel+bounces-77193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3DF8601FA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0969EB218D2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E09B14B827;
	Thu, 22 Feb 2024 18:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OzlgKd4s"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9A414B81B;
	Thu, 22 Feb 2024 18:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627385; cv=none; b=WMOW1JCbv8pl3NEjiD9DvrSdLIYaJunrRHhia6dPhqDUupGIjFuNtHFD+3sGV99pAKCNDRvLVaE6rUqqzHRr98s9IrohwLKMI1bN2WMNdO54Mjhjr7iwNJyZNApCNdN9HhrPBidOAqEe3JgxMTIBqLtjzvSNGJE/Tvv38O3lxCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627385; c=relaxed/simple;
	bh=z9V9SqwIoCEV0+0762M0Lypw4P+zHK31rT4rI5FLLx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlpjTZuXL0jFRISzaILLMF5qa9lkzmHpoeo/JXfXevkNDiHn1GqC+P4PkU1gGNFydf9xKFTXkCOFCUnBC3GCLdvAc/AVxELXQtSfZv1o2NkgEZmkwNMzDekODj8JPNXqpyzp3+bYHLXvP5my2PnySgq578PzTuLUNY0AoggLAtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OzlgKd4s; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627385; x=1740163385;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=z9V9SqwIoCEV0+0762M0Lypw4P+zHK31rT4rI5FLLx8=;
  b=OzlgKd4sjqFjpeXhCDWrB0iiOda0HGHV3OtTz3zm0BGKCNSt0W/Im9Gl
   1Rpq+CLPkc71lPHsbwQsNXGV4Gy/RbzDcdNVPne818qLZrXKftWKuR02n
   /PmCKi8UM3qHwYBkjtTSLCkmd8tpZIrjP2ydrgyz/oqGWNoZ3DO+y3nOn
   B5uWtTxqq3/uRo/rG+cRlxvIsyaVhqHNTWonbkuRpnxsYCoAZJmFThrt2
   4u6ChIbqyui5cTDmhg1FrzoMNFQvc/LX91wsRHRS+sO2LECKpEenm52hb
   pHLegOq1bgVXqX8DSa9wySyJCG84lTQMRG2KsRj6KSnQkCYLuIqgteNx3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3032581"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3032581"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:43:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="827588441"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="827588441"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 22 Feb 2024 10:43:00 -0800
Received: by stinkbox (sSMTP sendmail emulation); Thu, 22 Feb 2024 20:42:59 +0200
Date: Thu, 22 Feb 2024 20:42:59 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>
Subject: Re: [PATCH] drm/i915: Add missing ; to __assign_str() macros in
 tracepoint code
Message-ID: <ZdeVs-rlk4oGEOs7@intel.com>
References: <20240222133057.2af72a19@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240222133057.2af72a19@gandalf.local.home>
X-Patchwork-Hint: comment

On Thu, Feb 22, 2024 at 01:30:57PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> I'm working on improving the __assign_str() and __string() macros to be
> more efficient, and removed some unneeded semicolons. This triggered a bug
> in the build as some of the __assign_str() macros in intel_display_trace
> was missing a terminating semicolon.
> 
> Fixes: 2ceea5d88048b ("drm/i915: Print plane name in fbc tracepoints")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

Do you want me to apply this to drm-intel or do you want to take
it through some other tree? Either way seems fine for this stuff.

> ---
>  drivers/gpu/drm/i915/display/intel_display_trace.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_display_trace.h b/drivers/gpu/drm/i915/display/intel_display_trace.h
> index 99bdb833591c..7862e7cefe02 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_trace.h
> +++ b/drivers/gpu/drm/i915/display/intel_display_trace.h
> @@ -411,7 +411,7 @@ TRACE_EVENT(intel_fbc_activate,
>  			   struct intel_crtc *crtc = intel_crtc_for_pipe(to_i915(plane->base.dev),
>  									 plane->pipe);
>  			   __assign_str(dev, __dev_name_kms(plane));
> -			   __assign_str(name, plane->base.name)
> +			   __assign_str(name, plane->base.name);
>  			   __entry->pipe = crtc->pipe;
>  			   __entry->frame = intel_crtc_get_vblank_counter(crtc);
>  			   __entry->scanline = intel_get_crtc_scanline(crtc);
> @@ -438,7 +438,7 @@ TRACE_EVENT(intel_fbc_deactivate,
>  			   struct intel_crtc *crtc = intel_crtc_for_pipe(to_i915(plane->base.dev),
>  									 plane->pipe);
>  			   __assign_str(dev, __dev_name_kms(plane));
> -			   __assign_str(name, plane->base.name)
> +			   __assign_str(name, plane->base.name);
>  			   __entry->pipe = crtc->pipe;
>  			   __entry->frame = intel_crtc_get_vblank_counter(crtc);
>  			   __entry->scanline = intel_get_crtc_scanline(crtc);
> @@ -465,7 +465,7 @@ TRACE_EVENT(intel_fbc_nuke,
>  			   struct intel_crtc *crtc = intel_crtc_for_pipe(to_i915(plane->base.dev),
>  									 plane->pipe);
>  			   __assign_str(dev, __dev_name_kms(plane));
> -			   __assign_str(name, plane->base.name)
> +			   __assign_str(name, plane->base.name);
>  			   __entry->pipe = crtc->pipe;
>  			   __entry->frame = intel_crtc_get_vblank_counter(crtc);
>  			   __entry->scanline = intel_get_crtc_scanline(crtc);
> -- 
> 2.43.0

-- 
Ville Syrjälä
Intel

