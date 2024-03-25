Return-Path: <linux-kernel+bounces-117528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C3D88AC38
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 583031C3FD0D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9C413B2AD;
	Mon, 25 Mar 2024 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BbhyOwxL"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83851B962;
	Mon, 25 Mar 2024 16:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385895; cv=none; b=spPbw5HMdgkuBLWcuII/D4MIoiWoB6YLmypaVohJbTbbXzVPYyYh5jB+qJlVJJgB3CFHDwnYMigousZyh0LIbJDFBqdMSuWf4MGyAXCDD1ia5epx10+YShMNSs9nejlw8aU0eWMF+g+ogS2XFOY83hNDCLFgNKVN+WjMANVbkOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385895; c=relaxed/simple;
	bh=rqO3U+kmuB+SaZ67iLGqmxUpEUQEILsZ2JW/jQDB/nM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p9aKQe/fOCGFCIID1iSiLyQLXax5Nn1/h6rqvIBhdbb2IHSr1LdDcr51MhBLMRKBLAAl4tS2NG1a8IlTkTCfuoblbBwG/VtIE+OkB5lRQ0rE8JpypC21QeMNI81DDEsSftAZeVcJB3zuHScj3lKMaUO4R7N5/9MmuXqBbIXnMNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BbhyOwxL; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42PGw97q056599;
	Mon, 25 Mar 2024 11:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711385889;
	bh=EA0GkImO3YEnQ6eaQ8paCB06eEmWI7nX63pij7AZSqc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=BbhyOwxLdsjaumodUnAXf6/sceTnj9JbcC/0AYi/Cgsfy50lBuZ66fzw2R0ybq/pc
	 m9fnCnyCd+BZxorcAEbrRVhxdAO/Q9HAjQ2125/t4yB8QlpIXXb1OGZxGfM5OLiZaK
	 bQSK1s4232405WCmxc4MidSLcnhQCqKH+6fSkdPs=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42PGw9kq013858
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Mar 2024 11:58:09 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 11:58:09 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 11:58:09 -0500
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42PGw83j029739;
	Mon, 25 Mar 2024 11:58:09 -0500
From: Andrew Davis <afd@ti.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 2/3] remoteproc: k3-r5: Fix usage of omap_mbox_message and mbox_msg_t
Date: Mon, 25 Mar 2024 11:58:07 -0500
Message-ID: <20240325165808.31885-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325165808.31885-1-afd@ti.com>
References: <20240325165808.31885-1-afd@ti.com>
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
 drivers/remoteproc/ti_k3_r5_remoteproc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
index ad3415a3851b2..3bcde6d00b56a 100644
--- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
@@ -16,7 +16,6 @@
 #include <linux/of_address.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/of_platform.h>
-#include <linux/omap-mailbox.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/remoteproc.h>
@@ -188,7 +187,7 @@ static void k3_r5_rproc_mbox_callback(struct mbox_client *client, void *data)
 						client);
 	struct device *dev = kproc->rproc->dev.parent;
 	const char *name = kproc->rproc->name;
-	u32 msg = omap_mbox_message(data);
+	u32 msg = (u32)(uintptr_t)(data);
 
 	dev_dbg(dev, "mbox msg: 0x%x\n", msg);
 
@@ -222,11 +221,11 @@ static void k3_r5_rproc_kick(struct rproc *rproc, int vqid)
 {
 	struct k3_r5_rproc *kproc = rproc->priv;
 	struct device *dev = rproc->dev.parent;
-	mbox_msg_t msg = (mbox_msg_t)vqid;
+	u32 msg = vqid;
 	int ret;
 
 	/* send the index of the triggered virtqueue in the mailbox payload */
-	ret = mbox_send_message(kproc->mbox, (void *)msg);
+	ret = mbox_send_message(kproc->mbox, (void *)(uintptr_t)msg);
 	if (ret < 0)
 		dev_err(dev, "failed to send mailbox message, status = %d\n",
 			ret);
-- 
2.39.2


