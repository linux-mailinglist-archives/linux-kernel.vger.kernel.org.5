Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05A87FA741
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbjK0Q57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbjK0Q4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:56:21 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161632689;
        Mon, 27 Nov 2023 08:55:36 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 10CF3660732E;
        Mon, 27 Nov 2023 16:55:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701104135;
        bh=+QiW4+PKMpn2QOF9ET7fPoqeBffKw0nbwvNL+3C6ds0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d5k8un7Z4Qh5e/OGB9kL3m0OUr76zb73WO5lo60s/dRut7VkUohGVMUPd76SkojDB
         QQeeHKv8AGcKmyEhuPhxffYBlVBY+uq+No1fxE8S0EFp/7X2bJo7c/2a6iyhmf2JJl
         PRn3rcCY7uZ8JQMC0BBZjA0ZKXxkBMcDvhztqel1YmVdNWTjk9jw2AqvS/kZZuDE7P
         hdSRxbOF7g0ZcEcDv0njaD9jtbLTJHmWt7l5H1PWMAnaHCN2buGJLHfzZoL8SZwvwp
         BHeTczCoV+xl60d9M5YcqyaXzBOpF1nR0yI9xAQTgFoEwxGSpN1X2XNBVWrgPykaZm
         U4T7u6KX2KF4w==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Jai Luthra <j-luthra@ti.com>
Subject: [PATCH 38/55] media: ti: j721e-csi2rx: Use min_dma_buffers_needed field
Date:   Mon, 27 Nov 2023 17:54:37 +0100
Message-Id: <20231127165454.166373-39-benjamin.gaignard@collabora.com>
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

j721e-csi2rx driver use a dma engine and needs a minimum number of
buffers to be present before start streaming.
That is 'min_dma_buffers_needed' purpose so use it instead
of 'min_buffers_needed' field.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Jai Luthra <j-luthra@ti.com>
---
 drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
index ada61391c8d2..55e843419eb9 100644
--- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
+++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
@@ -873,7 +873,7 @@ static int ti_csi2rx_init_vb2q(struct ti_csi2rx_dev *csi)
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
 	q->dev = dmaengine_get_dma_device(csi->dma.chan);
 	q->lock = &csi->mutex;
-	q->min_buffers_needed = 1;
+	q->min_dma_buffers_needed = 1;
 
 	ret = vb2_queue_init(q);
 	if (ret)
-- 
2.39.2

