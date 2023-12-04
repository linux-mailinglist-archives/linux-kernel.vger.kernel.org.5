Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAAB80349D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344503AbjLDNY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344513AbjLDNYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:24:19 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00410D8;
        Mon,  4 Dec 2023 05:24:15 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 50E6B66072A4;
        Mon,  4 Dec 2023 13:24:14 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701696254;
        bh=q+PBOieh7TUOZfOTD/eax3kPGizf1naDWVCgdVzk/Rg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d+ot2jI04YYP3nNR4UaNzhMsi2OZw+QIwwxMc1qtNVNr2FZVmsM8qk2SnXAwymoiy
         YHFHpH26jUSYcsTSJc6NDNnWsNSvL/vEirCI4D7Vyi4u2d/Mi5y92f3c+qQ0toA4rF
         iaZp4BOWgLaUUYk+DCauT/jaJJc8KTNzBQIfo1XNVjDHfLMkQWDiEV7uXyllW1Pu8S
         F/OQ7P/8s2+syp5bL39Sggb3KDBEcVSC1896Y2CSbVC0VeO8EEaDiFyJ9ETdYGq/ij
         7Zz8sIdixI6XoEX5+pC6Z1c4z2Uh8wMmDQKSoMl2flZjeu0owqGUSp4AOPKQsb2kfy
         6lWfp2P42sW5g==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Jean-Christophe Trotin <jean-christophe.trotin@foss.st.com>
Subject: [PATCH v2 23/36] media: sti: hva: Fix misuse of min_buffers_needed field
Date:   Mon,  4 Dec 2023 14:23:10 +0100
Message-Id: <20231204132323.22811-24-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204132323.22811-1-benjamin.gaignard@collabora.com>
References: <20231204132323.22811-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'min_buffers_needed' is suppose to be used to indicate the number
of buffers needed by DMA engine to start streaming.
hva driver doesn't use DMA engine and just want to specify
the minimum number of buffers to allocate when calling VIDIOC_REQBUFS.
That 'min_reqbufs_allocation' field purpose so use it.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Jean-Christophe Trotin <jean-christophe.trotin@foss.st.com>
---
 drivers/media/platform/st/sti/hva/hva-v4l2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/st/sti/hva/hva-v4l2.c b/drivers/media/platform/st/sti/hva/hva-v4l2.c
index cfe83e9dc01b..d7bc25b0d69e 100644
--- a/drivers/media/platform/st/sti/hva/hva-v4l2.c
+++ b/drivers/media/platform/st/sti/hva/hva-v4l2.c
@@ -1142,7 +1142,7 @@ static int hva_queue_init(void *priv, struct vb2_queue *src_vq,
 
 	src_vq->type = V4L2_BUF_TYPE_VIDEO_OUTPUT;
 	src_vq->buf_struct_size = sizeof(struct hva_frame);
-	src_vq->min_buffers_needed = MIN_FRAMES;
+	src_vq->min_reqbufs_allocation = MIN_FRAMES;
 	src_vq->dev = ctx->hva_dev->dev;
 
 	ret = queue_init(ctx, src_vq);
@@ -1151,7 +1151,7 @@ static int hva_queue_init(void *priv, struct vb2_queue *src_vq,
 
 	dst_vq->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 	dst_vq->buf_struct_size = sizeof(struct hva_stream);
-	dst_vq->min_buffers_needed = MIN_STREAMS;
+	dst_vq->min_reqbufs_allocation = MIN_STREAMS;
 	dst_vq->dev = ctx->hva_dev->dev;
 
 	return queue_init(ctx, dst_vq);
-- 
2.39.2

