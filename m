Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CE57B6419
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239965AbjJCIJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239493AbjJCIHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:07:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B33F1B6;
        Tue,  3 Oct 2023 01:07:33 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:b6df:b784:6a0f:8451])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 948D66607376;
        Tue,  3 Oct 2023 09:07:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696320452;
        bh=VdkA3cGwhU6mks7jszAxr2TxDs9YvsJ75Ji6rKZEsA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Thk1R8gSBlf/qo9PXQ6My+Kj5qDw7mcgR/tG8cfnPR2LTsetF4K9UmYxhHB/AvjMH
         jxvupwOnuUFCc8VxkZdSOiH2WCV2YJoKEcTy0xg3NTg15MA0y+s1wTbF7ZdS2t2gNH
         7zFGQQ/tf8MeLc8oNNMZ29WJoYZohQ9/yR2a+81SNCg/L2CYwgaDt9KJ3GJ95E/sLr
         t+4eUNeKWr2PX8AjL8gZ4NrX4bYfhBs3mwVVwPDWud63+EE3Tpm4hwu36Iy6kCsan6
         baEbWdXy46LaO48uTCFUfvOlAnt6WlVFZFxz53pHRDy+go8stHCwR1dFJLz/6Ud6vT
         mMRwWld6WozhQ==
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
Subject: [PATCH v10 36/54] media: verisilicon: Stop direct calls to queue num_buffers field
Date:   Tue,  3 Oct 2023 10:06:45 +0200
Message-Id: <20231003080704.43911-37-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003080704.43911-1-benjamin.gaignard@collabora.com>
References: <20231003080704.43911-1-benjamin.gaignard@collabora.com>
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

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/platform/verisilicon/hantro_postproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/verisilicon/hantro_postproc.c b/drivers/media/platform/verisilicon/hantro_postproc.c
index 7aa45d0fd291..41e93176300b 100644
--- a/drivers/media/platform/verisilicon/hantro_postproc.c
+++ b/drivers/media/platform/verisilicon/hantro_postproc.c
@@ -250,7 +250,7 @@ int hantro_postproc_init(struct hantro_ctx *ctx)
 {
 	struct v4l2_m2m_ctx *m2m_ctx = ctx->fh.m2m_ctx;
 	struct vb2_queue *cap_queue = &m2m_ctx->cap_q_ctx.q;
-	unsigned int num_buffers = cap_queue->num_buffers;
+	unsigned int num_buffers = vb2_get_num_buffers(cap_queue);
 	unsigned int i;
 	int ret;
 
-- 
2.39.2

