Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78797FA722
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbjK0Q45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbjK0Q4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:56:16 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA73212C;
        Mon, 27 Nov 2023 08:55:35 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 75AB7660737B;
        Mon, 27 Nov 2023 16:55:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701104134;
        bh=X02tzOo2kO6Xf8Mm3XO+fdYdi1NrT5mrpTJUnhqGe4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SYacJ+X5qY1brq6yAX2v6Zh8vkADiRh6fL5ssu4J7Myr/+F2ok5EzyvDWTgMHHjXP
         5zzfGnbfATjw9t+mQdXymhiV3mymtoeLiX65T3m8+Ae4xllQeIw6OFIgIeSqC1NSzn
         dbhT00XGtQ+nld5mStG1N0pyys73Mse09oS0sERTP7WakGbDOcD4bjJEPnjWZ/NJ7y
         Gor0tI48ojqW9MVdR4Al0vXf/6SiknsCV8AFr179BFApBGgQUjqxKUFHRGZtC/PScq
         9FbmTemR64ciabk44Ke+awxocJzpI59XYNQVsAv4rhwe4vkrNSdaZJSSvCkpQR6meB
         0UY/Dv//MyFIQ==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Hugues Fruchet <hugues.fruchet@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 36/55] media: stm32: stm32-dcmi: Use min_dma_buffers_needed field
Date:   Mon, 27 Nov 2023 17:54:35 +0100
Message-Id: <20231127165454.166373-37-benjamin.gaignard@collabora.com>
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

smt32-dcmi driver use a dma engine and needs a minimum number of
buffers to be present before start streaming.
That is 'min_dma_buffers_needed' purpose so use it instead
of 'min_buffers_needed' field.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Hugues Fruchet <hugues.fruchet@foss.st.com>
CC: linux-stm32@st-md-mailman.stormreply.com
---
 drivers/media/platform/st/stm32/stm32-dcmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/st/stm32/stm32-dcmi.c b/drivers/media/platform/st/stm32/stm32-dcmi.c
index 48140fdf40bb..a267fdcbe886 100644
--- a/drivers/media/platform/st/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/st/stm32/stm32-dcmi.c
@@ -2031,7 +2031,7 @@ static int dcmi_probe(struct platform_device *pdev)
 	q->ops = &dcmi_video_qops;
 	q->mem_ops = &vb2_dma_contig_memops;
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	q->min_buffers_needed = 2;
+	q->min_dma_buffers_needed = 2;
 	q->allow_cache_hints = 1;
 	q->dev = &pdev->dev;
 
-- 
2.39.2

