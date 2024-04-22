Return-Path: <linux-kernel+bounces-152824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB498AC4BB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1F41F22002
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7C448CCC;
	Mon, 22 Apr 2024 07:08:33 +0000 (UTC)
Received: from mail-m17240.xmail.ntesmail.com (mail-m17240.xmail.ntesmail.com [45.195.17.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37779482D7;
	Mon, 22 Apr 2024 07:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.17.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713769713; cv=none; b=GfqWcyx/08OQH5XTzc2usxxNF7JvfQ2QfTWUy1wauVYep+LeodyRUUR1tSus4zoieH/GdKtWCGVhTMyZvfGtU/wCeAts/1q0ElvEZFgdGI98sB3nc+H4Q7DFrvnp+PVgq6E/Y7E26q9XpFsSHQH9p6JGJEQVyWeR5hQkED/a9nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713769713; c=relaxed/simple;
	bh=rO9wuLUfiR4E6XZ84kDSGhF4Q7qepug3oReICZiQTPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aGpzXxb51xeiyrjT0sB/DFez3FPufAxJHSV+cbACJWMtceCY52ex9WdpZ98I/s0y1tp51KTlGHK9ZZebnKxUMDhF5W3aKm+N1rrnntlVPjE3vSx/5THEUxkQ8vTaA5mgp/ud7lZjCGlEOP2KkrqpwWA9wPOomKyawzskf18iaAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=45.195.17.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from ubuntu-22-04.. (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 12BB186026B;
	Mon, 22 Apr 2024 15:01:33 +0800 (CST)
From: Dongsheng Yang <dongsheng.yang@easystack.cn>
To: dan.j.williams@intel.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	David Gow <davidgow@google.com>,
	Maxime Ripard <mripard@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] drivers: base: Free devm resources when unregistering a device
Date: Mon, 22 Apr 2024 07:01:23 +0000
Message-Id: <20240422070125.52519-3-dongsheng.yang@easystack.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422070125.52519-1-dongsheng.yang@easystack.cn>
References: <20240422070125.52519-1-dongsheng.yang@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGkhKVkgeGUseSkpJGUIdSlUZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKQ1VCT1VKSkNVQktZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8f049c2630023ckunm12bb186026b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mgw6Tgw*Czc9LxwBMhELGU8O
	NygKCQ5VSlVKTEpITE1CSUJIQ01MVTMWGhIXVR8UFRwIEx4VHFUCGhUcOx4aCAIIDxoYEFUYFUVZ
	V1kSC1lBWUlKQ1VCT1VKSkNVQktZV1kIAVlBT0NPQjcG

From: David Gow <davidgow@google.com>

In the current code, devres_release_all() only gets called if the device
has a bus and has been probed.

This leads to issues when using bus-less or driver-less devices where
the device might never get freed if a managed resource holds a reference
to the device. This is happening in the DRM framework for example.

We should thus call devres_release_all() in the device_del() function to
make sure that the device-managed actions are properly executed when the
device is unregistered, even if it has neither a bus nor a driver.

This is effectively the same change than commit 2f8d16a996da ("devres:
release resources on device_del()") that got reverted by commit
a525a3ddeaca ("driver core: free devres in device_release") over
memory leaks concerns.

This patch effectively combines the two commits mentioned above to
release the resources both on device_del() and device_release() and get
the best of both worlds.

Fixes: a525a3ddeaca ("driver core: free devres in device_release")
Signed-off-by: David Gow <davidgow@google.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Link: https://lore.kernel.org/r/20230720-kunit-devm-inconsistencies-test-v3-3-6aa7e074f373@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/core.c                      | 11 +++++++++++
 drivers/base/test/platform-device-test.c |  2 --
 drivers/base/test/root-device-test.c     |  2 --
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3dff5037943e..6ceaf50f5a67 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3817,6 +3817,17 @@ void device_del(struct device *dev)
 	device_platform_notify_remove(dev);
 	device_links_purge(dev);
 
+	/*
+	 * If a device does not have a driver attached, we need to clean
+	 * up any managed resources. We do this in device_release(), but
+	 * it's never called (and we leak the device) if a managed
+	 * resource holds a reference to the device. So release all
+	 * managed resources here, like we do in driver_detach(). We
+	 * still need to do so again in device_release() in case someone
+	 * adds a new resource after this point, though.
+	 */
+	devres_release_all(dev);
+
 	bus_notify(dev, BUS_NOTIFY_REMOVED_DEVICE);
 	kobject_uevent(&dev->kobj, KOBJ_REMOVE);
 	glue_dir = get_glue_dir(dev);
diff --git a/drivers/base/test/platform-device-test.c b/drivers/base/test/platform-device-test.c
index b6ebf1dcdffb..1ae5ce8bd366 100644
--- a/drivers/base/test/platform-device-test.c
+++ b/drivers/base/test/platform-device-test.c
@@ -87,8 +87,6 @@ static void platform_device_devm_register_get_unregister_with_devm_test(struct k
 	struct test_priv *priv = test->priv;
 	int ret;
 
-	kunit_skip(test, "This needs to be fixed in the core.");
-
 	pdev = platform_device_alloc(DEVICE_NAME, PLATFORM_DEVID_NONE);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
 
diff --git a/drivers/base/test/root-device-test.c b/drivers/base/test/root-device-test.c
index 9a3e6cccae13..780d07455f57 100644
--- a/drivers/base/test/root-device-test.c
+++ b/drivers/base/test/root-device-test.c
@@ -78,8 +78,6 @@ static void root_device_devm_register_get_unregister_with_devm_test(struct kunit
 	struct test_priv *priv = test->priv;
 	int ret;
 
-	kunit_skip(test, "This needs to be fixed in the core.");
-
 	priv->dev = root_device_register(DEVICE_NAME);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->dev);
 
-- 
2.34.1


