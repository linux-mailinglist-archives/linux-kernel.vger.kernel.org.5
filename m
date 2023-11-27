Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342CF7FA744
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbjK0Q6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbjK0Q4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:56:24 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CE52697;
        Mon, 27 Nov 2023 08:55:37 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C574866073F3;
        Mon, 27 Nov 2023 16:55:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701104136;
        bh=bUose2Qt+KgGhraI5gHXJBZnW4ioayca0b3t+erw7b4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aOqDp041fs/pryvCPqh+RTEXRELzEfst6tRZ+jEbOhsyU8v46pPm+6fd3zAHprbOq
         A35s2KgzdHp+aDziQP6DY8tzK6kD7PTEHdor/Zt2Hmsi0W+VTtD2zK4TZm7sfnz6nS
         pHxlUtx+jFP1HZW8Md7Q9rcbcbY47k5uB0FYfk1fVOPwG1aLVMndw+tk7cFDJFZA/V
         NhXxe/YWXNjI+/PzHFjfqcKKgcZw5rXPpOHo+imT+3cKnBYNpydTtvy4jgY/eioKBl
         /ZVKZZFXTjBrvLxKz80+7FRpdDung2wZDQv+OkqPLFinUPtUas7k7vdoDoSksCRWY7
         nNkeQgEkaHdlA==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH 39/55] media: ti: omap: Use min_dma_buffers_needed field
Date:   Mon, 27 Nov 2023 17:54:38 +0100
Message-Id: <20231127165454.166373-40-benjamin.gaignard@collabora.com>
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

omap driver use a dma engine and needs a minimum number of
buffers to be present before start streaming.
That is 'min_dma_buffers_needed' purpose so use it instead
of 'min_buffers_needed' field.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/platform/ti/omap/omap_vout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti/omap/omap_vout.c b/drivers/media/platform/ti/omap/omap_vout.c
index 72ce903717d3..0adbdd11e06b 100644
--- a/drivers/media/platform/ti/omap/omap_vout.c
+++ b/drivers/media/platform/ti/omap/omap_vout.c
@@ -1404,7 +1404,7 @@ static int __init omap_vout_setup_video_data(struct omap_vout_device *vout)
 	vq->ops = &omap_vout_vb2_ops;
 	vq->mem_ops = &vb2_dma_contig_memops;
 	vq->lock = &vout->lock;
-	vq->min_buffers_needed = 1;
+	vq->min_dma_buffers_needed = 1;
 	vfd->queue = vq;
 
 	ret = vb2_queue_init(vq);
-- 
2.39.2

