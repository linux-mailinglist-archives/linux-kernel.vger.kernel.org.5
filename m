Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD24803498
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344591AbjLDNYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344363AbjLDNYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:24:10 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB031AE;
        Mon,  4 Dec 2023 05:24:11 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D77A0660711D;
        Mon,  4 Dec 2023 13:24:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701696250;
        bh=CXOqINnxnCzQ6XOL+VA2AacFLu6JKWe+Zb7RZAzp+MY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fV/mbh8dUmW+X/g8KQ7t3JELb3BDz8avVf7Dm8369BUbOvgB0JutS9jE8gjeTI+V1
         TNdX6vEGlQr58xjm3lU7/tIWgx8D0+F5F2ZBkNMIu/StUph9vjP9X0VisVvoPegVd2
         Qs+VRvxh4QvFH8yEXVreJFkdBuR/Zs97K/fH4DdosxLLY8b+scWtWBDDvOrMnWFzhY
         i1irs6Mki1+moB6TTJ2FBozLulIBxnMaoAb8r9//ecrq0nQVKfJsVEYFZrfR0dfYdQ
         TnyUtP6tGvP9vy7vE4tnpLxIu45lcMcq1C9tq+aNBPbreqgLLUTeBhAU98p6vY6cu6
         r08VAWvBGwvfg==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH v2 20/36] media: atmel: Fix misuse of min_buffers_needed field
Date:   Mon,  4 Dec 2023 14:23:07 +0100
Message-Id: <20231204132323.22811-21-benjamin.gaignard@collabora.com>
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
atmel-isi driver doesn't use DMA engine and just want to specify
the minimum number of buffers to allocate when calling VIDIOC_REQBUFS.
That 'min_reqbufs_allocation' field purpose so use it.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Eugen Hristev <eugen.hristev@collabora.com>
CC: Mauro Carvalho Chehab <mchehab@kernel.org>
CC: Nicolas Ferre <nicolas.ferre@microchip.com>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/media/platform/atmel/atmel-isi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/atmel/atmel-isi.c b/drivers/media/platform/atmel/atmel-isi.c
index da58f33b6b0a..9c156771568a 100644
--- a/drivers/media/platform/atmel/atmel-isi.c
+++ b/drivers/media/platform/atmel/atmel-isi.c
@@ -1244,7 +1244,7 @@ static int atmel_isi_probe(struct platform_device *pdev)
 	q->ops = &isi_video_qops;
 	q->mem_ops = &vb2_dma_contig_memops;
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	q->min_buffers_needed = 2;
+	q->min_reqbufs_allocation = 2;
 	q->dev = &pdev->dev;
 
 	ret = vb2_queue_init(q);
-- 
2.39.2

