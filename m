Return-Path: <linux-kernel+bounces-77920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D69C860C27
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20A21287193
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915541865A;
	Fri, 23 Feb 2024 08:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kenoqkyx"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AE918633;
	Fri, 23 Feb 2024 08:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708676614; cv=none; b=e7qmW8DrqETvRwRH/YP+YKHGVCn7FnVcIRlbDCMgt6Syv4RDzSXUCCPJdRkBcGUkhV0+tyQpCv1u2nnFY3DB+pR++CPRpfkdNpG6VwT+OTGnSHH3OTE2KfsMSWMcZD+5XaSoKwYixdynmjXhyPYmTnEzBXLokP2jevhO9jI7hx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708676614; c=relaxed/simple;
	bh=pHvPRkx1K5XoNRPkxZDiThectiN+mcoEB1RRcmq2VsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=INEshby5lVHkX192FwBvX8MjBtcdaFp1wSwUSODQq/zK5dNMr8f3lGMM+Jxp2G+wwmFxpPTJ6CxzaNgdMrv6IBjQUJ2Q8rf2eioKY86E1kJl+ftJo3o/zCWjHxhHAh1M+LN29rNP9YYtc44iOhxWljnt/+lqHJe608xvGh5d6qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kenoqkyx; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41N8NEfB083390;
	Fri, 23 Feb 2024 02:23:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708676594;
	bh=tX1XmMkBVDupQAoozcClxG74vJ1ETTA3m38kugNQiTo=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=kenoqkyxpIPvDt4Fsc+5TGwqqxtqYUKEj6dKI9UBxF0X4wXI+mV+kDLMTD9za7SZM
	 MvWH2M666iJuO8JXX6RDfdHJ7CQzBgjrtmFEtBRKxMpUjNpcBmoZwipZ2d6xjfIHYK
	 ja38Wu9TFusajd5uPvQKLoD84VKahtyIB3k70NNA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41N8NEqQ032301
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Feb 2024 02:23:14 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 23
 Feb 2024 02:23:13 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 23 Feb 2024 02:23:13 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41N8NDVW023214;
	Fri, 23 Feb 2024 02:23:13 -0600
From: Jai Luthra <j-luthra@ti.com>
Date: Fri, 23 Feb 2024 13:53:02 +0530
Subject: [PATCH 2/2] media: ti: j721e-csi2rx: Fix races while restarting
 DMA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240223-csi_fixes-v1-2-c7eda7a4a852@ti.com>
References: <20240223-csi_fixes-v1-0-c7eda7a4a852@ti.com>
In-Reply-To: <20240223-csi_fixes-v1-0-c7eda7a4a852@ti.com>
To: Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jack Zhu
	<jack.zhu@starfivetech.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>
CC: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Julien
 Massot <julien.massot@collabora.com>,
        Changhuang Liang
	<Changhuang.liang@starfivetech.com>,
        Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1532; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=pHvPRkx1K5XoNRPkxZDiThectiN+mcoEB1RRcmq2VsE=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBl2FXt1EhtTzVRoy8lQtlI0I/nDoNbTGgfd2aUl
 4iHruNI3U6JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZdhV7QAKCRBD3pH5JJpx
 RRCwD/4gYCiyjk3tNdETbRxW9rao/BaImfsy4jy39t+9KuMzosVIielcjfJBUEX4lp0+Q5Ts8mq
 K+HG4uqdnFw/pkJHelAs4TOTrC0QTjhWdxByIv1RPbDU4asTYc+BfGyMMS4vT4C8OkeCE7J75bd
 ovsahxdcUZXGl9mWHuQjFjxpI1rDvJ1pu8OrvMctmHgupGPHm4X7ywfRq2bR6efWtRqSUcQMUyB
 rA+WNAar92uc1hPeIDORYLFcacTUKNSW7a8obH2BxJBEEJxZD6+L5UNxkZ2CwNi7iI7JLuGTyGz
 3tSlvnM6LuYIRtEfdXdZ40OTe2z4VGDIf53M/51mwWKwbpUfpIfWS8fzOydlORNnUgX2EN0nlBV
 8Kqcf/EmC+sQBag2UD+1qQT4kRdHWCymqG3uO+vgiWLpGbNjA7TTLBqu1HUEIyZGj8JV5H0u/jA
 Jo7rOfi8Ca0lS/7d4UbmCl20i59Snj90km7/OfrmicbykqgqFdYh1NC2xjRq3QShd64VReShw8h
 JKqcdvPlnM9hRBzNKDTuEObxL7+lDWb+QG9plGVqM/CVy5Oa+I/sIw1igIXcgyWI9H1TFmL2uAC
 YKtXnlrF3gxzEUupuazMZIyoGnNg2CbyBvb00R5gW4WNZ9og/k3UQ93oZ/0DGVZaFl9YrcPkB9X
 JrlkNonQkn/kE+A==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

After the frame is submitted to DMA, it may happen that the submitted
list is not updated soon enough, and the DMA callback is triggered
before that.

This can lead to kernel crashes, so move everything in a single
lock/unlock section to prevent such races.

Fixes: b4a3d877dc92 ("media: ti: Add CSI2RX support for J721E")
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
index 54aba055c96b..d47570f5d35a 100644
--- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
+++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
@@ -786,15 +786,14 @@ static void ti_csi2rx_buffer_queue(struct vb2_buffer *vb)
 			dev_warn(csi->dev,
 				 "Failed to drain DMA. Next frame might be bogus\n");
 
+		spin_lock_irqsave(&dma->lock, flags);
 		ret = ti_csi2rx_start_dma(csi, buf);
 		if (ret) {
-			dev_err(csi->dev, "Failed to start DMA: %d\n", ret);
-			spin_lock_irqsave(&dma->lock, flags);
 			vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
 			dma->state = TI_CSI2RX_DMA_IDLE;
 			spin_unlock_irqrestore(&dma->lock, flags);
+			dev_err(csi->dev, "Failed to start DMA: %d\n", ret);
 		} else {
-			spin_lock_irqsave(&dma->lock, flags);
 			list_add_tail(&buf->list, &dma->submitted);
 			spin_unlock_irqrestore(&dma->lock, flags);
 		}

-- 
2.43.0


