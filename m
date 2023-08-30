Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F148E78E00F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240914AbjH3TbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244689AbjH3NnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:43:14 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84CAA3;
        Wed, 30 Aug 2023 06:43:11 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bdc19b782aso35692925ad.0;
        Wed, 30 Aug 2023 06:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693402991; x=1694007791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtWgGFC8eXvRcZ4S/vmdUIxm0pQa8RJFaKyI9K5rklc=;
        b=YroWy06pxP3SZipKqg9gBeW/XyliFA9qDR/0T0hAE9Opa3IlSyrXggz0eroXLXiyQv
         SfNqi4YhutiWuzQcfb6FL9JviMT7QP0ujASaavP1FEP2kAQFkz9sGk/aSHB8FVLdxhPq
         PClJ/p2nnwugKGwCr+0fxMrdgxlq8d2Ax4JSytlM0k0hDNcrRCwVHjyNb4IbUZ10AiOy
         LucSgQOyxxVN0pCLv86auY2p1HtQT2VCqxq69Km3R9wt4mZ7aXXI1cGzRpkmOaMVFZH8
         stXcRciREQDJCs0g94nC/Qlhe9bvc1FjPb/kfdBha6YcuWg0GiTkk9wdgJHkiijYg7W8
         B+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693402991; x=1694007791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtWgGFC8eXvRcZ4S/vmdUIxm0pQa8RJFaKyI9K5rklc=;
        b=cbDzY0rLISy3PWiTmEV5rQd9T/fLWPnCDHq4wYJSCF2WUsI2+2/u8GP0Od2AZ2lYO7
         Nmu6j7ZiYiOmWWzMqH5RzT7EXGIB/oeL7WD/mTB2hcuENUuShn+cAdfYG/D2R477mTmq
         sqY0NwuMtJQSrpbFTPR1+RUhTT1DXwMRwgvUYrAHNnzbEg4Pumxkdr63LwxqvkMHrqTh
         T2nWceTwic60IFP82Szzr9+sXA7pPvfL1kODvsUcn7XCfMCnQaBit+eGjLHuilgY9BeB
         0+iodvlrJiKxXuacZyBCFEMsck0+kOYw3t9cfiiNtbnM1WXBPQYEdRP4+WRsf8BG7WHZ
         y+Zw==
X-Gm-Message-State: AOJu0Yxp26VDHLcWCI7hWkaTkZUYwCfEQj8oFjdq5eBzCDeK+3JZM+Bj
        z2RZ/PrnnSuASyBRYlWQOBTaVhZHz+MAqTbT
X-Google-Smtp-Source: AGHT+IGhhQGaiczvMzbvcGOgfeWfIwYFWKkyxmisUaNMVWYOYp9q1YsFXLqI2SQiSWFEWhKejfZtDA==
X-Received: by 2002:a17:903:2344:b0:1bf:73ec:b980 with SMTP id c4-20020a170903234400b001bf73ecb980mr2266783plh.66.1693402990946;
        Wed, 30 Aug 2023 06:43:10 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.lan ([103.184.129.7])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902eccb00b001b86dd825e7sm11042280plh.108.2023.08.30.06.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:43:10 -0700 (PDT)
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
Subject: [PATCH v4 4/4] MAINTAINERS: Update MIPS/LOONGSON1 entry
Date:   Wed, 30 Aug 2023 21:42:41 +0800
Message-Id: <20230830134241.506464-5-keguang.zhang@gmail.com>
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

Add two new F: entries for Loongson1 Ethernet driver
and dt-binding document.
Add a new F: entry for the rest Loongson-1 dt-binding documents.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
V3 -> V4: Update the dt-binding document entry of Loongson1 Ethernet
V2 -> V3: Update the entries and the commit message
V1 -> V2: Improve the commit message

 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ff1f273b4f36..2519d06b5aab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14344,9 +14344,12 @@ MIPS/LOONGSON1 ARCHITECTURE
 M:	Keguang Zhang <keguang.zhang@gmail.com>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/*/loongson,ls1x-*.yaml
+F:	Documentation/devicetree/bindings/net/loongson,ls1*.yaml
 F:	arch/mips/include/asm/mach-loongson32/
 F:	arch/mips/loongson32/
 F:	drivers/*/*loongson1*
+F:	drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
 
 MIPS/LOONGSON2EF ARCHITECTURE
 M:	Jiaxun Yang <jiaxun.yang@flygoat.com>
-- 
2.39.2

