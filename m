Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5077B127D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjI1GOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjI1GOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:14:19 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B14198
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 23:14:16 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-3513fa06bafso25697545ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 23:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695881655; x=1696486455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHuIvMJs8qzoPXhYXObNPxhAaUcGW9Ddxs7u6Di5I3s=;
        b=SR2hHAEWA7zh1pp+sRV0ysuSdn9TadbN6mkXvh8yz76bZ8A2r7VqccOb/axxhLl1dQ
         p/A0z2C2z+426E95uDfDJn5oGARpCN2RJX1+Osi2+1ex2S3ZgaH4LIvbe/pNBfrwWjQ3
         iuJMzXG2gtJAAXYuCe9bzhhtKF191dDZLGCOeNb33IJbMFwgiPtk5maT4FP+qqcJK79w
         a2P5rjvi6+/K6JSHLlVZdUGEJ7WoIsEa00lPCmfVDdD9JQyOV77f1C3qWzqL0zBborp+
         E5Jj/Fe6cZ3xGU+2Goa7Uu4WB4eY8pVib4/50P4ghRWjCHJh7BUvhV6OMxmMmItOn0Yc
         l4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695881655; x=1696486455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LHuIvMJs8qzoPXhYXObNPxhAaUcGW9Ddxs7u6Di5I3s=;
        b=W+lvadfWrrVC14sj8OoovQ0npW9xOUwGdVqtR792JXrkRdmaq5Rdg6pB4uVpkucm1p
         A6l5Lc7neXhCo+3ml9QJS5ps6do1yJLgfq5Ioaq4G/DFsnGu4FBGe01bxYGxGIYsJY7/
         ZeV/RmchvJ0BorNoxRHIxavkPVW627NsN3U3qM/ScGIJbOC4dHIUOl9Vf6+fuliZp99i
         1WPyJEe53TtDhegNkXpfHSZl7lfEZNQ21DZFnGlNECWnTnbemk04nrwwXnj8JNODZQj3
         2fFhgQ8nfe4PO6sYdvzCOqHtevz2GdIGHsmccShEr8F+zPKVteoph6OU67ScTRpwbEk7
         iWLw==
X-Gm-Message-State: AOJu0YwijtHlLQ6HDB7Zt7SSOjPT6u6BMDQPhT0tw0VFhS6cpROBr+B/
        Oi1CYExmcMZ2p5VtEs+1HUrmVg==
X-Google-Smtp-Source: AGHT+IFTu6zFLWGG5N+HYwj83ugftb4GPLwahJWLeQeUPg4Ri/nzVup+T9WjH0TGUx0jYGkXS+msOA==
X-Received: by 2002:a05:6e02:152e:b0:351:5acb:271 with SMTP id i14-20020a056e02152e00b003515acb0271mr335799ilu.1.1695881655365;
        Wed, 27 Sep 2023 23:14:15 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id x6-20020a92d306000000b003506f457d70sm4774467ila.63.2023.09.27.23.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 23:14:14 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v9 15/15] MAINTAINERS: Add entry for RISC-V AIA drivers
Date:   Thu, 28 Sep 2023 11:42:07 +0530
Message-Id: <20230928061207.1841513-16-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928061207.1841513-1-apatel@ventanamicro.com>
References: <20230928061207.1841513-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as maintainer for RISC-V AIA drivers including the
RISC-V INTC driver which supports both AIA and non-AIA platforms.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7518be65d782..92b2b1e6a673 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18411,6 +18411,20 @@ S:	Maintained
 F:	drivers/mtd/nand/raw/r852.c
 F:	drivers/mtd/nand/raw/r852.h
 
+RISC-V AIA DRIVERS
+M:	Anup Patel <anup@brainfault.org>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
+F:	Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
+F:	drivers/irqchip/irq-riscv-aplic-*.c
+F:	drivers/irqchip/irq-riscv-aplic-*.h
+F:	drivers/irqchip/irq-riscv-imsic-*.c
+F:	drivers/irqchip/irq-riscv-imsic-*.h
+F:	drivers/irqchip/irq-riscv-intc.c
+F:	include/linux/irqchip/riscv-aplic.h
+F:	include/linux/irqchip/riscv-imsic.h
+
 RISC-V ARCHITECTURE
 M:	Paul Walmsley <paul.walmsley@sifive.com>
 M:	Palmer Dabbelt <palmer@dabbelt.com>
-- 
2.34.1

