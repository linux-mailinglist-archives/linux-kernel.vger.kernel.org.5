Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996E77CFA00
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346123AbjJSMzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345941AbjJSMxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:53:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D352D4B;
        Thu, 19 Oct 2023 05:52:51 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:ccea:1fb5:34eb:239b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 67473660737B;
        Thu, 19 Oct 2023 13:52:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697719969;
        bh=fYtTvMYEVMZXzGkL+XEutCpKu5WEAYjMxFbMl5P4bZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P0nLAvyh9h1vYJMnKnu7cbpE6kQXryHyDcm52/tXf19o39Vbry/bP37nL5Emov07W
         imU1ib+tPfRnIEfMK3lBahbJNV4O/sQSsum4+VFk7R26Nxkx2avq6ZVRn3LeBLFguV
         datRHGSMUs7zEygT+x1GeSBV2EyRDS3Ogzk+3XMBoeqowjmv78e6lW+intgDJFplWK
         H4aap6dgH3erip28CGRT7CW7CtU50sb9PXn6P0aWeMtjub+sWelVZncIskgXeGh5GD
         f9bSaGfBduoUzmFI2IBi/dgyBiOF5WwNGjI3Kb8HMXbm7GS1EtlpifOn3OwVjCx7TH
         lNMcOsasmWfMg==
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
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Joseph Liu <kwliu@nuvoton.com>, Marvin Lin <kflin@nuvoton.com>
Subject: [PATCH v13 36/56] media: nuvoton: Stop direct calls to queue num_buffers field
Date:   Thu, 19 Oct 2023 14:52:02 +0200
Message-Id: <20231019125222.21370-37-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231019125222.21370-1-benjamin.gaignard@collabora.com>
References: <20231019125222.21370-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vb2_get_num_buffers() to avoid using queue num_buffers field directly.
This allows us to change how the number of buffers is computed in the
future.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Joseph Liu <kwliu@nuvoton.com>
CC: Marvin Lin <kflin@nuvoton.com>
---
 drivers/media/platform/nuvoton/npcm-video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/nuvoton/npcm-video.c b/drivers/media/platform/nuvoton/npcm-video.c
index b9e6782f59b4..f9b4e36a5175 100644
--- a/drivers/media/platform/nuvoton/npcm-video.c
+++ b/drivers/media/platform/nuvoton/npcm-video.c
@@ -393,7 +393,7 @@ static void npcm_video_free_diff_table(struct npcm_video *video)
 	struct rect_list *tmp;
 	unsigned int i;
 
-	for (i = 0; i < video->queue.num_buffers; i++) {
+	for (i = 0; i < vb2_get_num_buffers(&video->queue); i++) {
 		head = &video->list[i];
 		list_for_each_safe(pos, nx, head) {
 			tmp = list_entry(pos, struct rect_list, list);
-- 
2.39.2

