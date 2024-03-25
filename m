Return-Path: <linux-kernel+bounces-117526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E172F88AD89
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AEDEC20C05
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92B313AD1F;
	Mon, 25 Mar 2024 16:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mZJZ30FR"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5164913AD0D;
	Mon, 25 Mar 2024 16:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385895; cv=none; b=lBSqvDt7FmZ/MpCX8CFYI/2cYNHX5aYKCfCDigLhqnNROc6s1YNTxBr6FRGlwm5GxFBXOK4LHaYD5fQASb3OHpSzAPFG0ZOla38PCFNsQM51ujxW0ph0/iTR+XuuoNmM340MOir+vxesarUKmPVabVToVmMYyvBTEpNEuoCGNsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385895; c=relaxed/simple;
	bh=sgsGIdh6rXa+N6eNCVGxGbFVkGZfZjwxfq7Srb4nJuA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AQUWHaEjZ5P1vSFhpOGoLnIftDgXaE2uqJaJCmd2cG6bfbsv8kFEAGc3hcaxr2lh6waYI4sJNW6cq/vYIIBg5Zm/SW5mTGjWI9hrLcocCYo8se8efN1S5iHhlR/WyqcvdFRquDSIEQQDvvxJRkrgt6Q2CUkYuzDlhQaZCXLWOrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mZJZ30FR; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42PGw9k2006240;
	Mon, 25 Mar 2024 11:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711385889;
	bh=TuY6VETr0CDU+pGqpyrVp2v9Y506MoJZo3FRapPogA8=;
	h=From:To:CC:Subject:Date;
	b=mZJZ30FRQBCfqA93Ncw6s/CjBL1M6wyurmmmB58wnnGZb0whWlwBduVHk/ONUWyUE
	 OiofznNqcNgjLAimFYroi7g0p7R9VHtSyn/ruBYzqs5WHmALJKgGoB8dG9GyyUFLCd
	 NSxm8rUO89v0QnO3WhF6/YJ0CTwEhwLPITLNl9bU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42PGw9SY079557
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Mar 2024 11:58:09 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 11:58:09 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 11:58:08 -0500
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42PGw83i029739;
	Mon, 25 Mar 2024 11:58:08 -0500
From: Andrew Davis <afd@ti.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 1/3] remoteproc: k3-dsp: Fix usage of omap_mbox_message and mbox_msg_t
Date: Mon, 25 Mar 2024 11:58:06 -0500
Message-ID: <20240325165808.31885-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The type of message sent using omap-mailbox is always u32. The definition
of mbox_msg_t is uintptr_t which is wrong as that type changes based on
the architecture (32bit vs 64bit). Use u32 unconditionally and remove
the now unneeded omap-mailbox.h include.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/remoteproc/ti_k3_dsp_remoteproc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
index 3555b535b1683..33b30cfb86c9d 100644
--- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
@@ -11,7 +11,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_reserved_mem.h>
-#include <linux/omap-mailbox.h>
 #include <linux/platform_device.h>
 #include <linux/remoteproc.h>
 #include <linux/reset.h>
@@ -113,7 +112,7 @@ static void k3_dsp_rproc_mbox_callback(struct mbox_client *client, void *data)
 						  client);
 	struct device *dev = kproc->rproc->dev.parent;
 	const char *name = kproc->rproc->name;
-	u32 msg = omap_mbox_message(data);
+	u32 msg = (u32)(uintptr_t)(data);
 
 	dev_dbg(dev, "mbox msg: 0x%x\n", msg);
 
@@ -152,11 +151,11 @@ static void k3_dsp_rproc_kick(struct rproc *rproc, int vqid)
 {
 	struct k3_dsp_rproc *kproc = rproc->priv;
 	struct device *dev = rproc->dev.parent;
-	mbox_msg_t msg = (mbox_msg_t)vqid;
+	u32 msg = vqid;
 	int ret;
 
 	/* send the index of the triggered virtqueue in the mailbox payload */
-	ret = mbox_send_message(kproc->mbox, (void *)msg);
+	ret = mbox_send_message(kproc->mbox, (void *)(uintptr_t)msg);
 	if (ret < 0)
 		dev_err(dev, "failed to send mailbox message (%pe)\n",
 			ERR_PTR(ret));
-- 
2.39.2


