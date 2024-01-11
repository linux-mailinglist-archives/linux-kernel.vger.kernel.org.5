Return-Path: <linux-kernel+bounces-23774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF68F82B181
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F06E1F223A1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043D24CE0D;
	Thu, 11 Jan 2024 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OPbNb62l"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA43B4CB34
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704986082;
	bh=Eo8gKt5JYCXR+AsI/6kbMVWmmQfxzbA30c+2Y+wtasI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OPbNb62lsPmHpn+uJjiQTn32fEbP2pUl6LEOUIj9oVJDYpu4q8a9mIICL2fmSmALk
	 l0pjWEowxCQHL6O8TcfCS35h93qxxkljzl1oqUiuqKu+l7UjjH+/HPhxlp2aV5b8eI
	 ge+3+VLDBvZP3UVEgwxvXYf4CIHM6bqxjKeuJZWBa8xaCC27nYMgLxnVqx3qaNO2mP
	 oCm0d4D8G3d4mYonBDfdhv5on+J1lwjzHQr8wh2vJWA5TjzumbhJpbM7cr++uF38Xj
	 ywKX4t7m7XtddBgcpojViv0XaovXjDeVArpi/vZd7Hu+WgkAiuonpb1rhqQuRFflRq
	 eKtov3UjpgOfw==
Received: from localhost.localdomain (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4AC063781F80;
	Thu, 11 Jan 2024 15:14:39 +0000 (UTC)
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Brian Norris <briannorris@chromium.org>,
	Julius Werner <jwerner@chromium.org>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] firmware: coreboot: Generate modalias uevent for devices
Date: Thu, 11 Jan 2024 12:11:46 -0300
Message-ID: <20240111151226.842603-2-nfraprado@collabora.com>
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

Generate a modalias uevent for devices in the coreboot bus to allow
userspace to automatically load the corresponding modules.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 drivers/firmware/google/coreboot_table.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index 2a4469bf1b81..c1b9a9e8e8ed 100644
--- a/drivers/firmware/google/coreboot_table.c
+++ b/drivers/firmware/google/coreboot_table.c
@@ -53,11 +53,20 @@ static void coreboot_bus_remove(struct device *dev)
 		driver->remove(device);
 }
 
+static int coreboot_bus_uevent(const struct device *dev, struct kobj_uevent_env *env)
+{
+	struct coreboot_device *device = CB_DEV(dev);
+	u32 tag = device->entry.tag;
+
+	return add_uevent_var(env, "MODALIAS=coreboot:t%08X", tag);
+}
+
 static struct bus_type coreboot_bus_type = {
 	.name		= "coreboot",
 	.match		= coreboot_bus_match,
 	.probe		= coreboot_bus_probe,
 	.remove		= coreboot_bus_remove,
+	.uevent		= coreboot_bus_uevent,
 };
 
 static void coreboot_device_release(struct device *dev)
-- 
2.43.0


