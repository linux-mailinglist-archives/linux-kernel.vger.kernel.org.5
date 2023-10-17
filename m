Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5AC7CC693
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344511AbjJQOtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344209AbjJQOs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:48:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CC512F;
        Tue, 17 Oct 2023 07:48:19 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:7205:da49:a7e8:59f8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 79C136607322;
        Tue, 17 Oct 2023 15:48:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697554097;
        bh=/dEmIdIJBXPR3lp68L0eO8Ks+TlFFI9ywnMWFSnMh5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N+CeSGxVGpilyS+eYAD3rNm3nqwbVoBc+iuKh+sCyXkkQK3W+dOC8G1mJ/qtF9AOd
         sPu9Jc9gHHpVW5IcYiomB1lLQEDCqU+Mo7IK1uYN/tBXXr5aXiFdCbh04rde8gbqWg
         rOIm0K3O4/Xh4Bd6snBfxXs6aLlfRIumD1HSbsxy20RTjTbx74fQu22Yq0TwS2MZaM
         ezz5C2dezU6iIL6wobIlSmLs5diDGy124WjJ/wLguhIoS2GKOtHdU/LO2NvKdVV99x
         zuheO+ACvn6U07LZlsdTVm5+CN82ScwojLxX2kA0wmbjP9zy+OZbPBxLcACv0Nxfy4
         4iLb9jbV1mUbw==
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
Subject: [PATCH v12 27/56] media: coda: Stop direct calls to queue num_buffers field
Date:   Tue, 17 Oct 2023 16:47:27 +0200
Message-Id: <20231017144756.34719-28-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017144756.34719-1-benjamin.gaignard@collabora.com>
References: <20231017144756.34719-1-benjamin.gaignard@collabora.com>
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
This allows us to change how the number of buffers is computed in the
futur.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Philipp Zabel <p.zabel@pengutronix.de>
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

