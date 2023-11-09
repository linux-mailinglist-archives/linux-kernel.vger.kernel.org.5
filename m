Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4AC7E6F32
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344534AbjKIQih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344438AbjKIQiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:38:12 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD7D3874;
        Thu,  9 Nov 2023 08:37:58 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C6D3F66076A5;
        Thu,  9 Nov 2023 16:37:55 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699547876;
        bh=ioad4eznaxnOj9zTodU1qDxSmo+Iro3wnE43clfkbec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=afCqqPbLxw1RmnTEI7Fk0EfHjqj338bem/6+TU25259xJwuqVjyxqZQ4EaKxXCmID
         rQoo2GtCmYbWU54VXPyAhiyehc7DC8TxGdS1PQTmLV6WFw1kolM8BYDYwVj3oGvG8O
         Dt2Hf2K7ObMY7B3OBUp/l/NRdl5lJGk63yLzdR2jbWtoF/bJ6evmJEYvu4QrDQOIV1
         rRBQhs3QcAXGFLr+ypZF3Z0EQ41g+YZ7cUmSoH7UeoBi0/+6r1I8hX8rR1o4GwIkdb
         yuW6GX62sHjocz4AbcA/wBnMicUfk1p4C/kExkRUk5Dd8j9GEsd5CZgIREl3GyIIvY
         AV7Hr1ztTSUtQ==
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
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Sergey Kozlov <serjk@netup.ru>, Abylay Ospan <aospan@netup.ru>
Subject: [PATCH v15 24/56] media: pci: netup_unidvb: Stop direct calls to queue num_buffers field
Date:   Thu,  9 Nov 2023 17:34:40 +0100
Message-Id: <20231109163512.179524-25-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231109163512.179524-14-benjamin.gaignard@collabora.com>
References: <20231109163512.179524-14-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vb2_get_num_buffers() to avoid using queue num_buffers field directly.
This allows us to change how the number of buffers is computed in the
future.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
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

