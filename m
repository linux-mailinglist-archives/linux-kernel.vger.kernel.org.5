Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9858A7D3DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjJWRaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbjJWR3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:29:50 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34CD10FF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:29:16 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6bb4abb8100so2854696b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698082156; x=1698686956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36mJhajWQppw1r4vewDK4hFKpILxPms9Bh84cWTmNnE=;
        b=LluxEBrRHQrFQF1u8V8xNPaJglNbQcJsrrwT2tQTExFMPiUqTGE/f6QJe0TR/AIHRy
         0JIFgG9mmENjP3H0ewoUiJsOXAmDzoP8HUGpdxTXSmFZGCEN6FbwUZjjx26kXYbjH7bW
         plRDfsCybkSXmdzx5i4ueDEvkUp4CdDQFeRGUN2rhHAuvEKBXH3upcOe/89XfsqOeVeK
         mQ2b48mmOELgzJzOCHezeWY8Xz4KNxGjiDIPgEgOTpIOVhUHh5bAR/10msNCJGf3bja8
         PkKMvoEWqtOpcG+uOGVF/yuloMJu7in/JOsxApJqMT+hul3Lr2x17NB72sUigQQ0zPXA
         QA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698082156; x=1698686956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36mJhajWQppw1r4vewDK4hFKpILxPms9Bh84cWTmNnE=;
        b=C4UoglvE5uuqPoBV9XbkZYTS1uDO+tsCJEK2jMKpLXY/nBvelP00FQhLnlGtZqInuc
         hjxmUrLTNUYGVBaRK6MlN8cWyBdWHI02SIigusbZy6l06TwA1Ry+LJ3J3yHWDnqpgOrh
         qIjzI3+jHr0I/EyajVqEeBOTNe3ThjehF82gQ+LHuIK5hYyvEQ0Or17//GAJxNjxKDDb
         cWrn9paFVAhSAGqC+e+pkvE9DuhgLCVag9mi8pyYxnMSSwPRVU3/vGDt2gqZnueZkH/R
         WnHWMBubMFWA70RE/wy1KBKmHDIQW10d9QcKbJhKh07J63XT6jBipjjWCi7zd2l3xamF
         NlmQ==
X-Gm-Message-State: AOJu0Yz0kVrsYhYD/jBngHwUPBAa2q3IvtbUm4HKBU7eHeELuy+kggRH
        iTT4gTCnFdF4x0d5pfhuX6BRyg==
X-Google-Smtp-Source: AGHT+IFQlv4hAohFN2/tiwcRFKZLmk7B908S6YeDyALw0pkI0TorMC0K86E+LZulzmkBDxtFYTRLeg==
X-Received: by 2002:a05:6a00:c8f:b0:6b5:608d:64e1 with SMTP id a15-20020a056a000c8f00b006b5608d64e1mr8900912pfv.33.1698082156176;
        Mon, 23 Oct 2023 10:29:16 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.86.9])
        by smtp.gmail.com with ESMTPSA id g5-20020aa79f05000000b006be055ab117sm6473194pfr.92.2023.10.23.10.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 10:29:15 -0700 (PDT)
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
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v11 13/14] RISC-V: Select APLIC and IMSIC drivers
Date:   Mon, 23 Oct 2023 22:57:59 +0530
Message-Id: <20231023172800.315343-14-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023172800.315343-1-apatel@ventanamicro.com>
References: <20231023172800.315343-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

