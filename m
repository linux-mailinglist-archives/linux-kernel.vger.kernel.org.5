Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386117D3DBB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjJWRaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbjJWR3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:29:52 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EB61739
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:29:21 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5ae99bb5ccdso1816132a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698082161; x=1698686961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Z+lM1psdaIr4vqzMn22M1QYDstohuJWu+yz55IiCnA=;
        b=FWz9cTzTFoLUyU1GHdasai+atLj/rWbT3oQ+M3vgLxZi/eM8bABmnW1QhAPo7yczEl
         qa7RleVFtWl4SSuPF800ubDAKJS11TDLKHEz5L94FZf6KTnM3YWBp1EDgC8RM/s4zgMo
         B1gXNzva7fSzXgxwpzg4zSGIp104FPe2PIum4+KcNHxIfhIWbzAcf1J/XTkub2kwPByE
         g2xFq70etWLIZWC9ncgPO3T/I98A0h0aPLRqd3T5YWuVikcbniDAWJwvAZV6QpJC7t7G
         7oXpDk2JvjCDnYALPyNJ0CUx52N4hOFSzJIglMS0oUJBiuXnTWGKH6zEPOZsA8qKmYYP
         F4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698082161; x=1698686961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Z+lM1psdaIr4vqzMn22M1QYDstohuJWu+yz55IiCnA=;
        b=b56gvPAsIfliU3KxbgHDtoMS4dBEmSdfH4q+Qcc3D8xL7Fabdc9pEZFgTtUTn70OUF
         EDhsT5esZsnyugCb2xt3Ohf+DaeuvUgSoaloud/Ng9QRnncvxIa4pCPHeF8XBFV/1rT9
         ZAR0G8Cx8U32vpo7dbW3vYplYZB6MkZMP2VqURrFr/KjSMidj/kDxeCRYdzKkjsfekW8
         K92yq0QljCwvuXCpHIG0jXAcNRDfq7ow+MrMV2NLWo/jVbzN8wpUG6C7+JvPsZ663kED
         lwb1f9VUmfz7kOM5Xov0dntDiSJzWbsEukhzJ6uC0ZJYtD1H87o8dsoFIxKlZHFZvY3y
         LgHw==
X-Gm-Message-State: AOJu0YyscRLDxwtfAK5Dw83zsItFgsX7vyOvEmLwEGPYzxsAppPe3wXu
        NuxlK5CK0FcDwTStto4SM0I3pQ==
X-Google-Smtp-Source: AGHT+IHo6USP3pcRlXKuqJ79woJTXEsC0Rq2g43o4Sr9KzMGrxRYLsluIqp45MjwhV/47Ir+x9eEvA==
X-Received: by 2002:a05:6a20:daa3:b0:157:609f:6057 with SMTP id iy35-20020a056a20daa300b00157609f6057mr319511pzb.27.1698082161065;
        Mon, 23 Oct 2023 10:29:21 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.86.9])
        by smtp.gmail.com with ESMTPSA id g5-20020aa79f05000000b006be055ab117sm6473194pfr.92.2023.10.23.10.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 10:29:20 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v11 14/14] MAINTAINERS: Add entry for RISC-V AIA drivers
Date:   Mon, 23 Oct 2023 22:58:00 +0530
Message-Id: <20231023172800.315343-15-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023172800.315343-1-apatel@ventanamicro.com>
References: <20231023172800.315343-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
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
index 801a2f44182c..4557675c6086 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18410,6 +18410,20 @@ S:	Maintained
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

