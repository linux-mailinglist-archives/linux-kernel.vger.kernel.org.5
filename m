Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BAF7E1552
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 17:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjKEQ4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 11:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjKEQzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 11:55:54 -0500
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F582D9;
        Sun,  5 Nov 2023 08:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1699203347; bh=QFwovX5RPW7IMq4uUoTrIwvqoq7/7Q8z3p4frGKGekE=;
 b=iogMt8BWbZ0IMRmVXbXItCv2PMI90AvIJerLiaBkLdr5Iz3gxsyeA+sJtYcyrGpEiAq4Cx4jh
 CU6e08rrf0+3hAGVy+uUEWSLW1V9mgO3K0MhMjoD5j3sNnCLB/zlyIgQKEVPNEPMsJJsCjUPrSp
 bkjdHkeuCSVnNC6wRPf9nVTntHFNca6abSevGZl1ivQkXbc4zjsKD0bby05TvBxzYGNDV4jJEvN
 msaVQ7ak2pAhjvxTFBh/wR7hcGbvTNhHB8PrknCBLCMXttDHfgNPsOPd5mIGi3gHBL284C2+afM
 /TMAOTHtW2vO7Dp0JJU8Pi7PNGYV/XciaErgvSuz78Hw==
From:   Jonas Karlman <jonas@kwiboo.se>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     Alex Bee <knaerzche@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v4 05/11] media: rkvdec: h264: Remove SPS validation at streaming start
Date:   Sun,  5 Nov 2023 16:55:04 +0000
Message-ID: <20231105165521.3592037-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231105165521.3592037-1-jonas@kwiboo.se>
References: <20231105165521.3592037-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6547c91342ad2f8d1524691b
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPS parameters is validated in try_ctrl() ops so there is no need to
re-validate when streaming starts.

Remove the unnecessary call to validate sps at streaming start.

Suggested-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v4:
- No change

v3:
- New patch

 drivers/staging/media/rkvdec/rkvdec-h264.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
index 8bce8902b8dd..815d5359ddd5 100644
--- a/drivers/staging/media/rkvdec/rkvdec-h264.c
+++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
@@ -1070,17 +1070,6 @@ static int rkvdec_h264_start(struct rkvdec_ctx *ctx)
 	struct rkvdec_dev *rkvdec = ctx->dev;
 	struct rkvdec_h264_priv_tbl *priv_tbl;
 	struct rkvdec_h264_ctx *h264_ctx;
-	struct v4l2_ctrl *ctrl;
-	int ret;
-
-	ctrl = v4l2_ctrl_find(&ctx->ctrl_hdl,
-			      V4L2_CID_STATELESS_H264_SPS);
-	if (!ctrl)
-		return -EINVAL;
-
-	ret = rkvdec_h264_validate_sps(ctx, ctrl->p_new.p_h264_sps);
-	if (ret)
-		return ret;
 
 	h264_ctx = kzalloc(sizeof(*h264_ctx), GFP_KERNEL);
 	if (!h264_ctx)
@@ -1089,8 +1078,8 @@ static int rkvdec_h264_start(struct rkvdec_ctx *ctx)
 	priv_tbl = dma_alloc_coherent(rkvdec->dev, sizeof(*priv_tbl),
 				      &h264_ctx->priv_tbl.dma, GFP_KERNEL);
 	if (!priv_tbl) {
-		ret = -ENOMEM;
-		goto err_free_ctx;
+		kfree(h264_ctx);
+		return -ENOMEM;
 	}
 
 	h264_ctx->priv_tbl.size = sizeof(*priv_tbl);
@@ -1100,10 +1089,6 @@ static int rkvdec_h264_start(struct rkvdec_ctx *ctx)
 
 	ctx->priv = h264_ctx;
 	return 0;
-
-err_free_ctx:
-	kfree(h264_ctx);
-	return ret;
 }
 
 static void rkvdec_h264_stop(struct rkvdec_ctx *ctx)
-- 
2.42.0

