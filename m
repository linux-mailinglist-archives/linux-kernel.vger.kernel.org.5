Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC42E7B528F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237190AbjJBMHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236928AbjJBMGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:06:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529F1D7;
        Mon,  2 Oct 2023 05:06:38 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:9537:67ca:c85e:d0ae])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B7CEC66072E6;
        Mon,  2 Oct 2023 13:06:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696248397;
        bh=rkThknrqAdahL7+ESWJTTDJdizQjBtgRoFGagWtq+LE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gDvuJr0Yln1s0Fg3NmCkxvR/G8gewdO494eLn2gB1PDHl5nkzve6X5KbuBnoZquFo
         Uz4kYKYVfkIMT4b4tk5tKVvpGJ+Aagug2isCedZOUUPlwna9Hz14cncfuyLF9d2cQ/
         XpocK5lVt/N6mqR4HWxLiZJlwZOYxW3UZSdbQd+dTcWOcGJYvu57PiLVDwATPRhL/s
         IKHASWKdsqdlfXegI0bkZLzCKZ5czfYP7RGEa6uDRoj0gPDArWuMwLWG/bqOGY9WZY
         4LHmHcA9Yn9DCGk34X4hlT7a3JbKrkPxI3RlnyahPIYonkIr17uArVDwHqSK8j4Lp9
         3R0mu/kBRynmg==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v9 23/53] media: dvb-frontends: rtl2832_srd: Use queue min_buffers_needed field
Date:   Mon,  2 Oct 2023 14:05:47 +0200
Message-Id: <20231002120617.119602-24-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231002120617.119602-1-benjamin.gaignard@collabora.com>
References: <20231002120617.119602-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

queue_setup checks for a minimum number of buffers so use queue
min_buffers_needed field and remove the check done in
rtl2832_sdr_queue_setup().

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/dvb-frontends/rtl2832_sdr.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/media/dvb-frontends/rtl2832_sdr.c b/drivers/media/dvb-frontends/rtl2832_sdr.c
index 02c619e51641..597b1548ed8b 100644
--- a/drivers/media/dvb-frontends/rtl2832_sdr.c
+++ b/drivers/media/dvb-frontends/rtl2832_sdr.c
@@ -440,14 +440,9 @@ static int rtl2832_sdr_queue_setup(struct vb2_queue *vq,
 	struct rtl2832_sdr_dev *dev = vb2_get_drv_priv(vq);
 	struct platform_device *pdev = dev->pdev;
 
-	dev_dbg(&pdev->dev, "nbuffers=%d\n", *nbuffers);
-
-	/* Need at least 8 buffers */
-	if (vq->num_buffers + *nbuffers < 8)
-		*nbuffers = 8 - vq->num_buffers;
 	*nplanes = 1;
 	sizes[0] = PAGE_ALIGN(dev->buffersize);
-	dev_dbg(&pdev->dev, "nbuffers=%d sizes[0]=%d\n", *nbuffers, sizes[0]);
+	dev_dbg(&pdev->dev, "nbuffers=%d sizes[0]=%d\n", vb2_get_num_buffers(vq), sizes[0]);
 	return 0;
 }
 
@@ -1364,6 +1359,8 @@ static int rtl2832_sdr_probe(struct platform_device *pdev)
 	dev->vb_queue.ops = &rtl2832_sdr_vb2_ops;
 	dev->vb_queue.mem_ops = &vb2_vmalloc_memops;
 	dev->vb_queue.timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
+	/* Need at least 8 buffers */
+	dev->vb_queue.min_buffers_needed = 8;
 	ret = vb2_queue_init(&dev->vb_queue);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not initialize vb2 queue\n");
-- 
2.39.2

