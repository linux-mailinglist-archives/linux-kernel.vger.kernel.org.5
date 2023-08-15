Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D87077CE21
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237628AbjHOOc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237669AbjHOOcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:32:14 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF2B10C0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:32:12 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe1a17f983so49659425e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692109931; x=1692714731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xamr+VMNIiHUxs+t0NwOpENr1FFmryIpP13DFeFEEWA=;
        b=LoYhl7NX/UL3BuSxqil5bfW/WK3lS/sX7oKzuSlIs3D6b8d1vrI6S1GUJ0MljNiP1a
         Nx8m5uTAxHEOQLqP5JdVxF6Ncwzl/Ivxk8W8PGkF2r77Zp7Y5764sMNyl3G2UOrjBcHM
         ltW+nhHT5rBAB3+AgdhxwHzDSrNPJ8zyzIRrzoNAo4JTncp+6EPhzoG76abqKPOa6cZO
         Q/K6+nknXLfmorIK8dwhMOZEba6mJq+LP69fKWHeSgcUYTICHb0lsMp23zJL9bXcRzJq
         e43ggn7VpP9aTCIkopUTqDCwyLWTHpEAXAaA/gO2s+7dgfHVDsp/j6DQAu2gFBNmtvo8
         AvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692109931; x=1692714731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xamr+VMNIiHUxs+t0NwOpENr1FFmryIpP13DFeFEEWA=;
        b=PNJEVLAiwq3DaG+EvrMvKlTH0bP+IRMVuNm6rHLsz0c0UF1Hbomcxhog3hyUNX1maI
         vcRb2LmwGZM4sJMZLr6Rgcur5txfURm1ovKt4pDb3AeLbbUVGfEVNWQAxrZrY0/7835w
         j1ksmt5Jyf138nJm566F8kko18+Z+8Ku4NTDlSIsfD59vFrhXJBqKfsplOzMxzfyViNR
         vc9dXd+2hwCFeKdbi+c6GhpWbjpCFbsThjbp3x4N2tn1R1lynuUoX4uj2a6koT3/sRWs
         frsKJxMMIoWq9tjXrVswmm4l2lEMkaEZgtdSAXGuBtmkHaF0ptm41DuShKXmFoXWkenu
         FvXw==
X-Gm-Message-State: AOJu0YywZ/9tsrrIfa80++tBqsOhc1CxsP4OAPnMB7xahz35FmdA+xSV
        CguY7G/lOFUAh9HyW1XKsfUlfQ==
X-Google-Smtp-Source: AGHT+IF1krISD3AJXDPMTk0PBHJrfPjmRe6TLvoVjuU6BZ513y89qdOLID/M+Pv483mdRwQq//j3zw==
X-Received: by 2002:a7b:cd99:0:b0:3fe:14af:ea21 with SMTP id y25-20020a7bcd99000000b003fe14afea21mr9607003wmj.21.1692109931122;
        Tue, 15 Aug 2023 07:32:11 -0700 (PDT)
Received: from krzk-bin.. ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id l11-20020a05600012cb00b003177f57e79esm5851481wrx.88.2023.08.15.07.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 07:32:10 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Heiko Stuebner <heiko@sntech.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RESEND 1/3] ASoC: codecs: tlv320aic32x4: Fix Wvoid-pointer-to-enum-cast warning
Date:   Tue, 15 Aug 2023 16:32:02 +0200
Message-Id: <20230815143204.379708-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

'type' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  tlv320aic32x4.c:1352:18: error: cast to smaller integer type 'enum aic32x4_type' from 'void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Resending because thread got duplicated/messed on the lists. I also
dropped patch for aw88261 from the series, because it was fixed other
way by Arnd.
---
 sound/soc/codecs/tlv320aic32x4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index ffe1828a4b7e..6829834a412f 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -1349,7 +1349,7 @@ int aic32x4_probe(struct device *dev, struct regmap *regmap)
 		return -ENOMEM;
 
 	aic32x4->dev = dev;
-	aic32x4->type = (enum aic32x4_type)dev_get_drvdata(dev);
+	aic32x4->type = (uintptr_t)dev_get_drvdata(dev);
 
 	dev_set_drvdata(dev, aic32x4);
 
-- 
2.34.1

