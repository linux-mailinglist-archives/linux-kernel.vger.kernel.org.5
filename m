Return-Path: <linux-kernel+bounces-106174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EF687EA49
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911561F2250C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8E0482EA;
	Mon, 18 Mar 2024 13:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OzCR2FHY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D7F249EB;
	Mon, 18 Mar 2024 13:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710769325; cv=none; b=D8MgFhMSjiHMtFXHHznRk5UHVVGPCUrha5X1LjSkvJTwlExMOcSGqpeQ/sjHSn1y6GW1Hiw+tz9p+CUuH+72gm08O0Pvos9MvB/ewpiWMqFYxn0cePv0mMnt/+f2ZycTs34bYRfHLxS4tdZOj+9XI3Y5GtJRvPR7UrmuARtjzYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710769325; c=relaxed/simple;
	bh=QwXw278uS5af1/QLWBfT+3opLUTGo1Iotai2VsBacwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZISPGT8NWMXj6EKwwOKkAsTbRv3/Fm5AdFIgUnJbT4RBPneYWNS3MTTW9XVJMQRMNZikTSbveO28r6f9ESOTSP089gMVtrqnQDpRWcS1oRiM4b8HMN+EqKcUSNGAf/Mbd2xxUvcVv81+mOXunxMsuYgk+ARVykIbS7sYRc2h8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OzCR2FHY; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710769324; x=1742305324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QwXw278uS5af1/QLWBfT+3opLUTGo1Iotai2VsBacwA=;
  b=OzCR2FHYckU2tSO9qoqZtSa7vkYMCNTAQV/VzLCSUfB59XX0PO2QwqVd
   b8zZEssZqQrjgkLsYNK8p20sRfU+fuJYyTB86BjJLL94o/8mjswIl9Bbi
   2/4ojK56Jb8pX+VwOmHn15xRJ7nwiK9sE0hb4Sve9LGGx5W3Xq4YYZlGy
   IOB7ePQn7Jd23ID9L9JgDgc3NTFkbCFX6XQHp71tXhX1m6QW9vNeQsqOQ
   uC3il0l8gFOJNxCpn6F6nAwgH+oZdiqh9QiDZGatjVL2vCM+vCUBcPBYU
   Ed4zpx0/KX6unhRWbjbmQ4P8yL+9+8YI3oa9f7zvnObAQ9nUuSfC4SOt0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="5765572"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5765572"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 06:42:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="827781790"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="827781790"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 18 Mar 2024 06:41:57 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 18 Mar 2024 15:41:56 +0200
Date: Mon, 18 Mar 2024 15:41:56 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Luca Weiss <luca.weiss@fairphone.com>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: Select DRM_KMS_HELPER for DRM_PANEL_BRIDGE
Message-ID: <ZfhEpBLfAHk3JdlM@intel.com>
References: <20240111-drm-panel-bridge-fixup-v1-1-e06292f6f500@fairphone.com>
 <171075294759.1615603.8073986785380285265.b4-ty@linaro.org>
 <87wmpzq0bp.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wmpzq0bp.fsf@intel.com>
X-Patchwork-Hint: comment

On Mon, Mar 18, 2024 at 12:52:10PM +0200, Jani Nikula wrote:
> On Mon, 18 Mar 2024, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> > Hi,
> >
> > On Thu, 11 Jan 2024 13:38:04 +0100, Luca Weiss wrote:
> >> Since the kconfig symbol of DRM_PANEL_BRIDGE is only adding
> >> bridge/panel.o to drm_kms_helper object, we need to select
> >> DRM_KMS_HELPER to make sure the file is actually getting built.
> >> 
> >> Otherwise with certain defconfigs e.g. devm_drm_of_get_bridge will not
> >> be properly available:
> >> 
> >> [...]
> >
> > Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)
> >
> > [1/1] drm/bridge: Select DRM_KMS_HELPER for DRM_PANEL_BRIDGE
> >       https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/e3f18b0dd1db242791afbc3bd173026163ce0ccc
> 
> With my kernel config, e3f18b0dd1db ("drm/bridge: Select DRM_KMS_HELPER
> for DRM_PANEL_BRIDGE") leads to:
> 
> WARNING: unmet direct dependencies detected for DRM_KMS_HELPER
>   Depends on [m]: HAS_IOMEM [=y] && DRM [=m]
..

All the defconfigs in drm-rerere also seem to fail here.

Neil, are you using some weird .config, or did you not actually
build test this before pushing?

PS. the drm-rerere defconfigs seem pretty outdated (eg. missing
    tons of panel drivers). Would be good if someone could update
    those to provide better coverage

-- 
Ville Syrjälä
Intel

