Return-Path: <linux-kernel+bounces-40283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 795B483DD94
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC7E1C213C7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75EA1CF9A;
	Fri, 26 Jan 2024 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MPN2yaWx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5CECA73
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283305; cv=none; b=BQU8AWN4WhT2gtLfqbjY8iSNbkE80KWKDiRx+LwIVkzcMxHTnwMcJMQy1Td2GGFnxTUzdYD4Bx/AYG2oQdY819O8h98zfMOA759w/GFfwQ46bQCOFSFYqG+pctj+de9cwa4XlsesNAcf/RKao/JzKcvdF5l1MIpHoWec4N5yI3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283305; c=relaxed/simple;
	bh=v5P9LknsSMwEz0Qt7ZtZ3UN1mTbKYgPS/ZK5RtrKAuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E2hGwoHU0nm3T48ubrMbJzoig+bDm6MugcChx2jo7UbFx3rZqyhSWTxLPrx+ExdKS0CFcSC6+3caj1p3fKNSpNBIgp2rGcoX3kFMbWhaGP/x83hkmrnGeo9U3ESRELuSAObZq1YFDJvn/ZP8nWMnpgOuNZy/5B8Pfaj3y0LmoNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MPN2yaWx; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706283303; x=1737819303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v5P9LknsSMwEz0Qt7ZtZ3UN1mTbKYgPS/ZK5RtrKAuA=;
  b=MPN2yaWxSphcIGj42DI5nmi8NCjEIADLAaL77+9RczEptF/lv3Mauc4E
   Y6HZ1ADYzL3Q6OUKCr+5a9pjQ0rQVb+2tTHN4SAlfN+rzpN1ylcil73PX
   v29LNfFumtVWOFQvSNfqY80K9ueG4L89N56aR/N9VKmhZoyH6WYcBTvFv
   MQvuAmRirWAEB2V94cjJ1duYmtti+WI5Xpt11EHHMhsM7zbzofpREmX3H
   r8lzR96MnDtFgvd7Pcvg6JUJZNciVdEKU6p1vNnifQlIcZU14vRWomAf/
   28fUKSf2SG4uUBfVnn5srt7pp4Fthpn67syjqDR6VQ6IQXRXtHjEt0FSC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="2384768"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2384768"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 07:35:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="930399143"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="930399143"
Received: from tgl-lenovo-03.sh.intel.com ([10.239.87.93])
  by fmsmga001.fm.intel.com with ESMTP; 26 Jan 2024 07:34:57 -0800
From: wangxiaoming321 <xiaoming.wang@intel.com>
To: lucas.demarchi@intel.com,
	ogabbay@kernel.org,
	thomas.hellstrom@linux.intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: wangxiaoming321 <xiaoming.wang@intel.com>
Subject: [PATCH] drm/xe/display: Fix memleak in display initialization
Date: Fri, 26 Jan 2024 23:34:53 +0800
Message-Id: <20240126153453.997855-1-xiaoming.wang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240125063633.989944-1-xiaoming.wang@intel.com>
References: <20240125063633.989944-1-xiaoming.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_power_domains_init has been called twice in xe_device_probe:
xe_device_probe -> xe_display_init_nommio -> intel_power_domains_init(xe)
xe_device_probe -> xe_display_init_noirq -> intel_display_driver_probe_noirq
-> intel_power_domains_init(i915)

It needs remove one to avoid power_domains->power_wells double malloc.

unreferenced object 0xffff88811150ee00 (size 512):
  comm "systemd-udevd", pid 506, jiffies 4294674198 (age 3605.560s)
  hex dump (first 32 bytes):
    10 b4 9d a0 ff ff ff ff ff ff ff ff ff ff ff ff  ................
    ff ff ff ff ff ff ff ff 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8134b901>] __kmem_cache_alloc_node+0x1c1/0x2b0
    [<ffffffff812c98b2>] __kmalloc+0x52/0x150
    [<ffffffffa08b0033>] __set_power_wells+0xc3/0x360 [xe]
    [<ffffffffa08562fc>] xe_display_init_nommio+0x4c/0x70 [xe]
    [<ffffffffa07f0d1c>] xe_device_probe+0x3c/0x5a0 [xe]
    [<ffffffffa082e48f>] xe_pci_probe+0x33f/0x5a0 [xe]
    [<ffffffff817f2187>] local_pci_probe+0x47/0xa0
    [<ffffffff817f3db3>] pci_device_probe+0xc3/0x1f0
    [<ffffffff8192f2a2>] really_probe+0x1a2/0x410
    [<ffffffff8192f598>] __driver_probe_device+0x78/0x160
    [<ffffffff8192f6ae>] driver_probe_device+0x1e/0x90
    [<ffffffff8192f92a>] __driver_attach+0xda/0x1d0
    [<ffffffff8192c95c>] bus_for_each_dev+0x7c/0xd0
    [<ffffffff8192e159>] bus_add_driver+0x119/0x220
    [<ffffffff81930d00>] driver_register+0x60/0x120
    [<ffffffffa05e50a0>] 0xffffffffa05e50a0

Signed-off-by: wangxiaoming321 <xiaoming.wang@intel.com>
---
 drivers/gpu/drm/xe/xe_display.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_display.c b/drivers/gpu/drm/xe/xe_display.c
index 74391d9b11ae..e4db069f0db3 100644
--- a/drivers/gpu/drm/xe/xe_display.c
+++ b/drivers/gpu/drm/xe/xe_display.c
@@ -134,8 +134,6 @@ static void xe_display_fini_nommio(struct drm_device *dev, void *dummy)
 
 int xe_display_init_nommio(struct xe_device *xe)
 {
-	int err;
-
 	if (!xe->info.enable_display)
 		return 0;
 
@@ -145,10 +143,6 @@ int xe_display_init_nommio(struct xe_device *xe)
 	/* This must be called before any calls to HAS_PCH_* */
 	intel_detect_pch(xe);
 
-	err = intel_power_domains_init(xe);
-	if (err)
-		return err;
-
 	return drmm_add_action_or_reset(&xe->drm, xe_display_fini_nommio, xe);
 }
 
-- 
2.25.1


