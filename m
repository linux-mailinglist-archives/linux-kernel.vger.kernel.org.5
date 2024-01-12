Return-Path: <linux-kernel+bounces-24686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 123A282C0D2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B603D2829B5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3536D1B7;
	Fri, 12 Jan 2024 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iVk9KxSs"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9D06E2A4
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705065692;
	bh=BLXPKaAyUYO+6jqUrFyRS5lwMciTPldwcRsUMbzDyc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iVk9KxSsQtvtgQz99f/zijk6igWk9tf4efY5mWTJjXTiEETjQMS13rTN3ln0twZVs
	 4/ezaRE8z4zx+YEt0EydLp9Ej7iv6+W/ruOnP+vXE95sNb3aoDXzehdHBTLeQaLMEa
	 xqN7Erkn3v7tljPsnPRAu7m6PH/aVICOjQIDlpmgD8vjtEOdwCbLyaY5Dyt0EK+7/z
	 lmLV54ySEsj2ar2+JxWaKXo63IxX+otyt3Vdg99T7s91XngUE7kcikhVHJmufzbD3A
	 q/7jX2eiLbo/g88JZgTvLfcNcROHF4TCwAyi1/KYiPBTt0mB7BJzgo27vU9bKRcpIT
	 CkMdrSxCA8zww==
Received: from localhost.localdomain (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E69583781FE5;
	Fri, 12 Jan 2024 13:21:28 +0000 (UTC)
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	chrome-platform@lists.linux.dev,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Brian Norris <briannorris@chromium.org>,
	Julius Werner <jwerner@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] firmware: google: memconsole: Add to module device table
Date: Fri, 12 Jan 2024 10:18:34 -0300
Message-ID: <20240112131857.900734-6-nfraprado@collabora.com>
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
memconsole driver to be automatically loaded when a matching device is
found.

Suggested-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v2:
- Added this commit

 drivers/firmware/google/memconsole-coreboot.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/firmware/google/memconsole-coreboot.c b/drivers/firmware/google/memconsole-coreboot.c
index 74b5286518ee..b8e65b9d8cc0 100644
--- a/drivers/firmware/google/memconsole-coreboot.c
+++ b/drivers/firmware/google/memconsole-coreboot.c
@@ -11,6 +11,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 
 #include "memconsole.h"
 #include "coreboot_table.h"
@@ -96,6 +97,12 @@ static void memconsole_remove(struct coreboot_device *dev)
 	memconsole_exit();
 }
 
+static const struct coreboot_device_id memconsole_ids[] = {
+	{ .tag = CB_TAG_CBMEM_CONSOLE },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(coreboot, memconsole_ids);
+
 static struct coreboot_driver memconsole_driver = {
 	.probe = memconsole_probe,
 	.remove = memconsole_remove,
-- 
2.43.0


