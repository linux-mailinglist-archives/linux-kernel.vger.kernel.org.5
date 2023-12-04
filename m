Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C209F80347E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344395AbjLDNX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbjLDNXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:23:50 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6A9191;
        Mon,  4 Dec 2023 05:23:52 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1AFAC66071CC;
        Mon,  4 Dec 2023 13:23:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701696231;
        bh=6AlqOx+FFImcfZDLMEeEUovXA4Sft7cnaCjngZduvsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DQGdEJLnbAtvICwkzkiwILiCu5IFwCGI3sKELOnaQ4qA6uN+I1q949usc+7kddK47
         1T1h+qb9y7tP7O6BmnN0dyLk7S3GuIlq0TUdEhECJt6//xOlguCvaPsCk1/urrQFuR
         A99ucfpNWRhBfrlpWCNn7I5kMJPhas7NFwhwsNDNXTyWFGcSnK5yCsCPB7r7CTwIjw
         YahM0Wd0SKKbJ5Z8RPCSvfej+gFaQMyS4JiQ+wy4p72PPBDUwCy5fcg1TzA/jjstM2
         8yf1cVzOjIFQyWvlUv9KRj+Tx9paigAZMVKsM8YhFY9kAVp+4hTyzakBXHulctGw43
         ROG7G9CFiDylg==
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
Subject: [PATCH v2 08/36] media: atmel: Remove useless setting of min_buffers_needed
Date:   Mon,  4 Dec 2023 14:22:55 +0100
Message-Id: <20231204132323.22811-9-benjamin.gaignard@collabora.com>
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

This driver uses min_buffers_needed which vb2 uses to ensure
start_streaming is called when at least 'min_buffers_needed'
buffers are queued. However, this driver doesn't need this,
it can stream fine without any buffers queued.
Just drop this unnecessary restriction.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Eugen Hristev <eugen.hristev@collabora.com>
CC: Nicolas Ferre <nicolas.ferre@microchip.com>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/staging/media/deprecated/atmel/atmel-isc-base.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/media/deprecated/atmel/atmel-isc-base.c b/drivers/staging/media/deprecated/atmel/atmel-isc-base.c
index 468568b5bb7a..c18f3ba5ae1a 100644
--- a/drivers/staging/media/deprecated/atmel/atmel-isc-base.c
+++ b/drivers/staging/media/deprecated/atmel/atmel-isc-base.c
@@ -1871,7 +1871,6 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
 	q->mem_ops		= &vb2_dma_contig_memops;
 	q->timestamp_flags	= V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
 	q->lock			= &isc->lock;
-	q->min_buffers_needed	= 1;
 	q->dev			= isc->dev;
 
 	ret = vb2_queue_init(q);
-- 
2.39.2

