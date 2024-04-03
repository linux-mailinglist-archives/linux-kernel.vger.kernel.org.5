Return-Path: <linux-kernel+bounces-129300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0704F896891
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C7C8B2B8C9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31B013E8B8;
	Wed,  3 Apr 2024 08:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJRQk4h6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288FE13E8AB
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131858; cv=none; b=Eui4NkO8kh5T7qS4iOgnSyeFZnf3+/i04uKzglexSWmVMqMTNe3q/sSJzJU49C17M3yfbaLxhqGx1+C8T9botyBsgSpuCDLiZjwuTATtn57m2ZaE6uu7ZYrWwi06E6pdGwL9P9HXugdOVQFWe8mDDsudJyHdgcxw2t2I5Pu9TBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131858; c=relaxed/simple;
	bh=SG0i7m/Qv+Wgr/oIlICWhiX3c3WYeQZoUHuUuYHJ3Mg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PA3R2gdS+CkRohezoq91eSXg0SwWr1Didbx89U9Px43Xt06o+eVMls/+KSeYMXF8pHFDiNVE+L3AeFINiPOCmAs53G0CSljfhegyF+9YVdhqcEROvwswdIMj+R6w7Be4QKR1rdhyCVwtb/ylMkoMBeE9XZtmmoomezZ77CFe2tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJRQk4h6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31ECC433F1;
	Wed,  3 Apr 2024 08:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712131858;
	bh=SG0i7m/Qv+Wgr/oIlICWhiX3c3WYeQZoUHuUuYHJ3Mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NJRQk4h6DbL0PRCv2v9sEcKs42xqNz/dxm75KgThlyRajdVuR078RQ02O7Izdo+ZZ
	 LnK2cN6v+mPmgcHePdMATB3uWETGSzCoSJz5BBh+gbBFtlrzLAOtVzoTK9cKPTD3VX
	 xoglKUzgdJlNV7lO9y0aBfZDI24awPTqxjbDGUnUTcOZxsNcWxCNIyZ+UqDVyYvmJO
	 RYoSNwxAs2MVFI6FRMnpM6OyUArbDkXu+BieEVf366sDxQluFmBuH+PruUunNsQ9nZ
	 NRi1r/PQPL/Svp9zyGT2Mai3oHNv3/DVU/reCWO2S9NvNWzVWNBW42fOs6BC3OmsjV
	 h5Uy2eh2EdNIA==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	"James Qian Wang (Arm Technology China)" <james.qian.wang@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Rob Herring <robh@kernel.org>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 22/34] drm/komeda: don't warn for unused debugfs files
Date: Wed,  3 Apr 2024 10:06:40 +0200
Message-Id: <20240403080702.3509288-23-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403080702.3509288-1-arnd@kernel.org>
References: <20240403080702.3509288-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

With debugfs disabled, the komeda_register debugfs file is unused:

drivers/gpu/drm/arm/display/komeda/komeda_dev.c:44:1: error: unused variable 'komeda_register_fops' [-Werror,-Wunused-const-variable]
DEFINE_SHOW_ATTRIBUTE(komeda_register);

The komeda_debugfs_init() function already has a call to debugfs_initialized()
that ends up eliminating the file as dead code, so just drop the #ifdef
to get rid of the warning.

Fixes: 576832681891 ("arm/komeda: Compile komeda_debugfs_init() only if CONFIG_DEBUG_FS is enabled")
Fixes: 7d3cfb70a604 ("drm/komeda: Add debugfs node "register" for register dump")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
index 14ee79becacb..5ba62e637a61 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -12,10 +12,8 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/dma-mapping.h>
-#ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
-#endif
 
 #include <drm/drm_print.h>
 
@@ -43,7 +41,6 @@ static int komeda_register_show(struct seq_file *sf, void *x)
 
 DEFINE_SHOW_ATTRIBUTE(komeda_register);
 
-#ifdef CONFIG_DEBUG_FS
 static void komeda_debugfs_init(struct komeda_dev *mdev)
 {
 	if (!debugfs_initialized())
@@ -55,7 +52,6 @@ static void komeda_debugfs_init(struct komeda_dev *mdev)
 	debugfs_create_x16("err_verbosity", 0664, mdev->debugfs_root,
 			   &mdev->err_verbosity);
 }
-#endif
 
 static ssize_t
 core_id_show(struct device *dev, struct device_attribute *attr, char *buf)
@@ -265,9 +261,7 @@ struct komeda_dev *komeda_dev_create(struct device *dev)
 
 	mdev->err_verbosity = KOMEDA_DEV_PRINT_ERR_EVENTS;
 
-#ifdef CONFIG_DEBUG_FS
 	komeda_debugfs_init(mdev);
-#endif
 
 	return mdev;
 
@@ -286,9 +280,7 @@ void komeda_dev_destroy(struct komeda_dev *mdev)
 
 	sysfs_remove_group(&dev->kobj, &komeda_sysfs_attr_group);
 
-#ifdef CONFIG_DEBUG_FS
 	debugfs_remove_recursive(mdev->debugfs_root);
-#endif
 
 	if (mdev->aclk)
 		clk_prepare_enable(mdev->aclk);
-- 
2.39.2


