Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9339786F9F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240632AbjHXMvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240978AbjHXMur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:50:47 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FC51BC8;
        Thu, 24 Aug 2023 05:50:43 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bf078d5f33so53150665ad.3;
        Thu, 24 Aug 2023 05:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692881443; x=1693486243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CPGA2PqvTvxDxPUm4kJktqjzcvQ4BR3bH0TjBHCvGQM=;
        b=Qad0aFwEbG6AfK04Soj34z351tG2HWregvOeuM9asZPbEzKvTD0xDNBdqqAhh9O6/K
         naHgvSrFqvNdheNyKKpuWBjfv5dzvsU2LZ2JunVkji/P2+dmgFnd0ip03snbn/cDiFRg
         cOm3RzMhbrbGkxiBPfGZwcDlr4qzmb9XCacIn1LlCH7T0nhVRk3XsjQBgDyCQQm7XuuN
         YfsjuljLWiKMhTDmoYP7My6K2yer2pGlVhNEIOBvxrLunlV3gmVDYWi+6H6F6EbVNlmP
         8uWOThmI5XRXRVskeHByDCrFzHPKsxN1p71r1DGaeW9Im3zL8zQ/tDZJZ7q6VNuyAV3s
         gRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692881443; x=1693486243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CPGA2PqvTvxDxPUm4kJktqjzcvQ4BR3bH0TjBHCvGQM=;
        b=cqmGeYUSefsYh4Jt2m88BU7qv8WzUYZxbRosKIkq7i+xBxi8biZ6Gt1XsFgG4UI1m8
         Jg+YlzchPuiduAYfbunzX1TbwZdz3UdBAXJQcedO6MA8aj9N6Hs75e/P/ZZkvRtEq6Xe
         7VYe34Wl9cjPDQEg3NuTuM+5WyI1/XC9SkUD1ikFnHIenDKkxGmmjxPDOMBt3+S33ivs
         YpqYMLLDZRUDRbSO5P4Z0oJJ0FddEUeT3Fo5Y9AQNlvEBPecWYo9dS93aA81sLdp/gOw
         yRP235EuSlv2qiQhB4z7nkzSE3l0YohODCVTvhL03CYee1YkociM2xQoaJZUrwCzaH1n
         snoA==
X-Gm-Message-State: AOJu0YytSLa9PhB4ywYgU9R3n5Un8GtAE1gkJ5Xx5VUy6I1Utrhw0019
        OsOVIGUx5P5q/8Ld/BJcN8hqHwJIEHWQj0IB
X-Google-Smtp-Source: AGHT+IGo6MxMuhHVF+U4go81U3GGE1ONESr0BwzbCMtkD+UaIdBTJXmxSVAay7/DddBuZDWO37M+Qg==
X-Received: by 2002:a17:902:ab5a:b0:1b3:d4d5:beb2 with SMTP id ij26-20020a170902ab5a00b001b3d4d5beb2mr17167611plb.9.1692881442723;
        Thu, 24 Aug 2023 05:50:42 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.lan ([103.184.129.7])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902c11300b001afd821c057sm12837295pli.58.2023.08.24.05.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 05:50:42 -0700 (PDT)
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
Subject: [PATCH v3 0/4] Move Loongson1 MAC arch-code to the driver dir
Date:   Thu, 24 Aug 2023 20:50:08 +0800
Message-Id: <20230824125012.1040288-1-keguang.zhang@gmail.com>
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
V2 -> V3: Split the DT-schema file into loongson,ls1b-gmac.yaml
          and loongson,ls1c-emac.yaml (suggested by Serge Semin)
          Change the compatibles to loongson,ls1b-gmac and loongson,ls1c-emac
          Rename loongson,dwmac-syscon to loongson,ls1-syscon
          Amend the title
          Add description
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
 .../bindings/net/loongson,ls1b-gmac.yaml      | 115 +++++++++
 .../bindings/net/loongson,ls1c-emac.yaml      | 114 +++++++++
 MAINTAINERS                                   |   3 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-loongson1.c | 240 ++++++++++++++++++
 7 files changed, 486 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1b-gmac.yaml
 create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1c-emac.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c


base-commit: 2b3bd393093b04d4882152398019cbb96b0440ff
-- 
2.39.2

