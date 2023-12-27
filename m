Return-Path: <linux-kernel+bounces-11975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4272181EE65
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 12:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2794283A62
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BF94437F;
	Wed, 27 Dec 2023 11:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCddVyjA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C8A446A9;
	Wed, 27 Dec 2023 11:00:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF28C43395;
	Wed, 27 Dec 2023 11:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703674852;
	bh=QU+DYQDLS/MfjWJm3QN3L+CpUr04o07dcK8fax9PUP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WCddVyjAHYEJTEHjUsB+r03dv8YSq751+x+eH2BX8V7jzL2mdouObzhZ1pGGXHaBU
	 FotcD8fbiM6slfbQqgYDFQ2Cjv/keyqHPpA4hgZRw/EyEfWLnloM9Q3xC1+k2YLeMa
	 s/LJfDcQXDKXcQx/ENZAPkeMYUll3Ji96Jq+tfEPEXNmvo8eyb+nrWL7UIo3czBO2A
	 /s5TY30Fn9Ie/0YCA12YXOz/JOdhhfEijNGtJvM2D2mYFi6LDqiyuZMGZVEAAgW+b7
	 bGf33pU/PJuq587y1Oz2wCeppPJ3F8RnE832N23SdvOqvdmRqn+cmWnByGe3YpBu2V
	 3+HAwe4uaIe8w==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Fang Xiang <fangxiang3@xiaomi.com>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH v4 2/3] ACPICA: MADT: Add new MADT GICC/GICR/ITS non-coherent flags handling
Date: Wed, 27 Dec 2023 12:00:37 +0100
Message-Id: <20231227110038.55453-3-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227110038.55453-1-lpieralisi@kernel.org>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
 <20231227110038.55453-1-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ACPICA commit c5d2010744b1bf7efba0bd04a8a9c200ef8fb610

Add new flags and related fields to the MADT GICC/GICR/ITS
structures according to the code first ECR:

https://bugzilla.tianocore.org/show_bug.cgi?id=4557

Update the MADT template to the latest MADT revision.

Link: https://github.com/acpica/acpica/commit/c5d20107
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Robert Moore <robert.moore@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl2.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 2b4dd2c3348f..9775384d61c6 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1047,6 +1047,7 @@ struct acpi_madt_generic_interrupt {
 #define ACPI_MADT_PERFORMANCE_IRQ_MODE  (1<<1)	/* 01: Performance Interrupt Mode */
 #define ACPI_MADT_VGIC_IRQ_MODE         (1<<2)	/* 02: VGIC Maintenance Interrupt mode */
 #define ACPI_MADT_GICC_ONLINE_CAPABLE   (1<<3)	/* 03: Processor is online capable  */
+#define ACPI_MADT_GICC_NON_COHERENT     (1<<4)	/* 04: GIC redistributor is not coherent */
 
 /* 12: Generic Distributor (ACPI 5.0 + ACPI 6.0 changes) */
 
@@ -1091,21 +1092,27 @@ struct acpi_madt_generic_msi_frame {
 
 struct acpi_madt_generic_redistributor {
 	struct acpi_subtable_header header;
-	u16 reserved;		/* reserved - must be zero */
+	u8 flags;
+	u8 reserved;		/* reserved - must be zero */
 	u64 base_address;
 	u32 length;
 };
 
+#define ACPI_MADT_GICR_NON_COHERENT     (1)
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
 
+#define ACPI_MADT_ITS_NON_COHERENT      (1)
+
 /* 16: Multiprocessor wakeup (ACPI 6.4) */
 
 struct acpi_madt_multiproc_wakeup {
-- 
2.34.1


