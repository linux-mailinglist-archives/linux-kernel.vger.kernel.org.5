Return-Path: <linux-kernel+bounces-138696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F81C89F921
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9FC1F2D640
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DEA16DEAF;
	Wed, 10 Apr 2024 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JWK419be"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D61D15F406;
	Wed, 10 Apr 2024 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757591; cv=none; b=oSkxO5J4Cs52iam/gOl4obOVvqKYERYgpLGuHZzvQpI5rZ5CUHIuBdvmOIHS6h+1EeKtq3eWB3FNHV+ai+/P8blJGgBkaKBK0f7v9X2l8NpVcBcTDqex0OrHEZS4KMhxVYrU2A5ibrX3fEL3NNyZnWm1q6VK1llIs8ymihvyTlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757591; c=relaxed/simple;
	bh=4qCFUoIEU96IBV2b2tUi6AGuM8KAjc2gG9zsDeEvgPM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aLhvjVLYH4FXpGjvUpNPbqymYkBqxBI6YqyVSeuxuavQuvNJF7VzHb/CEvQQqup2UZRSpnYgFObuTaGjIANVM9pgAIvVmNRowVg57hdXQ+J5VBwvSOhaYHAgeEbPzZu/PxyKEmHGNEdp2tRb2tzXSvDKTKNyxLHzwEiN2+Cx12I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JWK419be; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43ADxitJ056739;
	Wed, 10 Apr 2024 08:59:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712757584;
	bh=9hjSi/2Z4Esm750pB+Wn6BYHE6HYNnn7M/Y0ritzKVA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=JWK419be5Q/pK8ZJopS7vAsQs2KyLKhDbnYFTUsP+lw4u6YQ5/6QlqbRrgUcXoona
	 DcWyhw5bNZwcUX2h6myoEgRdiVP3gL9bgwFave/DOXdNBQvSWDf6bplm+x/v0cdPYs
	 E91rhIj9M4tsbaVQEzZKFbKql7fbhW4aK+q5xbjI=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43ADxi6P029186
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Apr 2024 08:59:44 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Apr 2024 08:59:44 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Apr 2024 08:59:44 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43ADxham067183;
	Wed, 10 Apr 2024 08:59:44 -0500
From: Andrew Davis <afd@ti.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Hari Nagalla <hnagalla@ti.com>,
        Nick Saulnier <nsaulnier@ti.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH v2 02/13] mailbox: omap: Remove unused omap_mbox_request_channel() function
Date: Wed, 10 Apr 2024 08:59:31 -0500
Message-ID: <20240410135942.61667-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240410135942.61667-1-afd@ti.com>
References: <20240410135942.61667-1-afd@ti.com>
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


