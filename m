Return-Path: <linux-kernel+bounces-106130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0355587E990
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849E71F2185B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9579636AE0;
	Mon, 18 Mar 2024 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ijW2ZALP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78601210EC;
	Mon, 18 Mar 2024 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710766171; cv=none; b=lEmA4837qk2S167/GBOqcQNTz0rj3Rf314wGbUxpE7zUcDQ8jZHRTmpPiK3A9C5mkqvxWUJfCQWMV3fHpD1E170ZnxzSiOPNIWStCmWOVTs//LM8xRRMKlBQMBzmK1IVYF4aPpxdVD+cuSj0+Hd3XN8iB8UNJi0guunFyA7C08c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710766171; c=relaxed/simple;
	bh=GG08uu/7PRYcHnUSeAcc70mgP29OlkALxz8qX43lSQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZKYMhmEM48uF3Ttf8oZct5RfI3Pp/pTq3yrAhL1D2Pj/1o9ags2R0aDwn99I+3o1gz6DDHznMdowZEg+1uKbDX7Zv3inMYOLL/5rMXrzwewrifNvp8nHst3ljfahWUpE6Ys4r4gkxqJu5gtA7rEyRrRsB4G3G5bFYBo7A57tcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ijW2ZALP; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710766169; x=1742302169;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=GG08uu/7PRYcHnUSeAcc70mgP29OlkALxz8qX43lSQs=;
  b=ijW2ZALPYTDspEVzFEGEi4Bp4PFYBaozUcE88qB7aXEdGvucQcHnipLa
   UC+5XaAfnW8M/iVQKyC0JShQAizlDSOkb0LWFbL3TW8YIvt/IzZYzWCaa
   nPMZ/HrZuSZ0BprSDCqrau7SxKjDymUuR6X3/G5lKo4tGDYRGOkEG5VYa
   VGmC6sov/q2xkYE7okdLIjJBxbx8aWepzldBNCzMvjZO3Bj8zPSSmLWev
   dT4DPEp6Dd6oeMA0gcPyEYNw4VdY75g6JjaTi/gZSwrp74fCfVw2bUr9H
   AX11pVMbTqaxPIyjoUiQ2GPyYrppmyeg/sHnoJTNI0QAHP5k0y2F7vAFa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="16212989"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="16212989"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 05:49:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="18152352"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 05:49:24 -0700
Date: Mon, 18 Mar 2024 14:49:51 +0200
From: Imre Deak <imre.deak@intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Luca Weiss <luca.weiss@fairphone.com>
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
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: Select DRM_KMS_HELPER for DRM_PANEL_BRIDGE
Message-ID: <Zfg4b44TJ+bSADqJ@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
References: <20240111-drm-panel-bridge-fixup-v1-1-e06292f6f500@fairphone.com>
 <171075294759.1615603.8073986785380285265.b4-ty@linaro.org>
 <87wmpzq0bp.fsf@intel.com>
 <87ttl3pzzi.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttl3pzzi.fsf@intel.com>

