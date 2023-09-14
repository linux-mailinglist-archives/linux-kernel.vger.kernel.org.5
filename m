Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCA57A060B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239986AbjINNfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239348AbjINNeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:34:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0982326AB;
        Thu, 14 Sep 2023 06:33:50 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:36f2:37bd:ccbb:373f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 672906607358;
        Thu, 14 Sep 2023 14:33:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694698429;
        bh=JMZx2uxA26BNI9i9E6OsCtWtCLTgVI42g2rsSFOFa8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KMc3c3PZVLGDx78559nwmGzDHbm4s0tkKoSi47P9LzcBhzTYs2YRA165nqs1fGqzq
         dfHzyavdk5PrKZDz/P2YvJW2CbDp5+8+mH7Pe4hZIjuWkqhOQJc/iQ/zRjJSzDReHv
         IfIxknHFPLUfmDJtf85EWqFbXHsRdsIJgBwwkYEfwSNRxXdjgMgq3PjyXLqPzqAXKE
         d7qmMSO4fTKRZaKIDf7HX2MOVR/SongSzbQfe2J+lblpTnefsrmk0RdeTMzIkw/MTf
         op1DvFfCc246LfgbpGRiMzRHGUSDnbmbS5pR8WLXWHpLb8n91Q0P/jBheuzQVjjEXl
         zEc5T1pYE8gVA==
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
Subject: [PATCH v7 35/49] media: verisilicon: Stop direct calls to queue num_buffers field
Date:   Thu, 14 Sep 2023 15:33:09 +0200
Message-Id: <20230914133323.198857-36-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230914133323.198857-1-benjamin.gaignard@collabora.com>
References: <20230914133323.198857-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vb2_get_num_buffers() to avoid using queue num_buffer field directly.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/platform/verisilicon/hantro_postproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/verisilicon/hantro_postproc.c b/drivers/media/platform/verisilicon/hantro_postproc.c
index 77d8ecfbe12f..a242eedf9cf5 100644
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

