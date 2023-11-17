Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEB27EEF16
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345959AbjKQJnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345784AbjKQJnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:43:21 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A787199D;
        Fri, 17 Nov 2023 01:42:53 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 27FDE6607390;
        Fri, 17 Nov 2023 09:42:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700214172;
        bh=P8X/98SRN6b58tyqRku7rqXinlOozOu5V7sRiK56qy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F5IXmwIy38/fn23gDLxutrx/u8ezb9RKv66d3sxgwtwtqHzmo5NVoIKEFJvkwXZoc
         FqNAkMqP5dhJBy04ctNGA9n6ZOiqEuw1KsuImURIMDXVzpt+SXtnum1z19F7n5TWTb
         /GczntLx6lys/5PZ5802zi+qaWDgsb63dQHBQCfgsop9E+nKjH1Le7mkg4MyOZhNpB
         f7LNImqXvXJL17GXLDDAXs2jrV/NPq8OFTvQ2UlKJ9PloDib+PwcP8esUHpWWzkzfy
         dGTFjbgQ36BeuOramFMBJEcFqG0+xK5L3Uvxrj6uoNLgFI7aZyYEEhJVyHQ42TZK1t
         8UnQ4cH+2eJuA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        robh+dt@kernel.org, angelogioacchino.delregno@collabora.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
Subject: [PATCH v1 17/20] soc: mediatek: mtk-svs: Use ULONG_MAX to compare floor frequency
Date:   Fri, 17 Nov 2023 10:42:25 +0100
Message-ID: <20231117094228.40013-18-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231117094228.40013-1-angelogioacchino.delregno@collabora.com>
References: <20231117094228.40013-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `freq` variable is of type unsigned long and, even though it does
currently work with u32 because no frequency is higher than U32_MAX,
it is not guaranteed that in the future we will see one.
Initialize the freq variable with ULONG_MAX instead of U32_MAX.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-svs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 16a16c5a3f24..df39e7430ba9 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -1804,7 +1804,7 @@ static int svs_bank_resource_setup(struct svs_platform *svsp)
 			return count;
 		}
 
-		for (i = 0, freq = U32_MAX; i < svsb->opp_count; i++, freq--) {
+		for (i = 0, freq = ULONG_MAX; i < svsb->opp_count; i++, freq--) {
 			opp = dev_pm_opp_find_freq_floor(svsb->opp_dev, &freq);
 			if (IS_ERR(opp)) {
 				dev_err(svsb->dev, "cannot find freq = %ld\n",
-- 
2.42.0

