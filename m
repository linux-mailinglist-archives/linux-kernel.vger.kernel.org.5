Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0917618AD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbjGYMqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjGYMqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:46:36 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02BEFB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:46:34 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-991da766865so922215866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690289193; x=1690893993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlNxPg8P250n7ISOOb9O3P6IRwX+V9i/tQQGaWegZyk=;
        b=GZsQG4NIMegnM2aHjh5PeChjkSG29o/EHxvjXXIK5ZiFmj7UnLTS4mO1zxoEmyF0WY
         Qxg3stDeF/rWJeBZZ1suq5KuY87uc/nGa1lIcOPH6MLKAYDKkZ4goB0TMtksIIs8edRK
         Wvi9meyt7AAU7XwbjBGROP/Cjj8U6LqUDeV/nMnwE+WYDfvxhOX4C0UPBaPWr6pTH5uo
         +F0lfOzaoo8iI0cw+A+TxDzYIITFJSfsjRXovOBv2NiO1UYX2pBFJJUrMD4y4gMvD3kU
         JAfAESAvLqWg8TDVR/rqiF8TYJh5H9r4jrcrxRV4omeBJnIuSshUsUnJVhOTewdmmgnA
         Zh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690289193; x=1690893993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SlNxPg8P250n7ISOOb9O3P6IRwX+V9i/tQQGaWegZyk=;
        b=YYvlcX3aKDsOVS3pzjy1RiIlEA810wxvQ78DrkWyttvKYdmCneNiNMDhFiW18U4RcP
         tsZ8dUuaxMFTnkL8a6cpbnZ7vOTWDOO6IHc4RIpqbCEgsSBt/uOkvEmEX47b5fuUAFn2
         LgE5VS5akBhZ/4OSQrBvKtYax7NWBjEj46N0dVe7Y2wSW0AZcAkQMpVVkR095jF1btt2
         OnxJ9Sww56xXbkxmenwqZKwkboYN1OeQPQgZevcuyEUfbq/iPZ9zm/ZPGfEm1t8Ls4sc
         XtjYMWv6rQqrCCH8DY6DMbQECskpclyoyb47hMomUNCC/fGfdUExxQU8NX6HMHY0L7TS
         tYDg==
X-Gm-Message-State: ABy/qLZmyZzZQSy4iUwf0xNUFmvXzYTsomdSgNdA0kR+kNAyB3HRdTj1
        8SzJEIgSVJGD1+B1RxR9wlEM1Q==
X-Google-Smtp-Source: APBJJlGejpX0SoZtPDPmFmTNOX8R4TPfLiN9YKxn20cBWdgxCNLrghaRDqdGpKXKi+yH7CdELIMKLg==
X-Received: by 2002:a17:907:7757:b0:99b:627b:e962 with SMTP id kx23-20020a170907775700b0099b627be962mr13840966ejc.47.1690289193623;
        Tue, 25 Jul 2023 05:46:33 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id xo18-20020a170907bb9200b0099b5a71b0bfsm7970576ejc.94.2023.07.25.05.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 05:46:33 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Adam Ward <Adam.Ward.opensource@diasemi.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] regulator: dt-bindings: dlg,da9121: allow different names
Date:   Tue, 25 Jul 2023 14:46:28 +0200
Message-Id: <20230725124629.150113-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725124629.150113-1-krzysztof.kozlowski@linaro.org>
References: <20230725124629.150113-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regulator names, as specified by regulator-name, are board-dependent and
should describe the name used on the actual board.  Do not enforce
generic buck1/2 names.

This also fixes dtbs_check warnings like:

  zynqmp-sm-k26-revA.dtb: pmic@33: regulators:buck1:regulator-name:0: 'da9131_buck1' does not match '^BUCK([1-2])$'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/regulator/dlg,da9121.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
index 43f99bc8fbd4..13b3f75f8e5e 100644
--- a/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
+++ b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
@@ -95,9 +95,6 @@ properties:
           Properties for a single BUCK regulator
 
         properties:
-          regulator-name:
-            pattern: "^BUCK([1-2])$"
-
           regulator-initial-mode:
             enum: [ 0, 1, 2, 3 ]
             description: Defined in include/dt-bindings/regulator/dlg,da9121-regulator.h
-- 
2.34.1

