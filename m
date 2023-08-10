Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100477776C3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbjHJLUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbjHJLUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:20:13 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A616726AF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:20:04 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52327d63d7cso967946a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691666403; x=1692271203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktcs5NdTv2cCWAPg+nMpm3PUtm7rQSXE36l7Rn+flIg=;
        b=QSIhYdpdako5VYTZrsQt+ObZhMajMDlSo2PgCENCIMK0yRWLTDjCYs1qjNoEfGviwh
         oTjljpxyfQblKRN/m0swdnmQzVlZ+EceTO0aEWV0VOPctl51zss0Wkf1Drq3PlE786iF
         myAXejODadpaPJsrvq0IwLodeT3sNKBNXUyk/ScecsGYRpXnHzjA8skfym6ueIjCGS2H
         g8fpfPOK1cZMGfEYStA8etmijTDZ6jxhrALVb/HINLGrVaP4Z8sXv6c6TpqDeWJ6E3Og
         bn7QF0KxwVOQ+oKGWyHDP0d7F5RC78wrn50RBvKw2ORq9zL8q7D+3hEc4c5b/Ve+D2Jm
         pcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691666403; x=1692271203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktcs5NdTv2cCWAPg+nMpm3PUtm7rQSXE36l7Rn+flIg=;
        b=MT9OFSMxTFFWUC+iLK7GGF+hr6z5Sk05fEruKwdHA9VGpT/eA2FdgJbSVRh0+wFCew
         iWau/UD+ECUpzQvqbDHeUvDwDjX5rsBMWomEeo2AMhAGOVLaL8ZL3rCQUexl5IyGOWb/
         ZP3E3FDV5KbAC9tuKhjCpI4Ch/u08JarSuIRG/lIe8/J85HhKu3RpZjlyIpVG8DA4QJ3
         8C7+2BlvTMecb7LXDN9kU0GttlYGr/w3DbdfjNoQgjHhxeLeVRTJuQbXDiUL0/3MbSnP
         /4NZC6vCbUuQETOXKfGnsOPGREguMspF08Znk0wKXOjiuVzwUCNbJlBMUVEAPqgrQXQS
         XyOw==
X-Gm-Message-State: AOJu0YwjyVptSaLnyoMGNS2dzHh58GTgjlcjMuT6Eogbm6IX2SSfyGSf
        EaxmyX1y/Ef4bPWQn3wy84AARw==
X-Google-Smtp-Source: AGHT+IFUPx4e6WTIaWFS8XfPyJLCyfbqVQwy1oe+1dz/OcKdK+SDb+aWckxRLLJOvALWF+MJz4Fnqg==
X-Received: by 2002:aa7:d4c3:0:b0:523:4922:c9c4 with SMTP id t3-20020aa7d4c3000000b005234922c9c4mr1886784edr.11.1691666403284;
        Thu, 10 Aug 2023 04:20:03 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id l10-20020aa7d94a000000b0051a2d2f82fdsm672190eds.6.2023.08.10.04.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 04:20:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] phy: broadcom: sr-usb: fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 13:19:57 +0200
Message-Id: <20230810111958.205705-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810111958.205705-1-krzysztof.kozlowski@linaro.org>
References: <20230810111958.205705-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'version' is an enum, thus cast of pointer on 64-bit compile test with
W=1 causes:

  phy-bcm-sr-usb.c:314:13: error: cast to smaller integer type 'enum bcm_usb_phy_version' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/phy/broadcom/phy-bcm-sr-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/broadcom/phy-bcm-sr-usb.c b/drivers/phy/broadcom/phy-bcm-sr-usb.c
index 0002da3b5b5d..b0bd18a5df87 100644
--- a/drivers/phy/broadcom/phy-bcm-sr-usb.c
+++ b/drivers/phy/broadcom/phy-bcm-sr-usb.c
@@ -311,7 +311,7 @@ static int bcm_usb_phy_probe(struct platform_device *pdev)
 
 	of_id = of_match_node(bcm_usb_phy_of_match, dn);
 	if (of_id)
-		version = (enum bcm_usb_phy_version)of_id->data;
+		version = (uintptr_t)of_id->data;
 	else
 		return -ENODEV;
 
-- 
2.34.1

