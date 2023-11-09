Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCE47E6F5A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344778AbjKIQj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343866AbjKIQiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:38:51 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A794237;
        Thu,  9 Nov 2023 08:38:19 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 72BC966076B6;
        Thu,  9 Nov 2023 16:38:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699547898;
        bh=icIEMzQ+RwB59Jl10kDC7CgLWypuqx+VfcABRr9QKPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U40cbzs9hNmHZkWxyQlsq/09wxgfgR/YTwDNOt+AgX02GYgF2NMwzxzYDQ15RZFfi
         YL5LqnoVzitubdhD8xWZVo6H3p1waYq2GTusxC+4b2kMX+4LmqNSJYuIjbPbfYuias
         hjLofx75zEoyYl00J2afyFnUUikv6wwSylZ+G/zCccmsda297EkgBL/5Fl/Wee4737
         Ln/XlJY1YlNvy+fLvqtP005Qpvxegvfs6PGe4JPbRya2XL8VxtheUZNb8swA3XtoQv
         KAPgDbdshNYo8hFwOD8BnRQNIPx3hx6pT7w1rfMPCGj+1Ern9zeJ6p9OIR5TD69CDc
         0rEqslto7iViA==
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
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Joseph Liu <kwliu@nuvoton.com>, Marvin Lin <kflin@nuvoton.com>
Subject: [PATCH v15 36/56] media: nuvoton: Stop direct calls to queue num_buffers field
Date:   Thu,  9 Nov 2023 17:34:52 +0100
Message-Id: <20231109163512.179524-37-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231109163512.179524-14-benjamin.gaignard@collabora.com>
References: <20231109163512.179524-14-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vb2_get_num_buffers() to avoid using queue num_buffers field directly.
This allows us to change how the number of buffers is computed in the
future.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
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

