Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC397FA6EA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbjK0QzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbjK0QzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:55:02 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81371B5;
        Mon, 27 Nov 2023 08:55:08 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0450966071A9;
        Mon, 27 Nov 2023 16:55:06 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701104107;
        bh=RQZKjikW6Ece6fRgXGbXCqiDnEcXizem8w9dbLVAl84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h6HUoXxAS1RaL+324Vn+8xbiV+Lrc6tIB616nDIi1Bub1y5qVeNdc0RS27ndLvP4A
         pGhpZhy6/Fqzlu7mAHYip/0Uz6aOMChuuHMzQTnbNTI3yTuDV4KcuRWWgqcbovk4jD
         MgYnYbWeAeXOBIu4NSATm8wEf0IOdyfT8ltNcz8FrSOQl6x4bGrH5ouLTjHK0hlbIV
         yGZflYB0oOw2UXATQS6pPpRmIgWJx7Wf6WTNq+U+GsnwoC60DW780Xv6IUtdWHQSBc
         M9i7fZN1QAB/yAOzvw4dhleXlTfl3qdwkmEZmxgyfPgrsstKehbQnWGRS8NnXQ1q+t
         ZFsITfwPpSeDg==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH 03/55] media: usb: cx231xx: Stop abusing of min_buffers_needed field
Date:   Mon, 27 Nov 2023 17:54:02 +0100
Message-Id: <20231127165454.166373-4-benjamin.gaignard@collabora.com>
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
cx231xx driver doesn't use DMA engine and just want to specify
the minimum number of buffers to allocate when calling VIDIOC_REQBUFS.
That 'min_reqbufs_allocation' field purpose so use it.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/usb/cx231xx/cx231xx-417.c   | 2 +-
 drivers/media/usb/cx231xx/cx231xx-video.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/cx231xx/cx231xx-417.c b/drivers/media/usb/cx231xx/cx231xx-417.c
index 45973fe690b2..66043ed50c8e 100644
--- a/drivers/media/usb/cx231xx/cx231xx-417.c
+++ b/drivers/media/usb/cx231xx/cx231xx-417.c
@@ -1782,7 +1782,7 @@ int cx231xx_417_register(struct cx231xx *dev)
 	q->ops = &cx231xx_video_qops;
 	q->mem_ops = &vb2_vmalloc_memops;
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	q->min_buffers_needed = 1;
+	q->min_reqbufs_allocation = 1;
 	q->lock = &dev->lock;
 	err = vb2_queue_init(q);
 	if (err)
diff --git a/drivers/media/usb/cx231xx/cx231xx-video.c b/drivers/media/usb/cx231xx/cx231xx-video.c
index c8eb4222319d..df572c466bfb 100644
--- a/drivers/media/usb/cx231xx/cx231xx-video.c
+++ b/drivers/media/usb/cx231xx/cx231xx-video.c
@@ -1811,7 +1811,7 @@ int cx231xx_register_analog_devices(struct cx231xx *dev)
 	q->ops = &cx231xx_video_qops;
 	q->mem_ops = &vb2_vmalloc_memops;
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	q->min_buffers_needed = 1;
+	q->min_reqbufs_allocation = 1;
 	q->lock = &dev->lock;
 	ret = vb2_queue_init(q);
 	if (ret)
@@ -1871,7 +1871,7 @@ int cx231xx_register_analog_devices(struct cx231xx *dev)
 	q->ops = &cx231xx_vbi_qops;
 	q->mem_ops = &vb2_vmalloc_memops;
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	q->min_buffers_needed = 1;
+	q->min_reqbufs_allocation = 1;
 	q->lock = &dev->lock;
 	ret = vb2_queue_init(q);
 	if (ret)
-- 
2.39.2

