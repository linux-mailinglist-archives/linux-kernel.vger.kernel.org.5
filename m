Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5114D7FA75D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbjK0Q6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbjK0Q4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:56:43 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545A72729;
        Mon, 27 Nov 2023 08:55:44 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 451956607415;
        Mon, 27 Nov 2023 16:55:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701104142;
        bh=UHmN7DYDyoab4vSZsrfP/xW1VruJJjAHjGYWzN7yozk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lrj3kg6hVhrAmuJSFfTjyf/6lDbNyCtkyhgOXIk6j/FkIK8Zy0IHpn8WXuTNM14KB
         P05UGZihh9NRifbhDiEiybUbgDx9I7d3stjIqY6pT2oZy3YLQdlMORzYAw4FSTxupT
         Ll9Ho2XdIuhHW/p46IcBIXdhEtlds52vOtgt3HSzQ0mEsDXuQaDGwtbgFPHK+6tGn0
         ukHY+x0HELnnBBOQ94GhhvO5iPk5YGQb6jOefzF+Gc2bJFXwGhA2TkskLxm75isZ9Q
         fTgROk3eaPwKLcpJsMLyvnyjS87YrpjE9EgeQqAldgzhCeROl4gYQJephIk3Zlnwyv
         WFIiXzmPPXV2A==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Bluecherry Maintainers <maintainers@bluecherrydvr.com>,
        Anton Sviridenko <anton@corp.bluecherry.net>,
        Andrey Utkin <andrey.utkin@corp.bluecherry.net>
Subject: [PATCH 48/55] media: pci: tw5864: Use min_dma_buffers_needed field
Date:   Mon, 27 Nov 2023 17:54:47 +0100
Message-Id: <20231127165454.166373-49-benjamin.gaignard@collabora.com>
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

tw5864 driver use a dma engine and needs a minimum number of
buffers to be present before start streaming.
That is 'min_dma_buffers_needed' purpose so use it instead
of 'min_buffers_needed' field.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Bluecherry Maintainers <maintainers@bluecherrydvr.com>
CC: Anton Sviridenko <anton@corp.bluecherry.net>
CC: Andrey Utkin <andrey.utkin@corp.bluecherry.net>
---
 drivers/media/pci/tw5864/tw5864-video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/tw5864/tw5864-video.c b/drivers/media/pci/tw5864/tw5864-video.c
index 197ed8978102..647a57552d4c 100644
--- a/drivers/media/pci/tw5864/tw5864-video.c
+++ b/drivers/media/pci/tw5864/tw5864-video.c
@@ -1114,7 +1114,7 @@ static int tw5864_video_input_init(struct tw5864_input *input, int video_nr)
 	input->vidq.gfp_flags = 0;
 	input->vidq.buf_struct_size = sizeof(struct tw5864_buf);
 	input->vidq.lock = &input->lock;
-	input->vidq.min_buffers_needed = 2;
+	input->vidq.min_dma_buffers_needed = 2;
 	input->vidq.dev = &input->root->pci->dev;
 	ret = vb2_queue_init(&input->vidq);
 	if (ret)
-- 
2.39.2

