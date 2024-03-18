Return-Path: <linux-kernel+bounces-106020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5F587E7B6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4C852836CF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069462EAE5;
	Mon, 18 Mar 2024 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ehMsiZyV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C28A2DF92;
	Mon, 18 Mar 2024 10:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759142; cv=none; b=QgU3QDxvj7wttnCeDpezTo+HxHqoLyaC9XzcPptKzLhcdOZnjiP3DwiDGPbH8KaMDV1GNrsjwkBcQPrvik5UX8186mMqKq1zWUmX7796FisOIZuTq21CKudOEsWMXxnk9l9OHCOTH4V/TXywopVEaUU3Wl+w1gbx0O3yZGiwANQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759142; c=relaxed/simple;
	bh=kGc4kRCh8K/u7JQbGUUELXchD0hHGvGrWcrArfa4cP0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nesgm071j9C4hHUv1cSxN2EIyR19kuxskfatVqdkKgL9f1OYDbd2hgHDV+lwmAaQHEEyDJqTjprqLCfijzDVGrk8no+hBy1gr9w5MNDZwxPF91IyK0ihZ0IH3LiO9Hjps/jx4LOh+Cs4BBfxpsrmSL6cT2D6NJ3n2Y51bFo03SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ehMsiZyV; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710759140; x=1742295140;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=kGc4kRCh8K/u7JQbGUUELXchD0hHGvGrWcrArfa4cP0=;
  b=ehMsiZyVMN+Knlxbbqq8/LQ4qF0jodZibQLWR8sigrUWA7ZcNnUJLglB
   w6m01gDoUi12J+3xx1zDdVA6dUMYzAnCZ6V8+ToqxSYtpdsbG4tGDNBLl
   KgTrCDZ2rVXQpC1tkwowtLNN3WuIlIZMYXDM24iHHS8/0H0Ak6x3AK1X0
   o0rZ7fXzpnDVoN07UD2SoAM7JdvtXX39MIrVZCvbSXxFbqxTxz3FnQxDj
   Clewhloz2nAX/8Ph9YvgyRDqlrLgp/C/ZMEvKR67hBzGMKAStMAG4ykXD
   4dC9TJgapZkQw3L7io3uONm7SpylU0+oB1pAVQHUA0AxhlwUvI2/HS36o
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="23023571"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="23023571"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 03:52:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="18039699"
Received: from ahmedess-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.133])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 03:52:13 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Luca Weiss
 <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: Select DRM_KMS_HELPER for DRM_PANEL_BRIDGE
In-Reply-To: <171075294759.1615603.8073986785380285265.b4-ty@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240111-drm-panel-bridge-fixup-v1-1-e06292f6f500@fairphone.com>
 <171075294759.1615603.8073986785380285265.b4-ty@linaro.org>
Date: Mon, 18 Mar 2024 12:52:10 +0200
Message-ID: <87wmpzq0bp.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 18 Mar 2024, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> Hi,
>
> On Thu, 11 Jan 2024 13:38:04 +0100, Luca Weiss wrote:
>> Since the kconfig symbol of DRM_PANEL_BRIDGE is only adding
>> bridge/panel.o to drm_kms_helper object, we need to select
>> DRM_KMS_HELPER to make sure the file is actually getting built.
>> 
>> Otherwise with certain defconfigs e.g. devm_drm_of_get_bridge will not
>> be properly available:
>> 
>> [...]
>
> Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)
>
> [1/1] drm/bridge: Select DRM_KMS_HELPER for DRM_PANEL_BRIDGE
>       https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/e3f18b0dd1db242791afbc3bd173026163ce0ccc

