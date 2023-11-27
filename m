Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E117FA746
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbjK0Q6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbjK0Q4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:56:24 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B171BC;
        Mon, 27 Nov 2023 08:55:38 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 79A6566073FB;
        Mon, 27 Nov 2023 16:55:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701104137;
        bh=71+AtmSDH/h7dLOlV29BkPWy1yXzA9ywoJKq5O/+QVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gQd0qoEaJv55RD/PrXt+M/nrSvjUEquEZ2G5fgA7OMdfJZaDwhH6jBTTLr5QcJolC
         yFnWShT0rf29LNlSkd2gvc/eScBdKzW5La19tsISe+50xLBUNwloLBYWR1EFfuQ09K
         p3oM5Rg2A26IsLuIzOiEo2mSevVNxQr90CQJSzk1EUc+RD4h9stUI7t/GnfW8F4VLk
         AQjtMvKHqqto+zemN7U2/lkzeXukE93ac/XxPqQs50EVnSZcRsplFumvh7PjsAa+SF
         5xgPu331hbJAPLpTeBvIR0HNQFAux32Q/dl616VKWKzHONlienAESESHUFStNjQ3ed
         3wvzKRLBOFQng==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH 40/55] samples: v4l2: pci: Use min_dma_buffers_needed field
Date:   Mon, 27 Nov 2023 17:54:39 +0100
Message-Id: <20231127165454.166373-41-benjamin.gaignard@collabora.com>
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

v4l2 pci skeleton sample driver use a dma engine and
needs a minimum number of buffers to be present before
start streaming.
That is 'min_dma_buffers_needed' purpose so use it instead
of 'min_buffers_needed' field.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 samples/v4l/v4l2-pci-skeleton.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/v4l/v4l2-pci-skeleton.c b/samples/v4l/v4l2-pci-skeleton.c
index a65aa9d1e9da..6018c5e7b3f1 100644
--- a/samples/v4l/v4l2-pci-skeleton.c
+++ b/samples/v4l/v4l2-pci-skeleton.c
@@ -821,7 +821,7 @@ static int skeleton_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * available before it can be started. The start_streaming() op
 	 * won't be called until at least this many buffers are queued up.
 	 */
-	q->min_buffers_needed = 2;
+	q->min_dma_buffers_needed = 2;
 	/*
 	 * The serialization lock for the streaming ioctls. This is the same
 	 * as the main serialization lock, but if some of the non-streaming
-- 
2.39.2

