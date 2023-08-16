Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3326B77E00C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244072AbjHPLNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244102AbjHPLNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:13:37 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3E0E40;
        Wed, 16 Aug 2023 04:13:36 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68706b39c4cso4621589b3a.2;
        Wed, 16 Aug 2023 04:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692184415; x=1692789215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eSBjZcOTJy2eXVm/XkSIxwA5C0+XmtEjUZslwEUGHl0=;
        b=KJ8rCY80WwxTbXcyh+gjS1GYyly+ntK9J2ynh3Qo7r6hatiwykn1YYxBq+htFiIYJo
         t+YP9HTO+NlsfGLHVpYlVvHlMQzkfGZC2Jgqdid51TzG83A4npah8Q8x3Ve79yrvDGif
         nDW8s4DKhO+zaenTAV3lefrJaBh/nwZrbxD9URJYUHGrxSBl2ilFWhdVNfqJ4eODkHx7
         +zsIJZotay5aMpe92WZxDem8BN1ed7JTfaet+7ileJnrWfLpk28yK/1f1NZYwf8lBpHN
         Og4pmzsJfjnNXQ1dWYLfVmJQPNh9OXJtI53GcCiV951sk1z7jbO/9gRuODrpLkvXqJfM
         hjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692184415; x=1692789215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eSBjZcOTJy2eXVm/XkSIxwA5C0+XmtEjUZslwEUGHl0=;
        b=EjITisODL4KWuMR+1nVeawF9LoT1L2OZb2IVsEWJJBuMcZIcPGcRkIcLsxpzr9MEGr
         tbayT0jrI9AhoPDFl5wZHDr5NINtA5MEoTrGHbtCVdyutu88ZkNx7xPRinTOasHRd31j
         i465HKPFah80SlhXHNKYRCwUP4dLJ2Dd42VM/uOU6ipoX4XfMqTK1Zf+vA14lTTP6ObQ
         aaCrpxZe2MgFLHoGJOhIqWIcf4OgmbCHurc3wPCXZztKHP63027sY3LPrKp4+R1swH32
         kgIqKgUqbQTGUMMAB1s2NbJqd93ips3mJ7OjOgayN2TK9L6c/bwEL1TTul7cbNeSv1OJ
         Uy3Q==
X-Gm-Message-State: AOJu0YwGgs9+gos7jmOwSjZSwIGSVzpUfFNkmESTxYAcw5trX4TY7H1v
        crEtmWwn2dWy3cs7Sdxt+6v7ZCw7AwN5GWqK
X-Google-Smtp-Source: AGHT+IFWUErPVlP5682GLOgiwU48XugxogYfBtezH+idqJVmmax9mtxgiaR+BUBEuqNn6mi1UjRNJw==
X-Received: by 2002:a05:6a00:399f:b0:686:2ad5:d11c with SMTP id fi31-20020a056a00399f00b006862ad5d11cmr1498244pfb.33.1692184414911;
        Wed, 16 Aug 2023 04:13:34 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id r8-20020a638f48000000b00563e1ef0491sm11750627pgn.8.2023.08.16.04.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 04:13:34 -0700 (PDT)
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
Subject: [PATCH v2 0/4] Move Loongson1 MAC arch-code to the driver dir
Date:   Wed, 16 Aug 2023 19:13:06 +0800
Message-Id: <20230816111310.1656224-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
  dt-bindings: net: Add Loongson-1 DWMAC glue layer
  net: stmmac: Add glue layer for Loongson-1 SoC
  MAINTAINERS: Update MIPS/LOONGSON1 entry

 .../devicetree/bindings/mfd/syscon.yaml       |   2 +
 .../bindings/net/loongson,ls1x-dwmac.yaml     |  98 +++++++
 MAINTAINERS                                   |   2 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-loongson1.c | 273 ++++++++++++++++++
 6 files changed, 387 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1x-dwmac.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c


base-commit: ef66bf8aeb91fd331cf8f5dca8f9d7bca9ab2849
-- 
2.39.2

