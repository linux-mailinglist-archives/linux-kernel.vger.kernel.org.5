Return-Path: <linux-kernel+bounces-117570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E9D88ACB5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB141C3DB42
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F3784D13;
	Mon, 25 Mar 2024 17:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EfYNRk3u"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852EB45026;
	Mon, 25 Mar 2024 17:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387253; cv=none; b=ZwWN47aNR5T3u0VpxrrxAaUbjo84ws91nqV7gEhbYHGsyvK1n5OPm+bGKKPn9asEkqZ60CESkKdU+w+AYT9PTXs87zwi9KITY5zxb/0UB5yiUBVLgZDM6ODjD/X3CxVjj4YdwXdrMVg8LP/KkET47QAD6Dja9LBrZHdeTIUuufs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387253; c=relaxed/simple;
	bh=4qCFUoIEU96IBV2b2tUi6AGuM8KAjc2gG9zsDeEvgPM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3keQJ/qkyCHjz2T7Q2gobfq6z8L3Aq6E/vQjP7gasVSk8LDKyABNnDUi5WYd4nLErNXrccjwoAabH27nAs+j0NvNDFOt7p0mrmZ/OFIrc1l99gvkcWKNjqjKWEKy0XeZYE6uGeamhiSxrK0azGNK3z0b7+7A9lN2W5nd3KAsdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EfYNRk3u; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42PHKljE013522;
	Mon, 25 Mar 2024 12:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711387247;
	bh=9hjSi/2Z4Esm750pB+Wn6BYHE6HYNnn7M/Y0ritzKVA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=EfYNRk3unINoLLgelWc9A8YK0/eEUnyCR6Q0RflkW0zwvHXDyzj1VOtJYvqlWnfX3
	 /4X2ECwxtE9Vz7aAH3sQSL88j0968BK0qinl0eF7dCHKNuLK29VDchOcz0hcCdzczx
	 LL49yM07KHKImeMU7Mszh1p+e3rLjQXX76CAGPe0=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42PHKlDc104976
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Mar 2024 12:20:47 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 12:20:47 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 12:20:47 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42PHKkYY075282;
	Mon, 25 Mar 2024 12:20:47 -0500
From: Andrew Davis <afd@ti.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Hari Nagalla <hnagalla@ti.com>,
        Nick Saulnier <nsaulnier@ti.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 02/13] mailbox: omap: Remove unused omap_mbox_request_channel() function
Date: Mon, 25 Mar 2024 12:20:34 -0500
Message-ID: <20240325172045.113047-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325172045.113047-1-afd@ti.com>
References: <20240325172045.113047-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This function is not used, remove this function.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/mailbox/omap-mailbox.c | 36 ----------------------------------
 include/linux/omap-mailbox.h   |  6 ------
 2 files changed, 42 deletions(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index 624a7ccc27285..8151722eef383 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -389,42 +389,6 @@ static struct omap_mbox *omap_mbox_device_find(struct omap_mbox_device *mdev,
 	return mbox;
 }
 
-struct mbox_chan *omap_mbox_request_channel(struct mbox_client *cl,
-					    const char *chan_name)
-{
-	struct device *dev = cl->dev;
-	struct omap_mbox *mbox = NULL;
-	struct omap_mbox_device *mdev;
-	int ret;
-
-	if (!dev)
-		return ERR_PTR(-ENODEV);
-
-	if (dev->of_node) {
-		pr_err("%s: please use mbox_request_channel(), this API is supported only for OMAP non-DT usage\n",
-		       __func__);
-		return ERR_PTR(-ENODEV);
-	}
-
-	mutex_lock(&omap_mbox_devices_lock);
-	list_for_each_entry(mdev, &omap_mbox_devices, elem) {
-		mbox = omap_mbox_device_find(mdev, chan_name);
-		if (mbox)
-			break;
-	}
-	mutex_unlock(&omap_mbox_devices_lock);
-
-	if (!mbox || !mbox->chan)
-		return ERR_PTR(-ENOENT);
-
-	ret = mbox_bind_client(mbox->chan, cl);
-	if (ret)
-		return ERR_PTR(ret);
-
-	return mbox->chan;
-}
-EXPORT_SYMBOL(omap_mbox_request_channel);
-
 static struct class omap_mbox_class = { .name = "mbox", };
 
 static int omap_mbox_register(struct omap_mbox_device *mdev)
diff --git a/include/linux/omap-mailbox.h b/include/linux/omap-mailbox.h
index 426a80fb32b5c..f8ddf8e814167 100644
--- a/include/linux/omap-mailbox.h
+++ b/include/linux/omap-mailbox.h
@@ -14,10 +14,4 @@ typedef int __bitwise omap_mbox_irq_t;
 #define IRQ_TX ((__force omap_mbox_irq_t) 1)
 #define IRQ_RX ((__force omap_mbox_irq_t) 2)
 
-struct mbox_chan;
-struct mbox_client;
-
-struct mbox_chan *omap_mbox_request_channel(struct mbox_client *cl,
-					    const char *chan_name);
-
 #endif /* OMAP_MAILBOX_H */
-- 
2.39.2


