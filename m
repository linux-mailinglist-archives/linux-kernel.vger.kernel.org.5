Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3620277CE23
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237647AbjHOOcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237676AbjHOOcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:32:17 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B51810FF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:32:16 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so4827294f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692109935; x=1692714735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzMSq7HLSHN1HFLKAp83kiHFzC/dRhYUs++4UrDqaOA=;
        b=L1iV0sMzPMso3PSr1XH+y5/B8gyuV5pYEWqlU8NARJdqLI4hZ3F6s321hi7/VG8oLE
         phF5PpbnKhgxxQhD3n7lKAk/avrkQIoh6ll4b0iLamniMrti4GKXu1vdJsELmnaHYnmy
         dXW9fqkfSZo2Oc4ZLpAhuO/5waWLbDsOiufUm5OjYPAP2tQG98GYDqdKTERblKPMEH0F
         K+aDkrfeKeuhJAlzYWKgLsBOO9SDk0kp07/kNYdsC8nGGGUqwun4YursEJrylhuJxp0/
         n+Ka3lwGrr4oaw4/KSAIokrbKf8wPNLPfVHq2FCcb72KkDxaRhRl5by6WCpyi0ILqMwc
         OgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692109935; x=1692714735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzMSq7HLSHN1HFLKAp83kiHFzC/dRhYUs++4UrDqaOA=;
        b=T9g1OdkzSZr0N9/68ksi0vMtE8YmCLOOizWb2YvZ2vMUa7aajrvDgCQPiJAEf724mf
         sjgUGdg4wgqvpx58BQf/mTSQJBL/c0Aex3Zc15OwF9rFlgIhLZwZF2A8Bu+iJ3sF8U9O
         LfprMcx6K2PbEYmm8CjUZPS5/FYiuXgHHitge78ZpK/E9dzFW5I+q3K9a904h3XzhFkT
         gomAo0uaKgHT8mjPglnSkNvcv60iLPTtqJ3ByBLgk7YY651uGUOJusuS7Khv6P5kl18u
         c+iIk2FPwIKk8OIxV5CMml28wwiw2qGwI/Zt9k+2xdk6jh8B1K5Nq2Rt2HAlOve9Yh5B
         M+CQ==
X-Gm-Message-State: AOJu0Yz5+2m2WR98hlgjZ9UxmAS7atmwVzxkx2s39NgtoMMDkPzqrmpL
        oJDG/mFk6gDJ83sz33XIc99+tTYECM/5gKxoV5Q=
X-Google-Smtp-Source: AGHT+IH7QnBMIW+PVYhiQDxK0D6EQk2b+8pkoH7NcQ2NFAHzAWryQ2DVu/uXHuscNAunX53Tk+bXPw==
X-Received: by 2002:a05:6000:42:b0:317:e3a0:92c6 with SMTP id k2-20020a056000004200b00317e3a092c6mr9135862wrx.18.1692109934723;
        Tue, 15 Aug 2023 07:32:14 -0700 (PDT)
Received: from krzk-bin.. ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id l11-20020a05600012cb00b003177f57e79esm5851481wrx.88.2023.08.15.07.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 07:32:14 -0700 (PDT)
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
Subject: [PATCH RESEND 3/3] ASoC: rockchip: Fix Wvoid-pointer-to-enum-cast warning
Date:   Tue, 15 Aug 2023 16:32:04 +0200
Message-Id: <20230815143204.379708-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815143204.379708-1-krzysztof.kozlowski@linaro.org>
References: <20230815143204.379708-1-krzysztof.kozlowski@linaro.org>
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

'version' is an enum, thus cast of pointer on 64-bit compile test with
W=1 causes:

  rockchip_pdm.c:587:18: error: cast to smaller integer type 'enum rk_pdm_version' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/rockchip/rockchip_pdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index 52f9aae60be8..678989b25e57 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -584,7 +584,7 @@ static int rockchip_pdm_probe(struct platform_device *pdev)
 
 	match = of_match_device(rockchip_pdm_match, &pdev->dev);
 	if (match)
-		pdm->version = (enum rk_pdm_version)match->data;
+		pdm->version = (uintptr_t)match->data;
 
 	if (pdm->version == RK_PDM_RK3308) {
 		pdm->reset = devm_reset_control_get(&pdev->dev, "pdm-m");
-- 
2.34.1

