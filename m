Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F41762C9F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjGZHHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjGZHGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:06:06 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAC52D47
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:03:57 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-977e0fbd742so1002724166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690355036; x=1690959836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n3OYrZEWc/RsqnCiSew02qdPklfY25DFyQPxO4i8A+4=;
        b=udSHl+NPhOY2ohAq0oizF+LL4ZknSMEcg6SfnOiM4VEsNIeqS8Zgr57DfHlQG61DRH
         J5gD1r++Lhl5gFwSaJTjbHTXo2Gb/AeXozdqMsH/vlsBB60NMVJhcj+pHXYfe25szTfL
         gHd0nCrrnivFs/XqvwaMM/fBv/hmnuVyBtmi5qp3wUswoLucGeusz57AhwEXgL+4wLKk
         81ZiYvt/v5eR3nwy+erz3d1aY5VZxsXwwqHtTHgV3g/Gvsq7R9+PFYOm86qqkAi8aUWS
         f3CCjMRgmpFkS1I3F9XKBV2Ze2bsU0BdEFy9DJ0Nw+/n8ZWKaVhskqqyfAo8ldmWna3W
         vxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690355036; x=1690959836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3OYrZEWc/RsqnCiSew02qdPklfY25DFyQPxO4i8A+4=;
        b=MfzgJJq2E5bThAWLsPeMIYl5CnMVNpEPCVMtjgriRNBf6J98GWdghExdDwt0B+mxOg
         33TqM5n8dc1bFODHgTabYB3YyeUyKACIOKui+XmraYnUhjNFbcztvS43c5EvMYNZgTCj
         TAS1aKfTRIFglFk42KsM/gVXw7S4ZgxPwKnU7rftj3DPeK1ps0oeY8cAqvY+GqFaQyG2
         EI+6e7vgfPzdXMcpuA2R/nKEW6SVtzf570+HEPU2uds3M0+JdZjSkrS7R2wPtRyEm/ZX
         YMXg8owDZvrUzPgYrhvogmTYAuYXrdvbrK5DJcIoJ7r/Su2MF20yXtru7C4Nk8fnNsME
         TUSQ==
X-Gm-Message-State: ABy/qLbFVczXvydpBuvQh+/NOGq5aDkpW73myNLeL0c7rz6PFWFY3krK
        z/jGxz503dlVNcrQMHaPTmgqRQ==
X-Google-Smtp-Source: APBJJlE/HYLctwUu0akyRKzjFfPG5IVC3SDHcSEFXBMrYX782comSFFO/KzvV7TnO6iIcwhZBqWZiQ==
X-Received: by 2002:a17:906:1084:b0:994:5350:5a2b with SMTP id u4-20020a170906108400b0099453505a2bmr719803eju.62.1690355036348;
        Wed, 26 Jul 2023 00:03:56 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id ks27-20020a170906f85b00b0097404f4a124sm9212372ejb.2.2023.07.26.00.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 00:03:55 -0700 (PDT)
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
Subject: [PATCH 1/4] ARM: dts: st: stm32mp157c-emstamp: drop incorrect vref_ddr property
Date:   Wed, 26 Jul 2023 09:03:50 +0200
Message-Id: <20230726070353.103989-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The STPMIC1 PMIC vref_ddr regulator does not support over-current
protection, according to bindings and Linux driver:

  stm32mp157c-emsbc-argon.dtb: stpmic@33: regulators:vref_ddr: 'regulator-over-current-protection' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/st/stm32mp157c-emstamp-argon.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stm32mp157c-emstamp-argon.dtsi b/arch/arm/boot/dts/st/stm32mp157c-emstamp-argon.dtsi
index fd89542c69c9..f8e9980ed3d4 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-emstamp-argon.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp157c-emstamp-argon.dtsi
@@ -310,7 +310,6 @@ vdda: ldo6 {
 			vref_ddr: vref_ddr {
 				regulator-name = "vref_ddr";
 				regulator-always-on;
-				regulator-over-current-protection;
 			};
 
 			bst_out: boost {
-- 
2.34.1

