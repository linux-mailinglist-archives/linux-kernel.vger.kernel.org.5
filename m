Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6737A05CE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239384AbjINNeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239112AbjINNdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:33:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D586F1FDE;
        Thu, 14 Sep 2023 06:33:37 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:36f2:37bd:ccbb:373f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5CA61660735F;
        Thu, 14 Sep 2023 14:33:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694698416;
        bh=EMKVWITArl2PHuWHDFd/NcTii9pr6T7GjKNa1Tuop1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DVXFgKrI+9K9uGdzuWfxGGsdYSnRQ1qbifrJfbEj3lrerimhXlTOVIKOuytIYx9PY
         AGH4nx1RPdSG0xAoFtGwFp/vFwSe8exbn71U3AjzndwVDCrzX5giNylwLQ4RMjTW5T
         PyyKs0MeCmERkiq41Lq7GEA3lT39e7DuLctysxcv0dR6PprXIdeszX71vJKACjcI+Q
         ww5pHWo3brb6QfsFIYrdeRUDjBn+DQE/Kyj425uIVxyYm8Pu84BlmvpcBGeudvQS6u
         nVlkxaG7dp3/wfTZMSuyqyJlwH1tBwJIwFWfQIAQa+1UkmCKWmzmJF6gCIIugr8YuP
         zQuwJMAEIwnbA==
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
Subject: [PATCH v7 10/49] media: dvb-core: Use vb2_get_buffer() instead of directly access to buffers array
Date:   Thu, 14 Sep 2023 15:32:44 +0200
Message-Id: <20230914133323.198857-11-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230914133323.198857-1-benjamin.gaignard@collabora.com>
References: <20230914133323.198857-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vb2_get_buffer() instead of directly access to vb2_buffer buffer array.
This could allow to change the type bufs[] field of vb2_buffer structure if
needed.
After each call to vb2_get_buffer() we need to be sure that we get
a valid pointer so check the return value of all of them.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/dvb-core/dvb_vb2.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/media/dvb-core/dvb_vb2.c b/drivers/media/dvb-core/dvb_vb2.c
index b322ef179f05..3a966fdf814c 100644
--- a/drivers/media/dvb-core/dvb_vb2.c
+++ b/drivers/media/dvb-core/dvb_vb2.c
@@ -355,12 +355,13 @@ int dvb_vb2_reqbufs(struct dvb_vb2_ctx *ctx, struct dmx_requestbuffers *req)
 int dvb_vb2_querybuf(struct dvb_vb2_ctx *ctx, struct dmx_buffer *b)
 {
 	struct vb2_queue *q = &ctx->vb_q;
+	struct vb2_buffer *vb2 = vb2_get_buffer(q, b->index);
 
-	if (b->index >= q->num_buffers) {
-		dprintk(1, "[%s] buffer index out of range\n", ctx->name);
+	if (!vb2) {
+		dprintk(1, "[%s] invalid buffer index\n", ctx->name);
 		return -EINVAL;
 	}
-	vb2_core_querybuf(&ctx->vb_q, q->bufs[b->index], b);
+	vb2_core_querybuf(&ctx->vb_q, vb2, b);
 	dprintk(3, "[%s] index=%d\n", ctx->name, b->index);
 	return 0;
 }
@@ -385,13 +386,14 @@ int dvb_vb2_expbuf(struct dvb_vb2_ctx *ctx, struct dmx_exportbuffer *exp)
 int dvb_vb2_qbuf(struct dvb_vb2_ctx *ctx, struct dmx_buffer *b)
 {
 	struct vb2_queue *q = &ctx->vb_q;
+	struct vb2_buffer *vb2 = vb2_get_buffer(q, b->index);
 	int ret;
 
-	if (b->index >= q->num_buffers) {
-		dprintk(1, "[%s] buffer index out of range\n", ctx->name);
+	if (!vb2) {
+		dprintk(1, "[%s] invalid buffer index\n", ctx->name);
 		return -EINVAL;
 	}
-	ret = vb2_core_qbuf(&ctx->vb_q, q->bufs[b->index], b, NULL);
+	ret = vb2_core_qbuf(&ctx->vb_q, vb2, b, NULL);
 	if (ret) {
 		dprintk(1, "[%s] index=%d errno=%d\n", ctx->name,
 			b->index, ret);
-- 
2.39.2

