Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A747A05FE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239558AbjINNew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239402AbjINNeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:34:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536AC2129;
        Thu, 14 Sep 2023 06:33:47 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:36f2:37bd:ccbb:373f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 43469660737D;
        Thu, 14 Sep 2023 14:33:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694698426;
        bh=vej0xyoaRLN25qHgld1P1pTyfPCEtxO7zlLcrG23sig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nhuItNLeE/eHshL9NqkSa3ui7vNLCle4BfyDm9HwWNOf8qU6fu9ZHVbz+qM7AUO2+
         hjtFv2xfyIYnj36Jr5UkggkUfKEpG+u+CpDaGy+jvdb5cRM8cdW/BFr1DmyBh8ykgZ
         A+onhe5XfI6fnEPoYo5B4XEKGDou1F9nCi2P0ZGTG2IJYyGu7BSjmOQmM+Q8TVGRfd
         ZvmgpyITYotiJO2Okdgp887wYJBeNEufXuTVMaC3wUFk7JbYR2wLd5IiKKWEStrlUP
         DD5WHQhVEn3UcvTuhg0gqOU/EBFU9gDBrKKgVfQ7duL809XOFrYLLYdikpK+LbTCkE
         Td8EeFZsBaUjg==
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
Subject: [PATCH v7 29/49] media: coda: Stop direct calls to queue num_buffers field
Date:   Thu, 14 Sep 2023 15:33:03 +0200
Message-Id: <20230914133323.198857-30-benjamin.gaignard@collabora.com>
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
 drivers/media/platform/chips-media/coda-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/chips-media/coda-common.c b/drivers/media/platform/chips-media/coda-common.c
index cc4892129aaf..f1d85758f6dd 100644
--- a/drivers/media/platform/chips-media/coda-common.c
+++ b/drivers/media/platform/chips-media/coda-common.c
@@ -794,7 +794,7 @@ static int coda_s_fmt(struct coda_ctx *ctx, struct v4l2_format *f,
 
 	if (vb2_is_busy(vq)) {
 		v4l2_err(&ctx->dev->v4l2_dev, "%s: %s queue busy: %d\n",
-			 __func__, v4l2_type_names[f->type], vq->num_buffers);
+			 __func__, v4l2_type_names[f->type], vb2_get_num_buffers(vq));
 		return -EBUSY;
 	}
 
-- 
2.39.2

