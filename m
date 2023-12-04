Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBDF803483
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344357AbjLDNYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344350AbjLDNXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:23:55 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E94D4B;
        Mon,  4 Dec 2023 05:23:56 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A5222660711D;
        Mon,  4 Dec 2023 13:23:54 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701696235;
        bh=INhnWKxfeyDOt5+MSDz9mj1pvx9+8U4kzLbB8RirFts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R1cyr0Cz6N9zmXvAIXxoYllx2wyLKTZZi4UYPUCpchQiqpZuk7NPNTzz3K3ba6nGW
         U65GelxmN6oDuAemsPWzYSVsdMZ5L5VpLjLgHzafY7hXTt1Bfd6rpAJ3+OMe0nAhSV
         LvPfgrilMfXz+gqfJCoeX4RMCHXmpkC2oC/mSQkTw8iCrgP3KTz2BTKby2C0kBTPeo
         /iRGBvglcJwdnpUDyyTsp0gY1cdgwlANhHhT2akrKRbVaNGNQpVicR/3xKaXRDAn9E
         qcYRl+2pZAfgnqhozV1MrzMUmc/9uk/eCDUre8aw4G14HthQUetSCFgnjGchc2GRhl
         rHRWGCFHaQ1cg==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Subject: [PATCH v2 10/36] media: ti: am437x: Remove useless setting of min_buffers_needed
Date:   Mon,  4 Dec 2023 14:22:57 +0100
Message-Id: <20231204132323.22811-11-benjamin.gaignard@collabora.com>
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
CC: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
---
 drivers/media/platform/ti/am437x/am437x-vpfe.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/ti/am437x/am437x-vpfe.c b/drivers/media/platform/ti/am437x/am437x-vpfe.c
index f18acf9286a2..228920450e7a 100644
--- a/drivers/media/platform/ti/am437x/am437x-vpfe.c
+++ b/drivers/media/platform/ti/am437x/am437x-vpfe.c
@@ -2234,7 +2234,6 @@ static int vpfe_probe_complete(struct vpfe_device *vpfe)
 	q->buf_struct_size = sizeof(struct vpfe_cap_buffer);
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
 	q->lock = &vpfe->lock;
-	q->min_buffers_needed = 1;
 	q->dev = vpfe->pdev;
 
 	err = vb2_queue_init(q);
-- 
2.39.2

