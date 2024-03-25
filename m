Return-Path: <linux-kernel+bounces-117580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7965B88ACD1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0933A1F65563
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AFA5C900;
	Mon, 25 Mar 2024 17:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OWfKfH6A"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389E712C7EE;
	Mon, 25 Mar 2024 17:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387267; cv=none; b=iivsEonkOAH/wbvIQ+lWTmBg2ayD1+518Tfkt8bhLMotWEOMShFoROG2fCX0kLCU5nosaO19Zgc75pSRqoG4i+2LX8HxjQ5KaxmZeasI51FVk4N8ysAibggFXdxFm49Fv0n6umvzyassWUx0j3dQZCzgeObF5vrFcoc/HFUrygQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387267; c=relaxed/simple;
	bh=cHzIUSsWOwL4bdxoqheqXLuQ8KqcDtisXv/t7osIT50=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TlwO2QvcmOvj6MLxEdG71JpuCMXutUrCr2eqnET6f16eKXeB3XHU0OaXQgKhIlfeX/B3EbWQhnYUE64Ev5Sms9/fUtMnE9jwQsOZVyXM1CQ8SBKFguYUmjEett83u9tYqgY7FGLC+k5kZAeLUSPKfM7fbn+a5Yk6T9wGoE34bpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OWfKfH6A; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42PHKo8X022679;
	Mon, 25 Mar 2024 12:20:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711387250;
	bh=MRm7Wfdskw+FskyCTQqKVQqWK3HtEFp0jjB5j6n0QcE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=OWfKfH6AJoQwJeX0xCGsoVzvnXqGGjd0KxB0NXVk61HPfInJwVRAWHnoHuzL+aVcm
	 1EORYZcdjq0th+TMc9D74HQi5zjOD3MDSpxFTeOugxlhneiJwRYpY4GaCiiKXfn3ZG
	 47ovqdI8ldFOuglzR/YsOwXEAMsmUyzmSy+QaGZI=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42PHKon7043016
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Mar 2024 12:20:50 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 12:20:49 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 12:20:49 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42PHKkYf075282;
	Mon, 25 Mar 2024 12:20:49 -0500
From: Andrew Davis <afd@ti.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Hari Nagalla <hnagalla@ti.com>,
        Nick Saulnier <nsaulnier@ti.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 09/13] mailbox: omap: Use function local struct mbox_controller
Date: Mon, 25 Mar 2024 12:20:41 -0500
Message-ID: <20240325172045.113047-10-afd@ti.com>
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

The mbox_controller struct is only needed in the probe function. Make
it a local variable instead of storing a copy in omap_mbox_device
to simplify that struct.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/mailbox/omap-mailbox.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index 17c9b9df78b1d..97f59d9f9f319 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -86,7 +86,6 @@ struct omap_mbox_device {
 	u32 num_fifos;
 	u32 intr_type;
 	struct omap_mbox **mboxes;
-	struct mbox_controller controller;
 };
 
 struct omap_mbox {
@@ -541,7 +540,7 @@ static struct mbox_chan *omap_mbox_of_xlate(struct mbox_controller *controller,
 	struct omap_mbox_device *mdev;
 	struct omap_mbox *mbox;
 
-	mdev = container_of(controller, struct omap_mbox_device, controller);
+	mdev = dev_get_drvdata(controller->dev);
 	if (WARN_ON(!mdev))
 		return ERR_PTR(-EINVAL);
 
@@ -567,6 +566,7 @@ static int omap_mbox_probe(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	struct device_node *child;
 	const struct omap_mbox_match_data *match_data;
+	struct mbox_controller *controller;
 	u32 intr_type, info_count;
 	u32 num_users, num_fifos;
 	u32 tmp[3];
@@ -685,17 +685,20 @@ static int omap_mbox_probe(struct platform_device *pdev)
 	mdev->intr_type = intr_type;
 	mdev->mboxes = list;
 
+	controller = devm_kzalloc(&pdev->dev, sizeof(*controller), GFP_KERNEL);
+	if (!controller)
+		return -ENOMEM;
 	/*
 	 * OMAP/K3 Mailbox IP does not have a Tx-Done IRQ, but rather a Tx-Ready
 	 * IRQ and is needed to run the Tx state machine
 	 */
-	mdev->controller.txdone_irq = true;
-	mdev->controller.dev = mdev->dev;
-	mdev->controller.ops = &omap_mbox_chan_ops;
-	mdev->controller.chans = chnls;
-	mdev->controller.num_chans = info_count;
-	mdev->controller.of_xlate = omap_mbox_of_xlate;
-	ret = devm_mbox_controller_register(mdev->dev, &mdev->controller);
+	controller->txdone_irq = true;
+	controller->dev = mdev->dev;
+	controller->ops = &omap_mbox_chan_ops;
+	controller->chans = chnls;
+	controller->num_chans = info_count;
+	controller->of_xlate = omap_mbox_of_xlate;
+	ret = devm_mbox_controller_register(mdev->dev, controller);
 	if (ret)
 		return ret;
 
-- 
2.39.2


