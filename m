Return-Path: <linux-kernel+bounces-24683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF35682C0CF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41350B236F4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28CD6D1DF;
	Fri, 12 Jan 2024 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VT/FEgjx"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECE06BB50
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705065684;
	bh=vv7XfyY64AL9x6v0k9WhuSkPS+mvCU15xYmyHxujMQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VT/FEgjxDcYivmSqj8BoJVzPD5kxRg3ansgj2EbmqAD3msqLK6hO1SEOG/XLLVY2i
	 luv8RlWniiUjMey+Gofv04EFijpja4SxG1yJR948rtauLCVfo04QxVG8SDa/KkBdbQ
	 7psziR/FGNHjLvDtlBx4xNsktEGeoI/hw3sydU6ytcbrzBTTjX8DBFOlTgdcA3qTEu
	 JcPF3qlFd5AEHe+BJ7BDsx2pNfNLn8gYXWDAV9sKVLBxsXbxBiqT7VJCB9NTn8CvIS
	 ADPihfelHE6NiXgWgbfDTu6KXslilFEzU7uktZJ9wcpKpV4VRFCHEv3zTwYhWf4KIv
	 KsMLtKnvqG73g==
Received: from localhost.localdomain (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8BB743781FE5;
	Fri, 12 Jan 2024 13:21:21 +0000 (UTC)
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	chrome-platform@lists.linux.dev,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Brian Norris <briannorris@chromium.org>,
	Julius Werner <jwerner@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] firmware: google: cbmem: Add to module device table
Date: Fri, 12 Jan 2024 10:18:32 -0300
Message-ID: <20240112131857.900734-4-nfraprado@collabora.com>
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
cbmem driver to be automatically loaded when a matching device is found.

Acked-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

(no changes since v1)

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


