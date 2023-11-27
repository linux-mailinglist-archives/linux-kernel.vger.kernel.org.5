Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4244D7FA754
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjK0Q6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjK0Q4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:56:34 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924EB2711;
        Mon, 27 Nov 2023 08:55:42 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E0CCC66073C4;
        Mon, 27 Nov 2023 16:55:40 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701104141;
        bh=PRyjDZo6H5GsqtbpHscthGR2/GFV898HsT1KwjvLl4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cG1bHKwq7A65Ykdw7aja37ljE9yrOfjiA4eY+S7Awyo3OWXNWsPApIX3sKuUcborG
         X08yx6G57GxV8EVnKKYznJdbdWLg7u6ZDA1LXToQc3kRMvxr8t+vKEybtBE0dRqDlV
         TmFSGspRPhaq2pkmakfHZytJVjB55ZkGhMcg6skfw2P/DxgvDOUSr+Cjb81su3PgR4
         18O9aa2wXUkTcCmAeYkGL0vLLjzgWKbvSyaIns+iTnV09V3WBDgcpCfgsSHc0ZVUN2
         zy8sP9CewpvLbu1e7rqJF4+EHInrvXRrbISJ9sw8ja93D68qFmwPwOQLKhM1Tl4rc5
         CR0z2PcbDz23g==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH 46/55] media: pci: tw68: Use min_dma_buffers_needed field
Date:   Mon, 27 Nov 2023 17:54:45 +0100
Message-Id: <20231127165454.166373-47-benjamin.gaignard@collabora.com>
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

tw68 driver use a dma engine and needs a minimum number of
buffers to be present before start streaming.
That is 'min_dma_buffers_needed' purpose so use it instead
of 'min_buffers_needed' field.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/pci/tw68/tw68-video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/tw68/tw68-video.c b/drivers/media/pci/tw68/tw68-video.c
index 79b627ebc92a..b181abe3bfbb 100644
--- a/drivers/media/pci/tw68/tw68-video.c
+++ b/drivers/media/pci/tw68/tw68-video.c
@@ -952,7 +952,7 @@ int tw68_video_init2(struct tw68_dev *dev, int video_nr)
 	dev->vidq.gfp_flags = __GFP_DMA32 | __GFP_KSWAPD_RECLAIM;
 	dev->vidq.buf_struct_size = sizeof(struct tw68_buf);
 	dev->vidq.lock = &dev->lock;
-	dev->vidq.min_buffers_needed = 2;
+	dev->vidq.min_dma_buffers_needed = 2;
 	dev->vidq.dev = &dev->pci->dev;
 	ret = vb2_queue_init(&dev->vidq);
 	if (ret)
-- 
2.39.2

