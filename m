Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138448034BB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbjLDN0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344478AbjLDNZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:25:29 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8121C1BE1;
        Mon,  4 Dec 2023 05:24:30 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9F272660737C;
        Mon,  4 Dec 2023 13:24:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701696269;
        bh=6CSGRDiRO2lms0wmXZEstJJokqkWndIp5smKK5ehYIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kCooEnmkndIKQN0862GmZwqQIUBTkRANgsq1oGTjWto1LNmPYLRdTfup0Xe/IADHA
         XW6ubO67cr1Ol1bSKaZ0iWVwX4J3DerDiRTM3Qi/cDhtvyeGs2RDVmKGSdfH2euK64
         N/C3juaKclp90MPs/e0oHYFfUuAi4/UCavpliPji0c6iPNf1des2X9QVf1L8TD4SdL
         49kmO1YOK3+iQk7uh7j2BN1b1SU24T/JFfOkHami6tc4tQZvvc/DN8Ha9hBvx6j3JA
         pad2IELQ3EhvWhGBHlCH7N4yOt2O7+FcJJIDwemaR2Y75qX8Y1h9aUeqsBOElvahwX
         BxdUahsQ2IN5Q==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v2 34/36] media: saa7146: Fix misuse of min_buffers_needed field
Date:   Mon,  4 Dec 2023 14:23:21 +0100
Message-Id: <20231204132323.22811-35-benjamin.gaignard@collabora.com>
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
saa7146 driver doesn't use DMA engine and just want to specify
the minimum number of buffers to allocate when calling VIDIOC_REQBUFS.
That 'min_reqbufs_allocation' field purpose so use it.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/common/saa7146/saa7146_fops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/common/saa7146/saa7146_fops.c b/drivers/media/common/saa7146/saa7146_fops.c
index 79214459387a..db4d725a05d4 100644
--- a/drivers/media/common/saa7146/saa7146_fops.c
+++ b/drivers/media/common/saa7146/saa7146_fops.c
@@ -387,7 +387,7 @@ int saa7146_register_device(struct video_device *vfd, struct saa7146_dev *dev,
 	q->gfp_flags = __GFP_DMA32;
 	q->buf_struct_size = sizeof(struct saa7146_buf);
 	q->lock = &dev->v4l2_lock;
-	q->min_buffers_needed = 2;
+	q->min_reqbufs_allocation = 2;
 	q->dev = &dev->pci->dev;
 	err = vb2_queue_init(q);
 	if (err)
-- 
2.39.2

