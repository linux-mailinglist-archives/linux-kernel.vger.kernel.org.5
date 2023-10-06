Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CC27BB85D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjJFNAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjJFNAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:00:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E2D126
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 05:59:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED31BC43395;
        Fri,  6 Oct 2023 12:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696597190;
        bh=1a0WYm/JOuoSloUtHO8rcUYP3nlPMtWwDXeoC9j17ng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cxuu05QZS2zUIu3FMQpOk4GTxl5etLU3bdmcRa3X9ASqNJV8AQNtb+4cuNWzOCliJ
         J2kW9cevvgvHxvm2JEB1uR6HDj9cA+D79ZTTMcgylFpaflS9XKt6xPHUksQQphUpP0
         YeHTCWvV3aju5DnJZ2jNvxYEYgOaD2jdZ9W+3V2X/HAD7oPblNqmPPCb7BGc2Nq2u4
         ba7IrcEIp9aWoA5984O5Nc/ztL1bY609fWg0t+ncvT2vx/dDSQSxyw8E4xW0A3me35
         U1zkddfi/3nPuZ/8AKxXknVUuYFpbKzZwt3shyb3JEomgv03yPXktZQ5NywNA5Ef9H
         vmENa5OnxIeIg==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fang Xiang <fangxiang3@xiaomi.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH v3 4/5] ACPICA: Add new MADT GICC/GICR/ITS flags handling [code first]
Date:   Fri,  6 Oct 2023 14:59:28 +0200
Message-Id: <20231006125929.48591-5-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006125929.48591-1-lpieralisi@kernel.org>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
 <20231006125929.48591-1-lpieralisi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new flags and related fields to the MADT GICC/GICR/ITS
structures according to the code first ECR:

https://bugzilla.tianocore.org/show_bug.cgi?id=4557

Temporary code waiting for ECR approval, for testing
purpose only - eventually ACPICA changes will trickle
into the kernel from the ACPICA project repos.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
---
 include/acpi/actbl2.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 3751ae69432f..dd44915efd6b 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1046,6 +1046,7 @@ struct acpi_madt_generic_interrupt {
 /* ACPI_MADT_ENABLED                    (1)      Processor is usable if set */
 #define ACPI_MADT_PERFORMANCE_IRQ_MODE  (1<<1)	/* 01: Performance Interrupt Mode */
 #define ACPI_MADT_VGIC_IRQ_MODE         (1<<2)	/* 02: VGIC Maintenance Interrupt mode */
+#define ACPI_MADT_GICC_NON_COHERENT     (1<<4)  /* 04: GIC redistributor is not coherent */
 
 /* 12: Generic Distributor (ACPI 5.0 + ACPI 6.0 changes) */
 
@@ -1090,21 +1091,27 @@ struct acpi_madt_generic_msi_frame {
 
 struct acpi_madt_generic_redistributor {
 	struct acpi_subtable_header header;
-	u16 reserved;		/* reserved - must be zero */
+	u8 flags;
+	u8 reserved;		/* reserved - must be zero */
 	u64 base_address;
 	u32 length;
 };
 
+#define ACPI_MADT_GICR_NON_COHERENT   (1)
+
 /* 15: Generic Translator (ACPI 6.0) */
 
 struct acpi_madt_generic_translator {
 	struct acpi_subtable_header header;
-	u16 reserved;		/* reserved - must be zero */
+	u8 flags;
+	u8 reserved;		/* reserved - must be zero */
 	u32 translation_id;
 	u64 base_address;
 	u32 reserved2;
 };
 
+#define ACPI_MADT_ITS_NON_COHERENT   (1)
+
 /* 16: Multiprocessor wakeup (ACPI 6.4) */
 
 struct acpi_madt_multiproc_wakeup {
-- 
2.34.1

