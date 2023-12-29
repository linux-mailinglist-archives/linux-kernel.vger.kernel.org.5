Return-Path: <linux-kernel+bounces-12961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B00481FD5B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 07:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9F91F21B00
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 06:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62805CBB;
	Fri, 29 Dec 2023 06:54:28 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBA15669
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 06:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id BE36824E03E;
	Fri, 29 Dec 2023 14:54:21 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 29 Dec
 2023 14:54:21 +0800
Received: from jsia-virtual-machine.localdomain (175.136.135.142) by
 EXMBX066.cuchost.com (172.16.6.66) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Fri, 29 Dec 2023 14:54:17 +0800
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC: <rafael.j.wysocki@intel.com>, <ajones@ventanamicro.com>,
	<conor.dooley@microchip.com>, <sunilvl@ventanamicro.com>,
	<jeeheng.sia@starfivetech.com>, <aou@eecs.berkeley.edu>,
	<palmer@dabbelt.com>, <paul.walmsley@sifive.com>
Subject: [RFC v1 1/1] RISC-V: ACPI: Enable SPCR table for console output on RISC-V
Date: Fri, 29 Dec 2023 14:54:05 +0800
Message-ID: <20231229065405.235625-2-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229065405.235625-1-jeeheng.sia@starfivetech.com>
References: <20231229065405.235625-1-jeeheng.sia@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

The ACPI SPCR code has been used to enable console output for ARM64 and
X86. The same code can be reused for RISC-V.

Vendor will enable/disable the SPCR table in the firmware based on the
platform design. However, in cases where the SPCR table is not usable,
a kernel parameter could be used to specify the preferred console.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
---
 arch/riscv/kernel/acpi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index e619edc8b0cc..5ec2fdf9e09f 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -18,6 +18,7 @@
 #include <linux/io.h>
 #include <linux/memblock.h>
 #include <linux/pci.h>
+#include <linux/serial_core.h>
=20
 int acpi_noirq =3D 1;		/* skip ACPI IRQ initialization */
 int acpi_disabled =3D 1;
@@ -151,6 +152,9 @@ void __init acpi_boot_table_init(void)
 		if (!param_acpi_force)
 			disable_acpi();
 	}
+
+	if (!acpi_disabled)
+		acpi_parse_spcr(earlycon_acpi_spcr_enable, true);
 }
=20
 static int acpi_parse_madt_rintc(union acpi_subtable_headers *header, co=
nst unsigned long end)
--=20
2.34.1


