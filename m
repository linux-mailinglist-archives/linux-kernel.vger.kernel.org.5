Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6C47C6CCE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378575AbjJLLrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347167AbjJLLqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:46:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F8DB7;
        Thu, 12 Oct 2023 04:46:54 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:7ae7:b86d:c19a:877e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 67E56660734B;
        Thu, 12 Oct 2023 12:46:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697111212;
        bh=LnC/LgabfPomUWVgSsCIVeH8QJzOQ0dsjpcXwnRWi1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hjFh6xvACVR4dphfZJxcOqem6SOEhSzu4SjAiP6ObmI35oWJAZu0EMWDuNlHuX1OD
         2fQ2bmWJ/d1MakJ5WhgHV25ZSHDZD942xb3BBcsP7OOgODC8Cx36sB29eReR1ESFnd
         UcWNNZRsGy4sTLOKdYKrm/tYMF4oqjvhQdcGSERpljlmAS+icSgN7oeWzEK/1AwYDh
         u8OnOufan0XhzTKyr/k62xSdol/b+/T6mvvnb0cnGT3xCKNJ/f7EV+uFOqjl/M91SK
         Pq6umy3sDCJ0H6PdC7/DVzpM6RVN055/HI/0hMUnHh6JdHM/Szbbb1oN1p9qUwJgZp
         vCqSVec8JRMCQ==
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
Subject: [PATCH v11 06/56] media: videobuf2: Remove duplicated index vs q->num_buffers check
Date:   Thu, 12 Oct 2023 13:45:52 +0200
Message-Id: <20231012114642.19040-7-benjamin.gaignard@collabora.com>
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

vb2_get_buffer() already checks if the requested index is valid.
Stop duplicating this kind of check everywhere.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/common/videobuf2/videobuf2-v4l2.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index 3395e702ad1f..b9df2bdae389 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -378,11 +378,6 @@ static int vb2_queue_or_prepare_buf(struct vb2_queue *q, struct media_device *md
 		return -EINVAL;
 	}
 
-	if (b->index >= q->num_buffers) {
-		dprintk(q, 1, "%s: buffer index out of range\n", opname);
-		return -EINVAL;
-	}
-
 	vb = vb2_get_buffer(q, b->index);
 	if (!vb) {
 		dprintk(q, 1, "%s: buffer %u is NULL\n", opname,  b->index);
@@ -829,10 +824,6 @@ int vb2_qbuf(struct vb2_queue *q, struct media_device *mdev,
 		return -EBUSY;
 	}
 
-	if (b->index >= q->num_buffers) {
-		dprintk(q, 1, "buffer index out of range\n");
-		return -EINVAL;
-	}
 	vb = vb2_get_buffer(q, b->index);
 	if (!vb) {
 		dprintk(q, 1, "can't find the requested buffer %u\n", b->index);
@@ -904,10 +895,6 @@ int vb2_expbuf(struct vb2_queue *q, struct v4l2_exportbuffer *eb)
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

