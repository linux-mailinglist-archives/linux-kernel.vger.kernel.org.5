Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059CF7E8105
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345364AbjKJSVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345645AbjKJSS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:18:59 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D1C619B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 22:19:07 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-66d87554434so11248296d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 22:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699597147; x=1700201947; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y6aHgY7dVjq1emLLBr9I0qdToBO/wwiRz9A+uR2RPk0=;
        b=qZ5Yhh8VnH3CeIFte2/kg7Gw8DRSdl8rOgeOb09IT+1qbqpORszp3aYAFjzrcoSbl4
         lEH8qtQO4jt+HhBbCevpc/PcY60Mj3VnpTjtXKatSWdvetFTHkdIpYQYBR3J07Nzenry
         ZAYcpLYoS7yQFK1RI9L7ClwnAeS1SCAO1lbqYIjqRcV63YgDOaiUUdsgxSjnQmy3KAWu
         HehXEezehAwjW3VcEdKMT8c7PjwvbGhB3sAn3vQrsoDlb7N7utOxMIU6bJMJMdwcGeS4
         mcWvB5C6CLRaOvuBdCSFShRFrbtfXhp1qg9KCSealKdONR0vZtNcl8bRIJjaEjGtnJ0A
         Ij6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699597147; x=1700201947;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6aHgY7dVjq1emLLBr9I0qdToBO/wwiRz9A+uR2RPk0=;
        b=d/kY4KYvRT0/8psB3O9GkH+1BkhiFjWsHfrdHSFxKTAmoxIfcpNAmA62RHcZ50wxOx
         LpsOiI/eL/DQ8ZG2U27HxhOpHpL2RVCjfj2zVnBzHBwsTC289Fph/27LxKhhgMMB/HpU
         mh42+yj2bAf3H+7Sai1vVO6N68aQhRXpUqZ0erG4CrS1JuOfQQ9QxJqXjEs9IcU0guPS
         74bTeOFYFGd+vWohA2NSkW0HWViAA3xs9F6qyE45CrU8ECRhwCCFMsNeEBllj+CV9iJs
         i2JI/AlWV3fetAlujCDtKz2qImOnClp+SHv/uhrMeT6YY0HUYY3P8kngkIEcJOuM/AHT
         SrYg==
X-Gm-Message-State: AOJu0YySCLpe0drdcroPUhJ/5SHa5jt1bmB2G/LgQ8/nxp7ecROSuHt6
        QktlaQMHca3Q/W1dtAAADVe6VXNL4aSCgMIzw+rSWQ==
X-Google-Smtp-Source: AGHT+IFpFkfHNHBYhJCAUHAcswVdjopAz96NNqXsNMtnhZD1PCclguvJ4ptzgVdeIGhBXO4+11fEaA==
X-Received: by 2002:a17:902:d346:b0:1ce:a0b:7314 with SMTP id l6-20020a170902d34600b001ce0a0b7314mr525866plk.61.1699594947284;
        Thu, 09 Nov 2023 21:42:27 -0800 (PST)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:2071:4479:98b8:cc69])
        by smtp.gmail.com with ESMTPSA id ix22-20020a170902f81600b001b8a00d4f7asm4498845plb.9.2023.11.09.21.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 21:42:27 -0800 (PST)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Thu, 09 Nov 2023 21:41:11 -0800
Subject: [PATCH v5 1/7] dt-bindings: mmc: sdhci-of-dwcmhsc: Add T-Head
 TH1520 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231109-th1520-mmc-v5-1-018bd039cf17@baylibre.com>
References: <20231109-th1520-mmc-v5-0-018bd039cf17@baylibre.com>
In-Reply-To: <20231109-th1520-mmc-v5-0-018bd039cf17@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Drew Fustini <dfustini@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699594943; l=855;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=sdi2GBRazAXQCmzsLeFCtwwLCyPq9k+jdkf3IoMSdfo=;
 b=ugpumf9QoPxX+bSKCeojrp6bqXrSAnaGYhOubo1XOKWuUAe+aPIamwK96g3G9BlWXJHvQsys5
 SM5IH7XCovZCPWuPcsoCJ0439BkT26SbduFWhm4sFfHz07D59YfWw5g
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible value for the T-Head TH1520 dwcmshc controller.

Acked-by: Guo Ren <guoren@kernel.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index a43eb837f8da..42804d955293 100644
--- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
@@ -19,6 +19,7 @@ properties:
       - rockchip,rk3568-dwcmshc
       - rockchip,rk3588-dwcmshc
       - snps,dwcmshc-sdhci
+      - thead,th1520-dwcmshc
 
   reg:
     maxItems: 1

-- 
2.34.1

