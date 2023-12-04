Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD04803494
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344342AbjLDNYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344307AbjLDNYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:24:06 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0151134;
        Mon,  4 Dec 2023 05:24:08 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 362426607090;
        Mon,  4 Dec 2023 13:24:07 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701696247;
        bh=nXea1hVd1CLJC4QjmTPo1Qmgjq3TpB25wTNYX2076fw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q16SfkSUODOUuv0aRr1a3vsuwi50wG5boYx5dbxzV+1JktEOinEGm2IbRY9SpbKIV
         uM2jMqTnnGkJTXKKIa8mKU7hq6w1abgA7+HUszwqS82ybLLjoXljwQygr7sorOQRB7
         KZwGn6pABnYlJv7ayfvX9QB860fC9ChvBaocsCayHnHRWp4AJE6RWCnPzPBxda0HHt
         vnVWvcjjNz7i1wyRuKe2qbBTVG9/qsj5O/UOfArfMDW43kU60C6gjjfNL3VH36Cp9Y
         BLJsRd8531dND0h9nAJRsyvud+k5/sVWisQpOXTHzV/objUYPOyC4YM4mU6wdBvTA6
         kz5tfeY4HaeOg==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Michael Krufky <mkrufky@linuxtv.org>
Subject: [PATCH v2 18/36] media: usb: dvb-usb: cxusb-analog: Fix misuse of min_buffers_needed field
Date:   Mon,  4 Dec 2023 14:23:05 +0100
Message-Id: <20231204132323.22811-19-benjamin.gaignard@collabora.com>
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
cxusb-analog driver doesn't use DMA engine and just want to specify
the minimum number of buffers to allocate when calling VIDIOC_REQBUFS.
That 'min_reqbufs_allocation' field purpose so use it.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Michael Krufky <mkrufky@linuxtv.org>
---
 drivers/media/usb/dvb-usb/cxusb-analog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/dvb-usb/cxusb-analog.c b/drivers/media/usb/dvb-usb/cxusb-analog.c
index deba5224cb8d..a038d97dd62e 100644
--- a/drivers/media/usb/dvb-usb/cxusb-analog.c
+++ b/drivers/media/usb/dvb-usb/cxusb-analog.c
@@ -1632,7 +1632,7 @@ static int cxusb_medion_register_analog_video(struct dvb_usb_device *dvbdev)
 	cxdev->videoqueue.buf_struct_size =
 		sizeof(struct cxusb_medion_vbuffer);
 	cxdev->videoqueue.timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	cxdev->videoqueue.min_buffers_needed = 6;
+	cxdev->videoqueue.min_reqbufs_allocation = 6;
 	cxdev->videoqueue.lock = &cxdev->dev_lock;
 
 	ret = vb2_queue_init(&cxdev->videoqueue);
-- 
2.39.2

