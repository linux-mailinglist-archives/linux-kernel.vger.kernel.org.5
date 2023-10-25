Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8977D757F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 22:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbjJYUZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 16:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbjJYUYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 16:24:48 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6834D4A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:24:43 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-577fff1cae6so96832a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698265483; x=1698870283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmA5kOKekb5h3Uw1k+e0LhCWijGnTH8utnJ5szxpch8=;
        b=auVS/K/Jk7vgky4MjvSPyw3256thHNswIFM0+CHRJfw8cZMbSsKDL7aCq9OiRUFHIn
         vhqWb1Ba0aPYiVgfisYHsfrxFFdjBfLbOs15MAzbLhPHxuRqT5s81JCMSPHp7u4BnRry
         2ZPfCe8yqF4CGCh/KyUFfF2HFzYkNOEEm7i8nBl2N857thL2U0IW97wJcK88BIZUrGVV
         OYTNiUslB8+H3xiH1zs8mwP083VVwgO4yBf3eLBh2Fzc2+Waue+65NOTaD2v8RT8lmcd
         FXE3K1JffCz/cOrAvDcRniAps0d0N0MF3sseo29l7YXpoM1uetpW//TUo52Ge7kHw90C
         KoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698265483; x=1698870283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmA5kOKekb5h3Uw1k+e0LhCWijGnTH8utnJ5szxpch8=;
        b=cwsUJ8u2ud2so69Osh17GWsyDu6kpqlDiwv1/v8oJBweNBamMKFdO/BetxhXEzMtxs
         i3l2LJXseL8f6lE555Jr/mhkXGJCWr+2pIOi8qUe9swqEExov8DAvYUZTs7h9MbNPTY4
         llN/ODRwkkLrAfJ1bT7LeWeHyYlX2QijlfFQyXgT2DkvSs2qrXtJiIgMhlVqgCNk5HXZ
         q3rsEVQifVeesoekcOne0DMKwQLwqeHPHorJdo4x+IdL7/T1Ds3r9v9b+qY8JL6jn7Ej
         Fi4ppm9DFrzQxTPRt+RbPAld0t59MnKGCMhdYLmBSnsTVVEZRm1DDdi8y6+1rbHmsJfT
         u4vA==
X-Gm-Message-State: AOJu0Yxa2D5CnPV1isv2BzvZUccVQnAYBO3jioWd46Bixg1PYZhuGgnn
        tDZ+EIt6INmUrO/AfInKteaHFQ==
X-Google-Smtp-Source: AGHT+IEWaGrpkEpDFbneFUdLQrgY3wxCJPmh6tSJaEBSJOipB/ao+CEA+asAJLO3X3etojz+m4Eg/g==
X-Received: by 2002:a05:6a21:999c:b0:17a:f4b6:bf89 with SMTP id ve28-20020a056a21999c00b0017af4b6bf89mr713082pzb.31.1698265483317;
        Wed, 25 Oct 2023 13:24:43 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b006b84ed9371esm10079590pfo.177.2023.10.25.13.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:24:42 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Anup Patel <anup@brainfault.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v2 06/21] RISC-V: Kconfig: Select deferred GSI probe for ACPI systems
Date:   Thu, 26 Oct 2023 01:53:29 +0530
Message-Id: <20231025202344.581132-7-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231025202344.581132-1-sunilvl@ventanamicro.com>
References: <20231025202344.581132-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On RISC-V platforms, apart from root interrupt controllers (which
provide local interrupts and IPI), other interrupt controllers in the
hierarchy are probed late. Enable this select this CONFIG option for
RISC-V platforms so that device drivers which connect to deferred
interrupt controllers can take appropriate action.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 8c105a151e12..b62441aefa6a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -12,6 +12,7 @@ config 32BIT
 
 config RISCV
 	def_bool y
+	select ARCH_ACPI_DEFERRED_GSI if ACPI
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_MCFG if (ACPI && PCI)
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
-- 
2.39.2

