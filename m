Return-Path: <linux-kernel+bounces-46303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC47B843DE6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EB2FB330A8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBA86A030;
	Wed, 31 Jan 2024 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LWCfUDrJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E807AE71;
	Wed, 31 Jan 2024 11:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706699038; cv=none; b=N8MNhuK/OZW8YJshudKaIi7m7F6En8EL9PL2R4dQJaKRH+IG198sAk6wW5E0R/rW8I0kiw3RqQlhVnRqPQGixFJBHQfAlaDNS2In4cNePeqCov8KChpk9wI0JTLHvc17wgKsqlWxWQfKNbcf0orhI3lkw6BT+MyD/UUj3qek3Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706699038; c=relaxed/simple;
	bh=l97JaM/WxbJ3cuZRvKI3tEr4j0C+sm43YPiTF6kpOBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeRIUDng4QJn2/DmfVRaEXBqzzzIhAGkXQBo6EeNHK8fAiHd5arIj/zHU6RAl63Oh3vs7wytXReSj3BYVvFj7INMFMCijjqrNCRTp3Ego7t/BTO2+HlqgN6TtBHDEXO5PrxAReCU24w3XqGmjG1tTLdO+6dGMlwdHUrAYcdTK7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LWCfUDrJ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706699037; x=1738235037;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=l97JaM/WxbJ3cuZRvKI3tEr4j0C+sm43YPiTF6kpOBQ=;
  b=LWCfUDrJwxLresBSRIAXce4TjnDiuRGPyliEjO+yZ/79aq0lp9oBv9cp
   VymN2fwp3MKLB+LuQuH6DhauGmQ3H5TSqSS9XtF7E4lJwKKfUWeEq5hWd
   oQcwAV9X6pXaGtbNzEdsY86kLIWpFHbQUM3XoXaIeYPZYEwTxKYfqm1SR
   9ATuGb1qYsCVNqOTypl986N1irPms5LFKg3q7p1u1tlZ/RxLYs/13oglG
   +11ef0wTcc2wwl9J47j8ndYUIM0Ncj4m1MyY/0e9nlN2ZAR9Amg/XPsm3
   ELpWWXOG47Wd1r754PlHA499xw9GMka8+BTBNM67sy6SvkGjsXIJmiJPI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="2508381"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="2508381"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 03:03:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="822533447"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="822533447"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 31 Jan 2024 03:03:51 -0800
Received: by stinkbox (sSMTP sendmail emulation); Wed, 31 Jan 2024 13:03:50 +0200
Date: Wed, 31 Jan 2024 13:03:50 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
	airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH AUTOSEL 6.1 04/53] drm: Fix color LUT rounding
Message-ID: <ZbopFnfEwETj0mlx@intel.com>
References: <20240122150949.994249-1-sashal@kernel.org>
 <20240122150949.994249-4-sashal@kernel.org>
 <Za6ano6dg0Mau7OI@intel.com>
 <Zbl_gq9FhTICi4FS@sashalap>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zbl_gq9FhTICi4FS@sashalap>
X-Patchwork-Hint: comment

On Tue, Jan 30, 2024 at 06:00:18PM -0500, Sasha Levin wrote:
> On Mon, Jan 22, 2024 at 06:50:00PM +0200, Ville Syrjälä wrote:
> >On Mon, Jan 22, 2024 at 10:08:05AM -0500, Sasha Levin wrote:
> >> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> >>
> >> [ Upstream commit c6fbb6bca10838485b820e8a26c23996f77ce580 ]
> >
> >Why is this being backported?
> 
> Is this not a fix for an issue?

It is, for a very minor one that's not really going to hurt
anyone. But it doesn't exist in a vacuum so backprting it
alone can introduce other issues that people will actually
notice. If I wanted it backported I would have have
tagged it as such.

-- 
Ville Syrjälä
Intel

