Return-Path: <linux-kernel+bounces-38396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E52083BEE1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F6511F26644
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097EB1CAB9;
	Thu, 25 Jan 2024 10:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jRrYL5je"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816DA1CA94
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 10:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706178770; cv=none; b=iGQc5QLFR1cd9WC/u+Rt7rxpjzROITESQ4vOV3uAKBDL/0/8+xI2IhIyOa8LBBjJAE1b2FAP4yj8T8+jbisj6JxSJtQHKeTtOnyebqPQZrAxn18qKwgh+ASoNQK+wDTK97mGPupyKU7ssJoBA4DqRJzOdyEkd5KGOswggg3kSr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706178770; c=relaxed/simple;
	bh=zCOT4jByjYRQOwy8cdwIUFw1Xl/m54aWsDvK0r9pbHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StNTXH0ad5szY83qmk+rmZo+5TVhx+axjBkPHrdoxOWsIlP/RN/rlumzCYWZisggcGrRycdY3s1eESPE4fxGGSQXdfhwdVbmZsmTYljogp5x3h+fPFEuV767Tp9JUlwPfs+KGmaD0/aFsG9QNc/siSc5Q2qZx5TCfkg81sHy0DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jRrYL5je; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706178768; x=1737714768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zCOT4jByjYRQOwy8cdwIUFw1Xl/m54aWsDvK0r9pbHs=;
  b=jRrYL5jeSaVVhlbFhQIbBHAmkdKPkbKC1BpvYYr37nKH0yPNBkfxx07v
   8kAKC1A0y1qb0QH2NOEIKgGO2yC2CGCk+dJBG9mGqsUpmqpTsztMvosZJ
   6Ya3qafod7TYS+hmf2DOn8XMkZ3fgdi2bi1/Qm3uKR3bvjIrK6wXNH/GJ
   ux9TaFAr8erT5FrSmIn/zRwfcWXne/iMSK8KbI/jCONAIgYSsfovt7pzk
   HsjDE9CwoAI46mDFwGNRcA1G0VGcy/1beNIuhID8XRNZnhcebx2n64h2t
   pZM3xNrHUE3+438L3rdyMqqN2CQyHLqg7u7fAzCLsMSGCKaYB/H1ingqk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="9236637"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9236637"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 02:32:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="820754699"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="820754699"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 25 Jan 2024 02:32:25 -0800
Received: by stinkbox (sSMTP sendmail emulation); Thu, 25 Jan 2024 12:32:24 +0200
Date: Thu, 25 Jan 2024 12:32:24 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
	alexander.deucher@amd.com, christian.koenig@amd.com,
	Simon Ser <contact@emersion.fr>,
	Pekka Paalanen <ppaalanen@gmail.com>, daniel@ffwll.ch,
	Daniel Stone <daniel@fooishbar.org>,
	'Marek =?utf-8?B?T2zFocOhayc=?= <maraeo@gmail.com>,
	Dave Airlie <airlied@gmail.com>, Xaver Hugl <xaver.hugl@gmail.com>,
	Joshua Ashton <joshua@froggi.es>,
	Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>
Subject: Re: [PATCH v2 2/2] drm/amdgpu: Implement check_async_props for planes
Message-ID: <ZbI4uD3iK-CChNlz@intel.com>
References: <20240119181235.255060-1-andrealmeid@igalia.com>
 <20240119181235.255060-3-andrealmeid@igalia.com>
 <Zaq-r7UZpEy7_Rrn@intel.com>
 <68171ce1-3ccb-4699-8577-434d9b717acf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68171ce1-3ccb-4699-8577-434d9b717acf@igalia.com>
X-Patchwork-Hint: comment

On Wed, Jan 24, 2024 at 11:14:40AM -0300, André Almeida wrote:
> Hi Ville,
> 
> Em 19/01/2024 15:25, Ville Syrjälä escreveu:
> > On Fri, Jan 19, 2024 at 03:12:35PM -0300, André Almeida wrote:
> >> AMD GPUs can do async flips with changes on more properties than just
> >> the FB ID, so implement a custom check_async_props for AMD planes.
> >>
> >> Allow amdgpu to do async flips with IN_FENCE_ID and FB_DAMAGE_CLIPS
> >> properties. For userspace to check if a driver support this two
> >> properties, the strategy for now is to use TEST_ONLY commits.
> >>
> >> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> >> ---
> >> v2: Drop overlay plane option for now
> >>
> >>   .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 29 +++++++++++++++++++
> >>   1 file changed, 29 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> >> index 116121e647ca..7afe8c1b62d4 100644
> >> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> >> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> >> @@ -25,6 +25,7 @@
> >>    */
> >>   
> >>   #include <drm/drm_atomic_helper.h>
> >> +#include <drm/drm_atomic_uapi.h>
> >>   #include <drm/drm_blend.h>
> >>   #include <drm/drm_gem_atomic_helper.h>
> >>   #include <drm/drm_plane_helper.h>
> >> @@ -1430,6 +1431,33 @@ static void amdgpu_dm_plane_drm_plane_destroy_state(struct drm_plane *plane,
> >>   	drm_atomic_helper_plane_destroy_state(plane, state);
> >>   }
> >>   
> >> +static int amdgpu_dm_plane_check_async_props(struct drm_property *prop,
> >> +					  struct drm_plane *plane,
> >> +					  struct drm_plane_state *plane_state,
> >> +					  struct drm_mode_object *obj,
> >> +					  u64 prop_value, u64 old_val)
> >> +{
> >> +	struct drm_mode_config *config = &plane->dev->mode_config;
> >> +	int ret;
> >> +
> >> +	if (prop != config->prop_fb_id &&
> >> +	    prop != config->prop_in_fence_fd &&
> > 
> > IN_FENCE should just be allowed always.
> 
> Do you mean that the common path should allow IN_FENCE_FD for all drivers?

Yes.

-- 
Ville Syrjälä
Intel

