Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2813975C0DC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjGUIIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjGUIIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:08:17 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA17430C4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:08:13 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2633fe9b6c0so1954250a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689926892; x=1690531692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjm1htpsgUdaRZcHsGo757GH1rkymaOgiUPQg9DWT7s=;
        b=apTJsacQxezIERIOQSQqwO451/lek2u8gXH7fZL0cfCdEDjzED1YDa2Baxbhk9Skr8
         08FwwyQ/l7u4oL/MEXt8tamuL+5yYji/Mqu99B67oXI7wh9ZmE0PRft4CzhT55XJMN3A
         dwc5kMyE67C+0BtJfA5fjkXw4DR3dkg7NWXhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689926892; x=1690531692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjm1htpsgUdaRZcHsGo757GH1rkymaOgiUPQg9DWT7s=;
        b=RhAz7vx3TsseaAqWe+v0KP/52XP4GnTLpIvdwE74az414jeTvddfgb4PjV5YG2BLIa
         P1AjI1L2OTlf9VrxihaZFTJIlXu8CJ3MWGQ7UOwy21AWG6x0i0GXiEwFXF9oxGxhhfDx
         DVD7hWbDjUmkQDLlHx7dGusWVS/wl2bV6lXwG7+l+8CTAYMnBE8/8UNv8IW2M5w19puW
         s2DrcXnJPuxvGnXMEelSJA1Aoz3QAcR5I6MEAEpHcYvRsfrNh7PCjoYMtdUQqv10lKgo
         v0cdQqr2T52o0j2IM73ZMFq6+sHGDFzk2z298VBWIJWToviitVulaie2PGtHxgGUW8pu
         GT9Q==
X-Gm-Message-State: ABy/qLZRqnp7NXRVTXyE5mp9Dn+DoL1wLg3J1sBoEAvrefTOVA0+t66A
        zkVhB+BCK+F9Mbrk6OtAg9r82g==
X-Google-Smtp-Source: APBJJlGIS3+ANIVcIUnnknjeeQ8DSn4sVGCY4o1XMTR9Em25tsTHbHUsOx8EeBzPhWHUVPQUYP5HqA==
X-Received: by 2002:a17:90a:64c2:b0:25e:f696:1cf8 with SMTP id i2-20020a17090a64c200b0025ef6961cf8mr1951333pjm.14.1689926892623;
        Fri, 21 Jul 2023 01:08:12 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6d86:d21:714:abab])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902bcca00b001b850c9af71sm2740294pls.285.2023.07.21.01.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 01:08:12 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fei Shao <fshao@chromium.org>
Subject: [PATCH v2 3/7] regulator: mt6358: Fix incorrect VCN33 sync error message
Date:   Fri, 21 Jul 2023 16:07:44 +0800
Message-ID: <20230721080751.2012318-4-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230721080751.2012318-1-wenst@chromium.org>
References: <20230721080751.2012318-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After syncing the enable status of VCN33_WIFI to VCN33_BT, the driver
will disable VCN33_WIFI. If it fails it will error out with a message.
However the error message incorrectly refers to VCN33_BT.

Fix the error message so that it correctly refers to VCN33_WIFI.

Suggested-by: Fei Shao <fshao@chromium.org>
Fixes: 65bae54e08c1 ("regulator: mt6358: Merge VCN33_* regulators")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/regulator/mt6358-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
index da6b40f947c4..b9cda2210c33 100644
--- a/drivers/regulator/mt6358-regulator.c
+++ b/drivers/regulator/mt6358-regulator.c
@@ -661,7 +661,7 @@ static int mt6358_sync_vcn33_setting(struct device *dev)
 	/* Disable VCN33_WIFI */
 	ret = regmap_update_bits(mt6397->regmap, MT6358_LDO_VCN33_CON0_1, BIT(0), 0);
 	if (ret) {
-		dev_err(dev, "Failed to disable VCN33_BT\n");
+		dev_err(dev, "Failed to disable VCN33_WIFI\n");
 		return ret;
 	}
 
-- 
2.41.0.487.g6d72f3e995-goog

