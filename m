Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE507776C2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbjHJLUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbjHJLUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:20:15 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4437C26A5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:20:06 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5230ac6dbc5so991075a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691666405; x=1692271205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjRrPL3giyS12WpTx8mH1BV4cSs+Hb0fY60hyKCefvc=;
        b=DdSvEMf1eAnZGQZ/9FRALSlwt2iOxo0rsPe/51k5UmLZFZkfvRKyxDesDZJPtx1B3z
         gAoXq9TPVCrsGvLbpZa6pmuYaR01wFBmwLR2ywQLYx1qCsv8skIzEhY5Ly0yUz3A0eeL
         zFlow1dIoZehUAqK2IJJ0sjuHxFJJj9leFHGxKifnkNt8erRcth+VTHV2vmk2VVqFLhO
         t/SGdaHkoPTjgPmH39xSqQ2ToQHaEwjh06L/E001KoaKbeEx6DiwCJzd3YPQ06AZj+lN
         Fp0dy/7H2ZjikrjL7K9+BCrDi03SGanWkYhVRohDYS3DqPAJuQpHqtowUkPZdScryF6j
         svVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691666405; x=1692271205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjRrPL3giyS12WpTx8mH1BV4cSs+Hb0fY60hyKCefvc=;
        b=dBT8jC/JwMxrgqfSzI3HEBKh3qceEkgfoZ2PBSUWX3vLd9wvRF3XKKkjTuFftRpoUo
         RgikEBUYPQk3VLqviQwKXnbfbvixk75VWnctiJmg7RjZBXxbM3JlKqH4JD2Ag69Nj2t9
         /JG3aLEdAz4kPYZMRSQmpLyYaA7Td/aZntMyMte4SlaFdYQJjdJaQ0gXduPAdvES8otm
         jLIO5pWyk/1eBbt1NhiPaPX1gOBRCHv+sothB9sJXm92IrrPx4mVxxLkYomZkDatuiRA
         f4ESQH0uz8UXfpam/cG+Ks3cjRVsqUGjQ5TYG+Vd2SRPuQOgJrpyMVQJqmiy9Gv90aWt
         oH3w==
X-Gm-Message-State: AOJu0YxOSLiCPTHSq9l9gIaTlgKmv5mOlTmbc2lPWNjhLQu47k2eoECl
        DkkebIqZPWILLLtPbR8UKPz1JA==
X-Google-Smtp-Source: AGHT+IF958xthNASZUnlwJzqA0yJJGOR4I6Ld0t/wpSlG0seA0JNDjX1vM/bUIDiHFnWWkwvzjn0mQ==
X-Received: by 2002:a05:6402:1343:b0:522:28fa:3009 with SMTP id y3-20020a056402134300b0052228fa3009mr1646737edw.13.1691666404836;
        Thu, 10 Aug 2023 04:20:04 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id l10-20020aa7d94a000000b0051a2d2f82fdsm672190eds.6.2023.08.10.04.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 04:20:04 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/4] phy: marvell pxa-usb: fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 13:19:58 +0200
Message-Id: <20230810111958.205705-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810111958.205705-1-krzysztof.kozlowski@linaro.org>
References: <20230810111958.205705-1-krzysztof.kozlowski@linaro.org>
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

  phy-pxa-usb.c:299:26: error: cast to smaller integer type 'enum pxa_usb_phy_version' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/phy/marvell/phy-pxa-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/marvell/phy-pxa-usb.c b/drivers/phy/marvell/phy-pxa-usb.c
index ffe889893ff4..6c98eb9608e9 100644
--- a/drivers/phy/marvell/phy-pxa-usb.c
+++ b/drivers/phy/marvell/phy-pxa-usb.c
@@ -296,7 +296,7 @@ static int pxa_usb_phy_probe(struct platform_device *pdev)
 
 	of_id = of_match_node(pxa_usb_phy_of_match, dev->of_node);
 	if (of_id)
-		pxa_usb_phy->version = (enum pxa_usb_phy_version)of_id->data;
+		pxa_usb_phy->version = (uintptr_t)of_id->data;
 	else
 		pxa_usb_phy->version = PXA_USB_PHY_MMP2;
 
-- 
2.34.1

