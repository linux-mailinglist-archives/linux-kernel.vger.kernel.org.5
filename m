Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8E27E6ED8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344317AbjKIQcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344119AbjKIQcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:32:39 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8ADA3845;
        Thu,  9 Nov 2023 08:32:37 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8680166076A8;
        Thu,  9 Nov 2023 16:32:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699547556;
        bh=3b/dx2P81ZUhQ9IbGSLS7lMvQsWaifDH6Xromp4oCdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mCuHsiASxnXFKmcAKg1+O+g4ocUXrRRzRH9bXPhsDlcrNckr9sqdOZ0XlSohKLLJp
         0bvXhPxTg3Egn+lnXgaSWAthF3P4ebNhBnS6oOMfgdxSJRF39+op6NNEKY6jzvoJ1q
         b+Pv3qxnvEOd1EkbDy0oUstwWpTkTWkbbiczwA2wYTuRBg1nL9GYUG3GReQimIxD++
         3l4UfZDztP5ru5ZrCrkP+nLNEJNRsQwNabBmQNKdSrhNcl11yzcSvPHoMNLmVyaJZs
         l9FJfz/zfc8ov76TXcG92qj5aIuhJMJpkSLYA1JW8lgQNsEfuKLYUKKzQ1s7pC4pCz
         CHWq1QjSay/OQ==
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
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Subject: [PATCH v15 06/56] media: videobuf2: Remove duplicated index vs q->num_buffers check
Date:   Thu,  9 Nov 2023 17:29:18 +0100
Message-Id: <20231109163008.179152-7-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231109163008.179152-1-benjamin.gaignard@collabora.com>
References: <20231109163008.179152-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vb2_get_buffer() already checks if the requested index is valid.
Stop duplicating this kind of check everywhere.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
---
 drivers/media/common/videobuf2/videobuf2-v4l2.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index 37f814a89ace..6ba13a95323c 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -817,10 +817,6 @@ int vb2_qbuf(struct vb2_queue *q, struct media_device *mdev,
 		return -EBUSY;
 	}
 
-	if (b->index >= q->num_buffers) {
-		dprintk(q, 1, "buffer index out of range\n");
-		return -EINVAL;
-	}
 	vb = vb2_get_buffer(q, b->index);
 	if (!vb) {
 		dprintk(q, 1, "can't find the requested buffer %u\n", b->index);
@@ -892,10 +888,6 @@ int vb2_expbuf(struct vb2_queue *q, struct v4l2_exportbuffer *eb)
 {
 	struct vb2_buffer *vb;
 
-	if (eb->index >= q->num_buffers) {
-		dprintk(q, 1, "buffer index out of range\n");
-		return -EINVAL;
-	}
 	vb = vb2_get_buffer(q, eb->index);
 	if (!vb) {
 		dprintk(q, 1, "can't find the requested buffer %u\n", eb->index);
-- 
2.39.2

