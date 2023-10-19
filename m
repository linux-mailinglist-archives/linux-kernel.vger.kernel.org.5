Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144F67CF9E2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345987AbjJSMyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345784AbjJSMwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:52:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D096411B;
        Thu, 19 Oct 2023 05:52:39 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:ccea:1fb5:34eb:239b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4C7E36607352;
        Thu, 19 Oct 2023 13:52:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697719958;
        bh=b1HWvospKm41+ZR+lTHAwjFMrNIUi+qp4QEOx4PbCAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JjdLclCPhiIu7h9Loc+gRj84QPiQ0S7q7I6geT+3m/JHqRLoATk6ddtT7afJsn3dV
         igvqQ2BXlAzmG8++HlmmvxlYXxv8Monev0Urfau7bmsVa3Lj01Y+4Mz7t3Oi9CnEcc
         5saCCcwl2HQjLolj6ZFswqO3se408sBv+T4px2MdkIBkEcjYPUP0pbD0NDcI+2Dfo+
         LfgDCRuFR31xt3543oqp3TGuWz5s+09ciPDFjZNfnen5a1AUla7FCDUwcXtCA/4i5i
         7Fmz1d0jW2P7KRoOU8q4jv/UHcqvYczu7NA/lMUjOlDATD0fQfEGF+Qh33O18JR51T
         C1sDZ/GOt4rkg==
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
        Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH v13 15/56] media: visl: Use vb2_get_buffer() instead of directly access to buffers array
Date:   Thu, 19 Oct 2023 14:51:41 +0200
Message-Id: <20231019125222.21370-16-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231019125222.21370-1-benjamin.gaignard@collabora.com>
References: <20231019125222.21370-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vb2_get_buffer() instead of direct access to the vb2_queue bufs array.
This allows us to change the type of the bufs in the future.
After each call to vb2_get_buffer() we need to be sure that we get
a valid pointer so check the return value of all of them.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Daniel Almeida <daniel.almeida@collabora.com>
CC: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 drivers/media/test-drivers/visl/visl-dec.c | 28 ++++++++++++++++------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/media/test-drivers/visl/visl-dec.c b/drivers/media/test-drivers/visl/visl-dec.c
index 318d675e5668..ba20ea998d19 100644
--- a/drivers/media/test-drivers/visl/visl-dec.c
+++ b/drivers/media/test-drivers/visl/visl-dec.c
@@ -290,13 +290,20 @@ static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
 	for (i = 0; i < out_q->num_buffers; i++) {
 		char entry[] = "index: %u, state: %s, request_fd: %d, ";
 		u32 old_len = len;
-		char *q_status = visl_get_vb2_state(out_q->bufs[i]->state);
+		struct vb2_buffer *vb2;
+		char *q_status;
+
+		vb2 = vb2_get_buffer(out_q, i);
+		if (!vb2)
+			continue;
+
+		q_status = visl_get_vb2_state(vb2->state);
 
 		len += scnprintf(&buf[len], TPG_STR_BUF_SZ - len,
 				 entry, i, q_status,
-				 to_vb2_v4l2_buffer(out_q->bufs[i])->request_fd);
+				 to_vb2_v4l2_buffer(vb2)->request_fd);
 
-		len += visl_fill_bytesused(to_vb2_v4l2_buffer(out_q->bufs[i]),
+		len += visl_fill_bytesused(to_vb2_v4l2_buffer(vb2),
 					   &buf[len],
 					   TPG_STR_BUF_SZ - len);
 
@@ -342,13 +349,20 @@ static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
 	len = 0;
 	for (i = 0; i < cap_q->num_buffers; i++) {
 		u32 old_len = len;
-		char *q_status = visl_get_vb2_state(cap_q->bufs[i]->state);
+		struct vb2_buffer *vb2;
+		char *q_status;
+
+		vb2 = vb2_get_buffer(cap_q, i);
+		if (!vb2)
+			continue;
+
+		q_status = visl_get_vb2_state(vb2->state);
 
 		len += scnprintf(&buf[len], TPG_STR_BUF_SZ - len,
 				 "index: %u, status: %s, timestamp: %llu, is_held: %d",
-				 cap_q->bufs[i]->index, q_status,
-				 cap_q->bufs[i]->timestamp,
-				 to_vb2_v4l2_buffer(cap_q->bufs[i])->is_held);
+				 vb2->index, q_status,
+				 vb2->timestamp,
+				 to_vb2_v4l2_buffer(vb2)->is_held);
 
 		tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, &buf[old_len]);
 		frame_dprintk(ctx->dev, run->dst->sequence, "%s", &buf[old_len]);
-- 
2.39.2

