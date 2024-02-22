Return-Path: <linux-kernel+bounces-76416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D5785F70D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3068C1C23457
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA4B4596E;
	Thu, 22 Feb 2024 11:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rVeJYGXd"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDF7381A1;
	Thu, 22 Feb 2024 11:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601607; cv=none; b=LyWEGs0/m9BL5VLRyxKgWnEi0cc8wcBMFbJxyrEHMXS7KuS0kj2A6W3sFl41VhC7m6u7yizUm7gxpe26BBWGh+MKjQfYnInCYhu64wFRNqzFOo0RO20/GB968R6oO6oYja3HCV4sLuJFtU38c1ydJbRlOPWzooqgF4GUt9soSso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601607; c=relaxed/simple;
	bh=RGZevRFsIBvLsB1s0og8plkNvtCkfORtLILdFlyUzw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fp5C4e2uJGdKQmVpuFdiwsxAyomKseQhxVGOiMCups42qgWeRL4TQ3coJsOyswYtLO4IfsjzeI8CeIzawgaz0D2BNYXN5r9ABvzKX8qBux0t3nzWMsDWfbTg1TOPkIQajjXdARk9cUB8APDTroCfa8uStlh72rm/yNhFrIUd5qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rVeJYGXd; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41MBX7O6059121;
	Thu, 22 Feb 2024 05:33:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708601587;
	bh=unATImeiTgCx2h83hV/vvpZDGrNkG9tQmTwgLhrnhvI=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=rVeJYGXdT7Ymnf2W3KyFM42kDH/batnZnLLyh2+TyVQiP/CSD3IFOLukhWUeaWN0X
	 oqjXbTnCOzloDPiHKZNvVcL0jOdCOypZNvv9ySWUTH7vSaWBO8wDQL9UD1cpCXN8Ff
	 TvooYNuJos6qSxv4qPQglQ/tS7xreZdjB5qNv6g0=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41MBX7VF056960
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 05:33:07 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 05:33:06 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 05:33:06 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41MBX5bj090878;
	Thu, 22 Feb 2024 05:33:06 -0600
From: Jai Luthra <j-luthra@ti.com>
Date: Thu, 22 Feb 2024 17:01:17 +0530
Subject: [PATCH RFC 01/21] media: ti: j721e-csi2rx: Fix races while
 restarting DMA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-multistream-v1-1-1837ed916eeb@ti.com>
References: <20240222-multistream-v1-0-1837ed916eeb@ti.com>
In-Reply-To: <20240222-multistream-v1-0-1837ed916eeb@ti.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans
 Verkuil <hverkuil-cisco@xs4all.nl>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Aradhya
 Bhatia <a-bhatia1@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
        Changhuang
 Liang <changhuang.liang@starfivetech.com>,
        Jack Zhu
	<jack.zhu@starfivetech.com>,
        Julien Massot <julien.massot@collabora.com>,
        Jayshri Pawar <jpawar@cadence.com>, Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1532; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=RGZevRFsIBvLsB1s0og8plkNvtCkfORtLILdFlyUzw0=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBl1zDaW9QfFKtaA48EMnvlA0N0UPpud5MN0AiqU
 qz3gSThwtSJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZdcw2gAKCRBD3pH5JJpx
 RZpWD/9TrlLiXZwWyOpm0PdGXZeBKB+af2zmPStZLGcfOE2aiYqIvQXZasnffBaD+rtu0LF9vKc
 LSuRyNTfIbaKkideXMz5oYsyu46z9AeJ6+MLj2D3iEYabvJZknCGVOK5Xx1xyKGhBnAcd9XucDl
 zEPeX3tcpyBN8fwIaJ27pMs+HCW/9AEyZA+/DwVLrtz2UTYNmSHOz5cgaAXy2U2URgP66oi3VLU
 sEym4xvzKCa4uwid9Ns+O+bfgaFgyJMuHmGWwPig2nmVpTF4m5IiTsaOl5+h+a8XvYDDLoCyMcV
 8dorGmBTMb0WhPzeJ5GA7Dkw8lN+gbinoHomqJlf/B0gw5v1Ln6PQuWlY//NPyeWNL12lbCnHE2
 blYQ3L6zQE7eRI49fuN891rkdnHy3mnvzXySDNvx62kNG50yt7N1xthBjYH9FnutwaXcPzUe4MU
 lex+cUEG8cEBn7iT8ZkoNO2jUdQvk06e/+mOPv3KqzGzFFsNRhYhQpMAw6BYVPav+0x/4mtEcuD
 HSVaMyIRajwZ2Jpa//Fc5g9TPDaIR27LMer1l4X5D/Iz2PzLnmfrZ2xxma8fU6wqR3ABHdwBF8+
 2dJ8GlCphRINgnAea64x8tbbhCsvt3J/69JwpD/e/PBQdYGeFjPQPfbsiw3gDyKPUewiXs0rdow
 Bxk05JYwsUwjIBQ==
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
index be47a4a24f97..e2cac8d73d78 100644
--- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
+++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
@@ -810,15 +810,14 @@ static void ti_csi2rx_buffer_queue(struct vb2_buffer *vb)
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


