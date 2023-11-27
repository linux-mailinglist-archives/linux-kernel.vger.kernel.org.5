Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7E37FA6F5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbjK0Qz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbjK0QzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:55:07 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F7719D;
        Mon, 27 Nov 2023 08:55:13 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 060E66607314;
        Mon, 27 Nov 2023 16:55:11 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701104112;
        bh=bIx0yhKI+ScDV20M08uZHnsyThCdjj2x5yD228Iuuco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lqhg8KZokYkmmqeIECo9Ws1F/frc0ZzueihVGe0Indtr4/7hIh4Tu0gb+qxYqWhQo
         qntkHXlnmpN8OSJSXBXyk1gDKVE2yDegPQuhNR/1Nd1yCmJte94yWf74OKzvXoNfNb
         nTRbBSZ7zJ1PpL+90aSl3GwfrtEUQ1Mh+t5n8bdAFqmOGPQ4p2jnUsIyUCLxah2KQ3
         ywygheN76NPjONpYpI5d+OgDzuMmigh6vPV6ZpY6g5uYJhFLKVyKLeKi3tvxuicqOs
         GL9HQOX9fgqOqWE6TEmn799ggdtawQWQkrxUYTDU5cGeJi3MBteQf9Owr6Ancu2+vu
         XgFhrD89nI40w==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 09/55] media: chips-media: coda: Stop abusing of min_buffers_needed field
Date:   Mon, 27 Nov 2023 17:54:08 +0100
Message-Id: <20231127165454.166373-10-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231127165454.166373-1-benjamin.gaignard@collabora.com>
References: <20231127165454.166373-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'min_buffers_needed' is suppose to be used to indicate the number
of buffers needed by DMA engine to start streaming.
code driver doesn't use DMA engine and just want to specify
the minimum number of buffers to allocate when calling VIDIOC_REQBUFS.
That 'min_reqbufs_allocation' field purpose so use it.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/media/platform/chips-media/coda/coda-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/chips-media/coda/coda-common.c b/drivers/media/platform/chips-media/coda/coda-common.c
index f1d85758f6dd..2b535a31e017 100644
--- a/drivers/media/platform/chips-media/coda/coda-common.c
+++ b/drivers/media/platform/chips-media/coda/coda-common.c
@@ -2546,7 +2546,7 @@ static int coda_queue_init(struct coda_ctx *ctx, struct vb2_queue *vq)
 	 * would need to be reflected in job_ready(). Currently we expect all
 	 * queues to have at least one buffer queued.
 	 */
-	vq->min_buffers_needed = 1;
+	vq->min_reqbufs_allocation = 1;
 	vq->dev = ctx->dev->dev;
 
 	return vb2_queue_init(vq);
-- 
2.39.2

