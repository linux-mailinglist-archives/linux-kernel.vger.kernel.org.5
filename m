Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB7175E863
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjGXBkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjGXBkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:40:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28F044BE;
        Sun, 23 Jul 2023 18:35:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A5C760FCE;
        Mon, 24 Jul 2023 01:32:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56583C433C7;
        Mon, 24 Jul 2023 01:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162365;
        bh=AbFeG+jIWhUCdVnnm9TchTKYRxC386D0TsnkIcflR+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JYTu8Jy9L878BPbfpgocX560hy13NCp3nkPYoa9vl/bnxsL6/XbJUN3Ly9r82w0dm
         OEUN2w4Ir8R9knlMfeTc9qbkBeqrj+ZA+6zagXZphgUKDuwOoLHZLLXoYVKYutje4i
         vMR5K6fzh+xwEMl7WP5pGU4cQ5oAvNUDDXvLM96Hmuap3wKPAdvDOLqj1ShoY3D0b0
         tiSeNiZnmcN23TJF1cBVKFW+8jTZzMphxS/T2/AxLkG90oY16o9Lrqnq/85bCMXyFW
         Mig7EgBOGzGyef1kJw7PY2puUMtOzJZW2bMz2an1Bc1EO48HypJ4qMSr9zYQOF37Y7
         eIhl2M9JVZS+g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrey Konovalov <andrey.konovalov@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 04/34] media: camss: set VFE bpl_alignment to 16 for sdm845 and sm8250
Date:   Sun, 23 Jul 2023 21:32:07 -0400
Message-Id: <20230724013238.2329166-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013238.2329166-1-sashal@kernel.org>
References: <20230724013238.2329166-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.40
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andrey.konovalov@linaro.org>

[ Upstream commit d5b7eb477c286f6ceccbb38704136eea0e6b09ca ]

From the experiments with camera sensors using SGRBG10_1X10/3280x2464 and
SRGGB10_1X10/3280x2464 formats, it becomes clear that on sdm845 and sm8250
VFE outputs the lines padded to a length multiple of 16 bytes. As in the
current driver the value of the bpl_alignment is set to 8 bytes, the frames
captured in formats with the bytes-per-line value being not a multiple of
16 get corrupted.

Set the bpl_alignment of the camss video output device to 16 for sdm845 and
sm8250 to fix that.

Signed-off-by: Andrey Konovalov <andrey.konovalov@linaro.org>
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/camss/camss-vfe.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index a26e4a5d87b6b..d8cd9b09c20de 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -1540,7 +1540,11 @@ int msm_vfe_register_entities(struct vfe_device *vfe,
 		}
 
 		video_out->ops = &vfe->video_ops;
-		video_out->bpl_alignment = 8;
+		if (vfe->camss->version == CAMSS_845 ||
+		    vfe->camss->version == CAMSS_8250)
+			video_out->bpl_alignment = 16;
+		else
+			video_out->bpl_alignment = 8;
 		video_out->line_based = 0;
 		if (i == VFE_LINE_PIX) {
 			video_out->bpl_alignment = 16;
-- 
2.39.2

