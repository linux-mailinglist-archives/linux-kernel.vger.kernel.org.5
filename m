Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2988037BF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjLDO4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344413AbjLDNYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:24:52 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0E919A9;
        Mon,  4 Dec 2023 05:24:25 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 517856607090;
        Mon,  4 Dec 2023 13:24:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701696264;
        bh=ORlm67uM5fv255axUnsY7LF5+NRgLL1FXRZ/tIF2QjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pbi5bF6Y+KYs5YKI1S/bwWzcWq4rEoIhjVQhuizPnCrVxvAqKlVVQMhzVzTsHJHmQ
         LKxFor4iEZQHTxyGhn0BShMXGrQ+3+y+ee2miBCFH/cDiri2bhznfEFF0pInt9NmnW
         Ckr931qgtWKEBNvnTKolamn58mHqDp8QfNYKLjxrUGYLIQcFSu9aK6tEuaffTXB0Vn
         TX6+KEepBNhnRil5YxfJeTUjF4qZu2WrVqXe914jnFcbVJLlfb/Bh7sDb2IVRXgOEA
         5LTa+NFAfKJkvyH78BRkN5iNMt9cXsIkRng3oYaRzh11tpPmVfydCXV0h2R7hGZAa/
         0GTS4JiMTnFkA==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH v2 30/36] media: imx: Fix misuse of min_buffers_needed field
Date:   Mon,  4 Dec 2023 14:23:17 +0100
Message-Id: <20231204132323.22811-31-benjamin.gaignard@collabora.com>
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
imx-media-capture driver doesn't use DMA engine and just want to specify
the minimum number of buffers to allocate when calling VIDIOC_REQBUFS.
That 'min_reqbufs_allocation' field purpose so use it.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Steve Longerbeam <slongerbeam@gmail.com>
CC: Philipp Zabel <p.zabel@pengutronix.de>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Shawn Guo <shawnguo@kernel.org>
CC: Sascha Hauer <s.hauer@pengutronix.de>
CC: Pengutronix Kernel Team <kernel@pengutronix.de>
CC: Fabio Estevam <festevam@gmail.com>
CC: NXP Linux Team <linux-imx@nxp.com>
---
 drivers/staging/media/imx/imx-media-capture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/imx/imx-media-capture.c b/drivers/staging/media/imx/imx-media-capture.c
index ce02199e7b1b..5bb1ebd35d89 100644
--- a/drivers/staging/media/imx/imx-media-capture.c
+++ b/drivers/staging/media/imx/imx-media-capture.c
@@ -1022,7 +1022,7 @@ imx_media_capture_device_init(struct device *dev, struct v4l2_subdev *src_sd,
 	vq->mem_ops = &vb2_dma_contig_memops;
 	vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
 	vq->lock = &priv->mutex;
-	vq->min_buffers_needed = 2;
+	vq->min_reqbufs_allocation = 2;
 	vq->dev = priv->dev;
 
 	ret = vb2_queue_init(vq);
-- 
2.39.2

