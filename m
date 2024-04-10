Return-Path: <linux-kernel+bounces-138707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7ABA89F939
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D278F1F2BCE9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB12716D9BB;
	Wed, 10 Apr 2024 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qj2zSA2W"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DF216EBEF;
	Wed, 10 Apr 2024 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757596; cv=none; b=B1tDZ9N3uP2KLnNasRfIZQ7TW5yDo2HhQBKrnG9v0LfKdfJNuZQCc+eeUeb+IEK4suURzcgY4+kWAtQIrS3gv9vSyVi1LDCWRis49X3Sss43TGJ60dHuPVv6VJvFB2kdtVN1EP8iztgEgkdrMb2ztvILXQr1qnQ2SOt3vinOq2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757596; c=relaxed/simple;
	bh=qy9PyGlUP2RPUSM/eP2gDf7EcF/g1j8GI4jRMc+CzrY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ki9/2GY5jiTWGjme0AbawbGTPhlx5iaasrrlg9LPFlKkHOLqoOnddYjTqf/6A+zH9Unkz/ytcRs4eeYcpg/M3en6wDU8KKwI9rTQ9cnMJffZ3pGbD0Ho09Xgn/eoI5eg7Rrc3fhRAJfl90Ha2/ve5Nwe1fMsFaAjKx9rARR4qxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qj2zSA2W; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43ADxlgT056758;
	Wed, 10 Apr 2024 08:59:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712757587;
	bh=u3tJ80kY0yv2TU/mG7vJq/vhEjzXqcyTjxZViHgfa30=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=qj2zSA2WbHVWo8KsUUo4MaJtG3WokWGOcgXlUg7mspoaC8prO83V6RMO0B67G2NFO
	 /d+JmHjWAKERnCMoP87dNl8f15JfuOmWGvWtaXvj1t4VbKftzXZDHsGajytnwvZWum
	 4VK6mlR67iV8LQNMomNo0Q89Gd++epPv+lgtHA6Q=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43ADxlIi011519
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Apr 2024 08:59:47 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Apr 2024 08:59:47 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Apr 2024 08:59:47 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43ADxhav067183;
	Wed, 10 Apr 2024 08:59:47 -0500
From: Andrew Davis <afd@ti.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Hari Nagalla <hnagalla@ti.com>,
        Nick Saulnier <nsaulnier@ti.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH v2 11/13] mailbox: omap: Remove mbox_chan_to_omap_mbox()
Date: Wed, 10 Apr 2024 08:59:40 -0500
Message-ID: <20240410135942.61667-12-afd@ti.com>
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

This function only checks if mbox_chan *chan is not NULL, but that cannot
be the case and if it was returning NULL which is not later checked
doesn't save us from this. The second check for chan->con_priv is
completely redundant as if it was NULL we would return NULL just the
same. Simply dereference con_priv directly and remove this function.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/mailbox/omap-mailbox.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index 8e42266cb31a5..8e2760d2c5b0c 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -103,14 +103,6 @@ static unsigned int mbox_kfifo_size = CONFIG_OMAP_MBOX_KFIFO_SIZE;
 module_param(mbox_kfifo_size, uint, S_IRUGO);
 MODULE_PARM_DESC(mbox_kfifo_size, "Size of omap's mailbox kfifo (bytes)");
 
-static struct omap_mbox *mbox_chan_to_omap_mbox(struct mbox_chan *chan)
-{
-	if (!chan || !chan->con_priv)
-		return NULL;
-
-	return (struct omap_mbox *)chan->con_priv;
-}
-
 static inline
 unsigned int mbox_read_reg(struct omap_mbox_device *mdev, size_t ofs)
 {
@@ -357,7 +349,7 @@ static void omap_mbox_fini(struct omap_mbox *mbox)
 
 static int omap_mbox_chan_startup(struct mbox_chan *chan)
 {
-	struct omap_mbox *mbox = mbox_chan_to_omap_mbox(chan);
+	struct omap_mbox *mbox = chan->con_priv;
 	struct omap_mbox_device *mdev = mbox->parent;
 	int ret = 0;
 
@@ -372,7 +364,7 @@ static int omap_mbox_chan_startup(struct mbox_chan *chan)
 
 static void omap_mbox_chan_shutdown(struct mbox_chan *chan)
 {
-	struct omap_mbox *mbox = mbox_chan_to_omap_mbox(chan);
+	struct omap_mbox *mbox = chan->con_priv;
 	struct omap_mbox_device *mdev = mbox->parent;
 
 	mutex_lock(&mdev->cfg_lock);
@@ -415,7 +407,7 @@ static int omap_mbox_chan_send(struct omap_mbox *mbox, u32 msg)
 
 static int omap_mbox_chan_send_data(struct mbox_chan *chan, void *data)
 {
-	struct omap_mbox *mbox = mbox_chan_to_omap_mbox(chan);
+	struct omap_mbox *mbox = chan->con_priv;
 	int ret;
 	u32 msg = (u32)(uintptr_t)(data);
 
-- 
2.39.2


