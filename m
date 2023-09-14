Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C977A05F0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239506AbjINNel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239305AbjINNeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:34:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1710210C;
        Thu, 14 Sep 2023 06:33:45 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:36f2:37bd:ccbb:373f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 355306607379;
        Thu, 14 Sep 2023 14:33:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694698424;
        bh=m3sR68fD7RFMhs/9CpLuKCWbk5tpTajBvxLhqEExuTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JslCudCijCNZbjg/QccsFInVeRarUdHdzzatKGlmYaf2IlaBwMKxs+ayDH1t3kGZ7
         8N3M3Iq/vri4mZUXr13lAJH5HNrsKw0pVHZ4/Ho34xTL1/fYQzN1Vz3FQ2I+iF5oCo
         tpxZOIcNjhRWRTT0+kwqrU7JE6cTY+loFqBLoypTd5N4gTm6ho5uGWom0Mp443EfRq
         Kg9N2qfXsGs03r64YM8NvyfLuTrd4Gun5VoWf2r1M5gP3Ca2XdzKjIgDfTSFpl70n8
         WshJE0HQfwhFN3QuyeVxKAAcUHFLRRl/NI1rCyRJkG5jomtFeUJkRG7n/Kzu8P7+qX
         TjSROgV9SWezQ==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v7 25/49] media: pci: netup_unidvb: Stop direct calls to queue num_buffers field
Date:   Thu, 14 Sep 2023 15:32:59 +0200
Message-Id: <20230914133323.198857-26-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230914133323.198857-1-benjamin.gaignard@collabora.com>
References: <20230914133323.198857-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vb2_get_num_buffers() to avoid using queue num_buffer field directly.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/pci/netup_unidvb/netup_unidvb_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/netup_unidvb/netup_unidvb_core.c b/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
index d85bfbb77a25..557985ba25db 100644
--- a/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
+++ b/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
@@ -293,12 +293,13 @@ static int netup_unidvb_queue_setup(struct vb2_queue *vq,
 				    struct device *alloc_devs[])
 {
 	struct netup_dma *dma = vb2_get_drv_priv(vq);
+	unsigned int q_num_bufs = vb2_get_num_buffers(vq);
 
 	dev_dbg(&dma->ndev->pci_dev->dev, "%s()\n", __func__);
 
 	*nplanes = 1;
-	if (vq->num_buffers + *nbuffers < VIDEO_MAX_FRAME)
-		*nbuffers = VIDEO_MAX_FRAME - vq->num_buffers;
+	if (q_num_bufs + *nbuffers < VIDEO_MAX_FRAME)
+		*nbuffers = VIDEO_MAX_FRAME - q_num_bufs;
 	sizes[0] = PAGE_ALIGN(NETUP_DMA_PACKETS_COUNT * 188);
 	dev_dbg(&dma->ndev->pci_dev->dev, "%s() nbuffers=%d sizes[0]=%d\n",
 		__func__, *nbuffers, sizes[0]);
-- 
2.39.2

