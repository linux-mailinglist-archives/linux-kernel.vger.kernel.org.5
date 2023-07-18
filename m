Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFF57576E1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbjGRImc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbjGRIm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:42:27 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD589ED
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:42:24 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3142a9ff6d8so5506819f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1689669743; x=1692261743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsS2Iaqm2U2paaIACaH5afuQDHJxmglgO9qoIKv0pEA=;
        b=MBDlFtSo/of5p9ZelE58JuefVNUOWIvorbrubSBnVW4BlQlEH6Mw/KO3D5xPrkLvV5
         SjCuvySBuxskdiacTSqHZE8FtqlTrzKsQH9dwejWswvEPK+E7O3uUrOkn2z+FLnn1xTV
         ndrxQtNgjWwsrEnkBQ+OfMy0U3OKdZ/0rVTDmFAmm9mOV96oobm6vISd/bBza2cfkgt2
         KjVkpasRnlhtPSLCF+HNi8EX/OOEHqjQSm4xD84sqxLv6ofaMfcCMw4LQyFTJWH4pYNh
         xPWmNsAQ+HUkVDnjMgqRhxpkJ9/Cu3azqGoEUrFTZ+afcCeFdxF4ZMJi8K8Ef0M/07wU
         1cHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689669743; x=1692261743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsS2Iaqm2U2paaIACaH5afuQDHJxmglgO9qoIKv0pEA=;
        b=VdtENfgFLMTq954huJtctLh76NQMz0LSUBRzvCEtwFa8S2ueQmWniuyvhU40Oyo/AP
         f/JxgnY7iPVVXOiSZAFt7TtgvESx5OB1V0pxlb6JcOiFXrVzvc2w3Gjlo2AsBXcvLD0g
         5rrL0kbAM9D+qTP8poIyC7IlwehjBomvYNITsTse564PvhqDn1kf+qTGiSsvIzsuRAjL
         iTk8UMRMaUyAcNcaKQn9Wm6J+CPppdvQI/MRf9hBjNWm7P6ohvtUeOIBH/JHyylFuv/3
         qaUlWcnJG+VuLJyHDZbsduyc8UXdQRPVZzEmTGhz9zIv/K2AZUOQ99ZHHIm26RCYvT92
         f/wA==
X-Gm-Message-State: ABy/qLZwRoLGueFX+ZRmm4jFo3H3TxR9qMzXaapnvlBI6LcUqe6TTcUJ
        PVpx7shZIDfNQD8qGUVDrPJPwLckdRI/bFTPSHo=
X-Google-Smtp-Source: APBJJlHTgcBHE/VSkW3ZfuCIg9Ibg4GpA1UxvEWc9NATxNplSnsgVIZFa9W55MLD+FD0CzX/38W9Ug==
X-Received: by 2002:a5d:68c6:0:b0:313:ef93:925a with SMTP id p6-20020a5d68c6000000b00313ef93925amr11695801wrw.24.1689669742696;
        Tue, 18 Jul 2023 01:42:22 -0700 (PDT)
Received: from neptune.lan ([188.27.131.236])
        by smtp.gmail.com with ESMTPSA id a1-20020adffac1000000b003143ac73fd0sm1751233wrs.1.2023.07.18.01.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 01:42:22 -0700 (PDT)
From:   Alexandru Ardelean <alex@shruggie.ro>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     bogdan.togorean@analog.com, nuno.sa@analog.com, daniel@ffwll.ch,
        airlied@gmail.com, jonas@kwiboo.se,
        Laurent.pinchart@ideasonboard.com, rfoss@kernel.org,
        neil.armstrong@linaro.org, andrzej.hajda@intel.com,
        festevam@gmail.com, Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH v3] drm: adv7511: Fix low refresh rate register for ADV7533/5
Date:   Tue, 18 Jul 2023 11:42:15 +0300
Message-ID: <20230718084215.12767-1-alex@shruggie.ro>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20190716131005.761-1-bogdan.togorean@analog.com>
References: <20190716131005.761-1-bogdan.togorean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bogdan Togorean <bogdan.togorean@analog.com>

For ADV7533 and ADV7535 low refresh rate is selected using
bits [3:2] of 0x4a main register.
So depending on ADV model write 0xfb or 0x4a register.

Fixes: 2437e7cd88e8 ("drm/bridge: adv7533: Initial support for ADV7533")
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
---

Changelog v2 -> v3:
* https://lore.kernel.org/dri-devel/1c3fde3a873b0f948d3c4d37107c5bb67dc9f7bb.camel@gmail.com/T/#u
* Added my S-o-b tag back

Changelog v1 -> v2:
* https://lore.kernel.org/dri-devel/20190716131005.761-1-bogdan.togorean@analog.com/
* added Fixes: tag
* added Reviewed-by: tag for Nuno


 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index ddceafa7b637..09290a377957 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -786,8 +786,13 @@ static void adv7511_mode_set(struct adv7511 *adv7511,
 	else
 		low_refresh_rate = ADV7511_LOW_REFRESH_RATE_NONE;
 
-	regmap_update_bits(adv7511->regmap, 0xfb,
-		0x6, low_refresh_rate << 1);
+	if (adv7511->type == ADV7511)
+		regmap_update_bits(adv7511->regmap, 0xfb,
+			0x6, low_refresh_rate << 1);
+	else
+		regmap_update_bits(adv7511->regmap, 0x4a,
+			0xc, low_refresh_rate << 2);
+
 	regmap_update_bits(adv7511->regmap, 0x17,
 		0x60, (vsync_polarity << 6) | (hsync_polarity << 5));
 
-- 
2.41.0

