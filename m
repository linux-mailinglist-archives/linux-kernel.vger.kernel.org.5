Return-Path: <linux-kernel+bounces-24681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5AD82C0CC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0FEE1C21B44
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A9B6D1B7;
	Fri, 12 Jan 2024 13:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nBq3PbDy"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ABE6D1A8
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705065674;
	bh=L+28NgGOIiCoYRdT/O15SQx+OK5WNhSsQoOnP70V+rE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nBq3PbDy9JluN0ABov4e5gHyDfO1sVRroFlx7r4gUxjxDcW697MV7/glA4Gc5wekN
	 aCyiXzLcivCObF0Hb6Ovw/30z2prfulK6/ACxJpSw6753CYzeEYC763Ds3xwaasjVs
	 NYeux67OafiJt9ChjzFbcrJ8/ZjXMkiOG8PiU3eV6ZNXt8N25ou5EK7ej6WprCrR3e
	 UMWv+QBiDFd9WwC6aOyjkmvIidjt5mVSzSNm3DJf2XJQscd8rUFg1PKfqxf+qyxavE
	 nQ8pfuAXgicJP5jCBwDzXZvb1tbDNW0+F2UX0CIMT3DeRIR6rqgaDlx1LZenboqtUZ
	 5l/MEP1Gd0kkg==
Received: from localhost.localdomain (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B540E3782031;
	Fri, 12 Jan 2024 13:21:11 +0000 (UTC)
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	chrome-platform@lists.linux.dev,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Brian Norris <briannorris@chromium.org>,
	Julius Werner <jwerner@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] firmware: coreboot: Generate modalias uevent for devices
Date: Fri, 12 Jan 2024 10:18:30 -0300
Message-ID: <20240112131857.900734-2-nfraprado@collabora.com>
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

Generate a modalias uevent for devices in the coreboot bus to allow
userspace to automatically load the corresponding modules.

Acked-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

(no changes since v1)

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


