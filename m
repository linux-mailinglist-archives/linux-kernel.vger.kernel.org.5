Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C57777635
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbjHJKsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbjHJKsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:48:02 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9EED1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:48:01 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so1612720a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691664480; x=1692269280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpZqgVo2zkbi2B7sOh6o48YWO5812KC5/SRbTNsfhC4=;
        b=KMQ/zCzP8/TnQe3Wo6hhI2Ivi3DhHc4D2lLfGnt9ciA00FsL4hsZH4u87Vx04WxQ3x
         RRedSie2gJxhgIafqOtTPolui5SRF7Ic4Vh/1ssUoRFIsFqtay8eJwiP2rP/GE3d5CyF
         1U8Y8epFOGqz1GAfIaPLFw4D8jQ7FzptURDIlo29y/NLoTttT7zN4Y6JjqzQPpmgZ3DI
         qkoSxsWbdO4WWARabNALqhZfBleorwPNeLZ6txLHzT3GrZ2hyPwlbJS1fKPvwSxXIh1h
         MoL9oTYywO4hnzh8dJ90rVwUuNJGIvdY3mBw5BAQWHGNEzJ2+JwSpH+gwOi61e2xzoIM
         byWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691664480; x=1692269280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpZqgVo2zkbi2B7sOh6o48YWO5812KC5/SRbTNsfhC4=;
        b=XRftuI3Oo9BXWh6EaZVmHcGkm3qxmQR/EWPrmFvoDIdb4coYvFmoj+ap08+CeoKlgx
         WpEdM/0+SosGOA3WnyPhcK6tZAa0Qqv598LjyPlsJV9N3MXdN9HsndrcMAjxmy3ZyScb
         QATwHJdeth1xVgdmy5EcylBdsBm0sV34/SwhFfzbNOADPa6sqsBLdiLV1dGndXJfY+e9
         AOwsvqMJ3yffb81+BR1kLwTza1yVyHStL1m5GJm+j2Isz8FFEu7veGrG6doPsZBpE19s
         SvKuNT3ZLuV9Fk9Ou74PyqpjdtOoYIQrLytDV4dJlxlGFp5UFftMOmBvC+bLL4syVrr8
         RVbg==
X-Gm-Message-State: AOJu0Yw8d2IzC+P+6NnPJDRRjYXeOng1YUuOe+mQ+LLXCC8C/QkjyPK3
        eq7necINBh5/zzOkAURPM2wCGA==
X-Google-Smtp-Source: AGHT+IFqyvPfsZCXo/1EPc3mjODI47QAw0qLpl21vWUgc1bNs1yO0pXM9KolaKHhD7miC+E9pkUSwg==
X-Received: by 2002:aa7:d343:0:b0:522:2add:5841 with SMTP id m3-20020aa7d343000000b005222add5841mr2074582edr.7.1691664479840;
        Thu, 10 Aug 2023 03:47:59 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id x20-20020aa7cd94000000b0051dfa2e30b2sm653854edv.9.2023.08.10.03.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 03:47:59 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, llvm@lists.linux.dev
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] ASoC: codecs: wm8904: Fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 12:47:47 +0200
Message-Id: <20230810104749.164827-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810104749.164827-1-krzysztof.kozlowski@linaro.org>
References: <20230810104749.164827-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

