Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736BB7520F9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbjGMMNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbjGMMNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:13:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D2630D1;
        Thu, 13 Jul 2023 05:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689250393; x=1720786393;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SuAv8Leh99onWd/6PJcaTcunFy7r2dXNiII1c8HHGOI=;
  b=u2WqJ21dG2I4qhGSQymH2rD5vEcwtO/xdKhDX8imetwqUPFAQb42by0y
   P+Jzki3jpTvCKpd62PttIhbvdqPL0RAQRnltFo5Sa4H9d4nHXHMT6k0tW
   BLYlN27m2HZDyEnQTyVQYR8N50JdT68QYvrY1C62CLPpb62xqlKJkz4ug
   +oWLS6NIDWwVaHCr2DXBGLMvpRl3Nk3S5PqvLvchB3CppurIbJSEJ0dJn
   zcRIieb0ZCRDcrj0d7km8ntUzncqtR+SQ9QDnTvgGe6Fw/NBgPNKHBd5Z
   m6QHcQmME3MKbb1fz7l+Rwlp+cR+TUaDnq29KsjrX2ccdywfR/MSGwG6f
   w==;
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="220194629"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2023 05:13:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 13 Jul 2023 05:12:56 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Thu, 13 Jul 2023 05:12:53 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <palmer@dabbelt.com>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        "Heiko Stuebner" <heiko.stuebner@vrull.eu>,
        Evan Green <evan@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        <linux-doc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 09/11] RISC-V: enable extension detection from dedicated properties
Date:   Thu, 13 Jul 2023 13:11:07 +0100
Message-ID: <20230713-vocation-profane-39a74b3c2649@wendy>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713-target-much-8ac624e90df8@wendy>
References: <20230713-target-much-8ac624e90df8@wendy>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4797; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=SuAv8Leh99onWd/6PJcaTcunFy7r2dXNiII1c8HHGOI=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCnrX153FL9etPLdvZjQTYkiZ9X3npRO+ZUSUWxyI58/2utz 9KzWjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAExklTojw2SbOdOC/Q3q1VoypHwX7a 6LWZI2u33aqdKNlSLaumKrrRgZfp1YdeRsBrv7cnvJ6yUWD9NX57g3v7WtlXZsZS+9mviIHQA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for parsing the new riscv,isa-extensions property in
riscv_fill_hwcap(), by means of a new "property" member of the
riscv_isa_ext_data struct. For now, this shadows the name of the
extension for all users, however this may not be the case for all
extensions, based on how the dt-binding is written.
For the sake of backwards compatibility, fall back to the old scheme
if the new properties are not detected. For now, just inform, rather
than warn, when that happens.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v5:
- Add a missing put of the cpu node where the property is not found
- Reword the commit message, s/new/dedicated/
- Remove a this_isa bitmap & replace it with isainfo->isa, to match what
  is done for the isa string codepath

Changes in v2:
- Pick a more suitable function name than fill_hwcap_new()
- Actually use the property member to read from the DT
---
 arch/riscv/include/asm/hwcap.h |  1 +
 arch/riscv/kernel/cpufeature.c | 78 ++++++++++++++++++++++++++++++++--
 2 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index a20e4ade1b53..e3cda14a486b 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -76,6 +76,7 @@ unsigned long riscv_get_elf_hwcap(void);
 struct riscv_isa_ext_data {
 	const unsigned int id;
 	const char *name;
+	const char *property;
 };
 
 extern const struct riscv_isa_ext_data riscv_isa_ext[];
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 7c661b12ac8d..fdc71e52dc2b 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -101,6 +101,7 @@ static bool riscv_isa_extension_check(int id)
 
 #define __RISCV_ISA_EXT_DATA(_name, _id) {	\
 	.name = #_name,				\
+	.property = #_name,			\
 	.id = _id,				\
 }
 
@@ -414,11 +415,69 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 		acpi_put_table((struct acpi_table_header *)rhct);
 }
 
+static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
+{
+	unsigned int cpu;
+
+	for_each_possible_cpu(cpu) {
+		unsigned long this_hwcap = 0;
+		struct device_node *cpu_node;
+		struct riscv_isainfo *isainfo = &hart_isa[cpu];
+
+		cpu_node = of_cpu_device_node_get(cpu);
+		if (!cpu_node) {
+			pr_warn("Unable to find cpu node\n");
+			continue;
+		}
+
+		if (!of_property_present(cpu_node, "riscv,isa-extensions")) {
+			of_node_put(cpu_node);
+			continue;
+		}
+
+		for (int i = 0; i < riscv_isa_ext_count; i++) {
+			if (of_property_match_string(cpu_node, "riscv,isa-extensions",
+						     riscv_isa_ext[i].property) < 0)
+				continue;
+
+			if (!riscv_isa_extension_check(riscv_isa_ext[i].id))
+				continue;
+
+			/* Only single letter extensions get set in hwcap */
+			if (strnlen(riscv_isa_ext[i].name, 2) == 1)
+				this_hwcap |= isa2hwcap[riscv_isa_ext[i].id];
+
+			set_bit(riscv_isa_ext[i].id, isainfo->isa);
+		}
+
+		of_node_put(cpu_node);
+
+		/*
+		 * All "okay" harts should have same isa. Set HWCAP based on
+		 * common capabilities of every "okay" hart, in case they don't.
+		 */
+		if (elf_hwcap)
+			elf_hwcap &= this_hwcap;
+		else
+			elf_hwcap = this_hwcap;
+
+		if (bitmap_empty(riscv_isa, RISCV_ISA_EXT_MAX))
+			bitmap_copy(riscv_isa, isainfo->isa, RISCV_ISA_EXT_MAX);
+		else
+			bitmap_and(riscv_isa, riscv_isa, isainfo->isa, RISCV_ISA_EXT_MAX);
+	}
+
+	if (bitmap_empty(riscv_isa, RISCV_ISA_EXT_MAX))
+		return -ENOENT;
+
+	return 0;
+}
+
 void __init riscv_fill_hwcap(void)
 {
 	char print_str[NUM_ALPHA_EXTS + 1];
-	int i, j;
 	unsigned long isa2hwcap[26] = {0};
+	int i, j;
 
 	isa2hwcap['i' - 'a'] = COMPAT_HWCAP_ISA_I;
 	isa2hwcap['m' - 'a'] = COMPAT_HWCAP_ISA_M;
@@ -428,10 +487,21 @@ void __init riscv_fill_hwcap(void)
 	isa2hwcap['c' - 'a'] = COMPAT_HWCAP_ISA_C;
 	isa2hwcap['v' - 'a'] = COMPAT_HWCAP_ISA_V;
 
-	riscv_fill_hwcap_from_isa_string(isa2hwcap);
+	if (!acpi_disabled) {
+		riscv_fill_hwcap_from_isa_string(isa2hwcap);
+	} else {
+		int ret = riscv_fill_hwcap_from_ext_list(isa2hwcap);
 
-	/* We don't support systems with F but without D, so mask those out
-	 * here. */
+		if (ret) {
+			pr_info("Falling back to deprecated \"riscv,isa\"\n");
+			riscv_fill_hwcap_from_isa_string(isa2hwcap);
+		}
+	}
+
+	/*
+	 * We don't support systems with F but without D, so mask those out
+	 * here.
+	 */
 	if ((elf_hwcap & COMPAT_HWCAP_ISA_F) && !(elf_hwcap & COMPAT_HWCAP_ISA_D)) {
 		pr_info("This kernel does not support systems with F but not D\n");
 		elf_hwcap &= ~COMPAT_HWCAP_ISA_F;
-- 
2.40.1

