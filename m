Return-Path: <linux-kernel+bounces-23777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D49282B185
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B34A31C23741
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C59C4F8B4;
	Thu, 11 Jan 2024 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VFxLYHDq"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FC84F213
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704986091;
	bh=CHvr4PScujipymb+OTlox6s6i63JQHd4PBTYty5wiek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VFxLYHDq8htIlCQPt2uLpfyJxCn40rH/SW4OZM4tonLsrFfzfgA/l85xIRUD9OfQp
	 eJwDTAP0JAxdSIhq7CbAL4lQQURW9WCvW75P9434gUTV1NVDwBzsMmkk8NkKSWlsPC
	 HOuB03bhDe7rdLPT4C1kc0oMCAcZuCKkoQMZpU+7yAPeEkODkdRb5tbP6cnbRun/Oy
	 e65p1QuPFCjkh7pOWWeBCCqmf9Mv+Y+WoCtZ2FcXKX8C4SQjaKIEvOKwUY9nTqUBWK
	 gjmmTRX+JXaSwFsAp7SH3T/fTFh6JOcDfQtT06IngFPgMsGoZcOmuokelAC8sxGSW8
	 NN1iuq9uehaSw==
Received: from localhost.localdomain (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4A7113781F80;
	Thu, 11 Jan 2024 15:14:47 +0000 (UTC)
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Brian Norris <briannorris@chromium.org>,
	Julius Werner <jwerner@chromium.org>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] firmware: google: cbmem: Add to module device table
Date: Thu, 11 Jan 2024 12:11:48 -0300
Message-ID: <20240111151226.842603-4-nfraprado@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111151226.842603-1-nfraprado@collabora.com>
References: <20240111151226.842603-1-nfraprado@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Create an id table and add it to the module device table to allow the
cbmem driver to be automatically loaded when a matching device is found.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 drivers/firmware/google/cbmem.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/firmware/google/cbmem.c b/drivers/firmware/google/cbmem.c
index 88e587ba1e0d..ceb89b4cdbe0 100644
--- a/drivers/firmware/google/cbmem.c
+++ b/drivers/firmware/google/cbmem.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/kobject.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
@@ -114,6 +115,12 @@ static int cbmem_entry_probe(struct coreboot_device *dev)
 	return 0;
 }
 
+static const struct coreboot_device_id cbmem_ids[] = {
+	{ .tag = LB_TAG_CBMEM_ENTRY },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(coreboot, cbmem_ids);
+
 static struct coreboot_driver cbmem_entry_driver = {
 	.probe = cbmem_entry_probe,
 	.drv = {
-- 
2.43.0


