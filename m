Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E0A7CF9A3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345876AbjJSMx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345755AbjJSMwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:52:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7AB130;
        Thu, 19 Oct 2023 05:52:38 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:ccea:1fb5:34eb:239b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B6B7F660734C;
        Thu, 19 Oct 2023 13:52:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697719957;
        bh=LFTEg/R/Wor/QN2odw5Z+gHhYekb/C2BteTgt/nxpjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DTNGc1iiCyHnMzVXBjmWdOhVXbh9Q+qh0aZx+rDjQw8dNkm/dc7AKnsuotx8dBZJ8
         NF0U1uCUdlYotWfJsbXcE5kZHxKTj/7Dl7s+qvLAxF5OLA2UoSgLD5bXCo+Pign29B
         AhOLH5i2uCQb5ZrhDX9HRLF5v3XZEcTMvtrw8plKTWjZnYVAJlsTZCS6V5l+MLu7ja
         S/VKJCTsj7K51FZmqJGdX2UiVNj9fxrVv6soSPpxTqjTvdWmTtgHmMyJq6q10H0nLT
         KFgRhPN463QQlOwdjRYB1acRAMO8GuPhI/T3k+nQTCkfRZ88wtemuUQg7DSplY7+bx
         6HCx3kNvCgb/w==
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
        Bin Liu <bin.liu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v13 12/56] media: mediatek: vdec: Remove useless loop
Date:   Thu, 19 Oct 2023 14:51:38 +0200
Message-Id: <20231019125222.21370-13-benjamin.gaignard@collabora.com>
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

Simplify code by removing useless loop by using video buffer index.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Bin Liu <bin.liu@mediatek.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>
---
 .../mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c   | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
index e393e3e668f8..69d37b93bd35 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
@@ -1695,13 +1695,8 @@ static int vdec_vp9_slice_setup_core_buffer(struct vdec_vp9_slice_instance *inst
 		return -EINVAL;
 
 	/* update internal buffer's width/height */
-	for (i = 0; i < vq->num_buffers; i++) {
-		if (vb == vq->bufs[i]) {
-			instance->dpb[i].width = w;
-			instance->dpb[i].height = h;
-			break;
-		}
-	}
+	instance->dpb[vb->index].width = w;
+	instance->dpb[vb->index].height = h;
 
 	/*
 	 * get buffer's width/height from instance
-- 
2.39.2

