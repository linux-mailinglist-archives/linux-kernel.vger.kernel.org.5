Return-Path: <linux-kernel+bounces-117578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D5E88B009
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F8BAB22ED2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A9712AAF8;
	Mon, 25 Mar 2024 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GAsIDORE"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E2A86620;
	Mon, 25 Mar 2024 17:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387256; cv=none; b=Dn9pV9PQDbMdLptqcBK08n0z3Q5RCQRfdaCG0jFPNwn4/68O8f7Z5F+NcTWUbyYLsBgRz7e7PSO++niDm940n8bgCh0LL+zkpxU9BNG1q9KFx44ouKHUI3RfP+Ur2ZxEitoVke++53/XC+u66x/lRtROVBP/W8TP3cc+tfVHGpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387256; c=relaxed/simple;
	bh=qy9PyGlUP2RPUSM/eP2gDf7EcF/g1j8GI4jRMc+CzrY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ro7Uy7bdm/raRrVzIWARDNJjy3pbYJaD1NxKhELKlYl4yup4EnsNNjuOhMZk4OG3NNL7/7NCU3gI6wA1lynhOOtk1huMzRlAZxJsntPm6cE0W5silv/sYvFpsUFczxC0Repb95i3AzwWPA3iTKXijevAtaJDuo8w9+X+gOvm9Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GAsIDORE; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42PHKpl2040395;
	Mon, 25 Mar 2024 12:20:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711387251;
	bh=u3tJ80kY0yv2TU/mG7vJq/vhEjzXqcyTjxZViHgfa30=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=GAsIDOREBrc5QK4U52aKwaUgUZD8fXjJVbcQGMu+aIcaj30LeoLB3NKhl1i874T+z
	 EuVud9WkcAvqQ4KSIyD6ORM2R95oIkIe3aZpOrYU8FGVCRXJUG3g35hh1nH0lBljl0
	 OFoAxRHPz06voNwIiGOf+hBRVRGXYYUiB9pOZCRo=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42PHKoow089685
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Mar 2024 12:20:51 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 12:20:50 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 12:20:50 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42PHKkYh075282;
	Mon, 25 Mar 2024 12:20:50 -0500
From: Andrew Davis <afd@ti.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Hari Nagalla <hnagalla@ti.com>,
        Nick Saulnier <nsaulnier@ti.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 11/13] mailbox: omap: Remove mbox_chan_to_omap_mbox()
Date: Mon, 25 Mar 2024 12:20:43 -0500
Message-ID: <20240325172045.113047-12-afd@ti.com>
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


