Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9F27D7570
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 22:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbjJYUYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 16:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbjJYUYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 16:24:31 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B027519F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:24:26 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6bd96cfb99cso126677b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698265466; x=1698870266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8oe0TQ1+zZd/3zKJQAEE+us/MvQWSBihayeSKyJW3A=;
        b=B2QZEsvNG1mckIay9FM37B8+RnbVBxmNlf/31hZqak2JAmMmKKpO3kQ3+QwfNmjTqx
         WCHcf/DzVJlqsxO6h6FGcQQIB3fQvcGK0Xhm7PP5EI8GSSnFruJdb5VNBMmgZSukgjll
         hKkTgNdRX9DqS/9NVqSpYuTi8qQkluwSgds8Na3VFhxvltoRNN7JUqh0xw6EkGo37+km
         keMHZ8eewlPoof4/eNfdheg0AU/D6rS75EXHTf4AOzcv8yobdEXv0yymXFKR3BiSpp61
         txpZSki5CdlRBVvI4nTwBUCbz1S+qpkkDSvq78M6AgKDV+yzA4w+RdbxsqXehsdzMq2V
         XcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698265466; x=1698870266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8oe0TQ1+zZd/3zKJQAEE+us/MvQWSBihayeSKyJW3A=;
        b=FJF2M0JW8gYZIpFi9hchIw7FhZSlW6xvD2JKAcAUSjX7DtFDXEmwNV7vDzaPph3YrO
         +Y1VkUSDzeXokRbOUNqxVB6SR17KJGmGXa29nQMpsKVS6uUz5FyA94LjruDrFWAFKBxU
         PFfJrLT9Zn1y/c0vlNEm86nCrTShxTlIMcVbnovo3fWYeB8O8q8vL8wEjI0qvPnxlKt5
         yNx8D1y56qbqrpr2TTBOiP7U95uIyx03UYtG+TISFWmS/x1x4rqk6P66wDRu/Nf2wBeP
         vFxpbJXATKttgEAhdy3J5zl+cXp9Oq4gG1yZSPlfVWBRmLFsQ9W/tCG2bkA4jXhUYDqG
         yUAQ==
X-Gm-Message-State: AOJu0YyvHS+diBl6xbYnJC5p5Mb2gsjsvPM5MExcmYJ1LkPykey9JYXr
        MFcEcOLO+lK2JzZj1e+FW05ksA==
X-Google-Smtp-Source: AGHT+IGK6pQK6oEdjKlIa1mcimdR1pYjb6u2hPifw5U79lxb+nCirP606/eGPYNlPkAaYdn6n6fpUw==
X-Received: by 2002:a05:6a00:12:b0:6c0:52b9:d448 with SMTP id h18-20020a056a00001200b006c052b9d448mr905573pfk.9.1698265465988;
        Wed, 25 Oct 2023 13:24:25 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b006b84ed9371esm10079590pfo.177.2023.10.25.13.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:24:25 -0700 (PDT)
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
Subject: [RFC PATCH v2 03/21] ACPI: Kconfig: Introduce new option to support deferred GSI probe
Date:   Thu, 26 Oct 2023 01:53:26 +0530
Message-Id: <20231025202344.581132-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231025202344.581132-1-sunilvl@ventanamicro.com>
References: <20231025202344.581132-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some architectures like RISC-V, the interrupt controllers for Global
System Interrupts (GSI) are not probed early during boot. So, the
device drivers which need to register their GSI, need to be deferred
until the actual interrupt controller driver is probed. To reduce the
impact of such change, add a new CONFIG option which can be set only by
the architecture which needs deferred GSI probing.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index cee82b473dc5..4399e793f1d2 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -51,6 +51,9 @@ config ARCH_MIGHT_HAVE_ACPI_PDC
 config ACPI_GENERIC_GSI
 	bool
 
+config ARCH_ACPI_DEFERRED_GSI
+	bool
+
 config ACPI_SYSTEM_POWER_STATES_SUPPORT
 	bool
 
-- 
2.39.2

