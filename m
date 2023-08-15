Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EA077CE22
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237641AbjHOOcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237674AbjHOOcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:32:15 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF65510C0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:32:14 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe8a1591c8so39659255e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692109933; x=1692714733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpZqgVo2zkbi2B7sOh6o48YWO5812KC5/SRbTNsfhC4=;
        b=AjF7/iSx//xv+IXbPrL7byl1tK/SI6NcdK7rZc73VtoiGg7V7Sah6expliUD2+bF87
         lzbiBreVfmGWFKUAAvYpVUu5NjpfNgvYtUKTZfW4u/g7Fqp1OWlCIO6GI3wNGlMfsShu
         QaCMlMbRWVfdrBzrcf837XmCmiNlNcoREEI0n1r+JXFcjIuTNOL/wPsp4n5ZyekJgREy
         hcf8GsOJcMcDkYSbZ7hjiuaWK/Kdflgiv65As/HmePDlqJjG36NaQcJrTaxIju2YZ1+H
         S73dQldaf8Um/soORXdpTCTPCxIEu2h3wMSJjpCoLYWdX4EuhzlrSCaMqv358l+yIyhr
         c8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692109933; x=1692714733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpZqgVo2zkbi2B7sOh6o48YWO5812KC5/SRbTNsfhC4=;
        b=XvRM24jx754/bpygMM99wsOg5uuz0st61ftyn4FptxvfUrSmxoHYQgl6IOPOkBWUUn
         LvIwZvV+iRRNUvnhvej5JYQaQZTKFyp/TroDB/srMr7vdIDfPJJpYzgtQ8ZtKlyojrah
         6WDoL3ibU5b1m/uTPOwFttDLKy2A67F2uhoOhorV37fgCB10E9uDhOFnVN754Wq/GitB
         T6pQniv3RkAQlEioS36WzUfUTTRuATTt+aBY3ORmDVkbGwEVh6dIFFW2aoAUT9qMZV2n
         uNyAbJSrvu8FVC6e8yfIDYSMF/t7HQGJBgTJGFed9BWumKDz1YbmdtbLzTFNgNYa7nZU
         xpoA==
X-Gm-Message-State: AOJu0YwWM4Q6A0i94NT3haE06I5CVblkG0AxgK/G4I6mXnra4+6iCfFJ
        meyI8iDMQTG7QHIjotdTlC3Zaw==
X-Google-Smtp-Source: AGHT+IHtM12tZqB/uARbgqLwol3KwbEzc5BSEYMRqCDwwlrAIrZkQ/bVwv4A6dHrGW9OOEqZ0i1fRA==
X-Received: by 2002:a05:600c:5121:b0:3fe:1b4e:c484 with SMTP id o33-20020a05600c512100b003fe1b4ec484mr10756757wms.5.1692109932920;
        Tue, 15 Aug 2023 07:32:12 -0700 (PDT)
Received: from krzk-bin.. ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id l11-20020a05600012cb00b003177f57e79esm5851481wrx.88.2023.08.15.07.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 07:32:12 -0700 (PDT)
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
Subject: [PATCH RESEND 2/3] ASoC: codecs: wm8904: Fix Wvoid-pointer-to-enum-cast warning
Date:   Tue, 15 Aug 2023 16:32:03 +0200
Message-Id: <20230815143204.379708-2-krzysztof.kozlowski@linaro.org>
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

'devtype' is an enum, thus cast of pointer on 64-bit compile test with
W=1 causes:

  wm8904.c:2205:21: error: cast to smaller integer type 'enum wm8904_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wm8904.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 60319b468fb2..829bf055622a 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -2202,7 +2202,7 @@ static int wm8904_i2c_probe(struct i2c_client *i2c)
 		match = of_match_node(wm8904_of_match, i2c->dev.of_node);
 		if (match == NULL)
 			return -EINVAL;
-		wm8904->devtype = (enum wm8904_type)match->data;
+		wm8904->devtype = (uintptr_t)match->data;
 	} else {
 		const struct i2c_device_id *id =
 			i2c_match_id(wm8904_i2c_id, i2c);
-- 
2.34.1

