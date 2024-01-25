Return-Path: <linux-kernel+bounces-38044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 198E483BA30
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6BE228D7A7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F11C11181;
	Thu, 25 Jan 2024 06:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QdlSJjwv"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B91C10A2B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 06:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706164603; cv=none; b=czUBaL6GbNo/nTRA02/WeVdeWIdbzoeZjIGJdIfgVL8riwWAXT5xFjLN896y+JzL425AaqNjp7Wkx7e2PB1UQcktW0Lwu0Ppl0TFrIud3RZOT6keyB/V/Kz4BOsD7pEEG8FWjcA2cI0+heS1YS7eU+auRidQNamoxWePQhU+aDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706164603; c=relaxed/simple;
	bh=iKNSG8qLy9+IU6XC8XCWUQXo7YjyxS4FMfRu28VsM1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ptqHgld2+NiLdvC2TLPXM3qIb6W12nIIAMG0ewnA2wJzt9/vOSd3DtIh4RNieaBSRB2MkcOjxLjWqw79gwTQb691KKh4gk9nXbO8EoadjtBd/AvzN3K36qpb97MgzsQKONuZwnTj291FK2t+4CFyhdmUx5kgaM+3f/Zu0PRCv/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QdlSJjwv; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706164602; x=1737700602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iKNSG8qLy9+IU6XC8XCWUQXo7YjyxS4FMfRu28VsM1M=;
  b=QdlSJjwv8xeB53zGlFPBDhmQXDmjBMWsL1JraxjPOIaT49IFTU0C2m2S
   4pggs4XUsGta8TXQRLe72I65YZHTYX3kP0yoEjB7xSYib4ekaYjmMjVjl
   JpTxBeq8gpnZMG8Z+/JRl1OXacVt4OaagIeFsqdbd30cMG0IysCda7nV1
   EOBkX/A1fs0OWB4psDtSiGa4Lzxy6j4AEpEz5NSXo3zO2idD66teFZGwt
   DPCMEBmWqsRt8EmHvJrgiAyFZlb2t71NW37nJ9ikaRnBKBN9e871tz/Xa
   sbvJ4OfsmIvhTj/ImR11HwiZ/GKBW55vLSgVu0HJ99xIgncO1wO/PaH4w
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="433228393"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="433228393"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 22:36:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="820699476"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="820699476"
Received: from tgl-lenovo-03.sh.intel.com ([10.239.87.93])
  by orsmga001.jf.intel.com with ESMTP; 24 Jan 2024 22:36:38 -0800
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
Date: Thu, 25 Jan 2024 14:36:33 +0800
Message-Id: <20240125063633.989944-1-xiaoming.wang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <y>
References: <y>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the call stack xe_device_probe ->  xe_display_init_nommio -> intel_power_domains_init
Power_domains  hasn't been cleaned up if return error,
which has do the clean in i915_driver_late_release call from i915_driver_probe.

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
 drivers/gpu/drm/xe/xe_display.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_display.c b/drivers/gpu/drm/xe/xe_display.c
index 74391d9b11ae..2725afba4afb 100644
--- a/drivers/gpu/drm/xe/xe_display.c
+++ b/drivers/gpu/drm/xe/xe_display.c
@@ -146,8 +146,10 @@ int xe_display_init_nommio(struct xe_device *xe)
 	intel_detect_pch(xe);
 
 	err = intel_power_domains_init(xe);
-	if (err)
+	if (err) {
+		intel_power_domains_cleanup(xe);
 		return err;
+	}
 
 	return drmm_add_action_or_reset(&xe->drm, xe_display_fini_nommio, xe);
 }
-- 
2.25.1