On Mon, Mar 18, 2024 at 12:59:29PM +0200, Jani Nikula wrote:
> On Mon, 18 Mar 2024, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> > On Mon, 18 Mar 2024, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> >> Hi,
> >>
> >> On Thu, 11 Jan 2024 13:38:04 +0100, Luca Weiss wrote:
> >>> Since the kconfig symbol of DRM_PANEL_BRIDGE is only adding
> >>> bridge/panel.o to drm_kms_helper object, we need to select
> >>> DRM_KMS_HELPER to make sure the file is actually getting built.
> >>> 
> >>> Otherwise with certain defconfigs e.g. devm_drm_of_get_bridge will not
> >>> be properly available:
> >>> 
> >>> [...]
> >>
> >> Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)
> >>
> >> [1/1] drm/bridge: Select DRM_KMS_HELPER for DRM_PANEL_BRIDGE
> >>       https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/e3f18b0dd1db242791afbc3bd173026163ce0ccc
> >
> > With my kernel config, e3f18b0dd1db ("drm/bridge: Select DRM_KMS_HELPER
> > for DRM_PANEL_BRIDGE") leads to:
> >
> > WARNING: unmet direct dependencies detected for DRM_KMS_HELPER
> >   Depends on [m]: HAS_IOMEM [=y] && DRM [=m]
> >   Selected by [y]:
> >   - DRM_PANEL_BRIDGE [=y] && HAS_IOMEM [=y] && DRM_BRIDGE [=y]
> >   Selected by [m]:
> >   - DRM [=m] && HAS_IOMEM [=y] && (AGP [=y] || AGP [=y]=n) && !EMULATED_CMPXCHG && HAS_DMA [=y] && DRM_FBDEV_EMULATION [=y]
> >   - DRM_MIPI_DBI [=m] && HAS_IOMEM [=y] && DRM [=m]
> >   - DRM_KUNIT_TEST [=m] && HAS_IOMEM [=y] && DRM [=m] && KUNIT [=y] && MMU [=y]
> >   - DRM_RADEON [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && MMU [=y] && (AGP [=y] || !AGP [=y])
> >   - DRM_AMDGPU [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && MMU [=y] && !UML
> >   - DRM_NOUVEAU [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && MMU [=y]
> >   - DRM_I915 [=m] && HAS_IOMEM [=y] && DRM [=m] && X86 [=y] && PCI [=y] && !PREEMPT_RT [=n]
> >   - DRM_XE [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && MMU [=y] && (m && MODULES [=y] || y && KUNIT [=y]=y) && 64BIT [=y]
> >   - DRM_VKMS [=m] && HAS_IOMEM [=y] && DRM [=m] && MMU [=y]
> >   - DRM_VMWGFX [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && MMU [=y] && (X86 [=y] || ARM64)
> >   - DRM_GMA500 [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && X86 [=y] && MMU [=y]
> >   - DRM_UDL [=m] && HAS_IOMEM [=y] && DRM [=m] && USB [=m] && USB_ARCH_HAS_HCD [=y] && MMU [=y]
> >   - DRM_AST [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && MMU [=y]
> >   - DRM_MGAG200 [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && MMU [=y]
> >   - DRM_QXL [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && MMU [=y]
> >   - DRM_VIRTIO_GPU [=m] && HAS_IOMEM [=y] && DRM [=m] && VIRTIO_MENU [=y] && MMU [=y]
> >   - DRM_BOCHS [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && MMU [=y]
> >   - DRM_CIRRUS_QEMU [=m] && HAS_IOMEM [=y] && DRM [=m] && PCI [=y] && MMU [=y]
> >   - DRM_GM12U320 [=m] && HAS_IOMEM [=y] && DRM [=m] && USB [=m] && MMU [=y]
> >   - DRM_PANEL_MIPI_DBI [=m] && HAS_IOMEM [=y] && DRM [=m] && SPI [=y]
> >   - DRM_SIMPLEDRM [=m] && HAS_IOMEM [=y] && DRM [=m] && MMU [=y]
> >   - TINYDRM_HX8357D [=m] && HAS_IOMEM [=y] && DRM [=m] && SPI [=y]
> >   - TINYDRM_ILI9163 [=m] && HAS_IOMEM [=y] && DRM [=m] && SPI [=y]
> >   - TINYDRM_ILI9225 [=m] && HAS_IOMEM [=y] && DRM [=m] && SPI [=y]
> >   - TINYDRM_ILI9341 [=m] && HAS_IOMEM [=y] && DRM [=m] && SPI [=y]
> >   - TINYDRM_ILI9486 [=m] && HAS_IOMEM [=y] && DRM [=m] && SPI [=y]
> >   - TINYDRM_MI0283QT [=m] && HAS_IOMEM [=y] && DRM [=m] && SPI [=y]
> >   - TINYDRM_REPAPER [=m] && HAS_IOMEM [=y] && DRM [=m] && SPI [=y]
> >   - TINYDRM_ST7586 [=m] && HAS_IOMEM [=y] && DRM [=m] && SPI [=y]
> >   - TINYDRM_ST7735R [=m] && HAS_IOMEM [=y] && DRM [=m] && SPI [=y]
> >   - DRM_XEN_FRONTEND [=m] && HAS_IOMEM [=y] && XEN [=y] && DRM [=m]
> >   - DRM_VBOXVIDEO [=m] && HAS_IOMEM [=y] && DRM [=m] && X86 [=y] && PCI [=y]
> >   - DRM_GUD [=m] && HAS_IOMEM [=y] && DRM [=m] && USB [=m] && MMU [=y]
> >   - DRM_SSD130X [=m] && HAS_IOMEM [=y] && DRM [=m] && MMU [=y]
> >   - DRM_ANALOGIX_ANX78XX [=m] && HAS_IOMEM [=y] && DRM [=m] && DRM_BRIDGE [=y]
> 
> Please read Documentation/kbuild/kconfig-language.rst.
> 
> Basically boolean DRM_PANEL_BRIDGE selecting tristate DRM_KMS_HELPER
> forces it to y while it should remain m.
> 
> Please revert.

I can also see the above issue with the latest drm-tip, in particular a
CONFIG_DRM=m build will fail with the above kconfig warns and then
multiple linker errors:

ld: drivers/gpu/drm/drm_atomic_helper.o: in function `drm_atomic_helper_check_wb_connector_state':
/home/imre/intel-gfx/drm-misc-fixes/drivers/gpu/drm/drm_atomic_helper.c:832: undefined reference to `__drm_dev_dbg'
ld: drivers/gpu/drm/drm_atomic_helper.o: in function `drm_atomic_helper_async_check':
/home/imre/intel-gfx/drm-misc-fixes/drivers/gpu/drm/drm_atomic_helper.c:1932: undefined reference to `__drm_dev_dbg'
ld: /home/imre/intel-gfx/drm-misc-fixes/drivers/gpu/drm/drm_atomic_helper.c:1924: undefined reference to `__drm_dev_dbg'
ld: /home/imre/intel-gfx/drm-misc-fixes/drivers/gpu/drm/drm_atomic_helper.c:1896: undefined reference to `__drm_dev_dbg'
ld: /home/imre/intel-gfx/drm-misc-fixes/drivers/gpu/drm/drm_atomic_helper.c:1911: undefined reference to `__drm_dev_dbg'
ld: drivers/gpu/drm/drm_atomic_helper.o:/home/imre/intel-gfx/drm-misc-fixes/drivers/gpu/drm/drm_atomic_helper.c:1889: more undefined references to `__drm_dev_dbg' follow
ld: drivers/gpu/drm/drm_atomic_helper.o: in function `drm_atomic_helper_wait_for_dependencies':
/home/imre/intel-gfx/drm-misc-fixes/drivers/gpu/drm/drm_atomic_helper.c:2410: undefined reference to `drm_crtc_commit_wait'
ld: /home/imre/intel-gfx/drm-misc-fixes/drivers/gpu/drm/drm_atomic_helper.c:2418: undefined reference to `drm_crtc_commit_wait'
ld: /home/imre/intel-gfx/drm-misc-fixes/drivers/gpu/drm/drm_atomic_helper.c:2426: undefined reference to `drm_crtc_commit_wait'
ld: drivers/gpu/drm/drm_atomic_helper.o: in function `drm_atomic_helper_fake_vblank':
/home/imre/intel-gfx/drm-misc-fixes/drivers/gpu/drm/drm_atomic_helper.c:2467: undefined reference to `drm_crtc_send_vblank_event'
ld: drivers/gpu/drm/drm_atomic_helper.o: in function `drm_atomic_helper_prepare_planes':
/home/imre/intel-gfx/drm-misc-fixes/drivers/gpu/drm/drm_atomic_helper.c:2589: undefined reference to `drm_writeback_prepare_job'
ld: drivers/gpu/drm/drm_atomic_helper.o: in function `drm_atomic_helper_commit_duplicated_state':

..

CONFIG_DRM=y still builds ok.

> BR,
> Jani.
> 
> 
> -- 
> Jani Nikula, Intel

