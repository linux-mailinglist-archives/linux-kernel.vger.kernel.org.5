Return-Path: <linux-kernel+bounces-106294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B1287EC0E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C2DB280C5F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272CC4F1FB;
	Mon, 18 Mar 2024 15:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CUYs6qZd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CC9524A0;
	Mon, 18 Mar 2024 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710775461; cv=none; b=J1GqHXRML9F9kRFfuH5dgcWyQJpRAENP9z80p+M9/1QLCMO+hiEhPqjAT0lZlmCVeWJ7x7EzZY5yFidggRilSB+8dtfibOJ3HRIJDhTxpggBwWenjxBmA07lNXnMvBHrTcYqZ0jSl2qHpcujZJObOvKAWO0v0Q9emNgx+a0yhCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710775461; c=relaxed/simple;
	bh=H5Yl2+KH5clpDAidnyUJS6JZKwl1txrmCW3WlkQErtY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nXSskP7x02RtEG6KJ3yAQMR6gmfN0RCpEFMZ0z+2B+7rub+DmdsPvcEWjrpPjYrwXPYj8C3B/8SBL+7i5ef9g9b3UNx2dOANCgb56USRtLoYk9rQIE+7FdOjk5ZQGmTp3Ap6gWV2TXmRZokRUDe76q0KEBXhgtLTcj7NV4nTA+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CUYs6qZd; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710775460; x=1742311460;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=H5Yl2+KH5clpDAidnyUJS6JZKwl1txrmCW3WlkQErtY=;
  b=CUYs6qZdtfdoS5y8xzNSgNbD+RchsJQE1vINYs1OLw+kpJ1vtAZFF7MV
   GtZuKt3JSop+VcqZGLNxd+d95UGRMn0hAN3KrJ7Se005Eqquh0TwRoWPC
   QmvDJY/lbx9G4lxa3dd/PXdBpx3J8DC/WZEngtKu7Y5o+PyHZdwcyorDz
   JcPReHQsdS5sZm/jJ2aeujDzshLBjU0RBT1CUFo7Z/lzKsY6Pm2b7ce/K
   UVU2wUcyhJqQntF6FlT0TgIREB6PbxX4+J55f66lg2HRlE8v7G/8PzeDy
   HJqAAdATQLGGxP9+q0o8IwjDWpenWyGRsZKC1rCTQrcsOc/wxqFuECWxQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5456392"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5456392"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 08:24:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="13398989"
Received: from ahmedess-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.133])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 08:24:13 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Luca Weiss <luca.weiss@fairphone.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Masahiro
 Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH] drm/bridge: Select DRM_KMS_HELPER for DRM_PANEL_BRIDGE
In-Reply-To: <CZWX8POMMGS3.1YJ0MLS9HO90L@fairphone.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240111-drm-panel-bridge-fixup-v1-1-e06292f6f500@fairphone.com>
 <171075294759.1615603.8073986785380285265.b4-ty@linaro.org>
 <87wmpzq0bp.fsf@intel.com> <87ttl3pzzi.fsf@intel.com>
 <CZWX8POMMGS3.1YJ0MLS9HO90L@fairphone.com>
Date: Mon, 18 Mar 2024 17:24:10 +0200
Message-ID: <8734snpnqd.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 18 Mar 2024, "Luca Weiss" <luca.weiss@fairphone.com> wrote:
> Would you know the correct fix for this? I'm aware of the pattern
> "select FOO || !FOO" but I guess it's also not applicable here?

I don't think that pattern works for select, only for depends on.

And I think the problem, again, is the abuse of select for symbols with
dependencies.

$ git grep "select DRM_KMS_HELPER" | wc -l
122

I'm guessing these only work because a) they are tristates, and b) they
directly or indirectly already "depends on DRM", which satisfies
DRM_KMS_HELPER's "depends on DRM".

I think the correct fix for this, and a plethora of other kconfig
problems, is adhering to the note in
Documentation/kbuild/kconfig-language.rst:

  Note:
	select should be used with care. select will force
	a symbol to a value without visiting the dependencies.
	By abusing select you are able to select a symbol FOO even
	if FOO depends on BAR that is not set.
	In general use select only for non-visible symbols
	(no prompts anywhere) and for symbols with no dependencies.
	That will limit the usefulness but on the other hand avoid
	the illegal configurations all over.

The downsides are that it's a lot of churn to fix them, they'll creep
back in, and kconfig doesn't warn about these cases up front while it
could, and menuconfig etc. aren't helpful in enabling dependencies for
you recursively. So here we are, adding bandaid year after year. :(


BR,
Jani.


-- 
Jani Nikula, Intel

