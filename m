Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558B1803480
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344303AbjLDNYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbjLDNXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:23:52 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71151B8;
        Mon,  4 Dec 2023 05:23:54 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0085F6607090;
        Mon,  4 Dec 2023 13:23:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701696233;
        bh=oOWz24gQ5YvCYqxsrt9/vTKzJDstMTwD0f8jUu4NRTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fpiHlguwrMYeN1mEYBkELVL33tKiT1KR1nwYsrEn7jLbmYp4MWuEE2MQQ89kigGaS
         yiQkxZn5OjeQE6coLIgMLBpL6BUnC8Hxzlg44paOrvCSuKR3YBpPHmPc9zkaHWY4NV
         vU6EeU0+6cVc/8WmEtol8w1LDdFE6uEA5k4yN+zchWyxCK+X+OI/A3ozs8+fJ3hmBK
         ZixewklE7l4VrRbXm1HKQs4N/xwTNfA7icvXNmILAHbE4B/dBzM3N+zDaeAmIwEckF
         GmmQriTDYBxHDpJi4NRMUBVg+itb6l75/d9niz8NrIf3jmVvYh+2SxyAnz1VXzBgx/
         inX3JLYW+QaSg==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>
Subject: [PATCH v2 09/36] media: ipu3: Remove useless setting of min_buffers_needed
Date:   Mon,  4 Dec 2023 14:22:56 +0100
Message-Id: <20231204132323.22811-10-benjamin.gaignard@collabora.com>
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
CC: Sakari Ailus <sakari.ailus@linux.intel.com>
CC: Bingbu Cao <bingbu.cao@intel.com>
CC: Tianshu Qiu <tian.shu.qiu@intel.com>
---
 drivers/staging/media/ipu3/ipu3-v4l2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c b/drivers/staging/media/ipu3/ipu3-v4l2.c
index 0fe2b858da83..7f9104411edc 100644
--- a/drivers/staging/media/ipu3/ipu3-v4l2.c
+++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
@@ -1197,8 +1197,6 @@ static int imgu_v4l2_node_setup(struct imgu_device *imgu, unsigned int pipe,
 			sizeof(struct imgu_vb2_buffer);
 	vbq->buf_struct_size = imgu->buf_struct_size;
 	vbq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	/* can streamon w/o buffers */
-	vbq->min_buffers_needed = 0;
 	vbq->drv_priv = imgu;
 	vbq->lock = &node->lock;
 	r = vb2_queue_init(vbq);
-- 
2.39.2

