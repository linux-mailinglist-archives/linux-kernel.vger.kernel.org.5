Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E277FA72E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbjK0Q5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbjK0Qz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:55:58 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09A51FE0;
        Mon, 27 Nov 2023 08:55:30 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0844F66073D7;
        Mon, 27 Nov 2023 16:55:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701104129;
        bh=3CZsTTbHLtC5vyOvtssRJvLsPSp78mQlLUyr4UEzOZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EYVQNlDhTIxKDHnmG/Ekj99JD5kgVrukW22yr4FR3JKkFJU6WKYy2ELTie1khIxEW
         KyelEo7dOIjQRLCscyLgl3qFCVbux/fWK6ENMHTGzu0FdhiHrjucE1mvsXbMhWrGzL
         LGJ93g37lbE/Ky/0csRdacUDH2wGwJVi5FqvGJAl7Sy8EP2BoVrPew50Mmy29YMfN4
         f7sDclJ3eyLKuP1Y7CHuq8iCBxqYBq9Cscoq7sAviNjetQpcbbBMizPSZev3xtnJBr
         T5IRo07rQWHE7usTvfd22nmZLmkOOGz86nuXUa8Y+evAoKVBarFSMqYIUBDH1HuSky
         8/lu3VxwGRZ9A==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Benoit Parrot <bparrot@ti.com>
Subject: [PATCH 30/55] media: ti: cal: Stop abusing of min_buffers_needed field
Date:   Mon, 27 Nov 2023 17:54:29 +0100
Message-Id: <20231127165454.166373-31-benjamin.gaignard@collabora.com>
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
Cal driver doesn't use DMA engine and just want to specify
the minimum number of buffers to allocate when calling VIDIOC_REQBUFS.
That 'min_reqbufs_allocation' field purpose so use it.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Benoit Parrot <bparrot@ti.com>
---
 drivers/media/platform/ti/cal/cal-video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti/cal/cal-video.c b/drivers/media/platform/ti/cal/cal-video.c
index e1c5e68e945b..04709dac7221 100644
--- a/drivers/media/platform/ti/cal/cal-video.c
+++ b/drivers/media/platform/ti/cal/cal-video.c
@@ -1010,7 +1010,7 @@ int cal_ctx_v4l2_init(struct cal_ctx *ctx)
 	q->mem_ops = &vb2_dma_contig_memops;
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
 	q->lock = &ctx->mutex;
-	q->min_buffers_needed = 3;
+	q->min_reqbufs_allocation = 3;
 	q->dev = ctx->cal->dev;
 
 	ret = vb2_queue_init(q);
-- 
2.39.2