With my kernel config, e3f18b0dd1db ("drm/bridge: Select DRM_KMS_HELPER
for DRM_PANEL_BRIDGE") leads to:

WARNING: unmet direct dependencies detected for DRM_KMS_HELPER
  Depends on [m]: HAS_IOMEM [=y] && DRM [=m]
  Selected by [y]:
  - DRM_PANEL_BRIDGE [=y] && HAS_IOMEM [=y] && DRM_BRIDGE [=y]
  Selected by [m]:
  - DRM [=m] && HAS_IOMEM [=y] && (AGP [=y] || AGP [=y]=n) && !EMULATED_CMPXCHG && HAS_DMA [=y] && DRM_FBDEV_EMULATION [=y]
  - DRM_MIPI_DBI [=m] && HAS_IOMEM [=y] && DRM [=m]
  - DRM_KUNIT_TEST [=m] && HAS_IOMEM [=y] && DRM [=m] && KUNIT [=y] && MMU [=y]
  - DRM_RADEON [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && MMU [=y] && (AGP [=y] || !AGP [=y])
  - DRM_AMDGPU [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && MMU [=y] && !UML
  - DRM_NOUVEAU [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && MMU [=y]
  - DRM_I915 [=m] && HAS_IOMEM [=y] && DRM [=m] && X86 [=y] && PCI [=y] && !PREEMPT_RT [=n]
  - DRM_XE [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && MMU [=y] && (m && MODULES [=y] || y && KUNIT [=y]=y) && 64BIT [=y]
  - DRM_VKMS [=m] && HAS_IOMEM [=y] && DRM [=m] && MMU [=y]
  - DRM_VMWGFX [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && MMU [=y] && (X86 [=y] || ARM64)
  - DRM_GMA500 [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && X86 [=y] && MMU [=y]
  - DRM_UDL [=m] && HAS_IOMEM [=y] && DRM [=m] && USB [=m] && USB_ARCH_HAS_HCD [=y] && MMU [=y]
  - DRM_AST [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && MMU [=y]
  - DRM_MGAG200 [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && MMU [=y]
  - DRM_QXL [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && MMU [=y]
  - DRM_VIRTIO_GPU [=m] && HAS_IOMEM [=y] && DRM [=m] && VIRTIO_MENU [=y] && MMU [=y]
  - DRM_BOCHS [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && MMU [=y]
  - DRM_CIRRUS_QEMU [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && MMU [=y]
  - DRM_GM12U320 [=m] && HAS_IOMEM [=y] && DRM [=m] && USB [=m] && MMU [=y]
  - DRM_PANEL_MIPI_DBI [=m] && HAS_IOMEM [=y] && DRM [=m] && SPI [=y]
  - DRM_SIMPLEDRM [=m] && HAS_IOMEM [=y] && DRM [=m] && MMU [=y]
  - TINYDRM_HX8357D [=m] && HAS_IOMEM [=y] && DRM [=m] && SPI [=y]
  - TINYDRM_ILI9163 [=m] && HAS_IOMEM [=y] && DRM [=m] && SPI [=y]
  - TINYDRM_ILI9225 [=m] && HAS_IOMEM [=y] && DRM [=m] && SPI [=y]
  - TINYDRM_ILI9341 [=m] && HAS_IOMEM [=y] && DRM [=m] && SPI [=y]
  - TINYDRM_ILI9486 [=m] && HAS_IOMEM [=y] && DRM [=m] && SPI [=y]
  - TINYDRM_MI0283QT [=m] && HAS_IOMEM [=y] && DRM [=m] && SPI [=y]
  - TINYDRM_REPAPER [=m] && HAS_IOMEM [=y] && DRM [=m] && SPI [=y]
  - TINYDRM_ST7586 [=m] && HAS_IOMEM [=y] && DRM [=m] && SPI [=y]
  - TINYDRM_ST7735R [=m] && HAS_IOMEM [=y] && DRM [=m] && SPI [=y]
  - DRM_XEN_FRONTEND [=m] && HAS_IOMEM [=y] && XEN [=y] && DRM [=m]
  - DRM_VBOXVIDEO [=m] && HAS_IOMEM [=y] && DRM [=m] && X86 [=y] && PCI [=y]
  - DRM_GUD [=m] && HAS_IOMEM [=y] && DRM [=m] && USB [=m] && MMU [=y]
  - DRM_SSD130X [=m] && HAS_IOMEM [=y] && DRM [=m] && MMU [=y]
  - DRM_ANALOGIX_ANX78XX [=m] && HAS_IOMEM [=y] && DRM [=m] && DRM_BRIDGE [=y]


BR,
Jani.

-- 
Jani Nikula, Intel

