Return-Path: <linux-kernel+bounces-24687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD22D82C0D3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 389FDB23FB3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089886E2BF;
	Fri, 12 Jan 2024 13:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="u598Lenm"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DF46E2B2
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 13:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705065695;
	bh=gIUn32GOZvNsfDJEtW4SBOOpxVUI+08upkQ6PKTzhZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u598Lenmeb95HeOuDOhyRzOU/puSD8AwcBF+nzTySLpZZfVZIyNSfSFyfacdwN5kW
	 +v7989vDBjlU+0+mV70V6iFqOe3gPw1PqTbw5QzIaD9wdphdgjIfvP0pcx2yuOQTou
	 3SWcQhKs1cO4VYTup+KRxUzIXK8HTuo0WMcy2Xyh4uoyFABPSYu1es328E5vd7MhXy
	 lFKa1xIwV4gD6Ipe0aPMMmZy+Os3oj5f6rOjA8dS0eacDP1/dc110lAGriyyGjUevP
	 HsRFpr3f/wXn778wFrMQy3zmVPlNQmM6rads4iJua6odIt1diE3A7rViX5W25FdVOX
	 6GGR/nJlOLPOw==
Received: from localhost.localdomain (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CBCF43782031;
	Fri, 12 Jan 2024 13:21:32 +0000 (UTC)
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	chrome-platform@lists.linux.dev,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Brian Norris <briannorris@chromium.org>,
	Julius Werner <jwerner@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] firmware: google: framebuffer: Add to module device table
Date: Fri, 12 Jan 2024 10:18:35 -0300
Message-ID: <20240112131857.900734-7-nfraprado@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112131857.900734-1-nfraprado@collabora.com>
References: <20240112131857.900734-1-nfraprado@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Create an id table and add it to the module device table to allow the
framebuffer driver to be automatically loaded when a matching device is
found.

Suggested-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v2:
- Added this commit

 drivers/firmware/google/framebuffer-coreboot.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/firmware/google/framebuffer-coreboot.c b/drivers/firmware/google/framebuffer-coreboot.c
index 5c84bbebfef8..b33e9c6f97d7 100644
--- a/drivers/firmware/google/framebuffer-coreboot.c
+++ b/drivers/firmware/google/framebuffer-coreboot.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_data/simplefb.h>
 #include <linux/platform_device.h>
 
@@ -80,6 +81,12 @@ static void framebuffer_remove(struct coreboot_device *dev)
 	platform_device_unregister(pdev);
 }
 
+static const struct coreboot_device_id framebuffer_ids[] = {
+	{ .tag = CB_TAG_FRAMEBUFFER },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(coreboot, framebuffer_ids);
+
 static struct coreboot_driver framebuffer_driver = {
 	.probe = framebuffer_probe,
 	.remove = framebuffer_remove,
-- 
2.43.0


