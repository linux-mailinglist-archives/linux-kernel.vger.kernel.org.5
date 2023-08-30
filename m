Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF9878DA24
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbjH3Sfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244685AbjH3NnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:43:00 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E29AA3;
        Wed, 30 Aug 2023 06:42:58 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c1ff5b741cso14707735ad.2;
        Wed, 30 Aug 2023 06:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693402977; x=1694007777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QYflLN+TBQxWEao5rA2zFP+OREduZFJfAoqQQOBR08=;
        b=R8AOk08DKdD3vqMyA5CLM1JR7K14eWh/AptARSr24HHHGUuVUk7XAcBu7+hCwal9DM
         LKJQ4wZpffNZwHbB28vMh94qqltRRTHL39NLLyylAUwiVtb2+kSiquZ96tbUwPH7yctg
         85JmVjFn+oE0sTbOxThIWf1dyvSA5fQy7LmwNE7Ac5L2i7ouhZRrRzXP8/rREMUKiwf8
         gsaEyOKo2AgfmAkVDymnSQ/isqKLHBTQp/GbfAq19Gy3j7soVzfr4s64mgu0+mn3dA0R
         B9tfcc9tocYMayMpH/2RfqQtFaCEy/9Nudc95IOz7H583bnrYZ/LXaU0CPAlM9z8A/wY
         WOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693402977; x=1694007777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QYflLN+TBQxWEao5rA2zFP+OREduZFJfAoqQQOBR08=;
        b=KHGj8SSMh9R/1rwI/hNEFoWZKsQL8qjKkDivMAdoehcukfe+rbRkY/13KKAvKnKsx/
         5SB8+paWLSRiziq3a001GNOGbD2HwpHDEOo82LWsLDBKb0awbgCjDu3WXdUZNV2r0QEP
         jWB9ApoxDgmgUpy4ryVkDQqFxU/jRIVYMQVHddSmva9+J/kEZeH7dmH8OrHBLelIvQ3z
         gq0kADw9A7o8JOd8xMNuTwuzoHuLAl7zuwJSQcktWeLVrasqO5FnpPH+LPDudUzf227f
         hJ3PMYELvmzCFYRSIOGGGWeXsqX3JkxbI0KZjJ2AItY6+WkC72MGA/fwxDHvPMQvvVeW
         OKxA==
X-Gm-Message-State: AOJu0YxcAawLI2lj8u7FSrHFPLpX+Z5HqPeZyVLNhbb9RwtKIVGycKzk
        Q9TGR1myPx3oii75EfQKxV6GLxkDPOfLVUgv
X-Google-Smtp-Source: AGHT+IFh5wkZQupO8sIk8dfdn3Qtxodop1819qgtCcsgkRBsMm4gB/lAsQpL+ksI2jSw1mffaE6MbQ==
X-Received: by 2002:a17:902:f9c4:b0:1bc:5b36:a2e8 with SMTP id kz4-20020a170902f9c400b001bc5b36a2e8mr1905232plb.34.1693402977602;
        Wed, 30 Aug 2023 06:42:57 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.lan ([103.184.129.7])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902eccb00b001b86dd825e7sm11042280plh.108.2023.08.30.06.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:42:56 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/4] dt-bindings: mfd: syscon: Add compatibles for Loongson-1 syscon
Date:   Wed, 30 Aug 2023 21:42:38 +0800
Message-Id: <20230830134241.506464-2-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230830134241.506464-1-keguang.zhang@gmail.com>
References: <20230830134241.506464-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Loongson LS1B and LS1C compatibles for system controller.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
V3 -> V4: Add Acked-by tag from Krzysztof Kozlowski
V2 -> V3: Change compatibles back to loongson,ls1b-syscon
          and loongson,ls1c-syscon
V1 -> V2: Make the syscon compatibles more specific

 Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 8103154bbb52..c77d7b155a4c 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -49,6 +49,8 @@ properties:
               - hisilicon,peri-subctrl
               - hpe,gxp-sysreg
               - intel,lgm-syscon
+              - loongson,ls1b-syscon
+              - loongson,ls1c-syscon
               - marvell,armada-3700-usb2-host-misc
               - mediatek,mt8135-pctl-a-syscfg
               - mediatek,mt8135-pctl-b-syscfg
-- 
2.39.2

