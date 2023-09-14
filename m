Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640A77A02E5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbjINLpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjINLpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:45:07 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527469B;
        Thu, 14 Sep 2023 04:45:03 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c336f5b1ffso7061375ad.2;
        Thu, 14 Sep 2023 04:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694691902; x=1695296702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t+kQMiG2y9xvH6Xiq+UYTxDs8hYtVgDtBvxZVJtfEGc=;
        b=kvRR3QtDI9AFC0VJ1zlYzrnjA1n1fcJhsWu10HMiKyHKVgUkwSLBqEm0kuvi4DxHuS
         np54vIN67BfCNV4owzskh7AlLY91bMbJzQAeht51orTRQ5X9QcWZLmSub5ncKzjgbqar
         rSAJm9S0bLhxMa80P20znXXtthVCTkRVByDj3ushN1V6K9mEt/Okh2oCX3TNw7FEPoQT
         kMCrP7nA8jw2QikiKUwHiRy3g/lKP6sTWFndiZYozqrAY/AHVps4/OcEzlsg/Gv/p0Xw
         wcGbYlloNfhZ6jH4pY1sWm325kIjOFRAHiei19XvX9QNv2uFQNCFROx7p2Z3cTmRqBKL
         SP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694691902; x=1695296702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+kQMiG2y9xvH6Xiq+UYTxDs8hYtVgDtBvxZVJtfEGc=;
        b=N7xV3v4Qg+w+e263IqoWFUXOnT3ajnNqAIH0LQS/SQ0wYzMehMH3BQgywOAlPSwcE8
         h3hSXQTi2lByOtTHJdbXT0EMm6qglGOFj4k5OObT/I0zMgEwG5vkhpINln2DRKpYIw2s
         7Kzqc0tZyr7b1pZcdRVRi9f9iD3MUnAwxYEQRG/OLZxPUnhOkiZyV5k9DwCcjIkwcvAN
         KRA8bGx8XrD/aVYHtCyHYddZMzjGYKC7dbhAbZ7toraFnxesonVahHpgG7O22r2Po/F9
         81CDCRLUFa9ZVyKFeV9unKkiSKZeeZvMUNFSKYW8XQgYiKSb40H+L3qSqgZWr9+Exmm/
         DQMQ==
X-Gm-Message-State: AOJu0Yw+TCH7gtE3d3Pqfj0CS4jM2qMv0/R/OmebFq6RzH9EiRy355MR
        yZF9AlOib425CfvXcLObjwo3nNk9JHo=
X-Google-Smtp-Source: AGHT+IEdZ9OrlDQ1wj3a9ISCrzIrmQXHthOjb6+jUzE6gs8Mxu+sKRczcap9QjioakM5ICsyznnWXA==
X-Received: by 2002:a17:903:22cd:b0:1c3:52ed:1905 with SMTP id y13-20020a17090322cd00b001c352ed1905mr7039337plg.28.1694691902278;
        Thu, 14 Sep 2023 04:45:02 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.lan ([103.184.129.7])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902748c00b001b9cea4e8a2sm1388570pll.293.2023.09.14.04.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 04:45:01 -0700 (PDT)
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
Subject: [PATCH v5 0/3] Move Loongson1 MAC arch-code to the driver dir
Date:   Thu, 14 Sep 2023 19:44:32 +0800
Message-Id: <20230914114435.481900-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to convert Loongson1 MAC platform devices to the devicetree
nodes, Loongson1 MAC arch-code should be moved to the driver dir.
Add dt-binding document and update MAINTAINERS file accordingly. 
    
In other words, this patchset is a preparation for converting
Loongson1 platform devices to devicetree.

Changelog
V4 -> V5: Replace stmmac_probe_config_dt() with devm_stmmac_probe_config_dt()
          Replace stmmac_pltfr_probe() with devm_stmmac_pltfr_probe()
          Squash patch 4 into patch 2 and 3
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

Keguang Zhang (3):
  dt-bindings: mfd: syscon: Add compatibles for Loongson-1 syscon
  dt-bindings: net: Add Loongson-1 Ethernet Controller
  net: stmmac: Add glue layer for Loongson-1 SoC

 .../devicetree/bindings/mfd/syscon.yaml       |   2 +
 .../bindings/net/loongson,ls1b-gmac.yaml      | 114 ++++++++++
 .../bindings/net/loongson,ls1c-emac.yaml      | 113 ++++++++++
 MAINTAINERS                                   |   2 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-loongson1.c | 209 ++++++++++++++++++
 7 files changed, 452 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1b-gmac.yaml
 create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1c-emac.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c


base-commit: 98897dc735cf6635f0966f76eb0108354168fb15
-- 
2.39.2

