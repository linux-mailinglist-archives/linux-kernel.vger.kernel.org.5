Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC0D777638
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbjHJKsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjHJKsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:48:00 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9952610DE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:47:59 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52364e9daceso900169a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691664478; x=1692269278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpZqgVo2zkbi2B7sOh6o48YWO5812KC5/SRbTNsfhC4=;
        b=L+pJzrZz5LiodQRp/U/kbzpSYWnuq6UUxyeRItM6/VS+qn+D1PDLrcfAJlUCmks3Kz
         Licj4R5ZhYqFNIyGDXQpyL/zv+UQqLViDrfb5AQ5Lk0yh0s8tkC9JT5Wi4Rz2sWltvfD
         24dwksZBWyf0htE1vPBy9QBmrbo+qPRzH8EaHBcvW31pMM5faimC9YDi9d+PxB0L0IKN
         RvDGD0ECUskqfPBcVKcp9DdgIhUjd4a6DuzkmtbPY6Y/FFnK61k2qicYoEsqIRuuzPtV
         5rb0itHN4h2ptsZeSrFedln9PwV3C4sILAvNxBhujef01IdBWcivSBYg3FU8C6qUz/HA
         Y3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691664478; x=1692269278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpZqgVo2zkbi2B7sOh6o48YWO5812KC5/SRbTNsfhC4=;
        b=PNTiJNG28yeyeVb9TYKeL4RWZ/5A/z+bhYv96XQzGXWa7pSFdymkXfo8FO1stnaTEJ
         C86v6h+G5x8zXPpUeHzcEH//PfIMxxFU2FY6PmwIHSuBdn9GacQCO97vpOzKFLlJ/Xwi
         hxOfGC0VO5N5plb/CxaSZwLoMvIsqFcWB5kOJuL8WOFdNRgzm+EOlVB7oW3b7GG0nLy7
         YNLZ2yAHvOspvY+pTi+IDSLIMlCWYTePojKYc1B1YzKSqv0sU94OJeizjpaD33t2kuSp
         xVmJLfoTk6IljAz0fPZNzxUAzzYQ4oR/iVDlSp8QN5aH+Kqhw59P+nrERrRKHnKfBCXN
         /CBQ==
X-Gm-Message-State: AOJu0YwJcWD4qrhwTJmEgWDHFToreygmmatVSjU2wVLMwzvoXkoGJrcN
        Vl3Nh1tszys2YYJOd5oK47i3dg==
X-Google-Smtp-Source: AGHT+IFi6mpqtjPUZgkNME8tljPZsCKLpCa4i79mEQYjX4KcyxYg/CD19QBrJpMdXKSWYT3AtUshSw==
X-Received: by 2002:a50:fc09:0:b0:522:2d1b:5a38 with SMTP id i9-20020a50fc09000000b005222d1b5a38mr1688860edr.10.1691664478219;
        Thu, 10 Aug 2023 03:47:58 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id x20-20020aa7cd94000000b0051dfa2e30b2sm653854edv.9.2023.08.10.03.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 03:47:57 -0700 (PDT)
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
Subject: [PATCH 3/4] ASoC: codecs: wm8904: fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 12:47:46 +0200
Message-Id: <20230810104749.164827-4-krzysztof.kozlowski@linaro.org>
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

