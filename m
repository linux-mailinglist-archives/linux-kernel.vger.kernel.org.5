Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E117C6D30
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378791AbjJLLtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378811AbjJLLrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:47:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C28519E;
        Thu, 12 Oct 2023 04:47:09 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:7ae7:b86d:c19a:877e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 04BCE660738E;
        Thu, 12 Oct 2023 12:47:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697111228;
        bh=Zne8+1+gt7T5bArgwI34aDgBwx9md9yjRlThQEon5Pk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gf62AcjPOWvhMdRnJLmE7bGshcMQ4KNh+hthHIVDXid8l3MkgBetP/26Xjn2KSMtb
         H8EIQSwmX8n+aIhWpFXtdiS3F+VD8K0qfKNtKDWURVfH22H2dLYAxvb+SWUBXxslQB
         7fhI0AoGLYmOPsk2AfDcf2O9hPNloqPwd89JElrVskjwHUhCpOGFyyeJdn6VboNJhP
         Ac99fN6a8lkBmEnmkgSvKIVnNUyJSXkvto5CExml7BtvuC4Nx1w5XdmzPPb7C8Qi3b
         342KiEz+CMwVHJEKp5FmaLjASvSoTU+TKexyrkuS7nQqQLVOR5ZPbF8Gs3IfcZmZDz
         wauoulmDnt5fw==
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
        Antti Palosaari <crope@iki.fi>
Subject: [PATCH v11 35/56] media: usb: hackrf: Set min_buffers_needed to 8
Date:   Thu, 12 Oct 2023 13:46:21 +0200
Message-Id: <20231012114642.19040-36-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231012114642.19040-1-benjamin.gaignard@collabora.com>
References: <20231012114642.19040-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vb2 queue_setup checks for a minimum number of buffers so set
min_buffers_needed to 8 and remove the useless check in
hackrf_queue_setup().

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Antti Palosaari <crope@iki.fi>
---
 drivers/media/usb/hackrf/hackrf.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/media/usb/hackrf/hackrf.c b/drivers/media/usb/hackrf/hackrf.c
index 3e535be2c520..2e856b20aa21 100644
--- a/drivers/media/usb/hackrf/hackrf.c
+++ b/drivers/media/usb/hackrf/hackrf.c
@@ -754,15 +754,10 @@ static int hackrf_queue_setup(struct vb2_queue *vq,
 {
 	struct hackrf_dev *dev = vb2_get_drv_priv(vq);
 
-	dev_dbg(dev->dev, "nbuffers=%d\n", *nbuffers);
-
-	/* Need at least 8 buffers */
-	if (vq->num_buffers + *nbuffers < 8)
-		*nbuffers = 8 - vq->num_buffers;
 	*nplanes = 1;
 	sizes[0] = PAGE_ALIGN(dev->buffersize);
 
-	dev_dbg(dev->dev, "nbuffers=%d sizes[0]=%d\n", *nbuffers, sizes[0]);
+	dev_dbg(dev->dev, "nbuffers=%u sizes[0]=%d\n", vb2_get_num_buffers(vq), sizes[0]);
 	return 0;
 }
 
@@ -1392,6 +1387,8 @@ static int hackrf_probe(struct usb_interface *intf,
 	dev->rx_vb2_queue.type = V4L2_BUF_TYPE_SDR_CAPTURE;
 	dev->rx_vb2_queue.io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF |
 				     VB2_READ;
+	/* Need at least 8 buffers */
+	dev->rx_vb2_queue.min_buffers_needed = 8;
 	dev->rx_vb2_queue.ops = &hackrf_vb2_ops;
 	dev->rx_vb2_queue.mem_ops = &vb2_vmalloc_memops;
 	dev->rx_vb2_queue.drv_priv = dev;
-- 
2.39.2

