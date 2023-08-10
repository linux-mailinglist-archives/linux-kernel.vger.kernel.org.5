Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E515C777637
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjHJKsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbjHJKsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:48:05 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAAC212F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:48:03 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe11652b64so1132861e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691664481; x=1692269281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzMSq7HLSHN1HFLKAp83kiHFzC/dRhYUs++4UrDqaOA=;
        b=UGqNEmNN1GRZd/cQPQ8BSIM/P3HO1mpPaFsq5qWJJQp/cf2hqFCbXFb+QeRHXLlMKG
         7zasTTRuG7one9GfxqSB1uSZzw6Wy2owDcgscp2LVQ0ZEYKU/dIgcZ2X7SMvcCIuMvnP
         fT+UGY1nG6W+GX8JH8DDyNGJS0INeWEZe/xIc7W7rVuY1LUon1MxyAMsMXy/QaIJnAs5
         yOJES8JPBZNK0XFRdKrYta4LXxKYP8bpG35w5ltlkGbEGVbpp3kh+yoIZax3cM3SBv4E
         PjezXo8hgAwGpuJ1o+WPULiVfbGjx4KGX4Oer/736Jql6eOYkB/sibEnHmDbRKKrJh36
         Xrxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691664481; x=1692269281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzMSq7HLSHN1HFLKAp83kiHFzC/dRhYUs++4UrDqaOA=;
        b=g8fWTSPWTxnUrSqaah6ODYaCfy4HtxbNaRrtnldq8k9hf4Mv2Iqi4TaBYcq9qSBQSU
         RA5LArh2Afw5ylUo9+kz3JXJL2WM3Xdz8gZIt4MXJ3gK7wrR7Fps2f26gDmPRvsS9fZ+
         3ussH+DIC1dfkn0OlKWC+wjaOB5p4P6mLTLg+b2Q7rv8ci3mOH5N0O0LmgVAJ+AomOdy
         tAJquAYVCZwnBnkS7DRGGWH5hpRv6OxsTdFX/uU6tdhkkFo48kTb2NEBjvAUUpxI9Riw
         5l2crjy5dlxDWob2/BYU5DbBss3B+mBFbyUUcjDgP3GkcMYqALmfFiqwk36x0kKCWyKp
         O86Q==
X-Gm-Message-State: AOJu0YyG0idPxeRWGWJBuQMQr6xwbqGxWHAZpZpgI2JUO5uYdxqcQvwO
        J4Apl9TbIKQWnt0to0PO+CF1Qw==
X-Google-Smtp-Source: AGHT+IEP9ckwBL1/0mfPqosWIWOXy9uevpV0Iq3ArH10HdVvSOvTyx5j3EETKE0Mzgr1fyviNz4aeA==
X-Received: by 2002:a19:9159:0:b0:4fe:a2e:890c with SMTP id y25-20020a199159000000b004fe0a2e890cmr1439491lfj.49.1691664481535;
        Thu, 10 Aug 2023 03:48:01 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id x20-20020aa7cd94000000b0051dfa2e30b2sm653854edv.9.2023.08.10.03.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 03:48:01 -0700 (PDT)
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
Subject: [PATCH 4/4] ASoC: rockchip: fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 12:47:48 +0200
Message-Id: <20230810104749.164827-6-krzysztof.kozlowski@linaro.org>
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

