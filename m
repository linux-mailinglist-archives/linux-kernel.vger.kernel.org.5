Return-Path: <linux-kernel+bounces-24685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 513B782C0D1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DECCD1F2565B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC6A6DD0E;
	Fri, 12 Jan 2024 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eBucHIo9"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE746DCEA
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705065688;
	bh=5Zlhk9FViXuszWd2wU0HPdwd/advjvRNhG7guG3jd6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eBucHIo9anWE6EJwEzY9Q7buyISHqVTcdyY6Ok13pHm51PVG4FgDJpcMxuikzivgO
	 sD2i1iVIuQMoKKLUw6Ww5AQNt68xWYyZ7H/sX0+U2W9LKoNIyQYOkHY/BbfWwtg0va
	 45sCbBiP3MLvHnpn/Fa/3ZZOez1XgnfXdaJG4RX6/sOZtUFCYfU49p1b1AptFf8N6+
	 4Vy46pbklk3nhy9t3aCVJ56VJ1wmPM7ygG9VE0E/J4eZ6Qad9pxg/5j0KZZrEkvgFH
	 xay+P+4p+XupZ3u/OUFy0VdvvPp4qihJyJp+RXtbY/KbkzksZa0Ez/lqg/jaTYd+ZN
	 qSzMTRNIfA6Hw==
Received: from localhost.localdomain (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5CD503782031;
	Fri, 12 Jan 2024 13:21:25 +0000 (UTC)
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	chrome-platform@lists.linux.dev,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Brian Norris <briannorris@chromium.org>,
	Julius Werner <jwerner@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] firmware: google: vpd: Add to module device table
Date: Fri, 12 Jan 2024 10:18:33 -0300
Message-ID: <20240112131857.900734-5-nfraprado@collabora.com>
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
vpd driver to be automatically loaded when a matching device is found.

Suggested-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v2:
- Added this commit

 drivers/firmware/google/vpd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/firmware/google/vpd.c b/drivers/firmware/google/vpd.c
index ee6e08c0592b..9e9fe9ca1920 100644
--- a/drivers/firmware/google/vpd.c
+++ b/drivers/firmware/google/vpd.c
@@ -14,6 +14,7 @@
 #include <linux/kobject.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -306,6 +307,12 @@ static void vpd_remove(struct coreboot_device *dev)
 	kobject_put(vpd_kobj);
 }
 
+static const struct coreboot_device_id vpd_ids[] = {
+	{ .tag = CB_TAG_VPD },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(coreboot, vpd_ids);
+
 static struct coreboot_driver vpd_driver = {
 	.probe = vpd_probe,
 	.remove = vpd_remove,
-- 
2.43.0


