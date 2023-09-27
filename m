Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0120E7B08F5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbjI0Pij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbjI0Pge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:36:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFB41B8;
        Wed, 27 Sep 2023 08:36:30 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:672:46bd:3ec7:6cdf])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2296A6607376;
        Wed, 27 Sep 2023 16:36:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695828989;
        bh=qUxQMObFxpiy3pFolAat/Lsgv4wZ2hZHcdle7SRl8Pw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MJGhnJH7QCZeXAMK4RxX+U5d4DufSL7rrACPblJTpXUxaovUCbzqlJ91cvZLCoRI7
         i8MwxVQHPE+ePg6yZ+dg6YYDtMtjk6UmjsdOFs/b6yXIOMZx3FmDSZOEUYwH9BP/+P
         EIIiv24NiBf4WQ4hPRVnPQGx1uqiCUc0Fcwqfjv7qwCJPPTVtBu1opfOqhooSYzEkk
         Rp8pPVC9cJS6K4fNKjaUNUGhbwyO3XASYZ21tREL0iWiWMXHtpI/7WHPpLGz6Aee0u
         aNL0lwIebq3DriUDtGR5JcE732iONCK+rPVj1WaxMXDdl9nmvk6nwoJmtTMzCJTGwe
         FhgEPTsXzDu+w==
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
Subject: [PATCH v8 44/53] media: meson: vdec: Stop direct calls to queue num_buffers field
Date:   Wed, 27 Sep 2023 17:35:49 +0200
Message-Id: <20230927153558.159278-45-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230927153558.159278-1-benjamin.gaignard@collabora.com>
References: <20230927153558.159278-1-benjamin.gaignard@collabora.com>
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

Use vb2_get_num_buffers() to avoid using queue num_buffer field directly.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/staging/media/meson/vdec/vdec.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/media/meson/vdec/vdec.c
index 219185aaa588..1e2369f104c8 100644
--- a/drivers/staging/media/meson/vdec/vdec.c
+++ b/drivers/staging/media/meson/vdec/vdec.c
@@ -167,22 +167,23 @@ static void process_num_buffers(struct vb2_queue *q,
 				bool is_reqbufs)
 {
 	const struct amvdec_format *fmt_out = sess->fmt_out;
-	unsigned int buffers_total = q->num_buffers + *num_buffers;
+	unsigned int q_num_bufs = vb2_get_num_buffers(q);
+	unsigned int buffers_total = q_num_bufs + *num_buffers;
 	u32 min_buf_capture = v4l2_ctrl_g_ctrl(sess->ctrl_min_buf_capture);
 
-	if (q->num_buffers + *num_buffers < min_buf_capture)
-		*num_buffers = min_buf_capture - q->num_buffers;
+	if (q_num_bufs + *num_buffers < min_buf_capture)
+		*num_buffers = min_buf_capture - q_num_bufs;
 	if (is_reqbufs && buffers_total < fmt_out->min_buffers)
-		*num_buffers = fmt_out->min_buffers - q->num_buffers;
+		*num_buffers = fmt_out->min_buffers - q_num_bufs;
 	if (buffers_total > fmt_out->max_buffers)
-		*num_buffers = fmt_out->max_buffers - q->num_buffers;
+		*num_buffers = fmt_out->max_buffers - q_num_bufs;
 
 	/* We need to program the complete CAPTURE buffer list
 	 * in registers during start_streaming, and the firmwares
 	 * are free to choose any of them to write frames to. As such,
 	 * we need all of them to be queued into the driver
 	 */
-	sess->num_dst_bufs = q->num_buffers + *num_buffers;
+	sess->num_dst_bufs = q_num_bufs + *num_buffers;
 	q->min_buffers_needed = max(fmt_out->min_buffers, sess->num_dst_bufs);
 }
 
-- 
2.39.2

