Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A747FA71B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbjK0Q4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbjK0Qzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:55:53 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5231BF5;
        Mon, 27 Nov 2023 08:55:27 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AA81A66073C8;
        Mon, 27 Nov 2023 16:55:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701104126;
        bh=yTw2OYKem5rJF2Nwf34/Wc4CllCCaoPD56PNsk9nNiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LdlQSF8TUQUtEtQEX4FNz/sBA53t5NMSXGsZ7LoAxMo5zdnlfbOxs1MNTBy1JrjfA
         xCwqsJ/8Kry0SJi3u6Dpp9FextBN6RG6fN9a32XVoqePLvzxR9KiFPS4D2pnePmpRo
         BmypuumCDQykRPHnKSYMKZ3yvhyHoGQMsiGEODDUbc28DDz4RoK1UOiY6oftKGz6fV
         AJv4rNy63G6mMHKUcxHfbHSVhpUYe2irMrL8EOccFCwsWd9nZOmnV3SBpgcSqaswfn
         k7tAGqOsC14HEO1SsGqxPT6+5Tqe3lTwQccVH8KfoH9wUw2pZ/f/LQJzU41nIRDLgb
         Vm6Zkj3oOjoKA==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH 26/55] media: starfive: Stop abusing of min_buffers_needed field
Date:   Mon, 27 Nov 2023 17:54:25 +0100
Message-Id: <20231127165454.166373-27-benjamin.gaignard@collabora.com>
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
starfive driver doesn't use DMA engine and just want to specify
the minimum number of buffers to allocate when calling VIDIOC_REQBUFS.
That 'min_reqbufs_allocation' field purpose so use it.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Jack Zhu <jack.zhu@starfivetech.com>
CC: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/staging/media/starfive/camss/stf-video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/starfive/camss/stf-video.c b/drivers/staging/media/starfive/camss/stf-video.c
index 0b305f21eb53..25038e37e8a6 100644
--- a/drivers/staging/media/starfive/camss/stf-video.c
+++ b/drivers/staging/media/starfive/camss/stf-video.c
@@ -513,7 +513,7 @@ int stf_video_register(struct stfcamss_video *video,
 	q->buf_struct_size = sizeof(struct stfcamss_buffer);
 	q->dev = video->stfcamss->dev;
 	q->lock = &video->q_lock;
-	q->min_buffers_needed = STFCAMSS_MIN_BUFFERS;
+	q->min_reqbufs_allocation = STFCAMSS_MIN_BUFFERS;
 	ret = vb2_queue_init(q);
 	if (ret < 0) {
 		dev_err(video->stfcamss->dev,
-- 
2.39.2

