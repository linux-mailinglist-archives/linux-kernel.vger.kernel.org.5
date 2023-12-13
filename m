Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D818111CA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378982AbjLMMuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378921AbjLMMuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:50:23 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32C01BC;
        Wed, 13 Dec 2023 04:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DnFY2Lrn3laRjR0dFD9DsIQAz620A4pU6zpNT78Use8=; b=AsjeyEgF6qrzJzab3wkGeZcEwz
        rQbT8Tw9ttXnjWwBGSCpduVsdyCslNTtuX0uB4lOWLn2A4DQGf8kQ54y0eQssun1EYJVaEjWIl9+m
        pSqtSsZYzlpMk6x1cEk4OonnO/nvQhZCTzAnt6bk8eG11xPN/bKHuFd3QTGhNZKj9fdYNDgvvT6j5
        KjXoS4SJ3GKYkLPAF7X0EkDMoJdVgIbwj0bsR13/aGe4cetcTaI0cBPZMSGQ+V25Klu4Ppx6urvC/
        eKcbFBSHX4L8zY9q6CIQ36XIHBJPW92Q1bOt1cleQ9a1mRdmlhqi3jF3ZqX8pqXPmBYM0zM3WXTb5
        2ou+awpw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33732 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1rDOgp-0008Fs-39;
        Wed, 13 Dec 2023 12:50:16 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1rDOgs-00Dvko-6t; Wed, 13 Dec 2023 12:50:18 +0000
In-Reply-To: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
From:   Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
To:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, acpica-devel@lists.linuxfoundation.org,
        linux-csky@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org
Cc:     Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        James Morse <james.morse@arm.com>
Subject: [PATCH RFC v3 13/21] ACPICA: Add new MADT GICC flags fields
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rDOgs-00Dvko-6t@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Wed, 13 Dec 2023 12:50:18 +0000
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morse <james.morse@arm.com>

Add the new flag field to the MADT's GICC structure.

'Online Capable' indicates a disabled CPU can be enabled later. See
ACPI specification 6.5 Tabel 5.37: GICC CPU Interface Flags.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Jianyong Wu <jianyong.wu@arm.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
This patch probably needs to go via the upstream acpica project,
but is included here so the feature can be tested.

If the ACPICA header files are updated before merging this patch set,
this patch will need to be dropped.

Changes since RFC v2:
 * Add ACPI specification reference.
---
 include/acpi/actbl2.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 3751ae69432f..c433a079d8e1 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1046,6 +1046,7 @@ struct acpi_madt_generic_interrupt {
 /* ACPI_MADT_ENABLED                    (1)      Processor is usable if set */
 #define ACPI_MADT_PERFORMANCE_IRQ_MODE  (1<<1)	/* 01: Performance Interrupt Mode */
 #define ACPI_MADT_VGIC_IRQ_MODE         (1<<2)	/* 02: VGIC Maintenance Interrupt mode */
+#define ACPI_MADT_GICC_CPU_CAPABLE      (1<<3)	/* 03: CPU is online capable */
 
 /* 12: Generic Distributor (ACPI 5.0 + ACPI 6.0 changes) */
 
-- 
2.30.2

