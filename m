Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151C07FA6ED
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbjK0QzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbjK0QzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:55:03 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1688819B;
        Mon, 27 Nov 2023 08:55:10 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6F1FE6607286;
        Mon, 27 Nov 2023 16:55:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701104109;
        bh=cSCDQ8wlrHHxZIMdX6yERM4DP0+7F96unl/YfCpM+80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D7tOhGoZPJaPsvWVJ8Atsd6mk6513xTTrg+4o38gsdrIl/awNv66gZx6u/lM7Mor5
         oAj/uQLEdUP+btCuLOhWctSfo4Sgf3d3ylSPAPamYDjXGJYmxEiHmEKGI/5s66uG6C
         /ABdvLoH/nQunEo7/CoO0uArFNtKbtrPp4a0gRCYvXLeecADD5YVEE3VQ91CJ4Mnlo
         BX4UukdWNVV9zhGeqnuITExTYnjqBTnb7FuhrHLogkE/DTzdcd+P1zvysRrFq4UlrZ
         0wxqEn63/UXygAX7ShNebkQyb1AtQRkzF4gajpJVeK5p24u3aeZHOka7GFPWY412DV
         rUFsMOW1ruqLA==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH 05/55] media: usb: gspca: Stop abusing of min_buffers_needed field
Date:   Mon, 27 Nov 2023 17:54:04 +0100
Message-Id: <20231127165454.166373-6-benjamin.gaignard@collabora.com>
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
gspca driver doesn't use DMA engine and just want to specify
the minimum number of buffers to allocate when calling VIDIOC_REQBUFS.
That 'min_reqbufs_allocation' field purpose so use it.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/usb/gspca/gspca.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/gspca/gspca.c b/drivers/media/usb/gspca/gspca.c
index 770714c34295..7b701275f76d 100644
--- a/drivers/media/usb/gspca/gspca.c
+++ b/drivers/media/usb/gspca/gspca.c
@@ -1257,7 +1257,7 @@ static int vidioc_g_parm(struct file *filp, void *priv,
 {
 	struct gspca_dev *gspca_dev = video_drvdata(filp);
 
-	parm->parm.capture.readbuffers = gspca_dev->queue.min_buffers_needed;
+	parm->parm.capture.readbuffers = gspca_dev->queue.min_reqbufs_allocation;
 
 	if (!gspca_dev->sd_desc->get_streamparm)
 		return 0;
@@ -1273,7 +1273,7 @@ static int vidioc_s_parm(struct file *filp, void *priv,
 {
 	struct gspca_dev *gspca_dev = video_drvdata(filp);
 
-	parm->parm.capture.readbuffers = gspca_dev->queue.min_buffers_needed;
+	parm->parm.capture.readbuffers = gspca_dev->queue.min_reqbufs_allocation;
 
 	if (!gspca_dev->sd_desc->set_streamparm) {
 		parm->parm.capture.capability = 0;
@@ -1517,7 +1517,7 @@ int gspca_dev_probe2(struct usb_interface *intf,
 	q->ops = &gspca_qops;
 	q->mem_ops = &vb2_vmalloc_memops;
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	q->min_buffers_needed = 2;
+	q->min_reqbufs_allocation = 2;
 	q->lock = &gspca_dev->usb_lock;
 	ret = vb2_queue_init(q);
 	if (ret)
-- 
2.39.2

