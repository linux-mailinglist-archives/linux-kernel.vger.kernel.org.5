Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED12979D80F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237391AbjILRwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbjILRwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:52:06 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483841722
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:51:51 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c1ff5b741cso53884215ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1694541111; x=1695145911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36mJhajWQppw1r4vewDK4hFKpILxPms9Bh84cWTmNnE=;
        b=dLyJ0In8g2tzAQ5nH8ZwWqnx4HAZl3wma3kUpU3lHqzcep8L+N6dc21fRLjJVqJEGn
         9tCHwM7fwl7KMPTLAQQzdPCsrVdxWYGS0cL1SA192Vso9ZxgBk7VD06dENJ5n4tAHo91
         os/i8RYTEdHw9KJkOizZy0lk9miiljlEyzB9yaWfMsKiv3zxPtbUDqU4MD8kiMvFndQS
         DsXWvVYbapg08aXZE3lggob+SE+t+6paCLPTbvtAncVsPX9RDtyKGdZuZKNo1wJSsGF4
         OQvghNCYoc9+DG9rc9rFh28zRJ/ONzR9XB2/B1KF71Ze+KMueknpoTnm6pkBFb0FKtV2
         tjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694541111; x=1695145911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36mJhajWQppw1r4vewDK4hFKpILxPms9Bh84cWTmNnE=;
        b=R8BuogUGPUcyGGOZ5vsAWys+Qeob8tStOVoyuVx2nuGB/kozx6DUwh5fyQiSEjk4q1
         ft7x2WUCxOT2absQnJw/anECxQc6aB5lnPo4+EvLOvK4xjfSs1aSteNnqrYasbSz4LVM
         MJXIS778KqMDQpHp9UDZTRez5hE6IJBmYfVtnTRdPhGTubcEFqehQEyx8o1VXeIv45P+
         DmlEDpDersHLqGi/SuIZwGl5WsvvtkesjLlWOlej/Db6qhTujzISF8bdbWCkHTKWBd7K
         2wFSkihoWxZDx3TOxnu3tUaipEDTgWglZMs5/5xCghL/hPgj5boaGEhQJhwatauMckvB
         ul1Q==
X-Gm-Message-State: AOJu0Yxf+hnXRwP3ZCZTqQioCtwKZwIVXhNrs0zTyNJhvXxZXOALRauR
        LdMs5lMNMs9RAtqxsCrDmO5Prw==
X-Google-Smtp-Source: AGHT+IGzKiv6aVWHh57FmWTPTv7VGb8lmd++nbi2X5IKfa8UeOaBY9kForZ40pmyk5JQrBe5XHEEzg==
X-Received: by 2002:a17:902:be08:b0:1b0:f8:9b2d with SMTP id r8-20020a170902be0800b001b000f89b2dmr447310pls.29.1694541110710;
        Tue, 12 Sep 2023 10:51:50 -0700 (PDT)
Received: from localhost.localdomain ([171.76.81.83])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902a40c00b001b891259eddsm8691440plq.197.2023.09.12.10.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 10:51:50 -0700 (PDT)
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
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v8 15/16] RISC-V: Select APLIC and IMSIC drivers
Date:   Tue, 12 Sep 2023 23:19:27 +0530
Message-Id: <20230912174928.528414-16-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912174928.528414-1-apatel@ventanamicro.com>
References: <20230912174928.528414-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QEMU virt machine supports AIA emulation and we also have
quite a few RISC-V platforms with AIA support under development
so let us select APLIC and IMSIC drivers for all RISC-V platforms.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d607ab0f7c6d..45c660f1219d 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -153,6 +153,8 @@ config RISCV
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_MSI if PCI
 	select RISCV_ALTERNATIVE if !XIP_KERNEL
+	select RISCV_APLIC
+	select RISCV_IMSIC
 	select RISCV_INTC
 	select RISCV_TIMER if RISCV_SBI
 	select SIFIVE_PLIC
-- 
2.34.1

