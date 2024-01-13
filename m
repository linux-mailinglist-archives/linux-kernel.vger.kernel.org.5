Return-Path: <linux-kernel+bounces-25376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A593F82CECB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 22:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 196E4B217E6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 21:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B0A18049;
	Sat, 13 Jan 2024 21:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="CuUNN25x"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170141802B
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 21:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost.ispras.ru (unknown [10.10.165.8])
	by mail.ispras.ru (Postfix) with ESMTPSA id 04EB340F1DDD;
	Sat, 13 Jan 2024 21:34:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 04EB340F1DDD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1705181659;
	bh=jA1iaioDoAtebqph2VGtTKoDOZFhOG2UxbmEz0EkRBE=;
	h=From:To:Cc:Subject:Date:From;
	b=CuUNN25xkBLgDuEJKLcjth4fJwm5s0KpDHJVZ1qwcgY5rik4uP9Q73YM8eM9lY1qZ
	 uq93Di6gnKXiXHDHMqa8eKd+CW6aJc+EW9b21HOCnBQmQLc2RIZS4xH+k1PccRtLJn
	 DWnRHK+/ikKonlsJ6X/R8FdDIZKLr7kiDL9gMpRo=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Christian Koenig <christian.koenig@amd.com>,
	Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Huang Rui <ray.huang@amd.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH] drm/ttm: fix ttm pool initialization for no-dma-device drivers
Date: Sun, 14 Jan 2024 00:33:45 +0300
Message-ID: <20240113213347.9562-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

QXL driver doesn't use any device for DMA mappings or allocations so
dev_to_node() will panic inside ttm_device_init() on NUMA systems:

general protection fault, probably for non-canonical address 0xdffffc000000007a: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x00000000000003d0-0x00000000000003d7]
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.7.0+ #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
RIP: 0010:ttm_device_init+0x10e/0x340
Call Trace:
 <TASK>
 qxl_ttm_init+0xaa/0x310
 qxl_device_init+0x1071/0x2000
 qxl_pci_probe+0x167/0x3f0
 local_pci_probe+0xe1/0x1b0
 pci_device_probe+0x29d/0x790
 really_probe+0x251/0x910
 __driver_probe_device+0x1ea/0x390
 driver_probe_device+0x4e/0x2e0
 __driver_attach+0x1e3/0x600
 bus_for_each_dev+0x12d/0x1c0
 bus_add_driver+0x25a/0x590
 driver_register+0x15c/0x4b0
 qxl_pci_driver_init+0x67/0x80
 do_one_initcall+0xf5/0x5d0
 kernel_init_freeable+0x637/0xb10
 kernel_init+0x1c/0x2e0
 ret_from_fork+0x48/0x80
 ret_from_fork_asm+0x1b/0x30
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ttm_device_init+0x10e/0x340

Fall back to NUMA_NO_NODE if there is no device for DMA.

Found by Linux Verification Center (linuxtesting.org).

Fixes: b0a7ce53d494 ("drm/ttm: Schedule delayed_delete worker closer")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/gpu/drm/ttm/ttm_device.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
index f5187b384ae9..4130945052ed 100644
--- a/drivers/gpu/drm/ttm/ttm_device.c
+++ b/drivers/gpu/drm/ttm/ttm_device.c
@@ -195,7 +195,7 @@ int ttm_device_init(struct ttm_device *bdev, const struct ttm_device_funcs *func
 		    bool use_dma_alloc, bool use_dma32)
 {
 	struct ttm_global *glob = &ttm_glob;
-	int ret;
+	int ret, nid;
 
 	if (WARN_ON(vma_manager == NULL))
 		return -EINVAL;
@@ -215,7 +215,12 @@ int ttm_device_init(struct ttm_device *bdev, const struct ttm_device_funcs *func
 
 	ttm_sys_man_init(bdev);
 
-	ttm_pool_init(&bdev->pool, dev, dev_to_node(dev), use_dma_alloc, use_dma32);
+	if (dev)
+		nid = dev_to_node(dev);
+	else
+		nid = NUMA_NO_NODE;
+
+	ttm_pool_init(&bdev->pool, dev, nid, use_dma_alloc, use_dma32);
 
 	bdev->vma_manager = vma_manager;
 	spin_lock_init(&bdev->lru_lock);
-- 
2.43.0


