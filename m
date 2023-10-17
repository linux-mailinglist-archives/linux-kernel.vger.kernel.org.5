Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EF67CC6B0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344102AbjJQOuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344235AbjJQOsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:48:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39F7123;
        Tue, 17 Oct 2023 07:48:17 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:7205:da49:a7e8:59f8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DB73D6607378;
        Tue, 17 Oct 2023 15:48:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697554096;
        bh=OzWNoh3dVGH1f8/6CPeX6RasP+WQ7RCZ45t3ra50rec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CbZ4BxZyJPWCt/KTG9tG1OzCWe7n1bOCwR9S8+MGfNP8QJ0rnyNRtQDDgiwQfMhN6
         enug84zFwMuguWWj/VUzqtW7XN1e7sXIyUxW9x5rj9Bh7RG4xcK39EZhQ4Dq9OKsLY
         Pf/snQeWHL91jp3A38vZM9CTmZ+FnSDEx92QjxJcs259okcQDzzWt49oLi+i3ZTRaV
         Wy8KGOplX6y1GBFPAR3yRn/PyifHu7mAYpmEnfNTWY33cvNNKXoSUrrYATLKONWE4J
         SlW6ST86oDUmNpkcksi7cKl+wS2TvKpnbl6HIAjmY89DB3YjQ+wRoVk6t6b3bNgQ17
         rP0/Fruk1msHQ==
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
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Sergey Kozlov <serjk@netup.ru>, Abylay Ospan <aospan@netup.ru>
Subject: [PATCH v12 24/56] media: pci: netup_unidvb: Stop direct calls to queue num_buffers field
Date:   Tue, 17 Oct 2023 16:47:24 +0200
Message-Id: <20231017144756.34719-25-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017144756.34719-1-benjamin.gaignard@collabora.com>
References: <20231017144756.34719-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vb2_get_num_buffers() to avoid using queue num_buffers field directly.
This allows us to change how the number of buffers is computed in the
futur.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Sergey Kozlov <serjk@netup.ru>
CC: Abylay Ospan <aospan@netup.ru>
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

