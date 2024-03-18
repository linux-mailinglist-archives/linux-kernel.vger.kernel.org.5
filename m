Return-Path: <linux-kernel+bounces-106030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1AA87E7E0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE70B1C2152C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5FD32C96;
	Mon, 18 Mar 2024 10:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eIQ/A7ql"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D47376EC;
	Mon, 18 Mar 2024 10:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759580; cv=none; b=t25kph44T6JUwedZBara/T/jBlo8Z8R82l8BjOQUaiEWNOBZXCEfdkvQ2F4tE02Tnp1q7e10PCNgUej+ia59x92tEHdiuPeKbgC69yX1+l2QvS1EsfRZTWr6Rh8zOpC5eUwNJEal9xbfYkFKTt2MFa6RbRW57y4m9q2KKmnjTdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759580; c=relaxed/simple;
	bh=jH4juVmYO3OW2+xith3TnuAfUTev9LatWmEpCveIGgY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mBtGFbUoJxk6MEjaWUUpJgsXstEFOVva1+cbvNddrdpvlZAwn5c543Mx4LVNQPfFvBDzbg+KIlbxqI5BqChcW9UXaJ15XJvElN2vsFN5bIETg0KEmoce/vdL/XcigzXaTJAXQASiqY+gY53ooSLKOLS7heFZapXriZFTFjKDkIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eIQ/A7ql; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710759579; x=1742295579;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=jH4juVmYO3OW2+xith3TnuAfUTev9LatWmEpCveIGgY=;
  b=eIQ/A7qlu9ot27Jzjs3yvwC4othLVD7XJlC46JJC9Vjt8pihgYlIJXuh
   CAYkhtfCx3Cqv7Wm4WbFr+6cNDKZgEna+OXajc+NprbATjImDYJ67xDIw
   hMcZDFdVfiM+Q8hBRB5JZp0WpSuLNTSgZvMKY7BE+qoGAPlTF7urZtC++
   VFtdKIQdtzTodLWQUGwZoPMkuNPdNodMK8C83Bi4x69CNwStoCTawWE3E
   4blfJTpoD60DPsNoKi7bSDkDnFSzVzXf9PeWTOT8cU+7QVEMnRuY6gvnY
   r4+5b+BZlWvPItl0oEhehyNgD+h5udXnifllrsAV503BZLMyYtIS1Pzhs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="16201563"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="16201563"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 03:59:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="18120768"
Received: from ahmedess-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.133])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 03:59:32 -0700
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
In-Reply-To: <87wmpzq0bp.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240111-drm-panel-bridge-fixup-v1-1-e06292f6f500@fairphone.com>
 <171075294759.1615603.8073986785380285265.b4-ty@linaro.org>
 <87wmpzq0bp.fsf@intel.com>
