Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8530678DE8E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbjH3TFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244684AbjH3Nm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:42:56 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D41A3;
        Wed, 30 Aug 2023 06:42:53 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bc83a96067so34830625ad.0;
        Wed, 30 Aug 2023 06:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693402973; x=1694007773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3hvoy5sr8tqMiOZS3BEhHF+S+RG6KoTmJT68EUAGq/c=;
        b=YFBWiQTNMhjPzYQIxwkqb71J/vkJq1nb+5sldXTELyIJ8Hx8bQY2DfB7/1gldKBk9b
         tlo9gtZqxUqF+anldbT/UA+llLoHVMk0Dui2KWuwtrWXZOxnu+XoBnvDVsURK0jvQ01n
         uXr4x1wW7gJxWnNpmX8Ahf5J1I6K8paKmTkrz5mHJ/LRYj47X8sMZbVCN+d7zxFe0RmC
         PvMPzo1Ts9cwwW1Q7LgN4OnW9UECmTgJcg/5Arg/jxMaxAdnzHhpcFhL2yORj2HLYW6G
         LCY4xpksTy0r2Ais8j5XZ5wMZYA3s/UDXoz9xa5PnZ6yldPU5IRM4/vf4d4XytJ8YsGg
         BlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693402973; x=1694007773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3hvoy5sr8tqMiOZS3BEhHF+S+RG6KoTmJT68EUAGq/c=;
        b=PxkBk5vQfzIbSnqJyJwWQIZooONazH0AjDClCPo/iI3oV1cSKC5u/i6vvlr7EoHN4b
         n/gE+VRfTkIiVji5H+/qpLb1/bheTpkwKojyUe7SaD+S9/Vvx38VV1bTwjLeIS+QunOh
         nQRbqSvPEeG2hfaFXsXc1/LQRoKi1evNE4lLR2tAlEXtuMIzgJgJB4jb36KU5sjhbp+6
         cs3UMkRjl3CM+JoXaXNgvXQj3907ZzxPcOQ2nn/WHbEoJDHTW73mSz/A2qouZ6c1/kEH
         RY+BQviFDEl49kyH8T45aEctqeHgz8KTseC5aRQWuzMEOMo//TrE7NOvuiznX88ZKlPN
         nojQ==
X-Gm-Message-State: AOJu0YwO+tHPbHL3sRr+vJUp9C70+ImYPYH1VNb9tCQHmEpQy2ms7F2p
        DY4tOxPVim1YjWQ0FvAto4tKeFx3SBaVJSL1
X-Google-Smtp-Source: AGHT+IHNYCBqBKdVjz0xIDBB9g8PFCd6b36ktfUPu2blBKShGdiYXmzPGnJZooI8qTUr5rN1CpnZVg==
X-Received: by 2002:a17:902:f80d:b0:1c1:f5a6:bdfa with SMTP id ix13-20020a170902f80d00b001c1f5a6bdfamr2100502plb.7.1693402972678;
        Wed, 30 Aug 2023 06:42:52 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.lan ([103.184.129.7])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902eccb00b001b86dd825e7sm11042280plh.108.2023.08.30.06.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:42:52 -0700 (PDT)
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
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v4 0/4] Move Loongson1 MAC arch-code to the driver dir
Date:   Wed, 30 Aug 2023 21:42:37 +0800
Message-Id: <20230830134241.506464-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
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

In order to convert Loongson1 MAC platform devices to the devicetree
nodes, Loongson1 MAC arch-code should be moved to the driver dir.
Add dt-binding document and update MAINTAINERS file accordingly. 
    
In other words, this patchset is a preparation for converting
Loongson1 platform devices to devicetree.

Changelog
V3 -> V4: Add Acked-by tag from Krzysztof Kozlowski
          Add "|" to description part
          Amend "phy-mode" property
          Drop ls1x_dwmac_syscon definition and its instances
          Drop three redundant fields from the ls1x_dwmac structure
          Drop the ls1x_dwmac_init() method.
          Update the dt-binding document entry of Loongson1 Ethernet
          Some minor improvements
V2 -> V3: Split the DT-schema file into loongson,ls1b-gmac.yaml
          and loongson,ls1c-emac.yaml (suggested by Serge Semin)
          Change the compatibles to loongson,ls1b-gmac and loongson,ls1c-emac
          Rename loongson,dwmac-syscon to loongson,ls1-syscon
          Amend the title
          Add description
          Add Reviewed-by tag from Krzysztof Kozlowski
          Change compatibles back to loongson,ls1b-syscon
          and loongson,ls1c-syscon
          Determine the device ID by physical
          base address(suggested by Serge Semin)
          Use regmap instead of regmap fields
          Use syscon_regmap_lookup_by_phandle()
          Some minor fixes
          Update the entries of MAINTAINERS
V1 -> V2: Leave the Ethernet platform data for now
          Make the syscon compatibles more specific
          Fix "clock-names" and "interrupt-names" property
          Rename the syscon property to "loongson,dwmac-syscon"
          Drop "phy-handle" and "phy-mode" requirement
          Revert adding loongson,ls1b-dwmac/loongson,ls1c-dwmac
          to snps,dwmac.yaml
          Fix the build errors due to CONFIG_OF being unset
          Change struct reg_field definitions to const
          Rename the syscon property to "loongson,dwmac-syscon"
          Add MII PHY mode for LS1C
          Improve the commit message

Keguang Zhang (4):
  dt-bindings: mfd: syscon: Add compatibles for Loongson-1 syscon
  dt-bindings: net: Add Loongson-1 Ethernet Controller
  net: stmmac: Add glue layer for Loongson-1 SoC
  MAINTAINERS: Update MIPS/LOONGSON1 entry

 .../devicetree/bindings/mfd/syscon.yaml       |   2 +
 .../bindings/net/loongson,ls1b-gmac.yaml      | 114 +++++++++
 .../bindings/net/loongson,ls1c-emac.yaml      | 113 +++++++++
 MAINTAINERS                                   |   3 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-loongson1.c | 219 ++++++++++++++++++
 7 files changed, 463 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1b-gmac.yaml
 create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1c-emac.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c


base-commit: 56585460cc2ec44fc5d66924f0a116f57080f0dc
-- 
2.39.2

