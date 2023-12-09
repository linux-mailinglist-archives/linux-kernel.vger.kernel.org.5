Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DA780B3C1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 11:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjLIKoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 05:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjLIKoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 05:44:16 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CB710E0
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 02:44:22 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54dccf89cfdso3535389a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 02:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702118660; x=1702723460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlRF5ESN+8f4udkYKhzr8luKmrU8RaKXvO/JYQMW7WI=;
        b=htQiFI9KLIDsHOIf3JDDs+FtkRo0zu92tBbg32lYmqLawWLKFPT8WDrmw+D1a25t0+
         R5swhrjJCynSy6iFu9QIlEHBt5gyavn+vW56jNlHc+WROjzr2Tr1E8edDlsdwElYgAaZ
         Qwedfuvb/gItCYwxHFnJlpeU1ZpIoXBz1OryHHqcieY5gz272xJUwcx49BbrW63k7z3n
         WJBLY09wQ1SM24weDsj9w/50qJ/ax1ijjD3L0al3OAnxaSOMX8IY6Z+KVFvzcEkVOme/
         CXgN2VohTJ8A4fWXJrtlUWb4+pOYTU6ntVocNLAtXSmwgAt3fViFxjrWmzCrNbGKzRy3
         Bgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702118660; x=1702723460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WlRF5ESN+8f4udkYKhzr8luKmrU8RaKXvO/JYQMW7WI=;
        b=QbteXg+S6BL85DKM+HyopY5fn/PJytI8cPua/ZInn497XABaT2VbHosWs8VmrOkf7n
         pKLonadK3iT9rImPqNZgd8WjyPbTIWuofnpwpX6l4m7Gx/NnpY5sFtSCQtqn711ZsA5a
         4jiWO7shCJv2sDSoIZksFWHyGomfxAgf0JA7ueKRyAyp1OPMNmDuEJPGfH4ehOZvyg4p
         1Tq9nSW0D3JwvGUfjut83WhA158m39rcN7ZJQB8yD6V3jHL9vGZWo/pBJ67AhQ+AfipW
         cteCVtXKVQlhr8GK5bWR9YT3czSjr3szetb5SXlT4i5MsYOMluYiqeBEMvkout+5ViJF
         L6lQ==
X-Gm-Message-State: AOJu0YyBx5lV4rzUTVUeKKKrVXHI3taK//wkX2Uqh6DDvU5NeRJIrw31
        nVuDyvI6qKhuZVp8rMg7nXWHEA==
X-Google-Smtp-Source: AGHT+IHda76JkbbrEN5rBMhtlIG3Ox0CJOlh8Z2lE6T50ouOps31F6tLOfl570vTj7LIB2OLM+9I/A==
X-Received: by 2002:a05:6402:2152:b0:54d:412:c8f4 with SMTP id bq18-20020a056402215200b0054d0412c8f4mr705393edb.84.1702118660737;
        Sat, 09 Dec 2023 02:44:20 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id eh12-20020a0564020f8c00b00550e21a4f76sm349604edb.8.2023.12.09.02.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 02:44:20 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/4] ARM: dts: aspeed: yosemitev2: correct Mellanox multi-host property
Date:   Sat,  9 Dec 2023 11:44:12 +0100
Message-Id: <20231209104412.12916-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209104412.12916-1-krzysztof.kozlowski@linaro.org>
References: <20231209104412.12916-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"mlx,multi-host" is using incorrect vendor prefix and is not documented.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemitev2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemitev2.dts
index 6bf2ff85a40e..5143f85fbd70 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemitev2.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemitev2.dts
@@ -95,7 +95,7 @@ &mac0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rmii1_default>;
 	use-ncsi;
-	mlx,multi-host;
+	mellanox,multi-host;
 };
 
 &adc {
-- 
2.34.1

