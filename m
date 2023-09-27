Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5CE7B08D2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbjI0Ph2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjI0Pg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:36:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2636CC9;
        Wed, 27 Sep 2023 08:36:20 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:672:46bd:3ec7:6cdf])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5D3816607358;
        Wed, 27 Sep 2023 16:36:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695828979;
        bh=rFkYvrsLIxo1F3JyDJJ7M8J5xfn6Sk0yrCHC7ra2U7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UL1PKvY4yx9YNzuf5lH5Q42TuvYjDHGe7kVGh+wHFKvVPqP0xI+pQo7L7aJnMxGo+
         7j2e7PS2cNp5bZL+JLaXnO4SoUVSZQnWkHwjAm5chlirOe8ifDhcspba6y9NMys8b1
         Ho4RpziFsEjtJGBRhrribw9cX9LU2y+Z23ZHS8Oe/Hji5Ek5/jwV0c1T+acs0gCLxU
         xnQBnAxp3rIG5mdXZO7sE/LMcDTgvGLiSlWibTdgN54XNUK0mSAkOeTPfD8HO5FTWX
         aTb4GafJz4XZkAXMwwoKXTMt4eswcWia0zid5IS78xLiu1a1oFXZvzwEeLbDqLq3jY
         PmYdpGiKCATKA==
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
Subject: [PATCH v8 25/53] media: pci: cx18: Set correct value to min_buffers_needed field
Date:   Wed, 27 Sep 2023 17:35:30 +0200
Message-Id: <20230927153558.159278-26-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230927153558.159278-1-benjamin.gaignard@collabora.com>
References: <20230927153558.159278-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set queue min_buffers_needed field to 3 and remove the useless
check.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/pci/cx18/cx18-streams.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/media/pci/cx18/cx18-streams.c b/drivers/media/pci/cx18/cx18-streams.c
index 597472754c4c..6ed2c9fb882c 100644
--- a/drivers/media/pci/cx18/cx18-streams.c
+++ b/drivers/media/pci/cx18/cx18-streams.c
@@ -117,13 +117,6 @@ static int cx18_queue_setup(struct vb2_queue *vq,
 	else
 		szimage = cx->cxhdl.height * 720 * 2;
 
-	/*
-	 * Let's request at least three buffers: two for the
-	 * DMA engine and one for userspace.
-	 */
-	if (vq->num_buffers + *nbuffers < 3)
-		*nbuffers = 3 - vq->num_buffers;
-
 	if (*nplanes) {
 		if (*nplanes != 1 || sizes[0] < szimage)
 			return -EINVAL;
@@ -286,7 +279,11 @@ static int cx18_stream_init(struct cx18 *cx, int type)
 		s->vidq.ops = &cx18_vb2_qops;
 		s->vidq.mem_ops = &vb2_vmalloc_memops;
 		s->vidq.timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-		s->vidq.min_buffers_needed = 2;
+		/*
+		 * Let's request at least three buffers: two for the
+		 * DMA engine and one for userspace.
+		 */
+		s->vidq.min_buffers_needed = 3;
 		s->vidq.gfp_flags = GFP_DMA32;
 		s->vidq.dev = &cx->pci_dev->dev;
 		s->vidq.lock = &cx->serialize_lock;
-- 
2.39.2

