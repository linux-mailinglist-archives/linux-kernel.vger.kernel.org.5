Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9504C7FA6F8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbjK0Qzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234313AbjK0Qz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:55:26 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40433D62;
        Mon, 27 Nov 2023 08:55:16 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4ABBA66072A4;
        Mon, 27 Nov 2023 16:55:14 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701104114;
        bh=TyWnSNSrmM8e46vPb9QIHFcmc4e6SFgOyK7FFQxtbXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Err5SscROifk648ZJExh4TQcnejZoFk5VctUstRXFW7HD/aTCrbJQJX8ZSLDvvyRL
         MQLLvghzMeFsGURIpqImWeUvuqVd/eyR8Azsb4eHTgSWBKOUcyPuPWfFnhvWe/zshf
         a0DtV3EBKK37x+NgmCtrbbdsIevIEP65WtQyWnxpmnRZq9ZlZ3eemnDf+sWtBRIyCa
         rttpbZsQHyXxXKX2GYv69QEk3eyMnHYeAYyQp/VaT1vJJpl0TRoFihbCrCg1NzoNao
         rFxqDtpQmDWOg0mLYj8078e7FMg89rwT+n01VTwqP2Jy1V9cqPCCXEK006LM0k7fZN
         5qi/QTyW5oC8w==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 12/55] media: rockchip: rkisp1: Stop abusing of min_buffers_needed field
Date:   Mon, 27 Nov 2023 17:54:11 +0100
Message-Id: <20231127165454.166373-13-benjamin.gaignard@collabora.com>
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
rkisp1 driver doesn't use DMA engine and just want to specify
the minimum number of buffers to allocate when calling VIDIOC_REQBUFS.
That 'min_reqbufs_allocation' field purpose so use it.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Dafna Hirschfeld <dafna@fastmail.com> (maintainer:ROCKCHIP ISP V1 DRIVER)
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com> (maintainer:ROCKCHIP ISP V1 DRIVER)
CC: linux-rockchip@lists.infradead.org (open list:ROCKCHIP ISP V1 DRIVER)
---
 drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
index c6d7e01c8949..de3d89b1fac7 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
@@ -1431,7 +1431,7 @@ static int rkisp1_register_capture(struct rkisp1_capture *cap)
 	q->ops = &rkisp1_vb2_ops;
 	q->mem_ops = &vb2_dma_contig_memops;
 	q->buf_struct_size = sizeof(struct rkisp1_buffer);
-	q->min_buffers_needed = RKISP1_MIN_BUFFERS_NEEDED;
+	q->min_reqbufs_allocation = RKISP1_MIN_BUFFERS_NEEDED;
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
 	q->lock = &node->vlock;
 	q->dev = cap->rkisp1->dev;
-- 
2.39.2

