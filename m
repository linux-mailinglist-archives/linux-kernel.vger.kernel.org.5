Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105E7762CA1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbjGZHHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjGZHGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:06:07 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450682D4F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:03:59 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-992f15c36fcso1072040766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690355037; x=1690959837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKeJEiUanxKvu93sGzjSg4GF4B3WGVBx7i1L2VdYJQ4=;
        b=M+tp6oZe1gPH9xEEcC4NIz/+17tPBDwyrg5XqayofEhQcOhoKm69JynkDfwwln3rpV
         2bXq4FIfw0gia5OxZ792IV+GtBZD6vKPmmSwKoprsYvEmbnFGq0giDCbB3+D6hFg3Ion
         X2666qbAZ4Bfwgo20pn4ExEnfw4a1wvkXZ99Fc/huplZ4OhgbD3uahNruY7BfFt+Vck3
         dxw6cE84wmU0EPOzPqT1BitAPEnnHn3tt0VJdCaW3gjULq3xd81txASd+wFyY6O1Mx1x
         MDS1iUHm6HxJJf5hgiTlDcL6nG9XqmWfzwEHhf5kG7dcwgHMdGvNAgfmy4iqPe0v4fQz
         BE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690355037; x=1690959837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKeJEiUanxKvu93sGzjSg4GF4B3WGVBx7i1L2VdYJQ4=;
        b=SUZCTr/a12wVsSE22mP6W2pCz3gYAoyzzqmRmLd+wMZH414y0CuBPHsIIqU5Xchtn5
         eu9Q0QJ34xy2GraJD+Uq0N58tjyB4ElNZevaj2v/GxiNFapyieSBrAEa1y6lOYxBveMw
         gpUUmP3W/viczet8GJOph3iGLRAid95+7fWDz5vczz1+ev2DJhSiPRTp8zh7MMX1nn7M
         UXrTbXcckWzfMn7xtO5e7QtBB0dzpLWbdjP2tar5sccGdSFa/zAgiYG6Fz4N7fihS3m2
         g2oyvHHZmrzb4r7I/5GDcWWK1HEzke8zgQ8pZLTiFJTfai2oegxVPrhiVS9z4gP9GUyu
         j2eg==
X-Gm-Message-State: ABy/qLZjNpieqo0MkwBJSgmjjpVpi6/hlurxe40AgWf3mtghBjeUoLH5
        BzJXtPYNshIBcauN5MxdJHeH2A==
X-Google-Smtp-Source: APBJJlE8axeyzzn/n+ng+MNgJLYji7w3J5DoQfiai3wT/y6u66PcIt1x5dtooYjcqwlxSCkpv2+5yg==
X-Received: by 2002:a17:907:7705:b0:99b:627b:e96d with SMTP id kw5-20020a170907770500b0099b627be96dmr900296ejc.44.1690355037838;
        Wed, 26 Jul 2023 00:03:57 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id ks27-20020a170906f85b00b0097404f4a124sm9212372ejb.2.2023.07.26.00.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 00:03:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/4] ARM: dts: st: stm32mp157c-emstamp: correct regulator-active-discharge
Date:   Wed, 26 Jul 2023 09:03:51 +0200
Message-Id: <20230726070353.103989-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726070353.103989-1-krzysztof.kozlowski@linaro.org>
References: <20230726070353.103989-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "regulator-active-discharge" property is uint32, not boolean:

  stm32mp157c-emsbc-argon.dtb: stpmic@33: regulators:pwr_sw1:regulator-active-discharge: True is not of type 'array'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/st/stm32mp157c-emstamp-argon.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stm32mp157c-emstamp-argon.dtsi b/arch/arm/boot/dts/st/stm32mp157c-emstamp-argon.dtsi
index f8e9980ed3d4..009209ca673b 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-emstamp-argon.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp157c-emstamp-argon.dtsi
@@ -320,7 +320,7 @@ bst_out: boost {
 			vbus_otg: pwr_sw1 {
 				regulator-name = "vbus_otg";
 				interrupts = <IT_OCP_OTG 0>;
-				regulator-active-discharge;
+				regulator-active-discharge = <1>;
 			};
 
 			vbus_usbh: pwr_sw2 {
-- 
2.34.1

