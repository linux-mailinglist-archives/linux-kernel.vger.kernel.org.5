Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4CB7FA6F1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbjK0QzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbjK0QzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:55:06 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F313919B;
        Mon, 27 Nov 2023 08:55:12 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E9E7766072EC;
        Mon, 27 Nov 2023 16:55:10 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701104111;
        bh=/omb2mE5oy70HH/kBxdqmwaLlWf6cHg+GYUl9K/Xqzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UyygRunYjRkADBLKm+WPF/uWjoPZcVap4oKYXcLdaRC88jMZmnDU+EfLGW7qTd5PE
         ymFjgeVJlgGiAt59YziOGCV821Io/7/yu4OJGU1nOEfM1ZSR6lPcRQrZBofG0xAPNR
         RloGvqNXRoGjpoYltJJjTGRAtwvYlE4QxeV4LuBYrfuZHzyrx0tFB8qlLsHOK/zfx4
         4eWJByOcHtfS4j3e8OgsW2eHI/aeJMJG0wyasx+YcTt6eH2+YE3xejO5KPWkBBj2tX
         bxwCjvK2sJrjCcZg+0TxE8KqYmnHZwT+1oYFYFL3zb+V2DKWurp/PSI1g3bZVRB4wF
         ww/bxPqt7IzEQ==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Martin Kepplinger <martink@posteo.de>,
        Purism Kernel Team <kernel@puri.sm>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH 08/55] media: imx7-media-csi: Stop abusing of min_buffers_needed field
Date:   Mon, 27 Nov 2023 17:54:07 +0100
Message-Id: <20231127165454.166373-9-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231127165454.166373-1-benjamin.gaignard@collabora.com>
References: <20231127165454.166373-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'min_buffers_needed' is suppose to be used to indicate the number
of buffers needed by DMA engine to start streaming.
imx7-media-csi driver doesn't use DMA engine and just want to specify
the minimum number of buffers to allocate when calling VIDIOC_REQBUFS.
That 'min_reqbufs_allocation' field purpose so use it.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Rui Miguel Silva <rmfrfs@gmail.com>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC: Martin Kepplinger <martink@posteo.de>
CC: Purism Kernel Team <kernel@puri.sm>
CC: Mauro Carvalho Chehab <mchehab@kernel.org>
CC: Shawn Guo <shawnguo@kernel.org>
CC: Sascha Hauer <s.hauer@pengutronix.de>
CC: Pengutronix Kernel Team <kernel@pengutronix.de>
CC: Fabio Estevam <festevam@gmail.com>
CC: NXP Linux Team <linux-imx@nxp.com>
---
 drivers/media/platform/nxp/imx7-media-csi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/nxp/imx7-media-csi.c b/drivers/media/platform/nxp/imx7-media-csi.c
index 1d2464ca59b8..dcc8c54228e4 100644
--- a/drivers/media/platform/nxp/imx7-media-csi.c
+++ b/drivers/media/platform/nxp/imx7-media-csi.c
@@ -1676,7 +1676,7 @@ static int imx7_csi_video_init(struct imx7_csi *csi)
 	vq->mem_ops = &vb2_dma_contig_memops;
 	vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
 	vq->lock = &csi->vdev_mutex;
-	vq->min_buffers_needed = 2;
+	vq->min_reqbufs_allocation = 2;
 	vq->dev = csi->dev;
 
 	ret = vb2_queue_init(vq);
-- 
2.39.2