Date: Mon, 18 Mar 2024 12:59:29 +0200
Message-ID: <87ttl3pzzi.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 18 Mar 2024, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Mon, 18 Mar 2024, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>> Hi,
>>
>> On Thu, 11 Jan 2024 13:38:04 +0100, Luca Weiss wrote:
>>> Since the kconfig symbol of DRM_PANEL_BRIDGE is only adding
>>> bridge/panel.o to drm_kms_helper object, we need to select
>>> DRM_KMS_HELPER to make sure the file is actually getting built.
>>> 
>>> Otherwise with certain defconfigs e.g. devm_drm_of_get_bridge will not
>>> be properly available:
>>> 
>>> [...]
>>
>> Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)
>>
>> [1/1] drm/bridge: Select DRM_KMS_HELPER for DRM_PANEL_BRIDGE
>>       https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/e3f18b0dd1db242791afbc3bd173026163ce0ccc
>
> With my kernel config, e3f18b0dd1db ("drm/bridge: Select DRM_KMS_HELPER
> for DRM_PANEL_BRIDGE") leads to:
>
> WARNING: unmet direct dependencies detected for DRM_KMS_HELPER
>   Depends on [m]: HAS_IOMEM [=y] && DRM [=m]
>   Selected by [y]:
>   - DRM_PANEL_BRIDGE [=y] && HAS_IOMEM [=y] && DRM_BRIDGE [=y]
>   Selected by [m]:
>   - DRM [=m] && HAS_IOMEM [=y] && (AGP [=y] || AGP [=y]=n) && !EMULATED_CMPXCHG && HAS_DMA [=y] && DRM_FBDEV_EMULATION [=y]
>   - DRM_MIPI_DBI [=m] && HAS_IOMEM [=y] && DRM [=m]
>   - DRM_KUNIT_TEST [=m] && HAS_IOMEM [=y] && DRM [=m] && KUNIT [=y] && MMU [=y]
>   - DRM_RADEON [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && MMU [=y] && (AGP [=y] || !AGP [=y])
>   - DRM_AMDGPU [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && MMU [=y] && !UML
>   - DRM_NOUVEAU [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && MMU [=y]
>   - DRM_I915 [=m] && HAS_IOMEM [=y] && DRM [=m] && X86 [=y] && PCI [=y] && !PREEMPT_RT [=n]
>   - DRM_XE [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && MMU [=y] && (m && MODULES [=y] || y && KUNIT [=y]=y) && 64BIT [=y]
>   - DRM_VKMS [=m] && HAS_IOMEM [=y] && DRM [=m] && MMU [=y]
>   - DRM_VMWGFX [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && MMU [=y] && (X86 [=y] || ARM64)
>   - DRM_GMA500 [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && X86 [=y] && MMU [=y]
>   - DRM_UDL [=m] && HAS_IOMEM [=y] && DRM [=m] && USB [=m] && USB_ARCH_HAS_HCD [=y] && MMU [=y]
>   - DRM_AST [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && MMU [=y]
>   - DRM_MGAG200 [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && MMU [=y]
>   - DRM_QXL [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && MMU [=y]
>   - DRM_VIRTIO_GPU [=m] && HAS_IOMEM [=y] && DRM [=m] && VIRTIO_MENU [=y] && MMU [=y]
>   - DRM_BOCHS [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && MMU [=y]
>   - DRM_CIRRUS_QEMU [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && MMU [=y]
>   - DRM_GM12U320 [=m] && HAS_IOMEM [=y] && DRM [=m] && USB [=m] && MMU [=y]
>   - DRM_PANEL_MIPI_DBI [=m] && HAS_IOMEM [=y] && DRM [=m] && SPI [=y]
>   - DRM_SIMPLEDRM [=m] && HAS_IOMEM [=y] && DRM [=m] && MMU [=y]
>   - TINYDRM_HX8357D [=m] && HAS_IOMEM [=y] && DRM [=m] && SPI [=y]
>   - TINYDRM_ILI9163 [=m] && HAS_IOMEM [=y] && DRM [=m] && SPI [=y]
>   - TINYDRM_ILI9225 [=m] && HAS_IOMEM [=y] && DRM [=m] && SPI [=y]
>   - TINYDRM_ILI9341 [=m] && HAS_IOMEM [=y] && DRM [=m] && SPI [=y]
>   - TINYDRM_ILI9486 [=m] && HAS_IOMEM [=y] && DRM [=m] && SPI [=y]
>   - TINYDRM_MI0283QT [=m] && HAS_IOMEM [=y] && DRM [=m] && SPI [=y]
>   - TINYDRM_REPAPER [=m] && HAS_IOMEM [=y] && DRM [=m] && SPI [=y]
>   - TINYDRM_ST7586 [=m] && HAS_IOMEM [=y] && DRM [=m] && SPI [=y]
>   - TINYDRM_ST7735R [=m] && HAS_IOMEM [=y] && DRM [=m] && SPI [=y]
>   - DRM_XEN_FRONTEND [=m] && HAS_IOMEM [=y] && XEN [=y] && DRM [=m]
>   - DRM_VBOXVIDEO [=m] && HAS_IOMEM [=y] && DRM [=m] && X86 [=y] && PCI [=y]
>   - DRM_GUD [=m] && HAS_IOMEM [=y] && DRM [=m] && USB [=m] && MMU [=y]
>   - DRM_SSD130X [=m] && HAS_IOMEM [=y] && DRM [=m] && MMU [=y]
>   - DRM_ANALOGIX_ANX78XX [=m] && HAS_IOMEM [=y] && DRM [=m] && DRM_BRIDGE [=y]

Please read Documentation/kbuild/kconfig-language.rst.

Basically boolean DRM_PANEL_BRIDGE selecting tristate DRM_KMS_HELPER
forces it to y while it should remain m.

Please revert.

BR,
Jani.


-- 
Jani Nikula, Intel

