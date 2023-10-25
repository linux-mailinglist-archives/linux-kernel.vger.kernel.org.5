Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C790D7D75A9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 22:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbjJYU1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 16:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343747AbjJYU0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 16:26:37 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2760D1BEA
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:25:54 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b36e1fcee9so130422b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698265553; x=1698870353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwZ9IOYC0gRC/owt7RZ2EBdGuffYJiDuVuQ5+XRLwVw=;
        b=gni9otB/RxqkdQcBtDhkGtxYXI1WhO6/nBa5LuP10/nNencAljOkoEGMmIzHInY/ky
         oDlR4aIa6BOWPeVwvMeutGJ5V6ffVJCjq9yAVxUgQJ2NWKDBS7IHFKiQ+l6fFBvSh15A
         mZC/WjARqRxm2wTMlRiEvP5OHITXIqMDoeYIdAubOwiSoJbWpW6qqgDG3R3ijHPWgG3l
         RZ7TnvwKTmJTwhe02+58gFnl2LR1WgjHj440rGe69OikbaJsYYesrFvKharIMMus1Hog
         QqV5S9f6vTbimWXy/i5vLDf/0GQKcbKhCidzew7Kz1qBK6XcaGk99AbAHyc/PlHte0Xp
         EzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698265553; x=1698870353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VwZ9IOYC0gRC/owt7RZ2EBdGuffYJiDuVuQ5+XRLwVw=;
        b=eBWvE420c6c8QG4Cd4k2vme4j6DjYZ0aqHLwMEEaunIfFg3fqHMeAz5+xSjy65xEL8
         IpGgJHZml1T7STdIYckmh2Zc7kpWC0g8zZN0LQp6BSOAlLBVwzjITTBvgk9Ly2XiZwOy
         6QFh7xYOqkOnk5vcXB6zgGkIzu823S/7wWD9MqvLgmBrvn4G4uszp8/satEC6WMpnxr7
         nyKWAMT0pSucM2X6SIDqL3Ep2nwZwoPTMoyJesj4cV+5DDSkd5hDsXP5W+v1gJnK/5yo
         djnNmn2tI51hm3Tsky8rkg9q0S2x+OXJiKkt/ztpjVGlvrD04mi9vph2n/f1VbRWoX7H
         9CMg==
X-Gm-Message-State: AOJu0Yw4/0YiUeDBmfVcje2UwgvzhSIyqI/ia/yBn/tALSkiRoz5SuXi
        mMc0QngFXPIBH2fFhLCtneIlLw==
X-Google-Smtp-Source: AGHT+IHkn2z1G+Hl0DvKFF4S04ijeypy9mwQD0HYMK+syY66BONzs/0zW1LpSVQhK3aml5xBfnLnBg==
X-Received: by 2002:a05:6a00:17a1:b0:6be:265:1bf6 with SMTP id s33-20020a056a0017a100b006be02651bf6mr14834736pfg.32.1698265553494;
        Wed, 25 Oct 2023 13:25:53 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b006b84ed9371esm10079590pfo.177.2023.10.25.13.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:25:53 -0700 (PDT)
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
Subject: [RFC PATCH v2 18/21] irqchip: riscv-intc: Set ACPI irqmodel
Date:   Thu, 26 Oct 2023 01:53:41 +0530
Message-Id: <20231025202344.581132-19-sunilvl@ventanamicro.com>
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

INTC being the root interrupt controller, set the ACPI irqmodel with
callback function to get the GSI domain id.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-intc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index f3aaecde12dd..627723d72b01 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -273,6 +273,17 @@ int acpi_get_imsic_mmio_info(u32 index, struct resource *res)
 	return 0;
 }
 
+static struct fwnode_handle *riscv_get_gsi_domain_id(u32 gsi)
+{
+	struct fwnode_handle *gsi_fwnode = NULL;
+
+	gsi_fwnode = aplic_get_gsi_domain_id(gsi);
+	if (!gsi_fwnode)
+		gsi_fwnode = plic_get_gsi_domain_id(gsi);
+
+	return gsi_fwnode;
+}
+
 static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
 				       const unsigned long end)
 {
@@ -318,6 +329,7 @@ static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
 	 * unsupported. Once IMSIC is probed, MSI support will be set.
 	 */
 	pci_no_msi();
+	acpi_set_irq_model(ACPI_IRQ_MODEL_RINTC, riscv_get_gsi_domain_id);
 	return 0;
 }
 
-- 
2.39.2

