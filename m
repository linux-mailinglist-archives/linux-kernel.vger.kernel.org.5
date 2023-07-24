Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28E375E8CE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjGXBoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjGXBmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:42:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2D61FD0;
        Sun, 23 Jul 2023 18:37:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C76F60FEB;
        Mon, 24 Jul 2023 01:33:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060D5C433CA;
        Mon, 24 Jul 2023 01:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162409;
        bh=Jvoyff3+lkkFDN9MNw04Er4FwMpJ+BwfhJF/72Rgq9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bib44dlqG/6UOsvFgpUKas/JDwqJI7BMP8CyWep0+dIBQStOmPawX9nEmSAYR1cx3
         Zplh+50PjxvRmo1RTZ5vb2nDhLGhmynpL2/W/3bRhhEkipA9kEN82royI7rKzwCUAq
         GCRb6JrR2gN6VoM6eEkF+a9wMeBTzjLAlA7GiO57DlUwWbBY1I9oFbaBa8rUtLe///
         J5TJUvCfHHcajJxpXKEcAHRCPLjgdRTtoTh7njqUJgLl/MJT2PP2oTyIKrXwtGG86Q
         X17z8pjGVz7N1o0TM4mhYkuF6F63eWMAFQ3iymEtIKWaAKXGkYINgujWwG30bvi2kr
         asu2nXj+FItjQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrey Konovalov <andrey.konovalov@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 02/24] media: camss: set VFE bpl_alignment to 16 for sdm845 and sm8250
Date:   Sun, 23 Jul 2023 21:33:03 -0400
Message-Id: <20230724013325.2332084-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013325.2332084-1-sashal@kernel.org>
References: <20230724013325.2332084-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.121
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
index e0f3a36f3f3f9..2cfd1edc53956 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -1573,7 +1573,11 @@ int msm_vfe_register_entities(struct vfe_device *vfe,
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

