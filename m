Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAED77A0A4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 17:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjHLPMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 11:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjHLPL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 11:11:58 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE40171B;
        Sat, 12 Aug 2023 08:12:01 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-26837895fbbso2001720a91.3;
        Sat, 12 Aug 2023 08:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691853121; x=1692457921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kLJorMlL6hfqjCM48v52PYqEdNPQtxhp1HCXAeYBAoM=;
        b=FdObHNE2jednt/gMSOvuljKxBw5KmUvVCylKbyUD+D4afoeky1RIpGWnqTOlZrgY6R
         bf+P5UNIHEb8tMBUmVYAdC+OhqtZwHR07AmKp/ZRvZkU3Jt4juX8aKfKVniZMDQL1Z96
         CRec6p08c/9YPPJGw5fcdYu1oSA2A+ulrkxDm7FKcMJ8MKUzUcFEhv34lsqNUuOL2UNs
         oxjNitu5MAOt1IWOIyLFg7oMaQqRuEOEGUMH8gAtaO2H+WkMxIxMrR9rIUjRiVKwMzRZ
         YL4ZVBK32rQm/nUxfUgaUTo9WG4rotLHOC03nEuX/gmFe3tEFT+G1U9/YIo4dYZcNamd
         tgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691853121; x=1692457921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLJorMlL6hfqjCM48v52PYqEdNPQtxhp1HCXAeYBAoM=;
        b=d6zd0k+jyfRz3dEmLOF6whm+rn3Q+mPeOpfEnOEDzNX4EvHP0cISVQqBCET2xRiXHp
         4q89FyUijTqzQnCpshK+DPckp6IbCo0ZKiJrJW7juKg7SX4Wu2eZvnPKj/fiEIO1dhKC
         lTkrwEtd4uiCet7zwThCnqIiUGnSn9xc9dnSep5f22Jc4BQF3R5ZA3XqbgisNT40eQs4
         cDZZj0DyWIGgMxRkVxsjuikSJ54c0ywc9btjKndvxOBre19Cj203/At33U8ngDeoLUXJ
         EMGh1BxvUvmTsI/srQbjbjkrSTmJc3JKeVz2FFAObn7M2gfFgZH446JzQ0DkzmBEtEEF
         BR0g==
X-Gm-Message-State: AOJu0YzSZrLQm52z9o5jPYzgSZgc9dJcgclCQFzCcJt0ZEt4//PaG7cj
        AGfTfdwbH6a/B8SX0OATRkDiJKkv4xQWh05n
X-Google-Smtp-Source: AGHT+IEqP+xKIcFC285EPyhVzS2Z6SWw7VLVDaiMxz4bWKwdsTAFaf210apQ45+cIXlxaG7AI+ompg==
X-Received: by 2002:a17:90a:4f4a:b0:268:5477:811c with SMTP id w10-20020a17090a4f4a00b002685477811cmr4445249pjl.23.1691853120729;
        Sat, 12 Aug 2023 08:12:00 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id 17-20020a17090a195100b0026b41363887sm1040927pjh.27.2023.08.12.08.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 08:12:00 -0700 (PDT)
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
        Kelvin Zhang <kelvin.zhang@amlogic.com>
Subject: [PATCH 0/5] Move Loongson1 MAC arch-code to the driver dir
Date:   Sat, 12 Aug 2023 23:11:30 +0800
Message-Id: <20230812151135.1028780-1-keguang.zhang@gmail.com>
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

From: Kelvin Zhang <kelvin.zhang@amlogic.com>

In order to convert Loongson1 MAC platform devices to the devicetree
nodes, Loongson1 MAC arch-code should be moved to the driver dir.
    
In other words, this patchset is a preparation for converting
Loongson1 platform devices to devicetree.

Keguang Zhang (5):
  MIPS: loongson32: Remove Loongson1 MAC arch-code
  dt-bindings: mfd: syscon: Add compatibles for Loongson-1 syscon
  dt-bindings: net: Add Loongson-1 DWMAC glue layer
  net: stmmac: Add glue layer for Loongson-1 SoC
  MAINTAINERS: Add entry for Loongson-1 DWMAC

 .../devicetree/bindings/mfd/syscon.yaml       |   2 +
 .../bindings/net/loongson,ls1x-dwmac.yaml     |  98 +++++++
 .../devicetree/bindings/net/snps,dwmac.yaml   |   2 +
 MAINTAINERS                                   |   2 +
 arch/mips/loongson32/common/platform.c        | 127 ++-------
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-loongson1.c | 257 ++++++++++++++++++
 8 files changed, 396 insertions(+), 104 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1x-dwmac.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c


base-commit: 21ef7b1e17d039053edaeaf41142423810572741
-- 
2.39.2

