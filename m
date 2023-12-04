Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00D48034BA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbjLDN0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344685AbjLDNZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:25:16 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C71B19BD;
        Mon,  4 Dec 2023 05:24:26 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C56AC6605835;
        Mon,  4 Dec 2023 13:24:24 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701696265;
        bh=yTw2OYKem5rJF2Nwf34/Wc4CllCCaoPD56PNsk9nNiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hmPpJnHV44ms7R4ZV/QZy3iR1p65Sk+Wr8py03hZzLr3LOKclMSekhZhlscj2wTsZ
         EbePD6eaCkrj1bGGTdegy4le6jLK+qdfJcYfajKg4rDs9N2NaUWOwJkbqP0fQ7eq53
         KITflsKQnst6zAVdDortp3a0PSJBjcAwv4P06V+fPHiJevozdvvZ8XVbewacPKVYDG
         U42X1q5747Yn2ebL77qmvZxFnnPfOpK0mQmx+W1O96UWJOSRt6in4kccd1gOZLVlm0
         27hYlEcxjD3Dbp17ksBlQO4VgsFVqbPa6OlIQLf3Giqi+Tb6Lw/9aXl7OkHuAipZyn
         NYfVB72UlPlxw==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v2 31/36] media: starfive: Fix misuse of min_buffers_needed field
Date:   Mon,  4 Dec 2023 14:23:18 +0100
Message-Id: <20231204132323.22811-32-benjamin.gaignard@collabora.com>
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

