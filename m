Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8457E78972A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 16:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjHZOGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 10:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjHZOGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 10:06:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E5719A0;
        Sat, 26 Aug 2023 07:05:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 159CF608C0;
        Sat, 26 Aug 2023 14:05:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B94C433C8;
        Sat, 26 Aug 2023 14:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693058753;
        bh=uN3FAIbSqgPAdPsJ5+JzxJI1FJ+RXZxCDW8fdGHbGJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q00PFm7gih+xQ8mmOYnoWJ2gb+1+2sZlw3/93Lb3jKwtaAxWz+IWwtNQ+Xyz11tGB
         EZBHfYqlXjKxAtJofYU2RD71XyW5EpwaUakagw4fjrxN4aqieaugZPVXxQNytSP6JL
         k1Bc0Fo26gyxApItcNkKgwVOL+OCE2KLV8SxFurQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.128
Date:   Sat, 26 Aug 2023 16:05:41 +0200
Message-ID: <2023082641-fridge-wobbling-5bc1@gregkh>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <2023082641-easel-sudden-fde4@gregkh>
References: <2023082641-easel-sudden-fde4@gregkh>
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

diff --git a/Documentation/admin-guide/hw-vuln/srso.rst b/Documentation/admin-guide/hw-vuln/srso.rst
index 2f923c805802..f79cb11b080f 100644
--- a/Documentation/admin-guide/hw-vuln/srso.rst
+++ b/Documentation/admin-guide/hw-vuln/srso.rst
@@ -124,8 +124,8 @@ sequence.
 To ensure the safety of this mitigation, the kernel must ensure that the
 safe return sequence is itself free from attacker interference.  In Zen3
 and Zen4, this is accomplished by creating a BTB alias between the
-untraining function srso_untrain_ret_alias() and the safe return
-function srso_safe_ret_alias() which results in evicting a potentially
+untraining function srso_alias_untrain_ret() and the safe return
+function srso_alias_safe_ret() which results in evicting a potentially
 poisoned BTB entry and using that safe one for all function returns.
 
 In older Zen1 and Zen2, this is accomplished using a reinterpretation
diff --git a/MAINTAINERS b/MAINTAINERS
index e6b53e76651b..9216b9c85ce9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1250,7 +1250,7 @@ APEX EMBEDDED SYSTEMS STX104 IIO DRIVER
 M:	William Breathitt Gray <vilhelm.gray@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-F:	drivers/iio/adc/stx104.c
+F:	drivers/iio/addac/stx104.c
 
 APM DRIVER
 M:	Jiri Kosina <jikos@kernel.org>
diff --git a/Makefile b/Makefile
index f5e69631ca58..2b5160227e82 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 127
+SUBLEVEL = 128
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
index 9b4cf5ebe6d5..c62aff908ab4 100644
--- a/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
@@ -63,7 +63,7 @@ flash@0 {
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
-		spi-max-frequency = <100000000>; /* 100 MHz */
+		spi-max-frequency = <50000000>; /* 50 MHz */
 #include "openbmc-flash-layout.dtsi"
 	};
 };
diff --git a/arch/arm/boot/dts/imx6dl-prtrvt.dts b/arch/arm/boot/dts/imx6dl-prtrvt.dts
index 5ac84445e9cc..90e01de8c2c1 100644
--- a/arch/arm/boot/dts/imx6dl-prtrvt.dts
+++ b/arch/arm/boot/dts/imx6dl-prtrvt.dts
@@ -126,6 +126,10 @@ &usbh1 {
 	status = "disabled";
 };
 
+&usbotg {
+	disable-over-current;
+};
+
 &vpu {
 	status = "disabled";
 };
diff --git a/arch/arm/boot/dts/imx6qdl-prti6q.dtsi b/arch/arm/boot/dts/imx6qdl-prti6q.dtsi
index 19578f660b09..70dfa07a1698 100644
--- a/arch/arm/boot/dts/imx6qdl-prti6q.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-prti6q.dtsi
@@ -69,6 +69,7 @@ &usbh1 {
 	vbus-supply = <&reg_usb_h1_vbus>;
 	phy_type = "utmi";
 	dr_mode = "host";
+	disable-over-current;
 	status = "okay";
 };
 
@@ -78,10 +79,18 @@ &usbotg {
 	pinctrl-0 = <&pinctrl_usbotg>;
 	phy_type = "utmi";
 	dr_mode = "host";
-	disable-over-current;
+	over-current-active-low;
 	status = "okay";
 };
 
+&usbphynop1 {
+	status = "disabled";
+};
+
+&usbphynop2 {
+	status = "disabled";
+};
+
 &usdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc1>;
diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
index eecb2f68a1c3..3659fd5ecfa6 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -51,20 +51,18 @@ cpu0: cpu@0 {
 			device_type = "cpu";
 			reg = <0>;
 			next-level-cache = <&L2>;
-			operating-points = <
+			operating-points =
 				/* kHz    uV */
-				996000  1275000
-				792000  1175000
-				396000  1075000
-				198000	975000
-			>;
-			fsl,soc-operating-points = <
+				<996000  1275000>,
+				<792000  1175000>,
+				<396000  1075000>,
+				<198000	  975000>;
+			fsl,soc-operating-points =
 				/* ARM kHz      SOC-PU uV */
-				996000          1175000
-				792000          1175000
-				396000          1175000
-				198000		1175000
-			>;
+				<996000         1175000>,
+				<792000         1175000>,
+				<396000         1175000>,
+				<198000		1175000>;
 			clock-latency = <61036>; /* two CLK32 periods */
 			#cooling-cells = <2>;
 			clocks = <&clks IMX6SLL_CLK_ARM>,
@@ -554,7 +552,7 @@ usbphy2: usb-phy@20ca000 {
 				reg = <0x020ca000 0x1000>;
 				interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SLL_CLK_USBPHY2>;
-				phy-reg_3p0-supply = <&reg_3p0>;
+				phy-3p0-supply = <&reg_3p0>;
 				fsl,anatop = <&anatop>;
 			};
 
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 8bef5440278b..3e779fd0a396 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -981,6 +981,8 @@ usdhc1: mmc@2190000 {
 					 <&clks IMX6SX_CLK_USDHC1>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-start-tap = <20>;
+				fsl,tuning-step= <2>;
 				status = "disabled";
 			};
 
@@ -993,6 +995,8 @@ usdhc2: mmc@2194000 {
 					 <&clks IMX6SX_CLK_USDHC2>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-start-tap = <20>;
+				fsl,tuning-step= <2>;
 				status = "disabled";
 			};
 
@@ -1005,6 +1009,8 @@ usdhc3: mmc@2198000 {
 					 <&clks IMX6SX_CLK_USDHC3>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-start-tap = <20>;
+				fsl,tuning-step= <2>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index 0ce2d36ab257..d3449cb52def 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -113,7 +113,7 @@ active-config0 {
 			};
 		};
 
-		pm8150l-thermal {
+		pm8150l-pcb-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&pm8150l_adc_tm 1>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
index a7ec81657503..8b70e831aff2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
@@ -595,9 +595,9 @@ &sdmmc {
 };
 
 &sdhci {
+	max-frequency = <150000000>;
 	bus-width = <8>;
-	mmc-hs400-1_8v;
-	mmc-hs400-enhanced-strobe;
+	mmc-hs200-1_8v;
 	non-removable;
 	status = "okay";
 };
diff --git a/arch/powerpc/kernel/rtas_flash.c b/arch/powerpc/kernel/rtas_flash.c
index a99179d83538..56bd0aa30f93 100644
--- a/arch/powerpc/kernel/rtas_flash.c
+++ b/arch/powerpc/kernel/rtas_flash.c
@@ -710,9 +710,9 @@ static int __init rtas_flash_init(void)
 	if (!rtas_validate_flash_data.buf)
 		return -ENOMEM;
 
-	flash_block_cache = kmem_cache_create("rtas_flash_cache",
-					      RTAS_BLK_SIZE, RTAS_BLK_SIZE, 0,
-					      NULL);
+	flash_block_cache = kmem_cache_create_usercopy("rtas_flash_cache",
+						       RTAS_BLK_SIZE, RTAS_BLK_SIZE,
+						       0, 0, RTAS_BLK_SIZE, NULL);
 	if (!flash_block_cache) {
 		printk(KERN_ERR "%s: failed to create block cache\n",
 				__func__);
diff --git a/arch/powerpc/mm/kasan/Makefile b/arch/powerpc/mm/kasan/Makefile
index bb1a5408b86b..8636b17c6a20 100644
--- a/arch/powerpc/mm/kasan/Makefile
+++ b/arch/powerpc/mm/kasan/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 KASAN_SANITIZE := n
+KCOV_INSTRUMENT := n
 
 obj-$(CONFIG_PPC32)           += kasan_init_32.o
 obj-$(CONFIG_PPC_8xx)		+= 8xx.o
diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
index 2c7c1c5026af..4fe436a0eec2 100644
--- a/arch/riscv/lib/uaccess.S
+++ b/arch/riscv/lib/uaccess.S
@@ -19,8 +19,11 @@ ENTRY(__asm_copy_from_user)
 	li t6, SR_SUM
 	csrs CSR_STATUS, t6
 
-	/* Save for return value */
-	mv	t5, a2
+	/*
+	 * Save the terminal address which will be used to compute the number
+	 * of bytes copied in case of a fixup exception.
+	 */
+	add	t5, a0, a2
 
 	/*
 	 * Register allocation for code below:
@@ -178,7 +181,7 @@ ENTRY(__asm_copy_from_user)
 10:
 	/* Disable access to user memory */
 	csrc CSR_STATUS, t6
-	mv a0, t5
+	sub a0, t5, a0
 	ret
 ENDPROC(__asm_copy_to_user)
 ENDPROC(__asm_copy_from_user)
@@ -230,7 +233,7 @@ ENTRY(__clear_user)
 11:
 	/* Disable access to user memory */
 	csrc CSR_STATUS, t6
-	mv a0, a1
+	sub a0, a3, a0
 	ret
 ENDPROC(__clear_user)
 EXPORT_SYMBOL(__clear_user)
diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index 43184640b579..a12fdf01dc26 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -92,6 +92,7 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 static __always_inline void arch_exit_to_user_mode(void)
 {
 	mds_user_clear_cpu_buffers();
+	amd_clear_divider();
 }
 #define arch_exit_to_user_mode arch_exit_to_user_mode
 
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 4a12dfdd317c..940c15ee5650 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -156,9 +156,9 @@
 .endm
 
 #ifdef CONFIG_CPU_UNRET_ENTRY
-#define CALL_ZEN_UNTRAIN_RET	"call zen_untrain_ret"
+#define CALL_UNTRAIN_RET	"call entry_untrain_ret"
 #else
-#define CALL_ZEN_UNTRAIN_RET	""
+#define CALL_UNTRAIN_RET	""
 #endif
 
 /*
@@ -166,7 +166,7 @@
  * return thunk isn't mapped into the userspace tables (then again, AMD
  * typically has NO_MELTDOWN).
  *
- * While zen_untrain_ret() doesn't clobber anything but requires stack,
+ * While retbleed_untrain_ret() doesn't clobber anything but requires stack,
  * entry_ibpb() will clobber AX, CX, DX.
  *
  * As such, this must be placed after every *SWITCH_TO_KERNEL_CR3 at a point
@@ -177,14 +177,9 @@
 	defined(CONFIG_CPU_SRSO)
 	ANNOTATE_UNRET_END
 	ALTERNATIVE_2 "",						\
-	              CALL_ZEN_UNTRAIN_RET, X86_FEATURE_UNRET,		\
+		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
 		      "call entry_ibpb", X86_FEATURE_ENTRY_IBPB
 #endif
-
-#ifdef CONFIG_CPU_SRSO
-	ALTERNATIVE_2 "", "call srso_untrain_ret", X86_FEATURE_SRSO, \
-			  "call srso_untrain_ret_alias", X86_FEATURE_SRSO_ALIAS
-#endif
 .endm
 
 #else /* __ASSEMBLY__ */
@@ -195,10 +190,21 @@
 	_ASM_PTR " 999b\n\t"					\
 	".popsection\n\t"
 
+#ifdef CONFIG_RETHUNK
 extern void __x86_return_thunk(void);
-extern void zen_untrain_ret(void);
+#else
+static inline void __x86_return_thunk(void) {}
+#endif
+
+extern void retbleed_return_thunk(void);
+extern void srso_return_thunk(void);
+extern void srso_alias_return_thunk(void);
+
+extern void retbleed_untrain_ret(void);
 extern void srso_untrain_ret(void);
-extern void srso_untrain_ret_alias(void);
+extern void srso_alias_untrain_ret(void);
+
+extern void entry_untrain_ret(void);
 extern void entry_ibpb(void);
 
 #ifdef CONFIG_RETPOLINE
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 0ca7123417ab..0a0230bd5089 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1320,3 +1320,4 @@ void noinstr amd_clear_divider(void)
 	asm volatile(ALTERNATIVE("", "div %2\n\t", X86_BUG_DIV0)
 		     :: "a" (0), "d" (0), "r" (1));
 }
+EXPORT_SYMBOL_GPL(amd_clear_divider);
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 73dad1400633..0d2c5fe84141 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -62,6 +62,8 @@ EXPORT_SYMBOL_GPL(x86_pred_cmd);
 
 static DEFINE_MUTEX(spec_ctrl_mutex);
 
+void (*x86_return_thunk)(void) __ro_after_init = &__x86_return_thunk;
+
 /* Update SPEC_CTRL MSR and its cached copy unconditionally */
 static void update_spec_ctrl(u64 val)
 {
@@ -164,8 +166,13 @@ void __init cpu_select_mitigations(void)
 	md_clear_select_mitigation();
 	srbds_select_mitigation();
 	l1d_flush_select_mitigation();
-	gds_select_mitigation();
+
+	/*
+	 * srso_select_mitigation() depends and must run after
+	 * retbleed_select_mitigation().
+	 */
 	srso_select_mitigation();
+	gds_select_mitigation();
 }
 
 /*
@@ -1013,6 +1020,9 @@ static void __init retbleed_select_mitigation(void)
 		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
 		setup_force_cpu_cap(X86_FEATURE_UNRET);
 
+		if (IS_ENABLED(CONFIG_RETHUNK))
+			x86_return_thunk = retbleed_return_thunk;
+
 		if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
 		    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 			pr_err(RETBLEED_UNTRAIN_MSG);
@@ -2388,9 +2398,10 @@ static void __init srso_select_mitigation(void)
 		 * Zen1/2 with SMT off aren't vulnerable after the right
 		 * IBPB microcode has been applied.
 		 */
-		if ((boot_cpu_data.x86 < 0x19) &&
-		    (!cpu_smt_possible() || (cpu_smt_control == CPU_SMT_DISABLED)))
+		if (boot_cpu_data.x86 < 0x19 && !cpu_smt_possible()) {
 			setup_force_cpu_cap(X86_FEATURE_SRSO_NO);
+			return;
+		}
 	}
 
 	if (retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
@@ -2419,11 +2430,15 @@ static void __init srso_select_mitigation(void)
 			 * like ftrace, static_call, etc.
 			 */
 			setup_force_cpu_cap(X86_FEATURE_RETHUNK);
+			setup_force_cpu_cap(X86_FEATURE_UNRET);
 
-			if (boot_cpu_data.x86 == 0x19)
+			if (boot_cpu_data.x86 == 0x19) {
 				setup_force_cpu_cap(X86_FEATURE_SRSO_ALIAS);
-			else
+				x86_return_thunk = srso_alias_return_thunk;
+			} else {
 				setup_force_cpu_cap(X86_FEATURE_SRSO);
+				x86_return_thunk = srso_return_thunk;
+			}
 			srso_mitigation = SRSO_MITIGATION_SAFE_RET;
 		} else {
 			pr_err("WARNING: kernel not compiled with CPU_SRSO.\n");
@@ -2672,6 +2687,9 @@ static ssize_t gds_show_state(char *buf)
 
 static ssize_t srso_show_state(char *buf)
 {
+	if (boot_cpu_has(X86_FEATURE_SRSO_NO))
+		return sysfs_emit(buf, "Mitigation: SMT disabled\n");
+
 	return sysfs_emit(buf, "%s%s\n",
 			  srso_strings[srso_mitigation],
 			  (cpu_has_ibpb_brtype_microcode() ? "" : ", no microcode"));
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index 2fc4f96702e6..b48b659ccf6f 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -135,6 +135,19 @@ EXPORT_SYMBOL_GPL(arch_static_call_transform);
  */
 bool __static_call_fixup(void *tramp, u8 op, void *dest)
 {
+	unsigned long addr = (unsigned long)tramp;
+	/*
+	 * Not all .return_sites are a static_call trampoline (most are not).
+	 * Check if the 3 bytes after the return are still kernel text, if not,
+	 * then this definitely is not a trampoline and we need not worry
+	 * further.
+	 *
+	 * This avoids the memcmp() below tripping over pagefaults etc..
+	 */
+	if (((addr >> PAGE_SHIFT) != ((addr + 7) >> PAGE_SHIFT)) &&
+	    !kernel_text_address(addr + 7))
+		return false;
+
 	if (memcmp(tramp+5, tramp_ud, 3)) {
 		/* Not a trampoline site, not our problem. */
 		return false;
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 3361d32d090f..ca47080e3774 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -202,8 +202,6 @@ DEFINE_IDTENTRY(exc_divide_error)
 {
 	do_error_trap(regs, 0, "divide error", X86_TRAP_DE, SIGFPE,
 		      FPE_INTDIV, error_get_trap_addr(regs));
-
-	amd_clear_divider();
 }
 
 DEFINE_IDTENTRY(exc_overflow)
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 7f3fa72a236a..ca1a7595edac 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -134,18 +134,18 @@ SECTIONS
 		KPROBES_TEXT
 		ALIGN_ENTRY_TEXT_BEGIN
 #ifdef CONFIG_CPU_SRSO
-		*(.text.__x86.rethunk_untrain)
+		*(.text..__x86.rethunk_untrain)
 #endif
 
 		ENTRY_TEXT
 
 #ifdef CONFIG_CPU_SRSO
 		/*
-		 * See the comment above srso_untrain_ret_alias()'s
+		 * See the comment above srso_alias_untrain_ret()'s
 		 * definition.
 		 */
-		. = srso_untrain_ret_alias | (1 << 2) | (1 << 8) | (1 << 14) | (1 << 20);
-		*(.text.__x86.rethunk_safe)
+		. = srso_alias_untrain_ret | (1 << 2) | (1 << 8) | (1 << 14) | (1 << 20);
+		*(.text..__x86.rethunk_safe)
 #endif
 		ALIGN_ENTRY_TEXT_END
 		SOFTIRQENTRY_TEXT
@@ -155,8 +155,8 @@ SECTIONS
 
 #ifdef CONFIG_RETPOLINE
 		__indirect_thunk_start = .;
-		*(.text.__x86.indirect_thunk)
-		*(.text.__x86.return_thunk)
+		*(.text..__x86.indirect_thunk)
+		*(.text..__x86.return_thunk)
 		__indirect_thunk_end = .;
 #endif
 	} :text =0xcccc
@@ -511,8 +511,8 @@ INIT_PER_CPU(irq_stack_backing_store);
            "fixed_percpu_data is not at start of per-cpu area");
 #endif
 
- #ifdef CONFIG_RETHUNK
-. = ASSERT((__ret & 0x3f) == 0, "__ret not cacheline-aligned");
+#ifdef CONFIG_RETHUNK
+. = ASSERT((retbleed_return_thunk & 0x3f) == 0, "retbleed_return_thunk not cacheline-aligned");
 . = ASSERT((srso_safe_ret & 0x3f) == 0, "srso_safe_ret not cacheline-aligned");
 #endif
 
@@ -527,8 +527,8 @@ INIT_PER_CPU(irq_stack_backing_store);
  * Instead do: (A | B) - (A & B) in order to compute the XOR
  * of the two function addresses:
  */
-. = ASSERT(((ABSOLUTE(srso_untrain_ret_alias) | srso_safe_ret_alias) -
-		(ABSOLUTE(srso_untrain_ret_alias) & srso_safe_ret_alias)) == ((1 << 2) | (1 << 8) | (1 << 14) | (1 << 20)),
+. = ASSERT(((ABSOLUTE(srso_alias_untrain_ret) | srso_alias_safe_ret) -
+		(ABSOLUTE(srso_alias_untrain_ret) & srso_alias_safe_ret)) == ((1 << 2) | (1 << 8) | (1 << 14) | (1 << 20)),
 		"SRSO function pair won't alias");
 #endif
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d63c3843e493..8e9a6c41f9ee 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1452,6 +1452,8 @@ static void svm_prepare_guest_switch(struct kvm_vcpu *vcpu)
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct svm_cpu_data *sd = per_cpu(svm_data, vcpu->cpu);
 
+	amd_clear_divider();
+
 	if (sev_es_guest(vcpu->kvm))
 		sev_es_unmap_ghcb(svm);
 
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 5f7eed97487e..6f5321b36dbb 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -11,7 +11,7 @@
 #include <asm/frame.h>
 #include <asm/nops.h>
 
-	.section .text.__x86.indirect_thunk
+	.section .text..__x86.indirect_thunk
 
 .macro RETPOLINE reg
 	ANNOTATE_INTRA_FUNCTION_CALL
@@ -75,74 +75,105 @@ SYM_CODE_END(__x86_indirect_thunk_array)
 #ifdef CONFIG_RETHUNK
 
 /*
- * srso_untrain_ret_alias() and srso_safe_ret_alias() are placed at
+ * srso_alias_untrain_ret() and srso_alias_safe_ret() are placed at
  * special addresses:
  *
- * - srso_untrain_ret_alias() is 2M aligned
- * - srso_safe_ret_alias() is also in the same 2M page but bits 2, 8, 14
+ * - srso_alias_untrain_ret() is 2M aligned
+ * - srso_alias_safe_ret() is also in the same 2M page but bits 2, 8, 14
  * and 20 in its virtual address are set (while those bits in the
- * srso_untrain_ret_alias() function are cleared).
+ * srso_alias_untrain_ret() function are cleared).
  *
  * This guarantees that those two addresses will alias in the branch
  * target buffer of Zen3/4 generations, leading to any potential
  * poisoned entries at that BTB slot to get evicted.
  *
- * As a result, srso_safe_ret_alias() becomes a safe return.
+ * As a result, srso_alias_safe_ret() becomes a safe return.
  */
 #ifdef CONFIG_CPU_SRSO
-	.section .text.__x86.rethunk_untrain
+	.section .text..__x86.rethunk_untrain
 
-SYM_START(srso_untrain_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)
+SYM_START(srso_alias_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
+	UNWIND_HINT_FUNC
 	ASM_NOP2
 	lfence
-	jmp __x86_return_thunk
-SYM_FUNC_END(srso_untrain_ret_alias)
-__EXPORT_THUNK(srso_untrain_ret_alias)
+	jmp srso_alias_return_thunk
+SYM_FUNC_END(srso_alias_untrain_ret)
+__EXPORT_THUNK(srso_alias_untrain_ret)
 
-	.section .text.__x86.rethunk_safe
+	.section .text..__x86.rethunk_safe
+#else
+/* dummy definition for alternatives */
+SYM_START(srso_alias_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+SYM_FUNC_END(srso_alias_untrain_ret)
 #endif
 
-/* Needs a definition for the __x86_return_thunk alternative below. */
-SYM_START(srso_safe_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)
-#ifdef CONFIG_CPU_SRSO
-	add $8, %_ASM_SP
+SYM_START(srso_alias_safe_ret, SYM_L_GLOBAL, SYM_A_NONE)
+	lea 8(%_ASM_SP), %_ASM_SP
 	UNWIND_HINT_FUNC
-#endif
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
-SYM_FUNC_END(srso_safe_ret_alias)
+SYM_FUNC_END(srso_alias_safe_ret)
 
-	.section .text.__x86.return_thunk
+	.section .text..__x86.return_thunk
+
+SYM_CODE_START(srso_alias_return_thunk)
+	UNWIND_HINT_FUNC
+	ANNOTATE_NOENDBR
+	call srso_alias_safe_ret
+	ud2
+SYM_CODE_END(srso_alias_return_thunk)
+
+/*
+ * Some generic notes on the untraining sequences:
+ *
+ * They are interchangeable when it comes to flushing potentially wrong
+ * RET predictions from the BTB.
+ *
+ * The SRSO Zen1/2 (MOVABS) untraining sequence is longer than the
+ * Retbleed sequence because the return sequence done there
+ * (srso_safe_ret()) is longer and the return sequence must fully nest
+ * (end before) the untraining sequence. Therefore, the untraining
+ * sequence must fully overlap the return sequence.
+ *
+ * Regarding alignment - the instructions which need to be untrained,
+ * must all start at a cacheline boundary for Zen1/2 generations. That
+ * is, instruction sequences starting at srso_safe_ret() and
+ * the respective instruction sequences at retbleed_return_thunk()
+ * must start at a cacheline boundary.
+ */
 
 /*
  * Safety details here pertain to the AMD Zen{1,2} microarchitecture:
- * 1) The RET at __x86_return_thunk must be on a 64 byte boundary, for
+ * 1) The RET at retbleed_return_thunk must be on a 64 byte boundary, for
  *    alignment within the BTB.
- * 2) The instruction at zen_untrain_ret must contain, and not
+ * 2) The instruction at retbleed_untrain_ret must contain, and not
  *    end with, the 0xc3 byte of the RET.
  * 3) STIBP must be enabled, or SMT disabled, to prevent the sibling thread
  *    from re-poisioning the BTB prediction.
  */
 	.align 64
-	.skip 64 - (__ret - zen_untrain_ret), 0xcc
-SYM_FUNC_START_NOALIGN(zen_untrain_ret);
+	.skip 64 - (retbleed_return_thunk - retbleed_untrain_ret), 0xcc
+SYM_FUNC_START_NOALIGN(retbleed_untrain_ret);
 
 	/*
-	 * As executed from zen_untrain_ret, this is:
+	 * As executed from retbleed_untrain_ret, this is:
 	 *
 	 *   TEST $0xcc, %bl
 	 *   LFENCE
-	 *   JMP __x86_return_thunk
+	 *   JMP retbleed_return_thunk
 	 *
 	 * Executing the TEST instruction has a side effect of evicting any BTB
 	 * prediction (potentially attacker controlled) attached to the RET, as
-	 * __x86_return_thunk + 1 isn't an instruction boundary at the moment.
+	 * retbleed_return_thunk + 1 isn't an instruction boundary at the moment.
 	 */
 	.byte	0xf6
 
 	/*
-	 * As executed from __x86_return_thunk, this is a plain RET.
+	 * As executed from retbleed_return_thunk, this is a plain RET.
 	 *
 	 * As part of the TEST above, RET is the ModRM byte, and INT3 the imm8.
 	 *
@@ -154,13 +185,13 @@ SYM_FUNC_START_NOALIGN(zen_untrain_ret);
 	 * With SMT enabled and STIBP active, a sibling thread cannot poison
 	 * RET's prediction to a type of its choice, but can evict the
 	 * prediction due to competitive sharing. If the prediction is
-	 * evicted, __x86_return_thunk will suffer Straight Line Speculation
+	 * evicted, retbleed_return_thunk will suffer Straight Line Speculation
 	 * which will be contained safely by the INT3.
 	 */
-SYM_INNER_LABEL(__ret, SYM_L_GLOBAL)
+SYM_INNER_LABEL(retbleed_return_thunk, SYM_L_GLOBAL)
 	ret
 	int3
-SYM_CODE_END(__ret)
+SYM_CODE_END(retbleed_return_thunk)
 
 	/*
 	 * Ensure the TEST decoding / BTB invalidation is complete.
@@ -171,16 +202,16 @@ SYM_CODE_END(__ret)
 	 * Jump back and execute the RET in the middle of the TEST instruction.
 	 * INT3 is for SLS protection.
 	 */
-	jmp __ret
+	jmp retbleed_return_thunk
 	int3
-SYM_FUNC_END(zen_untrain_ret)
-__EXPORT_THUNK(zen_untrain_ret)
+SYM_FUNC_END(retbleed_untrain_ret)
+__EXPORT_THUNK(retbleed_untrain_ret)
 
 /*
- * SRSO untraining sequence for Zen1/2, similar to zen_untrain_ret()
+ * SRSO untraining sequence for Zen1/2, similar to retbleed_untrain_ret()
  * above. On kernel entry, srso_untrain_ret() is executed which is a
  *
- * movabs $0xccccccc308c48348,%rax
+ * movabs $0xccccc30824648d48,%rax
  *
  * and when the return thunk executes the inner label srso_safe_ret()
  * later, it is a stack manipulation and a RET which is mispredicted and
@@ -191,22 +222,44 @@ __EXPORT_THUNK(zen_untrain_ret)
 SYM_START(srso_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	.byte 0x48, 0xb8
 
+/*
+ * This forces the function return instruction to speculate into a trap
+ * (UD2 in srso_return_thunk() below).  This RET will then mispredict
+ * and execution will continue at the return site read from the top of
+ * the stack.
+ */
 SYM_INNER_LABEL(srso_safe_ret, SYM_L_GLOBAL)
-	add $8, %_ASM_SP
+	lea 8(%_ASM_SP), %_ASM_SP
 	ret
 	int3
 	int3
-	int3
+	/* end of movabs */
 	lfence
 	call srso_safe_ret
-	int3
+	ud2
 SYM_CODE_END(srso_safe_ret)
 SYM_FUNC_END(srso_untrain_ret)
 __EXPORT_THUNK(srso_untrain_ret)
 
-SYM_FUNC_START(__x86_return_thunk)
-	ALTERNATIVE_2 "jmp __ret", "call srso_safe_ret", X86_FEATURE_SRSO, \
-			"call srso_safe_ret_alias", X86_FEATURE_SRSO_ALIAS
+SYM_CODE_START(srso_return_thunk)
+	UNWIND_HINT_FUNC
+	ANNOTATE_NOENDBR
+	call srso_safe_ret
+	ud2
+SYM_CODE_END(srso_return_thunk)
+
+SYM_FUNC_START(entry_untrain_ret)
+	ALTERNATIVE_2 "jmp retbleed_untrain_ret", \
+		      "jmp srso_untrain_ret", X86_FEATURE_SRSO, \
+		      "jmp srso_alias_untrain_ret", X86_FEATURE_SRSO_ALIAS
+SYM_FUNC_END(entry_untrain_ret)
+__EXPORT_THUNK(entry_untrain_ret)
+
+SYM_CODE_START(__x86_return_thunk)
+	UNWIND_HINT_FUNC
+	ANNOTATE_NOENDBR
+	ANNOTATE_UNRET_SAFE
+	ret
 	int3
 SYM_CODE_END(__x86_return_thunk)
 EXPORT_SYMBOL(__x86_return_thunk)
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9eb2267bd3a0..15d253325fd8 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -475,6 +475,9 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0489, 0xe0d9), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0f5), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 	{ USB_DEVICE(0x13d3, 0x3568), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 7d508f905003..71b541538801 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -2089,6 +2089,8 @@ static int sysc_reset(struct sysc *ddata)
 		sysc_val = sysc_read_sysconfig(ddata);
 		sysc_val |= sysc_mask;
 		sysc_write(ddata, sysc_offset, sysc_val);
+		/* Flush posted write */
+		sysc_val = sysc_read_sysconfig(ddata);
 	}
 
 	if (ddata->cfg.srst_udelay)
diff --git a/drivers/firewire/net.c b/drivers/firewire/net.c
index 4c3fd2eed1da..beba0a56bb9a 100644
--- a/drivers/firewire/net.c
+++ b/drivers/firewire/net.c
@@ -488,7 +488,7 @@ static int fwnet_finish_incoming_packet(struct net_device *net,
 					struct sk_buff *skb, u16 source_node_id,
 					bool is_broadcast, u16 ether_type)
 {
-	int status;
+	int status, len;
 
 	switch (ether_type) {
 	case ETH_P_ARP:
@@ -542,13 +542,15 @@ static int fwnet_finish_incoming_packet(struct net_device *net,
 		}
 		skb->protocol = protocol;
 	}
+
+	len = skb->len;
 	status = netif_rx(skb);
 	if (status == NET_RX_DROP) {
 		net->stats.rx_errors++;
 		net->stats.rx_dropped++;
 	} else {
 		net->stats.rx_packets++;
-		net->stats.rx_bytes += skb->len;
+		net->stats.rx_bytes += len;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 2fd4d8ad7e40..4b01188385b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1541,15 +1541,15 @@ static int amdgpu_cs_wait_all_fences(struct amdgpu_device *adev,
 			continue;
 
 		r = dma_fence_wait_timeout(fence, true, timeout);
+		if (r > 0 && fence->error)
+			r = fence->error;
+
 		dma_fence_put(fence);
 		if (r < 0)
 			return r;
 
 		if (r == 0)
 			break;
-
-		if (fence->error)
-			return fence->error;
 	}
 
 	memset(wait, 0, sizeof(*wait));
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 642acfc9f0b1..2b5766d3789b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4066,6 +4066,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 		amdgpu_fbdev_set_suspend(adev, 1);
 
 	cancel_delayed_work_sync(&adev->delayed_init_work);
+	flush_delayed_work(&adev->gfx.gfx_off_delay_work);
 
 	amdgpu_ras_suspend(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 5e32906f9819..252712f930f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -579,15 +579,8 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
 
 		if (adev->gfx.gfx_off_req_count == 0 &&
 		    !adev->gfx.gfx_off_state) {
-			/* If going to s2idle, no need to wait */
-			if (adev->in_s0ix) {
-				if (!amdgpu_dpm_set_powergating_by_smu(adev,
-						AMD_IP_BLOCK_TYPE_GFX, true))
-					adev->gfx.gfx_off_state = true;
-			} else {
-				schedule_delayed_work(&adev->gfx.gfx_off_delay_work,
+			schedule_delayed_work(&adev->gfx.gfx_off_delay_work,
 					      delay);
-			}
 		}
 	} else {
 		if (adev->gfx.gfx_off_req_count == 0) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 0e4554950e07..788611a50a68 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2260,6 +2260,7 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu_device *adev,
 	amdgpu_vm_bo_base_init(&bo_va->base, vm, bo);
 
 	bo_va->ref_count = 1;
+	bo_va->last_pt_update = dma_fence_get_stub();
 	INIT_LIST_HEAD(&bo_va->valids);
 	INIT_LIST_HEAD(&bo_va->invalids);
 
@@ -2974,7 +2975,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 		vm->update_funcs = &amdgpu_vm_cpu_funcs;
 	else
 		vm->update_funcs = &amdgpu_vm_sdma_funcs;
-	vm->last_update = NULL;
+
+	vm->last_update = dma_fence_get_stub();
 	vm->last_unlocked = dma_fence_get_stub();
 
 	mutex_init(&vm->eviction_lock);
@@ -3117,7 +3119,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 		vm->update_funcs = &amdgpu_vm_sdma_funcs;
 	}
 	dma_fence_put(vm->last_update);
-	vm->last_update = NULL;
+	vm->last_update = dma_fence_get_stub();
 	vm->is_compute_context = true;
 
 	/* Free the shadow bo for compute VM */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7bd38d927b18..4cf33abfb7cc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8566,27 +8566,55 @@ is_scaling_state_different(const struct dm_connector_state *dm_state,
 }
 
 #ifdef CONFIG_DRM_AMD_DC_HDCP
-static bool is_content_protection_different(struct drm_connector_state *state,
-					    const struct drm_connector_state *old_state,
-					    const struct drm_connector *connector, struct hdcp_workqueue *hdcp_w)
+static bool is_content_protection_different(struct drm_crtc_state *new_crtc_state,
+					    struct drm_crtc_state *old_crtc_state,
+					    struct drm_connector_state *new_conn_state,
+					    struct drm_connector_state *old_conn_state,
+					    const struct drm_connector *connector,
+					    struct hdcp_workqueue *hdcp_w)
 {
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 	struct dm_connector_state *dm_con_state = to_dm_connector_state(connector->state);
 
-	/* Handle: Type0/1 change */
-	if (old_state->hdcp_content_type != state->hdcp_content_type &&
-	    state->content_protection != DRM_MODE_CONTENT_PROTECTION_UNDESIRED) {
-		state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
+	pr_debug("[HDCP_DM] connector->index: %x connect_status: %x dpms: %x\n",
+		connector->index, connector->status, connector->dpms);
+	pr_debug("[HDCP_DM] state protection old: %x new: %x\n",
+		old_conn_state->content_protection, new_conn_state->content_protection);
+
+	if (old_crtc_state)
+		pr_debug("[HDCP_DM] old crtc en: %x a: %x m: %x a-chg: %x c-chg: %x\n",
+		old_crtc_state->enable,
+		old_crtc_state->active,
+		old_crtc_state->mode_changed,
+		old_crtc_state->active_changed,
+		old_crtc_state->connectors_changed);
+
+	if (new_crtc_state)
+		pr_debug("[HDCP_DM] NEW crtc en: %x a: %x m: %x a-chg: %x c-chg: %x\n",
+		new_crtc_state->enable,
+		new_crtc_state->active,
+		new_crtc_state->mode_changed,
+		new_crtc_state->active_changed,
+		new_crtc_state->connectors_changed);
+
+	/* hdcp content type change */
+	if (old_conn_state->hdcp_content_type != new_conn_state->hdcp_content_type &&
+	    new_conn_state->content_protection != DRM_MODE_CONTENT_PROTECTION_UNDESIRED) {
+		new_conn_state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
+		pr_debug("[HDCP_DM] Type0/1 change %s :true\n", __func__);
 		return true;
 	}
 
-	/* CP is being re enabled, ignore this
-	 *
-	 * Handles:	ENABLED -> DESIRED
-	 */
-	if (old_state->content_protection == DRM_MODE_CONTENT_PROTECTION_ENABLED &&
-	    state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED) {
-		state->content_protection = DRM_MODE_CONTENT_PROTECTION_ENABLED;
+	/* CP is being re enabled, ignore this */
+	if (old_conn_state->content_protection == DRM_MODE_CONTENT_PROTECTION_ENABLED &&
+	    new_conn_state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED) {
+		if (new_crtc_state && new_crtc_state->mode_changed) {
+			new_conn_state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
+			pr_debug("[HDCP_DM] ENABLED->DESIRED & mode_changed %s :true\n", __func__);
+			return true;
+		};
+		new_conn_state->content_protection = DRM_MODE_CONTENT_PROTECTION_ENABLED;
+		pr_debug("[HDCP_DM] ENABLED -> DESIRED %s :false\n", __func__);
 		return false;
 	}
 
@@ -8594,9 +8622,9 @@ static bool is_content_protection_different(struct drm_connector_state *state,
 	 *
 	 * Handles:	UNDESIRED -> ENABLED
 	 */
-	if (old_state->content_protection == DRM_MODE_CONTENT_PROTECTION_UNDESIRED &&
-	    state->content_protection == DRM_MODE_CONTENT_PROTECTION_ENABLED)
-		state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
+	if (old_conn_state->content_protection == DRM_MODE_CONTENT_PROTECTION_UNDESIRED &&
+	    new_conn_state->content_protection == DRM_MODE_CONTENT_PROTECTION_ENABLED)
+		new_conn_state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
 
 	/* Stream removed and re-enabled
 	 *
@@ -8606,10 +8634,12 @@ static bool is_content_protection_different(struct drm_connector_state *state,
 	 *
 	 * Handles:	DESIRED -> DESIRED (Special case)
 	 */
-	if (!(old_state->crtc && old_state->crtc->enabled) &&
-		state->crtc && state->crtc->enabled &&
+	if (!(old_conn_state->crtc && old_conn_state->crtc->enabled) &&
+		new_conn_state->crtc && new_conn_state->crtc->enabled &&
 		connector->state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED) {
 		dm_con_state->update_hdcp = false;
+		pr_debug("[HDCP_DM] DESIRED->DESIRED (Stream removed and re-enabled) %s :true\n",
+			__func__);
 		return true;
 	}
 
@@ -8621,35 +8651,42 @@ static bool is_content_protection_different(struct drm_connector_state *state,
 	 *
 	 * Handles:	DESIRED -> DESIRED (Special case)
 	 */
-	if (dm_con_state->update_hdcp && state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED &&
-	    connector->dpms == DRM_MODE_DPMS_ON && aconnector->dc_sink != NULL) {
+	if (dm_con_state->update_hdcp &&
+	new_conn_state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED &&
+	connector->dpms == DRM_MODE_DPMS_ON && aconnector->dc_sink != NULL) {
 		dm_con_state->update_hdcp = false;
+		pr_debug("[HDCP_DM] DESIRED->DESIRED (Hot-plug, headless s3, dpms) %s :true\n",
+			__func__);
 		return true;
 	}
 
-	/*
-	 * Handles:	UNDESIRED -> UNDESIRED
-	 *		DESIRED -> DESIRED
-	 *		ENABLED -> ENABLED
-	 */
-	if (old_state->content_protection == state->content_protection)
+	if (old_conn_state->content_protection == new_conn_state->content_protection) {
+		if (new_conn_state->content_protection >= DRM_MODE_CONTENT_PROTECTION_DESIRED) {
+			if (new_crtc_state && new_crtc_state->mode_changed) {
+				pr_debug("[HDCP_DM] DESIRED->DESIRED or ENABLE->ENABLE mode_change %s :true\n",
+					__func__);
+				return true;
+			};
+			pr_debug("[HDCP_DM] DESIRED->DESIRED & ENABLE->ENABLE %s :false\n",
+				__func__);
+			return false;
+		};
+
+		pr_debug("[HDCP_DM] UNDESIRED->UNDESIRED %s :false\n", __func__);
 		return false;
+	}
 
-	/*
-	 * Handles:	UNDESIRED -> DESIRED
-	 *		DESIRED -> UNDESIRED
-	 *		ENABLED -> UNDESIRED
-	 */
-	if (state->content_protection != DRM_MODE_CONTENT_PROTECTION_ENABLED)
+	if (new_conn_state->content_protection != DRM_MODE_CONTENT_PROTECTION_ENABLED) {
+		pr_debug("[HDCP_DM] UNDESIRED->DESIRED or DESIRED->UNDESIRED or ENABLED->UNDESIRED %s :true\n",
+			__func__);
 		return true;
+	}
 
-	/*
-	 * Handles:	DESIRED -> ENABLED
-	 */
+	pr_debug("[HDCP_DM] DESIRED->ENABLED %s :false\n", __func__);
 	return false;
 }
-
 #endif
+
 static void remove_stream(struct amdgpu_device *adev,
 			  struct amdgpu_crtc *acrtc,
 			  struct dc_stream_state *stream)
@@ -9597,10 +9634,67 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(dm_new_con_state->base.crtc);
 		struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 
+		if (!adev->dm.hdcp_workqueue)
+			continue;
+
+		pr_debug("[HDCP_DM] -------------- i : %x ----------\n", i);
+
+		if (!connector)
+			continue;
+
+		pr_debug("[HDCP_DM] connector->index: %x connect_status: %x dpms: %x\n",
+			connector->index, connector->status, connector->dpms);
+		pr_debug("[HDCP_DM] state protection old: %x new: %x\n",
+			old_con_state->content_protection, new_con_state->content_protection);
+
+		if (aconnector->dc_sink) {
+			if (aconnector->dc_sink->sink_signal != SIGNAL_TYPE_VIRTUAL &&
+				aconnector->dc_sink->sink_signal != SIGNAL_TYPE_NONE) {
+				pr_debug("[HDCP_DM] pipe_ctx dispname=%s\n",
+				aconnector->dc_sink->edid_caps.display_name);
+			}
+		}
+
 		new_crtc_state = NULL;
+		old_crtc_state = NULL;
 
-		if (acrtc)
+		if (acrtc) {
 			new_crtc_state = drm_atomic_get_new_crtc_state(state, &acrtc->base);
+			old_crtc_state = drm_atomic_get_old_crtc_state(state, &acrtc->base);
+		}
+
+		if (old_crtc_state)
+			pr_debug("old crtc en: %x a: %x m: %x a-chg: %x c-chg: %x\n",
+			old_crtc_state->enable,
+			old_crtc_state->active,
+			old_crtc_state->mode_changed,
+			old_crtc_state->active_changed,
+			old_crtc_state->connectors_changed);
+
+		if (new_crtc_state)
+			pr_debug("NEW crtc en: %x a: %x m: %x a-chg: %x c-chg: %x\n",
+			new_crtc_state->enable,
+			new_crtc_state->active,
+			new_crtc_state->mode_changed,
+			new_crtc_state->active_changed,
+			new_crtc_state->connectors_changed);
+	}
+
+	for_each_oldnew_connector_in_state(state, connector, old_con_state, new_con_state, i) {
+		struct dm_connector_state *dm_new_con_state = to_dm_connector_state(new_con_state);
+		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(dm_new_con_state->base.crtc);
+		struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
+
+		if (!adev->dm.hdcp_workqueue)
+			continue;
+
+		new_crtc_state = NULL;
+		old_crtc_state = NULL;
+
+		if (acrtc) {
+			new_crtc_state = drm_atomic_get_new_crtc_state(state, &acrtc->base);
+			old_crtc_state = drm_atomic_get_old_crtc_state(state, &acrtc->base);
+		}
 
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 
@@ -9612,11 +9706,44 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			continue;
 		}
 
-		if (is_content_protection_different(new_con_state, old_con_state, connector, adev->dm.hdcp_workqueue))
+		if (is_content_protection_different(new_crtc_state, old_crtc_state, new_con_state,
+											old_con_state, connector, adev->dm.hdcp_workqueue)) {
+			/* when display is unplugged from mst hub, connctor will
+			 * be destroyed within dm_dp_mst_connector_destroy. connector
+			 * hdcp perperties, like type, undesired, desired, enabled,
+			 * will be lost. So, save hdcp properties into hdcp_work within
+			 * amdgpu_dm_atomic_commit_tail. if the same display is
+			 * plugged back with same display index, its hdcp properties
+			 * will be retrieved from hdcp_work within dm_dp_mst_get_modes
+			 */
+
+			bool enable_encryption = false;
+
+			if (new_con_state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED)
+				enable_encryption = true;
+
+			if (aconnector->dc_link && aconnector->dc_sink &&
+				aconnector->dc_link->type == dc_connection_mst_branch) {
+				struct hdcp_workqueue *hdcp_work = adev->dm.hdcp_workqueue;
+				struct hdcp_workqueue *hdcp_w =
+					&hdcp_work[aconnector->dc_link->link_index];
+
+				hdcp_w->hdcp_content_type[connector->index] =
+					new_con_state->hdcp_content_type;
+				hdcp_w->content_protection[connector->index] =
+					new_con_state->content_protection;
+			}
+
+			if (new_crtc_state && new_crtc_state->mode_changed &&
+				new_con_state->content_protection >= DRM_MODE_CONTENT_PROTECTION_DESIRED)
+				enable_encryption = true;
+
+			DRM_INFO("[HDCP_DM] hdcp_update_display enable_encryption = %x\n", enable_encryption);
+
 			hdcp_update_display(
 				adev->dm.hdcp_workqueue, aconnector->dc_link->link_index, aconnector,
-				new_con_state->hdcp_content_type,
-				new_con_state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED);
+				new_con_state->hdcp_content_type, enable_encryption);
+		}
 	}
 #endif
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
index 09294ff122fe..bbbf7d0eff82 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
@@ -52,6 +52,20 @@ struct hdcp_workqueue {
 	struct mod_hdcp_link link;
 
 	enum mod_hdcp_encryption_status encryption_status;
+
+	/* when display is unplugged from mst hub, connctor will be
+	 * destroyed within dm_dp_mst_connector_destroy. connector
+	 * hdcp perperties, like type, undesired, desired, enabled,
+	 * will be lost. So, save hdcp properties into hdcp_work within
+	 * amdgpu_dm_atomic_commit_tail. if the same display is
+	 * plugged back with same display index, its hdcp properties
+	 * will be retrieved from hdcp_work within dm_dp_mst_get_modes
+	 */
+	/* un-desired, desired, enabled */
+	unsigned int content_protection[AMDGPU_DM_MAX_DISPLAY_INDEX];
+	/* hdcp1.x, hdcp2.x */
+	unsigned int hdcp_content_type[AMDGPU_DM_MAX_DISPLAY_INDEX];
+
 	uint8_t max_link;
 
 	uint8_t *srm;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 7a3fee71a867..0b58a9386449 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -32,6 +32,10 @@
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_mst_types.h"
 
+#ifdef CONFIG_DRM_AMD_DC_HDCP
+#include "amdgpu_dm_hdcp.h"
+#endif
+
 #include "dc.h"
 #include "dm_helpers.h"
 
@@ -315,6 +319,32 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 		/* dc_link_add_remote_sink returns a new reference */
 		aconnector->dc_sink = dc_sink;
 
+		/* when display is unplugged from mst hub, connctor will be
+		 * destroyed within dm_dp_mst_connector_destroy. connector
+		 * hdcp perperties, like type, undesired, desired, enabled,
+		 * will be lost. So, save hdcp properties into hdcp_work within
+		 * amdgpu_dm_atomic_commit_tail. if the same display is
+		 * plugged back with same display index, its hdcp properties
+		 * will be retrieved from hdcp_work within dm_dp_mst_get_modes
+		 */
+#ifdef CONFIG_DRM_AMD_DC_HDCP
+		if (aconnector->dc_sink && connector->state) {
+			struct drm_device *dev = connector->dev;
+			struct amdgpu_device *adev = drm_to_adev(dev);
+
+			if (adev->dm.hdcp_workqueue) {
+				struct hdcp_workqueue *hdcp_work = adev->dm.hdcp_workqueue;
+				struct hdcp_workqueue *hdcp_w =
+					&hdcp_work[aconnector->dc_link->link_index];
+
+				connector->state->hdcp_content_type =
+				hdcp_w->hdcp_content_type[connector->index];
+				connector->state->content_protection =
+				hdcp_w->content_protection[connector->index];
+			}
+		}
+#endif
+
 		if (aconnector->dc_sink) {
 			amdgpu_dm_update_freesync_caps(
 					connector, aconnector->edid);
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 391d73d2638a..7cf0af78b7bc 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1258,21 +1258,21 @@ static const struct panel_desc auo_g104sn02 = {
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
-static const struct drm_display_mode auo_g121ean01_mode = {
-	.clock = 66700,
-	.hdisplay = 1280,
-	.hsync_start = 1280 + 58,
-	.hsync_end = 1280 + 58 + 8,
-	.htotal = 1280 + 58 + 8 + 70,
-	.vdisplay = 800,
-	.vsync_start = 800 + 6,
-	.vsync_end = 800 + 6 + 4,
-	.vtotal = 800 + 6 + 4 + 10,
+static const struct display_timing auo_g121ean01_timing = {
+	.pixelclock = { 60000000, 74400000, 90000000 },
+	.hactive = { 1280, 1280, 1280 },
+	.hfront_porch = { 20, 50, 100 },
+	.hback_porch = { 20, 50, 100 },
+	.hsync_len = { 30, 100, 200 },
+	.vactive = { 800, 800, 800 },
+	.vfront_porch = { 2, 10, 25 },
+	.vback_porch = { 2, 10, 25 },
+	.vsync_len = { 4, 18, 50 },
 };
 
 static const struct panel_desc auo_g121ean01 = {
-	.modes = &auo_g121ean01_mode,
-	.num_modes = 1,
+	.timings = &auo_g121ean01_timing,
+	.num_timings = 1,
 	.bpc = 8,
 	.size = {
 		.width = 261,
diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 359266d9e860..f0f512d58497 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -318,7 +318,7 @@ int qxl_gem_object_create_with_handle(struct qxl_device *qdev,
 				      u32 domain,
 				      size_t size,
 				      struct qxl_surface *surf,
-				      struct qxl_bo **qobj,
+				      struct drm_gem_object **gobj,
 				      uint32_t *handle);
 void qxl_gem_object_free(struct drm_gem_object *gobj);
 int qxl_gem_object_open(struct drm_gem_object *obj, struct drm_file *file_priv);
diff --git a/drivers/gpu/drm/qxl/qxl_dumb.c b/drivers/gpu/drm/qxl/qxl_dumb.c
index d636ba685451..17df5c7ccf69 100644
--- a/drivers/gpu/drm/qxl/qxl_dumb.c
+++ b/drivers/gpu/drm/qxl/qxl_dumb.c
@@ -34,6 +34,7 @@ int qxl_mode_dumb_create(struct drm_file *file_priv,
 {
 	struct qxl_device *qdev = to_qxl(dev);
 	struct qxl_bo *qobj;
+	struct drm_gem_object *gobj;
 	uint32_t handle;
 	int r;
 	struct qxl_surface surf;
@@ -62,11 +63,13 @@ int qxl_mode_dumb_create(struct drm_file *file_priv,
 
 	r = qxl_gem_object_create_with_handle(qdev, file_priv,
 					      QXL_GEM_DOMAIN_CPU,
-					      args->size, &surf, &qobj,
+					      args->size, &surf, &gobj,
 					      &handle);
 	if (r)
 		return r;
+	qobj = gem_to_qxl_bo(gobj);
 	qobj->is_dumb = true;
+	drm_gem_object_put(gobj);
 	args->pitch = pitch;
 	args->handle = handle;
 	return 0;
diff --git a/drivers/gpu/drm/qxl/qxl_gem.c b/drivers/gpu/drm/qxl/qxl_gem.c
index a08da0bd9098..fc5e3763c359 100644
--- a/drivers/gpu/drm/qxl/qxl_gem.c
+++ b/drivers/gpu/drm/qxl/qxl_gem.c
@@ -72,32 +72,41 @@ int qxl_gem_object_create(struct qxl_device *qdev, int size,
 	return 0;
 }
 
+/*
+ * If the caller passed a valid gobj pointer, it is responsible to call
+ * drm_gem_object_put() when it no longer needs to acess the object.
+ *
+ * If gobj is NULL, it is handled internally.
+ */
 int qxl_gem_object_create_with_handle(struct qxl_device *qdev,
 				      struct drm_file *file_priv,
 				      u32 domain,
 				      size_t size,
 				      struct qxl_surface *surf,
-				      struct qxl_bo **qobj,
+				      struct drm_gem_object **gobj,
 				      uint32_t *handle)
 {
-	struct drm_gem_object *gobj;
 	int r;
+	struct drm_gem_object *local_gobj;
 
-	BUG_ON(!qobj);
 	BUG_ON(!handle);
 
 	r = qxl_gem_object_create(qdev, size, 0,
 				  domain,
 				  false, false, surf,
-				  &gobj);
+				  &local_gobj);
 	if (r)
 		return -ENOMEM;
-	r = drm_gem_handle_create(file_priv, gobj, handle);
+	r = drm_gem_handle_create(file_priv, local_gobj, handle);
 	if (r)
 		return r;
-	/* drop reference from allocate - handle holds it now */
-	*qobj = gem_to_qxl_bo(gobj);
-	drm_gem_object_put(gobj);
+
+	if (gobj)
+		*gobj = local_gobj;
+	else
+		/* drop reference from allocate - handle holds it now */
+		drm_gem_object_put(local_gobj);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index 38aabcbe2238..4066499ca79e 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -39,7 +39,6 @@ static int qxl_alloc_ioctl(struct drm_device *dev, void *data,
 	struct qxl_device *qdev = to_qxl(dev);
 	struct drm_qxl_alloc *qxl_alloc = data;
 	int ret;
-	struct qxl_bo *qobj;
 	uint32_t handle;
 	u32 domain = QXL_GEM_DOMAIN_VRAM;
 
@@ -51,7 +50,7 @@ static int qxl_alloc_ioctl(struct drm_device *dev, void *data,
 						domain,
 						qxl_alloc->size,
 						NULL,
-						&qobj, &handle);
+						NULL, &handle);
 	if (ret) {
 		DRM_ERROR("%s: failed to create gem ret=%d\n",
 			  __func__, ret);
@@ -393,7 +392,6 @@ static int qxl_alloc_surf_ioctl(struct drm_device *dev, void *data,
 {
 	struct qxl_device *qdev = to_qxl(dev);
 	struct drm_qxl_alloc_surf *param = data;
-	struct qxl_bo *qobj;
 	int handle;
 	int ret;
 	int size, actual_stride;
@@ -413,7 +411,7 @@ static int qxl_alloc_surf_ioctl(struct drm_device *dev, void *data,
 						QXL_GEM_DOMAIN_SURFACE,
 						size,
 						&surf,
-						&qobj, &handle);
+						NULL, &handle);
 	if (ret) {
 		DRM_ERROR("%s: failed to create gem ret=%d\n",
 			  __func__, ret);
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 5daec769df7a..5fceefb3c707 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -593,6 +593,7 @@
 #define USB_DEVICE_ID_UGCI_FIGHTING	0x0030
 
 #define USB_VENDOR_ID_HP		0x03f0
+#define USB_PRODUCT_ID_HP_ELITE_PRESENTER_MOUSE_464A		0x464a
 #define USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0A4A	0x0a4a
 #define USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0B4A	0x0b4a
 #define USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE		0x134a
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index c61da859cd3c..0ac67dd76574 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4377,6 +4377,8 @@ static const struct hid_device_id hidpp_devices[] = {
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC086) },
 	{ /* Logitech G903 Hero Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC091) },
+	{ /* Logitech G915 TKL Keyboard over USB */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC343) },
 	{ /* Logitech G920 Wheel over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL),
 		.driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS},
@@ -4392,6 +4394,8 @@ static const struct hid_device_id hidpp_devices[] = {
 	{ /* MX5500 keyboard over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb30b),
 	  .driver_data = HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS },
+	{ /* Logitech G915 TKL keyboard over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb35f) },
 	{ /* M-RCQ142 V470 Cordless Laser Mouse over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb008) },
 	{ /* MX Master mouse over Bluetooth */
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index c7c06aa958c4..96ca7d981ee2 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -96,6 +96,7 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD_A096), HID_QUIRK_NO_INIT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD_A293), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0A4A), HID_QUIRK_ALWAYS_POLL },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_ELITE_PRESENTER_MOUSE_464A), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0B4A), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_094A), HID_QUIRK_ALWAYS_POLL },
diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index 6304d1dd2dd6..ec6571b82fff 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -243,13 +243,14 @@ static inline u32 iproc_i2c_rd_reg(struct bcm_iproc_i2c_dev *iproc_i2c,
 				   u32 offset)
 {
 	u32 val;
+	unsigned long flags;
 
 	if (iproc_i2c->idm_base) {
-		spin_lock(&iproc_i2c->idm_lock);
+		spin_lock_irqsave(&iproc_i2c->idm_lock, flags);
 		writel(iproc_i2c->ape_addr_mask,
 		       iproc_i2c->idm_base + IDM_CTRL_DIRECT_OFFSET);
 		val = readl(iproc_i2c->base + offset);
-		spin_unlock(&iproc_i2c->idm_lock);
+		spin_unlock_irqrestore(&iproc_i2c->idm_lock, flags);
 	} else {
 		val = readl(iproc_i2c->base + offset);
 	}
@@ -260,12 +261,14 @@ static inline u32 iproc_i2c_rd_reg(struct bcm_iproc_i2c_dev *iproc_i2c,
 static inline void iproc_i2c_wr_reg(struct bcm_iproc_i2c_dev *iproc_i2c,
 				    u32 offset, u32 val)
 {
+	unsigned long flags;
+
 	if (iproc_i2c->idm_base) {
-		spin_lock(&iproc_i2c->idm_lock);
+		spin_lock_irqsave(&iproc_i2c->idm_lock, flags);
 		writel(iproc_i2c->ape_addr_mask,
 		       iproc_i2c->idm_base + IDM_CTRL_DIRECT_OFFSET);
 		writel(val, iproc_i2c->base + offset);
-		spin_unlock(&iproc_i2c->idm_lock);
+		spin_unlock_irqrestore(&iproc_i2c->idm_lock, flags);
 	} else {
 		writel(val, iproc_i2c->base + offset);
 	}
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index e0559eff8928..b79e1380ff68 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -525,9 +525,21 @@ i2c_dw_read(struct dw_i2c_dev *dev)
 			u32 flags = msgs[dev->msg_read_idx].flags;
 
 			regmap_read(dev->map, DW_IC_DATA_CMD, &tmp);
+			tmp &= DW_IC_DATA_CMD_DAT;
 			/* Ensure length byte is a valid value */
-			if (flags & I2C_M_RECV_LEN &&
-			    (tmp & DW_IC_DATA_CMD_DAT) <= I2C_SMBUS_BLOCK_MAX && tmp > 0) {
+			if (flags & I2C_M_RECV_LEN) {
+				/*
+				 * if IC_EMPTYFIFO_HOLD_MASTER_EN is set, which cannot be
+				 * detected from the registers, the controller can be
+				 * disabled if the STOP bit is set. But it is only set
+				 * after receiving block data response length in
+				 * I2C_FUNC_SMBUS_BLOCK_DATA case. That needs to read
+				 * another byte with STOP bit set when the block data
+				 * response length is invalid to complete the transaction.
+				 */
+				if (!tmp || tmp > I2C_SMBUS_BLOCK_MAX)
+					tmp = 1;
+
 				len = i2c_dw_recv_len(dev, tmp);
 			}
 			*buf++ = tmp;
diff --git a/drivers/i2c/busses/i2c-hisi.c b/drivers/i2c/busses/i2c-hisi.c
index 1f406e6f4ece..6bdebe51ea11 100644
--- a/drivers/i2c/busses/i2c-hisi.c
+++ b/drivers/i2c/busses/i2c-hisi.c
@@ -329,6 +329,14 @@ static irqreturn_t hisi_i2c_irq(int irq, void *context)
 	struct hisi_i2c_controller *ctlr = context;
 	u32 int_stat;
 
+	/*
+	 * Don't handle the interrupt if cltr->completion is NULL. We may
+	 * reach here because the interrupt is spurious or the transfer is
+	 * started by another port (e.g. firmware) rather than us.
+	 */
+	if (!ctlr->completion)
+		return IRQ_NONE;
+
 	int_stat = readl(ctlr->iobase + HISI_I2C_INT_MSTAT);
 	hisi_i2c_clear_int(ctlr, int_stat);
 	if (!(int_stat & HISI_I2C_INT_ALL))
diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 2334ad249b46..4fb4321a72cb 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -70,6 +70,7 @@ config IIO_TRIGGERED_EVENT
 
 source "drivers/iio/accel/Kconfig"
 source "drivers/iio/adc/Kconfig"
+source "drivers/iio/addac/Kconfig"
 source "drivers/iio/afe/Kconfig"
 source "drivers/iio/amplifiers/Kconfig"
 source "drivers/iio/cdc/Kconfig"
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 65e39bd4f934..8d48c70fee4d 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_IIO_TRIGGERED_EVENT) += industrialio-triggered-event.o
 
 obj-y += accel/
 obj-y += adc/
+obj-y += addac/
 obj-y += afe/
 obj-y += amplifiers/
 obj-y += buffer/
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index af168e1c9fdb..86b83dc7b7d9 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -991,22 +991,6 @@ config STMPE_ADC
 	  Say yes here to build support for ST Microelectronics STMPE
 	  built-in ADC block (stmpe811).
 
-config STX104
-	tristate "Apex Embedded Systems STX104 driver"
-	depends on PC104 && X86
-	select ISA_BUS_API
-	select GPIOLIB
-	help
-	  Say yes here to build support for the Apex Embedded Systems STX104
-	  integrated analog PC/104 card.
-
-	  This driver supports the 16 channels of single-ended (8 channels of
-	  differential) analog inputs, 2 channels of analog output, 4 digital
-	  inputs, and 4 digital outputs provided by the STX104.
-
-	  The base port addresses for the devices may be configured via the base
-	  array module parameter.
-
 config SUN4I_GPADC
 	tristate "Support for the Allwinner SoCs GPADC"
 	depends on IIO
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index d68550f493e3..13668c4cfbaf 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -85,7 +85,6 @@ obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
 obj-$(CONFIG_RZG2L_ADC) += rzg2l_adc.o
 obj-$(CONFIG_SC27XX_ADC) += sc27xx_adc.o
 obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
-obj-$(CONFIG_STX104) += stx104.o
 obj-$(CONFIG_SUN4I_GPADC) += sun4i-gpadc-iio.o
 obj-$(CONFIG_STM32_ADC_CORE) += stm32-adc-core.o
 obj-$(CONFIG_STM32_ADC) += stm32-adc.o
diff --git a/drivers/iio/adc/stx104.c b/drivers/iio/adc/stx104.c
deleted file mode 100644
index 55bd2dc514e9..000000000000
--- a/drivers/iio/adc/stx104.c
+++ /dev/null
@@ -1,374 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * IIO driver for the Apex Embedded Systems STX104
- * Copyright (C) 2016 William Breathitt Gray
- */
-#include <linux/bitops.h>
-#include <linux/device.h>
-#include <linux/errno.h>
-#include <linux/gpio/driver.h>
-#include <linux/iio/iio.h>
-#include <linux/iio/types.h>
-#include <linux/io.h>
-#include <linux/ioport.h>
-#include <linux/isa.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/spinlock.h>
-
-#define STX104_OUT_CHAN(chan) {				\
-	.type = IIO_VOLTAGE,				\
-	.channel = chan,				\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
-	.indexed = 1,					\
-	.output = 1					\
-}
-#define STX104_IN_CHAN(chan, diff) {					\
-	.type = IIO_VOLTAGE,						\
-	.channel = chan,						\
-	.channel2 = chan,						\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_HARDWAREGAIN) |	\
-		BIT(IIO_CHAN_INFO_OFFSET) | BIT(IIO_CHAN_INFO_SCALE),	\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
-	.indexed = 1,							\
-	.differential = diff						\
-}
-
-#define STX104_NUM_OUT_CHAN 2
-
-#define STX104_EXTENT 16
-
-static unsigned int base[max_num_isa_dev(STX104_EXTENT)];
-static unsigned int num_stx104;
-module_param_hw_array(base, uint, ioport, &num_stx104, 0);
-MODULE_PARM_DESC(base, "Apex Embedded Systems STX104 base addresses");
-
-/**
- * struct stx104_iio - IIO device private data structure
- * @chan_out_states:	channels' output states
- * @base:		base port address of the IIO device
- */
-struct stx104_iio {
-	unsigned int chan_out_states[STX104_NUM_OUT_CHAN];
-	unsigned int base;
-};
-
-/**
- * struct stx104_gpio - GPIO device private data structure
- * @chip:	instance of the gpio_chip
- * @lock:	synchronization lock to prevent I/O race conditions
- * @base:	base port address of the GPIO device
- * @out_state:	output bits state
- */
-struct stx104_gpio {
-	struct gpio_chip chip;
-	spinlock_t lock;
-	unsigned int base;
-	unsigned int out_state;
-};
-
-static int stx104_read_raw(struct iio_dev *indio_dev,
-	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
-{
-	struct stx104_iio *const priv = iio_priv(indio_dev);
-	unsigned int adc_config;
-	int adbu;
-	int gain;
-
-	switch (mask) {
-	case IIO_CHAN_INFO_HARDWAREGAIN:
-		/* get gain configuration */
-		adc_config = inb(priv->base + 11);
-		gain = adc_config & 0x3;
-
-		*val = 1 << gain;
-		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_RAW:
-		if (chan->output) {
-			*val = priv->chan_out_states[chan->channel];
-			return IIO_VAL_INT;
-		}
-
-		/* select ADC channel */
-		outb(chan->channel | (chan->channel << 4), priv->base + 2);
-
-		/* trigger ADC sample capture and wait for completion */
-		outb(0, priv->base);
-		while (inb(priv->base + 8) & BIT(7));
-
-		*val = inw(priv->base);
-		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_OFFSET:
-		/* get ADC bipolar/unipolar configuration */
-		adc_config = inb(priv->base + 11);
-		adbu = !(adc_config & BIT(2));
-
-		*val = -32768 * adbu;
-		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SCALE:
-		/* get ADC bipolar/unipolar and gain configuration */
-		adc_config = inb(priv->base + 11);
-		adbu = !(adc_config & BIT(2));
-		gain = adc_config & 0x3;
-
-		*val = 5;
-		*val2 = 15 - adbu + gain;
-		return IIO_VAL_FRACTIONAL_LOG2;
-	}
-
-	return -EINVAL;
-}
-
-static int stx104_write_raw(struct iio_dev *indio_dev,
-	struct iio_chan_spec const *chan, int val, int val2, long mask)
-{
-	struct stx104_iio *const priv = iio_priv(indio_dev);
-
-	switch (mask) {
-	case IIO_CHAN_INFO_HARDWAREGAIN:
-		/* Only four gain states (x1, x2, x4, x8) */
-		switch (val) {
-		case 1:
-			outb(0, priv->base + 11);
-			break;
-		case 2:
-			outb(1, priv->base + 11);
-			break;
-		case 4:
-			outb(2, priv->base + 11);
-			break;
-		case 8:
-			outb(3, priv->base + 11);
-			break;
-		default:
-			return -EINVAL;
-		}
-
-		return 0;
-	case IIO_CHAN_INFO_RAW:
-		if (chan->output) {
-			/* DAC can only accept up to a 16-bit value */
-			if ((unsigned int)val > 65535)
-				return -EINVAL;
-
-			priv->chan_out_states[chan->channel] = val;
-			outw(val, priv->base + 4 + 2 * chan->channel);
-
-			return 0;
-		}
-		return -EINVAL;
-	}
-
-	return -EINVAL;
-}
-
-static const struct iio_info stx104_info = {
-	.read_raw = stx104_read_raw,
-	.write_raw = stx104_write_raw
-};
-
-/* single-ended input channels configuration */
-static const struct iio_chan_spec stx104_channels_sing[] = {
-	STX104_OUT_CHAN(0), STX104_OUT_CHAN(1),
-	STX104_IN_CHAN(0, 0), STX104_IN_CHAN(1, 0), STX104_IN_CHAN(2, 0),
-	STX104_IN_CHAN(3, 0), STX104_IN_CHAN(4, 0), STX104_IN_CHAN(5, 0),
-	STX104_IN_CHAN(6, 0), STX104_IN_CHAN(7, 0), STX104_IN_CHAN(8, 0),
-	STX104_IN_CHAN(9, 0), STX104_IN_CHAN(10, 0), STX104_IN_CHAN(11, 0),
-	STX104_IN_CHAN(12, 0), STX104_IN_CHAN(13, 0), STX104_IN_CHAN(14, 0),
-	STX104_IN_CHAN(15, 0)
-};
-/* differential input channels configuration */
-static const struct iio_chan_spec stx104_channels_diff[] = {
-	STX104_OUT_CHAN(0), STX104_OUT_CHAN(1),
-	STX104_IN_CHAN(0, 1), STX104_IN_CHAN(1, 1), STX104_IN_CHAN(2, 1),
-	STX104_IN_CHAN(3, 1), STX104_IN_CHAN(4, 1), STX104_IN_CHAN(5, 1),
-	STX104_IN_CHAN(6, 1), STX104_IN_CHAN(7, 1)
-};
-
-static int stx104_gpio_get_direction(struct gpio_chip *chip,
-	unsigned int offset)
-{
-	/* GPIO 0-3 are input only, while the rest are output only */
-	if (offset < 4)
-		return 1;
-
-	return 0;
-}
-
-static int stx104_gpio_direction_input(struct gpio_chip *chip,
-	unsigned int offset)
-{
-	if (offset >= 4)
-		return -EINVAL;
-
-	return 0;
-}
-
-static int stx104_gpio_direction_output(struct gpio_chip *chip,
-	unsigned int offset, int value)
-{
-	if (offset < 4)
-		return -EINVAL;
-
-	chip->set(chip, offset, value);
-	return 0;
-}
-
-static int stx104_gpio_get(struct gpio_chip *chip, unsigned int offset)
-{
-	struct stx104_gpio *const stx104gpio = gpiochip_get_data(chip);
-
-	if (offset >= 4)
-		return -EINVAL;
-
-	return !!(inb(stx104gpio->base) & BIT(offset));
-}
-
-static int stx104_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
-	unsigned long *bits)
-{
-	struct stx104_gpio *const stx104gpio = gpiochip_get_data(chip);
-
-	*bits = inb(stx104gpio->base);
-
-	return 0;
-}
-
-static void stx104_gpio_set(struct gpio_chip *chip, unsigned int offset,
-	int value)
-{
-	struct stx104_gpio *const stx104gpio = gpiochip_get_data(chip);
-	const unsigned int mask = BIT(offset) >> 4;
-	unsigned long flags;
-
-	if (offset < 4)
-		return;
-
-	spin_lock_irqsave(&stx104gpio->lock, flags);
-
-	if (value)
-		stx104gpio->out_state |= mask;
-	else
-		stx104gpio->out_state &= ~mask;
-
-	outb(stx104gpio->out_state, stx104gpio->base);
-
-	spin_unlock_irqrestore(&stx104gpio->lock, flags);
-}
-
-#define STX104_NGPIO 8
-static const char *stx104_names[STX104_NGPIO] = {
-	"DIN0", "DIN1", "DIN2", "DIN3", "DOUT0", "DOUT1", "DOUT2", "DOUT3"
-};
-
-static void stx104_gpio_set_multiple(struct gpio_chip *chip,
-	unsigned long *mask, unsigned long *bits)
-{
-	struct stx104_gpio *const stx104gpio = gpiochip_get_data(chip);
-	unsigned long flags;
-
-	/* verify masked GPIO are output */
-	if (!(*mask & 0xF0))
-		return;
-
-	*mask >>= 4;
-	*bits >>= 4;
-
-	spin_lock_irqsave(&stx104gpio->lock, flags);
-
-	stx104gpio->out_state &= ~*mask;
-	stx104gpio->out_state |= *mask & *bits;
-	outb(stx104gpio->out_state, stx104gpio->base);
-
-	spin_unlock_irqrestore(&stx104gpio->lock, flags);
-}
-
-static int stx104_probe(struct device *dev, unsigned int id)
-{
-	struct iio_dev *indio_dev;
-	struct stx104_iio *priv;
-	struct stx104_gpio *stx104gpio;
-	int err;
-
-	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
-	if (!indio_dev)
-		return -ENOMEM;
-
-	stx104gpio = devm_kzalloc(dev, sizeof(*stx104gpio), GFP_KERNEL);
-	if (!stx104gpio)
-		return -ENOMEM;
-
-	if (!devm_request_region(dev, base[id], STX104_EXTENT,
-		dev_name(dev))) {
-		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
-			base[id], base[id] + STX104_EXTENT);
-		return -EBUSY;
-	}
-
-	indio_dev->info = &stx104_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
-
-	/* determine if differential inputs */
-	if (inb(base[id] + 8) & BIT(5)) {
-		indio_dev->num_channels = ARRAY_SIZE(stx104_channels_diff);
-		indio_dev->channels = stx104_channels_diff;
-	} else {
-		indio_dev->num_channels = ARRAY_SIZE(stx104_channels_sing);
-		indio_dev->channels = stx104_channels_sing;
-	}
-
-	indio_dev->name = dev_name(dev);
-
-	priv = iio_priv(indio_dev);
-	priv->base = base[id];
-
-	/* configure device for software trigger operation */
-	outb(0, base[id] + 9);
-
-	/* initialize gain setting to x1 */
-	outb(0, base[id] + 11);
-
-	/* initialize DAC output to 0V */
-	outw(0, base[id] + 4);
-	outw(0, base[id] + 6);
-
-	stx104gpio->chip.label = dev_name(dev);
-	stx104gpio->chip.parent = dev;
-	stx104gpio->chip.owner = THIS_MODULE;
-	stx104gpio->chip.base = -1;
-	stx104gpio->chip.ngpio = STX104_NGPIO;
-	stx104gpio->chip.names = stx104_names;
-	stx104gpio->chip.get_direction = stx104_gpio_get_direction;
-	stx104gpio->chip.direction_input = stx104_gpio_direction_input;
-	stx104gpio->chip.direction_output = stx104_gpio_direction_output;
-	stx104gpio->chip.get = stx104_gpio_get;
-	stx104gpio->chip.get_multiple = stx104_gpio_get_multiple;
-	stx104gpio->chip.set = stx104_gpio_set;
-	stx104gpio->chip.set_multiple = stx104_gpio_set_multiple;
-	stx104gpio->base = base[id] + 3;
-	stx104gpio->out_state = 0x0;
-
-	spin_lock_init(&stx104gpio->lock);
-
-	err = devm_gpiochip_add_data(dev, &stx104gpio->chip, stx104gpio);
-	if (err) {
-		dev_err(dev, "GPIO registering failed (%d)\n", err);
-		return err;
-	}
-
-	return devm_iio_device_register(dev, indio_dev);
-}
-
-static struct isa_driver stx104_driver = {
-	.probe = stx104_probe,
-	.driver = {
-		.name = "stx104"
-	},
-};
-
-module_isa_driver(stx104_driver, num_stx104);
-
-MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
-MODULE_DESCRIPTION("Apex Embedded Systems STX104 IIO driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/addac/Kconfig b/drivers/iio/addac/Kconfig
new file mode 100644
index 000000000000..1f598670e84f
--- /dev/null
+++ b/drivers/iio/addac/Kconfig
@@ -0,0 +1,24 @@
+#
+# ADC DAC drivers
+#
+# When adding new entries keep the list in alphabetical order
+
+menu "Analog to digital and digital to analog converters"
+
+config STX104
+	tristate "Apex Embedded Systems STX104 driver"
+	depends on PC104 && X86
+	select ISA_BUS_API
+	select GPIOLIB
+	help
+	  Say yes here to build support for the Apex Embedded Systems STX104
+	  integrated analog PC/104 card.
+
+	  This driver supports the 16 channels of single-ended (8 channels of
+	  differential) analog inputs, 2 channels of analog output, 4 digital
+	  inputs, and 4 digital outputs provided by the STX104.
+
+	  The base port addresses for the devices may be configured via the base
+	  array module parameter.
+
+endmenu
diff --git a/drivers/iio/addac/Makefile b/drivers/iio/addac/Makefile
new file mode 100644
index 000000000000..862914523354
--- /dev/null
+++ b/drivers/iio/addac/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for industrial I/O ADDAC drivers
+#
+
+# When adding new entries keep the list in alphabetical order
+obj-$(CONFIG_STX104) += stx104.o
diff --git a/drivers/iio/addac/stx104.c b/drivers/iio/addac/stx104.c
new file mode 100644
index 000000000000..b658a75d4e3a
--- /dev/null
+++ b/drivers/iio/addac/stx104.c
@@ -0,0 +1,414 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * IIO driver for the Apex Embedded Systems STX104
+ * Copyright (C) 2016 William Breathitt Gray
+ */
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/gpio/driver.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/isa.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#define STX104_OUT_CHAN(chan) {				\
+	.type = IIO_VOLTAGE,				\
+	.channel = chan,				\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
+	.indexed = 1,					\
+	.output = 1					\
+}
+#define STX104_IN_CHAN(chan, diff) {					\
+	.type = IIO_VOLTAGE,						\
+	.channel = chan,						\
+	.channel2 = chan,						\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_HARDWAREGAIN) |	\
+		BIT(IIO_CHAN_INFO_OFFSET) | BIT(IIO_CHAN_INFO_SCALE),	\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.indexed = 1,							\
+	.differential = diff						\
+}
+
+#define STX104_NUM_OUT_CHAN 2
+
+#define STX104_EXTENT 16
+
+static unsigned int base[max_num_isa_dev(STX104_EXTENT)];
+static unsigned int num_stx104;
+module_param_hw_array(base, uint, ioport, &num_stx104, 0);
+MODULE_PARM_DESC(base, "Apex Embedded Systems STX104 base addresses");
+
+/**
+ * struct stx104_reg - device register structure
+ * @ssr_ad:	Software Strobe Register and ADC Data
+ * @achan:	ADC Channel
+ * @dio:	Digital I/O
+ * @dac:	DAC Channels
+ * @cir_asr:	Clear Interrupts and ADC Status
+ * @acr:	ADC Control
+ * @pccr_fsh:	Pacer Clock Control and FIFO Status MSB
+ * @acfg:	ADC Configuration
+ */
+struct stx104_reg {
+	u16 ssr_ad;
+	u8 achan;
+	u8 dio;
+	u16 dac[2];
+	u8 cir_asr;
+	u8 acr;
+	u8 pccr_fsh;
+	u8 acfg;
+};
+
+/**
+ * struct stx104_iio - IIO device private data structure
+ * @lock: synchronization lock to prevent I/O race conditions
+ * @chan_out_states:	channels' output states
+ * @reg:		I/O address offset for the device registers
+ */
+struct stx104_iio {
+	struct mutex lock;
+	unsigned int chan_out_states[STX104_NUM_OUT_CHAN];
+	struct stx104_reg __iomem *reg;
+};
+
+/**
+ * struct stx104_gpio - GPIO device private data structure
+ * @chip:	instance of the gpio_chip
+ * @lock:	synchronization lock to prevent I/O race conditions
+ * @base:	base port address of the GPIO device
+ * @out_state:	output bits state
+ */
+struct stx104_gpio {
+	struct gpio_chip chip;
+	spinlock_t lock;
+	u8 __iomem *base;
+	unsigned int out_state;
+};
+
+static int stx104_read_raw(struct iio_dev *indio_dev,
+	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
+{
+	struct stx104_iio *const priv = iio_priv(indio_dev);
+	struct stx104_reg __iomem *const reg = priv->reg;
+	unsigned int adc_config;
+	int adbu;
+	int gain;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		/* get gain configuration */
+		adc_config = ioread8(&reg->acfg);
+		gain = adc_config & 0x3;
+
+		*val = 1 << gain;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_RAW:
+		if (chan->output) {
+			*val = priv->chan_out_states[chan->channel];
+			return IIO_VAL_INT;
+		}
+
+		mutex_lock(&priv->lock);
+
+		/* select ADC channel */
+		iowrite8(chan->channel | (chan->channel << 4), &reg->achan);
+
+		/* trigger ADC sample capture by writing to the 8-bit
+		 * Software Strobe Register and wait for completion
+		 */
+		iowrite8(0, &reg->ssr_ad);
+		while (ioread8(&reg->cir_asr) & BIT(7));
+
+		*val = ioread16(&reg->ssr_ad);
+
+		mutex_unlock(&priv->lock);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_OFFSET:
+		/* get ADC bipolar/unipolar configuration */
+		adc_config = ioread8(&reg->acfg);
+		adbu = !(adc_config & BIT(2));
+
+		*val = -32768 * adbu;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		/* get ADC bipolar/unipolar and gain configuration */
+		adc_config = ioread8(&reg->acfg);
+		adbu = !(adc_config & BIT(2));
+		gain = adc_config & 0x3;
+
+		*val = 5;
+		*val2 = 15 - adbu + gain;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	}
+
+	return -EINVAL;
+}
+
+static int stx104_write_raw(struct iio_dev *indio_dev,
+	struct iio_chan_spec const *chan, int val, int val2, long mask)
+{
+	struct stx104_iio *const priv = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		/* Only four gain states (x1, x2, x4, x8) */
+		switch (val) {
+		case 1:
+			iowrite8(0, &priv->reg->acfg);
+			break;
+		case 2:
+			iowrite8(1, &priv->reg->acfg);
+			break;
+		case 4:
+			iowrite8(2, &priv->reg->acfg);
+			break;
+		case 8:
+			iowrite8(3, &priv->reg->acfg);
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		return 0;
+	case IIO_CHAN_INFO_RAW:
+		if (chan->output) {
+			/* DAC can only accept up to a 16-bit value */
+			if ((unsigned int)val > 65535)
+				return -EINVAL;
+
+			mutex_lock(&priv->lock);
+
+			priv->chan_out_states[chan->channel] = val;
+			iowrite16(val, &priv->reg->dac[chan->channel]);
+
+			mutex_unlock(&priv->lock);
+			return 0;
+		}
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
+static const struct iio_info stx104_info = {
+	.read_raw = stx104_read_raw,
+	.write_raw = stx104_write_raw
+};
+
+/* single-ended input channels configuration */
+static const struct iio_chan_spec stx104_channels_sing[] = {
+	STX104_OUT_CHAN(0), STX104_OUT_CHAN(1),
+	STX104_IN_CHAN(0, 0), STX104_IN_CHAN(1, 0), STX104_IN_CHAN(2, 0),
+	STX104_IN_CHAN(3, 0), STX104_IN_CHAN(4, 0), STX104_IN_CHAN(5, 0),
+	STX104_IN_CHAN(6, 0), STX104_IN_CHAN(7, 0), STX104_IN_CHAN(8, 0),
+	STX104_IN_CHAN(9, 0), STX104_IN_CHAN(10, 0), STX104_IN_CHAN(11, 0),
+	STX104_IN_CHAN(12, 0), STX104_IN_CHAN(13, 0), STX104_IN_CHAN(14, 0),
+	STX104_IN_CHAN(15, 0)
+};
+/* differential input channels configuration */
+static const struct iio_chan_spec stx104_channels_diff[] = {
+	STX104_OUT_CHAN(0), STX104_OUT_CHAN(1),
+	STX104_IN_CHAN(0, 1), STX104_IN_CHAN(1, 1), STX104_IN_CHAN(2, 1),
+	STX104_IN_CHAN(3, 1), STX104_IN_CHAN(4, 1), STX104_IN_CHAN(5, 1),
+	STX104_IN_CHAN(6, 1), STX104_IN_CHAN(7, 1)
+};
+
+static int stx104_gpio_get_direction(struct gpio_chip *chip,
+	unsigned int offset)
+{
+	/* GPIO 0-3 are input only, while the rest are output only */
+	if (offset < 4)
+		return 1;
+
+	return 0;
+}
+
+static int stx104_gpio_direction_input(struct gpio_chip *chip,
+	unsigned int offset)
+{
+	if (offset >= 4)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int stx104_gpio_direction_output(struct gpio_chip *chip,
+	unsigned int offset, int value)
+{
+	if (offset < 4)
+		return -EINVAL;
+
+	chip->set(chip, offset, value);
+	return 0;
+}
+
+static int stx104_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct stx104_gpio *const stx104gpio = gpiochip_get_data(chip);
+
+	if (offset >= 4)
+		return -EINVAL;
+
+	return !!(ioread8(stx104gpio->base) & BIT(offset));
+}
+
+static int stx104_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
+	unsigned long *bits)
+{
+	struct stx104_gpio *const stx104gpio = gpiochip_get_data(chip);
+
+	*bits = ioread8(stx104gpio->base);
+
+	return 0;
+}
+
+static void stx104_gpio_set(struct gpio_chip *chip, unsigned int offset,
+	int value)
+{
+	struct stx104_gpio *const stx104gpio = gpiochip_get_data(chip);
+	const unsigned int mask = BIT(offset) >> 4;
+	unsigned long flags;
+
+	if (offset < 4)
+		return;
+
+	spin_lock_irqsave(&stx104gpio->lock, flags);
+
+	if (value)
+		stx104gpio->out_state |= mask;
+	else
+		stx104gpio->out_state &= ~mask;
+
+	iowrite8(stx104gpio->out_state, stx104gpio->base);
+
+	spin_unlock_irqrestore(&stx104gpio->lock, flags);
+}
+
+#define STX104_NGPIO 8
+static const char *stx104_names[STX104_NGPIO] = {
+	"DIN0", "DIN1", "DIN2", "DIN3", "DOUT0", "DOUT1", "DOUT2", "DOUT3"
+};
+
+static void stx104_gpio_set_multiple(struct gpio_chip *chip,
+	unsigned long *mask, unsigned long *bits)
+{
+	struct stx104_gpio *const stx104gpio = gpiochip_get_data(chip);
+	unsigned long flags;
+
+	/* verify masked GPIO are output */
+	if (!(*mask & 0xF0))
+		return;
+
+	*mask >>= 4;
+	*bits >>= 4;
+
+	spin_lock_irqsave(&stx104gpio->lock, flags);
+
+	stx104gpio->out_state &= ~*mask;
+	stx104gpio->out_state |= *mask & *bits;
+	iowrite8(stx104gpio->out_state, stx104gpio->base);
+
+	spin_unlock_irqrestore(&stx104gpio->lock, flags);
+}
+
+static int stx104_probe(struct device *dev, unsigned int id)
+{
+	struct iio_dev *indio_dev;
+	struct stx104_iio *priv;
+	struct stx104_gpio *stx104gpio;
+	int err;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	stx104gpio = devm_kzalloc(dev, sizeof(*stx104gpio), GFP_KERNEL);
+	if (!stx104gpio)
+		return -ENOMEM;
+
+	if (!devm_request_region(dev, base[id], STX104_EXTENT,
+		dev_name(dev))) {
+		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
+			base[id], base[id] + STX104_EXTENT);
+		return -EBUSY;
+	}
+
+	priv = iio_priv(indio_dev);
+	priv->reg = devm_ioport_map(dev, base[id], STX104_EXTENT);
+	if (!priv->reg)
+		return -ENOMEM;
+
+	indio_dev->info = &stx104_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	/* determine if differential inputs */
+	if (ioread8(&priv->reg->cir_asr) & BIT(5)) {
+		indio_dev->num_channels = ARRAY_SIZE(stx104_channels_diff);
+		indio_dev->channels = stx104_channels_diff;
+	} else {
+		indio_dev->num_channels = ARRAY_SIZE(stx104_channels_sing);
+		indio_dev->channels = stx104_channels_sing;
+	}
+
+	indio_dev->name = dev_name(dev);
+
+	mutex_init(&priv->lock);
+
+	/* configure device for software trigger operation */
+	iowrite8(0, &priv->reg->acr);
+
+	/* initialize gain setting to x1 */
+	iowrite8(0, &priv->reg->acfg);
+
+	/* initialize DAC output to 0V */
+	iowrite16(0, &priv->reg->dac[0]);
+	iowrite16(0, &priv->reg->dac[1]);
+
+	stx104gpio->chip.label = dev_name(dev);
+	stx104gpio->chip.parent = dev;
+	stx104gpio->chip.owner = THIS_MODULE;
+	stx104gpio->chip.base = -1;
+	stx104gpio->chip.ngpio = STX104_NGPIO;
+	stx104gpio->chip.names = stx104_names;
+	stx104gpio->chip.get_direction = stx104_gpio_get_direction;
+	stx104gpio->chip.direction_input = stx104_gpio_direction_input;
+	stx104gpio->chip.direction_output = stx104_gpio_direction_output;
+	stx104gpio->chip.get = stx104_gpio_get;
+	stx104gpio->chip.get_multiple = stx104_gpio_get_multiple;
+	stx104gpio->chip.set = stx104_gpio_set;
+	stx104gpio->chip.set_multiple = stx104_gpio_set_multiple;
+	stx104gpio->base = &priv->reg->dio;
+	stx104gpio->out_state = 0x0;
+
+	spin_lock_init(&stx104gpio->lock);
+
+	err = devm_gpiochip_add_data(dev, &stx104gpio->chip, stx104gpio);
+	if (err) {
+		dev_err(dev, "GPIO registering failed (%d)\n", err);
+		return err;
+	}
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static struct isa_driver stx104_driver = {
+	.probe = stx104_probe,
+	.driver = {
+		.name = "stx104"
+	},
+};
+
+module_isa_driver(stx104_driver, num_stx104);
+
+MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
+MODULE_DESCRIPTION("Apex Embedded Systems STX104 IIO driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/infiniband/hw/mlx5/qpc.c b/drivers/infiniband/hw/mlx5/qpc.c
index 8844eacf2380..e508c0753dd3 100644
--- a/drivers/infiniband/hw/mlx5/qpc.c
+++ b/drivers/infiniband/hw/mlx5/qpc.c
@@ -297,8 +297,7 @@ int mlx5_core_destroy_qp(struct mlx5_ib_dev *dev, struct mlx5_core_qp *qp)
 	MLX5_SET(destroy_qp_in, in, opcode, MLX5_CMD_OP_DESTROY_QP);
 	MLX5_SET(destroy_qp_in, in, qpn, qp->qpn);
 	MLX5_SET(destroy_qp_in, in, uid, qp->uid);
-	mlx5_cmd_exec_in(dev->mdev, destroy_qp, in);
-	return 0;
+	return mlx5_cmd_exec_in(dev->mdev, destroy_qp, in);
 }
 
 int mlx5_core_set_delay_drop(struct mlx5_ib_dev *dev,
@@ -548,14 +547,14 @@ int mlx5_core_xrcd_dealloc(struct mlx5_ib_dev *dev, u32 xrcdn)
 	return mlx5_cmd_exec_in(dev->mdev, dealloc_xrcd, in);
 }
 
-static void destroy_rq_tracked(struct mlx5_ib_dev *dev, u32 rqn, u16 uid)
+static int destroy_rq_tracked(struct mlx5_ib_dev *dev, u32 rqn, u16 uid)
 {
 	u32 in[MLX5_ST_SZ_DW(destroy_rq_in)] = {};
 
 	MLX5_SET(destroy_rq_in, in, opcode, MLX5_CMD_OP_DESTROY_RQ);
 	MLX5_SET(destroy_rq_in, in, rqn, rqn);
 	MLX5_SET(destroy_rq_in, in, uid, uid);
-	mlx5_cmd_exec_in(dev->mdev, destroy_rq, in);
+	return mlx5_cmd_exec_in(dev->mdev, destroy_rq, in);
 }
 
 int mlx5_core_create_rq_tracked(struct mlx5_ib_dev *dev, u32 *in, int inlen,
@@ -586,8 +585,7 @@ int mlx5_core_destroy_rq_tracked(struct mlx5_ib_dev *dev,
 				 struct mlx5_core_qp *rq)
 {
 	destroy_resource_common(dev, rq);
-	destroy_rq_tracked(dev, rq->qpn, rq->uid);
-	return 0;
+	return destroy_rq_tracked(dev, rq->qpn, rq->uid);
 }
 
 static void destroy_sq_tracked(struct mlx5_ib_dev *dev, u32 sqn, u16 uid)
diff --git a/drivers/media/platform/mtk-vpu/mtk_vpu.c b/drivers/media/platform/mtk-vpu/mtk_vpu.c
index 7f1647da0ade..af59cc52fdd7 100644
--- a/drivers/media/platform/mtk-vpu/mtk_vpu.c
+++ b/drivers/media/platform/mtk-vpu/mtk_vpu.c
@@ -562,15 +562,17 @@ static int load_requested_vpu(struct mtk_vpu *vpu,
 int vpu_load_firmware(struct platform_device *pdev)
 {
 	struct mtk_vpu *vpu;
-	struct device *dev = &pdev->dev;
+	struct device *dev;
 	struct vpu_run *run;
 	int ret;
 
 	if (!pdev) {
-		dev_err(dev, "VPU platform device is invalid\n");
+		pr_err("VPU platform device is invalid\n");
 		return -EINVAL;
 	}
 
+	dev = &pdev->dev;
+
 	vpu = platform_get_drvdata(pdev);
 	run = &vpu->run;
 
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 0b72096f10e6..965b44a09507 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2081,14 +2081,14 @@ static void mmc_blk_mq_poll_completion(struct mmc_queue *mq,
 	mmc_blk_urgent_bkops(mq, mqrq);
 }
 
-static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq, struct request *req)
+static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq, enum mmc_issue_type issue_type)
 {
 	unsigned long flags;
 	bool put_card;
 
 	spin_lock_irqsave(&mq->lock, flags);
 
-	mq->in_flight[mmc_issue_type(mq, req)] -= 1;
+	mq->in_flight[issue_type] -= 1;
 
 	put_card = (mmc_tot_in_flight(mq) == 0);
 
@@ -2100,6 +2100,7 @@ static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq, struct request *req)
 
 static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req)
 {
+	enum mmc_issue_type issue_type = mmc_issue_type(mq, req);
 	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
 	struct mmc_request *mrq = &mqrq->brq.mrq;
 	struct mmc_host *host = mq->card->host;
@@ -2115,7 +2116,7 @@ static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req)
 	else if (likely(!blk_should_fake_timeout(req->q)))
 		blk_mq_complete_request(req);
 
-	mmc_blk_mq_dec_in_flight(mq, req);
+	mmc_blk_mq_dec_in_flight(mq, issue_type);
 }
 
 void mmc_blk_mq_recovery(struct mmc_queue *mq)
diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 8c2361e66277..985079943be7 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1413,8 +1413,8 @@ static int bcm2835_probe(struct platform_device *pdev)
 	host->max_clk = clk_get_rate(clk);
 
 	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq <= 0) {
-		ret = -EINVAL;
+	if (host->irq < 0) {
+		ret = host->irq;
 		goto err;
 	}
 
diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
index 6c4f43e11282..7ede74bf3723 100644
--- a/drivers/mmc/host/sdhci_f_sdh30.c
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -26,9 +26,16 @@ struct f_sdhost_priv {
 	bool enable_cmd_dat_delay;
 };
 
+static void *sdhci_f_sdhost_priv(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	return sdhci_pltfm_priv(pltfm_host);
+}
+
 static void sdhci_f_sdh30_soft_voltage_switch(struct sdhci_host *host)
 {
-	struct f_sdhost_priv *priv = sdhci_priv(host);
+	struct f_sdhost_priv *priv = sdhci_f_sdhost_priv(host);
 	u32 ctrl = 0;
 
 	usleep_range(2500, 3000);
@@ -61,7 +68,7 @@ static unsigned int sdhci_f_sdh30_get_min_clock(struct sdhci_host *host)
 
 static void sdhci_f_sdh30_reset(struct sdhci_host *host, u8 mask)
 {
-	struct f_sdhost_priv *priv = sdhci_priv(host);
+	struct f_sdhost_priv *priv = sdhci_f_sdhost_priv(host);
 	u32 ctl;
 
 	if (sdhci_readw(host, SDHCI_CLOCK_CONTROL) == 0)
@@ -85,30 +92,32 @@ static const struct sdhci_ops sdhci_f_sdh30_ops = {
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
+static const struct sdhci_pltfm_data sdhci_f_sdh30_pltfm_data = {
+	.ops = &sdhci_f_sdh30_ops,
+	.quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
+		| SDHCI_QUIRK_INVERTED_WRITE_PROTECT,
+	.quirks2 = SDHCI_QUIRK2_SUPPORT_SINGLE
+		|  SDHCI_QUIRK2_TUNING_WORK_AROUND,
+};
+
 static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
 	struct device *dev = &pdev->dev;
-	int irq, ctrl = 0, ret = 0;
+	int ctrl = 0, ret = 0;
 	struct f_sdhost_priv *priv;
+	struct sdhci_pltfm_host *pltfm_host;
 	u32 reg = 0;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
-
-	host = sdhci_alloc_host(dev, sizeof(struct f_sdhost_priv));
+	host = sdhci_pltfm_init(pdev, &sdhci_f_sdh30_pltfm_data,
+				sizeof(struct f_sdhost_priv));
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
-	priv = sdhci_priv(host);
+	pltfm_host = sdhci_priv(host);
+	priv = sdhci_pltfm_priv(pltfm_host);
 	priv->dev = dev;
 
-	host->quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
-		       SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
-	host->quirks2 = SDHCI_QUIRK2_SUPPORT_SINGLE |
-			SDHCI_QUIRK2_TUNING_WORK_AROUND;
-
 	priv->enable_cmd_dat_delay = device_property_read_bool(dev,
 						"fujitsu,cmd-dat-delay-select");
 
@@ -116,18 +125,6 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
-	platform_set_drvdata(pdev, host);
-
-	host->hw_name = "f_sdh30";
-	host->ops = &sdhci_f_sdh30_ops;
-	host->irq = irq;
-
-	host->ioaddr = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(host->ioaddr)) {
-		ret = PTR_ERR(host->ioaddr);
-		goto err;
-	}
-
 	if (dev_of_node(dev)) {
 		sdhci_get_of_property(pdev);
 
@@ -182,23 +179,22 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 err_clk:
 	clk_disable_unprepare(priv->clk_iface);
 err:
-	sdhci_free_host(host);
+	sdhci_pltfm_free(pdev);
+
 	return ret;
 }
 
 static int sdhci_f_sdh30_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
-	struct f_sdhost_priv *priv = sdhci_priv(host);
-
-	sdhci_remove_host(host, readl(host->ioaddr + SDHCI_INT_STATUS) ==
-			  0xffffffff);
+	struct f_sdhost_priv *priv = sdhci_f_sdhost_priv(host);
+	struct clk *clk_iface = priv->clk_iface;
+	struct clk *clk = priv->clk;
 
-	clk_disable_unprepare(priv->clk_iface);
-	clk_disable_unprepare(priv->clk);
+	sdhci_pltfm_unregister(pdev);
 
-	sdhci_free_host(host);
-	platform_set_drvdata(pdev, NULL);
+	clk_disable_unprepare(clk_iface);
+	clk_disable_unprepare(clk);
 
 	return 0;
 }
diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 032f2c03e8fb..3c213816db78 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1341,8 +1341,8 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
 		return ret;
 
 	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq <= 0) {
-		ret = -EINVAL;
+	if (host->irq < 0) {
+		ret = host->irq;
 		goto error_disable_mmc;
 	}
 
diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
index 7c7ec8d10232..b5b1a42ca25e 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -1705,8 +1705,6 @@ static int wbsd_init(struct device *dev, int base, int irq, int dma,
 
 		wbsd_release_resources(host);
 		wbsd_free_mmc(dev);
-
-		mmc_free_host(mmc);
 		return ret;
 	}
 
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index ac1560fa29e4..7e93b72f9b54 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -2588,6 +2588,14 @@ static void mv88e6xxx_hardware_reset(struct mv88e6xxx_chip *chip)
 
 	/* If there is a GPIO connected to the reset pin, toggle it */
 	if (gpiod) {
+		/* If the switch has just been reset and not yet completed
+		 * loading EEPROM, the reset may interrupt the I2C transaction
+		 * mid-byte, causing the first EEPROM read after the reset
+		 * from the wrong location resulting in the switch booting
+		 * to wrong mode and inoperable.
+		 */
+		mv88e6xxx_g1_wait_eeprom_done(chip);
+
 		gpiod_set_value_cansleep(gpiod, 1);
 		usleep_range(10000, 20000);
 		gpiod_set_value_cansleep(gpiod, 0);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index 82af180cc5ee..b7556a6c2758 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -210,11 +210,11 @@ static int i40e_read_nvm_word_srctl(struct i40e_hw *hw, u16 offset,
  * @hw: pointer to the HW structure.
  * @module_pointer: module pointer location in words from the NVM beginning
  * @offset: offset in words from module start
- * @words: number of words to write
- * @data: buffer with words to write to the Shadow RAM
+ * @words: number of words to read
+ * @data: buffer with words to read to the Shadow RAM
  * @last_command: tells the AdminQ that this is the last command
  *
- * Writes a 16 bit words buffer to the Shadow RAM using the admin command.
+ * Reads a 16 bit words buffer to the Shadow RAM using the admin command.
  **/
 static int i40e_read_nvm_aq(struct i40e_hw *hw,
 			    u8 module_pointer, u32 offset,
@@ -234,18 +234,18 @@ static int i40e_read_nvm_aq(struct i40e_hw *hw,
 	 */
 	if ((offset + words) > hw->nvm.sr_size)
 		i40e_debug(hw, I40E_DEBUG_NVM,
-			   "NVM write error: offset %d beyond Shadow RAM limit %d\n",
+			   "NVM read error: offset %d beyond Shadow RAM limit %d\n",
 			   (offset + words), hw->nvm.sr_size);
 	else if (words > I40E_SR_SECTOR_SIZE_IN_WORDS)
-		/* We can write only up to 4KB (one sector), in one AQ write */
+		/* We can read only up to 4KB (one sector), in one AQ write */
 		i40e_debug(hw, I40E_DEBUG_NVM,
-			   "NVM write fail error: tried to write %d words, limit is %d.\n",
+			   "NVM read fail error: tried to read %d words, limit is %d.\n",
 			   words, I40E_SR_SECTOR_SIZE_IN_WORDS);
 	else if (((offset + (words - 1)) / I40E_SR_SECTOR_SIZE_IN_WORDS)
 		 != (offset / I40E_SR_SECTOR_SIZE_IN_WORDS))
-		/* A single write cannot spread over two sectors */
+		/* A single read cannot spread over two sectors */
 		i40e_debug(hw, I40E_DEBUG_NVM,
-			   "NVM write error: cannot spread over two sectors in a single write offset=%d words=%d\n",
+			   "NVM read error: cannot spread over two sectors in a single read offset=%d words=%d\n",
 			   offset, words);
 	else
 		ret_code = i40e_aq_read_nvm(hw, module_pointer,
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index e622b6e6ac2b..a9a7453d969c 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -1275,6 +1275,7 @@ iavf_add_fdir_fltr_info(struct iavf_adapter *adapter, struct ethtool_rx_flow_spe
 		fltr->ip_mask.src_port = fsp->m_u.tcp_ip4_spec.psrc;
 		fltr->ip_mask.dst_port = fsp->m_u.tcp_ip4_spec.pdst;
 		fltr->ip_mask.tos = fsp->m_u.tcp_ip4_spec.tos;
+		fltr->ip_ver = 4;
 		break;
 	case AH_V4_FLOW:
 	case ESP_V4_FLOW:
@@ -1286,6 +1287,7 @@ iavf_add_fdir_fltr_info(struct iavf_adapter *adapter, struct ethtool_rx_flow_spe
 		fltr->ip_mask.v4_addrs.dst_ip = fsp->m_u.ah_ip4_spec.ip4dst;
 		fltr->ip_mask.spi = fsp->m_u.ah_ip4_spec.spi;
 		fltr->ip_mask.tos = fsp->m_u.ah_ip4_spec.tos;
+		fltr->ip_ver = 4;
 		break;
 	case IPV4_USER_FLOW:
 		fltr->ip_data.v4_addrs.src_ip = fsp->h_u.usr_ip4_spec.ip4src;
@@ -1298,6 +1300,7 @@ iavf_add_fdir_fltr_info(struct iavf_adapter *adapter, struct ethtool_rx_flow_spe
 		fltr->ip_mask.l4_header = fsp->m_u.usr_ip4_spec.l4_4_bytes;
 		fltr->ip_mask.tos = fsp->m_u.usr_ip4_spec.tos;
 		fltr->ip_mask.proto = fsp->m_u.usr_ip4_spec.proto;
+		fltr->ip_ver = 4;
 		break;
 	case TCP_V6_FLOW:
 	case UDP_V6_FLOW:
@@ -1316,6 +1319,7 @@ iavf_add_fdir_fltr_info(struct iavf_adapter *adapter, struct ethtool_rx_flow_spe
 		fltr->ip_mask.src_port = fsp->m_u.tcp_ip6_spec.psrc;
 		fltr->ip_mask.dst_port = fsp->m_u.tcp_ip6_spec.pdst;
 		fltr->ip_mask.tclass = fsp->m_u.tcp_ip6_spec.tclass;
+		fltr->ip_ver = 6;
 		break;
 	case AH_V6_FLOW:
 	case ESP_V6_FLOW:
@@ -1331,6 +1335,7 @@ iavf_add_fdir_fltr_info(struct iavf_adapter *adapter, struct ethtool_rx_flow_spe
 		       sizeof(struct in6_addr));
 		fltr->ip_mask.spi = fsp->m_u.ah_ip6_spec.spi;
 		fltr->ip_mask.tclass = fsp->m_u.ah_ip6_spec.tclass;
+		fltr->ip_ver = 6;
 		break;
 	case IPV6_USER_FLOW:
 		memcpy(&fltr->ip_data.v6_addrs.src_ip, fsp->h_u.usr_ip6_spec.ip6src,
@@ -1347,6 +1352,7 @@ iavf_add_fdir_fltr_info(struct iavf_adapter *adapter, struct ethtool_rx_flow_spe
 		fltr->ip_mask.l4_header = fsp->m_u.usr_ip6_spec.l4_4_bytes;
 		fltr->ip_mask.tclass = fsp->m_u.usr_ip6_spec.tclass;
 		fltr->ip_mask.proto = fsp->m_u.usr_ip6_spec.l4_proto;
+		fltr->ip_ver = 6;
 		break;
 	case ETHER_FLOW:
 		fltr->eth_data.etype = fsp->h_u.ether_spec.h_proto;
@@ -1357,6 +1363,10 @@ iavf_add_fdir_fltr_info(struct iavf_adapter *adapter, struct ethtool_rx_flow_spe
 		return -EINVAL;
 	}
 
+	err = iavf_validate_fdir_fltr_masks(adapter, fltr);
+	if (err)
+		return err;
+
 	if (iavf_fdir_is_dup_fltr(adapter, fltr))
 		return -EEXIST;
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_fdir.c b/drivers/net/ethernet/intel/iavf/iavf_fdir.c
index 505e82ebafe4..03e774bd2a5b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_fdir.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_fdir.c
@@ -18,6 +18,79 @@ static const struct in6_addr ipv6_addr_full_mask = {
 	}
 };
 
+static const struct in6_addr ipv6_addr_zero_mask = {
+	.in6_u = {
+		.u6_addr8 = {
+			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+		}
+	}
+};
+
+/**
+ * iavf_validate_fdir_fltr_masks - validate Flow Director filter fields masks
+ * @adapter: pointer to the VF adapter structure
+ * @fltr: Flow Director filter data structure
+ *
+ * Returns 0 if all masks of packet fields are either full or empty. Returns
+ * error on at least one partial mask.
+ */
+int iavf_validate_fdir_fltr_masks(struct iavf_adapter *adapter,
+				  struct iavf_fdir_fltr *fltr)
+{
+	if (fltr->eth_mask.etype && fltr->eth_mask.etype != htons(U16_MAX))
+		goto partial_mask;
+
+	if (fltr->ip_ver == 4) {
+		if (fltr->ip_mask.v4_addrs.src_ip &&
+		    fltr->ip_mask.v4_addrs.src_ip != htonl(U32_MAX))
+			goto partial_mask;
+
+		if (fltr->ip_mask.v4_addrs.dst_ip &&
+		    fltr->ip_mask.v4_addrs.dst_ip != htonl(U32_MAX))
+			goto partial_mask;
+
+		if (fltr->ip_mask.tos && fltr->ip_mask.tos != U8_MAX)
+			goto partial_mask;
+	} else if (fltr->ip_ver == 6) {
+		if (memcmp(&fltr->ip_mask.v6_addrs.src_ip, &ipv6_addr_zero_mask,
+			   sizeof(struct in6_addr)) &&
+		    memcmp(&fltr->ip_mask.v6_addrs.src_ip, &ipv6_addr_full_mask,
+			   sizeof(struct in6_addr)))
+			goto partial_mask;
+
+		if (memcmp(&fltr->ip_mask.v6_addrs.dst_ip, &ipv6_addr_zero_mask,
+			   sizeof(struct in6_addr)) &&
+		    memcmp(&fltr->ip_mask.v6_addrs.dst_ip, &ipv6_addr_full_mask,
+			   sizeof(struct in6_addr)))
+			goto partial_mask;
+
+		if (fltr->ip_mask.tclass && fltr->ip_mask.tclass != U8_MAX)
+			goto partial_mask;
+	}
+
+	if (fltr->ip_mask.proto && fltr->ip_mask.proto != U8_MAX)
+		goto partial_mask;
+
+	if (fltr->ip_mask.src_port && fltr->ip_mask.src_port != htons(U16_MAX))
+		goto partial_mask;
+
+	if (fltr->ip_mask.dst_port && fltr->ip_mask.dst_port != htons(U16_MAX))
+		goto partial_mask;
+
+	if (fltr->ip_mask.spi && fltr->ip_mask.spi != htonl(U32_MAX))
+		goto partial_mask;
+
+	if (fltr->ip_mask.l4_header &&
+	    fltr->ip_mask.l4_header != htonl(U32_MAX))
+		goto partial_mask;
+
+	return 0;
+
+partial_mask:
+	dev_err(&adapter->pdev->dev, "Failed to add Flow Director filter, partial masks are not supported\n");
+	return -EOPNOTSUPP;
+}
+
 /**
  * iavf_pkt_udp_no_pay_len - the length of UDP packet without payload
  * @fltr: Flow Director filter data structure
@@ -263,8 +336,6 @@ iavf_fill_fdir_ip4_hdr(struct iavf_fdir_fltr *fltr,
 		VIRTCHNL_ADD_PROTO_HDR_FIELD_BIT(hdr, IPV4, DST);
 	}
 
-	fltr->ip_ver = 4;
-
 	return 0;
 }
 
@@ -309,8 +380,6 @@ iavf_fill_fdir_ip6_hdr(struct iavf_fdir_fltr *fltr,
 		VIRTCHNL_ADD_PROTO_HDR_FIELD_BIT(hdr, IPV6, DST);
 	}
 
-	fltr->ip_ver = 6;
-
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_fdir.h b/drivers/net/ethernet/intel/iavf/iavf_fdir.h
index 33c55c366315..9eb9f73f6adf 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_fdir.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_fdir.h
@@ -110,6 +110,8 @@ struct iavf_fdir_fltr {
 	struct virtchnl_fdir_add vc_add_msg;
 };
 
+int iavf_validate_fdir_fltr_masks(struct iavf_adapter *adapter,
+				  struct iavf_fdir_fltr *fltr);
 int iavf_fill_fdir_add_msg(struct iavf_adapter *adapter, struct iavf_fdir_fltr *fltr);
 void iavf_print_fdir_fltr(struct iavf_adapter *adapter, struct iavf_fdir_fltr *fltr);
 bool iavf_fdir_is_dup_fltr(struct iavf_adapter *adapter, struct iavf_fdir_fltr *fltr);
diff --git a/drivers/net/ethernet/intel/igc/igc_base.h b/drivers/net/ethernet/intel/igc/igc_base.h
index ce530f5fd7bd..52849f5e8048 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.h
+++ b/drivers/net/ethernet/intel/igc/igc_base.h
@@ -85,8 +85,13 @@ union igc_adv_rx_desc {
 #define IGC_RXDCTL_SWFLUSH		0x04000000 /* Receive Software Flush */
 
 /* SRRCTL bit definitions */
-#define IGC_SRRCTL_BSIZEPKT_SHIFT		10 /* Shift _right_ */
-#define IGC_SRRCTL_BSIZEHDRSIZE_SHIFT		2  /* Shift _left_ */
-#define IGC_SRRCTL_DESCTYPE_ADV_ONEBUF	0x02000000
+#define IGC_SRRCTL_BSIZEPKT_MASK	GENMASK(6, 0)
+#define IGC_SRRCTL_BSIZEPKT(x)		FIELD_PREP(IGC_SRRCTL_BSIZEPKT_MASK, \
+					(x) / 1024) /* in 1 KB resolution */
+#define IGC_SRRCTL_BSIZEHDR_MASK	GENMASK(13, 8)
+#define IGC_SRRCTL_BSIZEHDR(x)		FIELD_PREP(IGC_SRRCTL_BSIZEHDR_MASK, \
+					(x) / 64) /* in 64 bytes resolution */
+#define IGC_SRRCTL_DESCTYPE_MASK	GENMASK(27, 25)
+#define IGC_SRRCTL_DESCTYPE_ADV_ONEBUF	FIELD_PREP(IGC_SRRCTL_DESCTYPE_MASK, 1)
 
 #endif /* _IGC_BASE_H */
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index a47dce10d3a7..a8c24a1c12b4 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -674,8 +674,11 @@ static void igc_configure_rx_ring(struct igc_adapter *adapter,
 	else
 		buf_size = IGC_RXBUFFER_2048;
 
-	srrctl = IGC_RX_HDR_LEN << IGC_SRRCTL_BSIZEHDRSIZE_SHIFT;
-	srrctl |= buf_size >> IGC_SRRCTL_BSIZEPKT_SHIFT;
+	srrctl = rd32(IGC_SRRCTL(reg_idx));
+	srrctl &= ~(IGC_SRRCTL_BSIZEPKT_MASK | IGC_SRRCTL_BSIZEHDR_MASK |
+		    IGC_SRRCTL_DESCTYPE_MASK);
+	srrctl |= IGC_SRRCTL_BSIZEHDR(IGC_RX_HDR_LEN);
+	srrctl |= IGC_SRRCTL_BSIZEPKT(buf_size);
 	srrctl |= IGC_SRRCTL_DESCTYPE_ADV_ONEBUF;
 
 	wr32(IGC_SRRCTL(reg_idx), srrctl);
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 10b3f4fb2612..98ce24422424 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -160,6 +160,19 @@ static struct macsec_rx_sa *macsec_rxsa_get(struct macsec_rx_sa __rcu *ptr)
 	return sa;
 }
 
+static struct macsec_rx_sa *macsec_active_rxsa_get(struct macsec_rx_sc *rx_sc)
+{
+	struct macsec_rx_sa *sa = NULL;
+	int an;
+
+	for (an = 0; an < MACSEC_NUM_AN; an++)	{
+		sa = macsec_rxsa_get(rx_sc->sa[an]);
+		if (sa)
+			break;
+	}
+	return sa;
+}
+
 static void free_rx_sc_rcu(struct rcu_head *head)
 {
 	struct macsec_rx_sc *rx_sc = container_of(head, struct macsec_rx_sc, rcu_head);
@@ -493,18 +506,28 @@ static void macsec_encrypt_finish(struct sk_buff *skb, struct net_device *dev)
 	skb->protocol = eth_hdr(skb)->h_proto;
 }
 
+static unsigned int macsec_msdu_len(struct sk_buff *skb)
+{
+	struct macsec_dev *macsec = macsec_priv(skb->dev);
+	struct macsec_secy *secy = &macsec->secy;
+	bool sci_present = macsec_skb_cb(skb)->has_sci;
+
+	return skb->len - macsec_hdr_len(sci_present) - secy->icv_len;
+}
+
 static void macsec_count_tx(struct sk_buff *skb, struct macsec_tx_sc *tx_sc,
 			    struct macsec_tx_sa *tx_sa)
 {
+	unsigned int msdu_len = macsec_msdu_len(skb);
 	struct pcpu_tx_sc_stats *txsc_stats = this_cpu_ptr(tx_sc->stats);
 
 	u64_stats_update_begin(&txsc_stats->syncp);
 	if (tx_sc->encrypt) {
-		txsc_stats->stats.OutOctetsEncrypted += skb->len;
+		txsc_stats->stats.OutOctetsEncrypted += msdu_len;
 		txsc_stats->stats.OutPktsEncrypted++;
 		this_cpu_inc(tx_sa->stats->OutPktsEncrypted);
 	} else {
-		txsc_stats->stats.OutOctetsProtected += skb->len;
+		txsc_stats->stats.OutOctetsProtected += msdu_len;
 		txsc_stats->stats.OutPktsProtected++;
 		this_cpu_inc(tx_sa->stats->OutPktsProtected);
 	}
@@ -534,9 +557,10 @@ static void macsec_encrypt_done(struct crypto_async_request *base, int err)
 	aead_request_free(macsec_skb_cb(skb)->req);
 
 	rcu_read_lock_bh();
-	macsec_encrypt_finish(skb, dev);
 	macsec_count_tx(skb, &macsec->secy.tx_sc, macsec_skb_cb(skb)->tx_sa);
-	len = skb->len;
+	/* packet is encrypted/protected so tx_bytes must be calculated */
+	len = macsec_msdu_len(skb) + 2 * ETH_ALEN;
+	macsec_encrypt_finish(skb, dev);
 	ret = dev_queue_xmit(skb);
 	count_tx(dev, ret, len);
 	rcu_read_unlock_bh();
@@ -695,6 +719,7 @@ static struct sk_buff *macsec_encrypt(struct sk_buff *skb,
 
 	macsec_skb_cb(skb)->req = req;
 	macsec_skb_cb(skb)->tx_sa = tx_sa;
+	macsec_skb_cb(skb)->has_sci = sci_present;
 	aead_request_set_callback(req, 0, macsec_encrypt_done, skb);
 
 	dev_hold(skb->dev);
@@ -736,15 +761,17 @@ static bool macsec_post_decrypt(struct sk_buff *skb, struct macsec_secy *secy, u
 		u64_stats_update_begin(&rxsc_stats->syncp);
 		rxsc_stats->stats.InPktsLate++;
 		u64_stats_update_end(&rxsc_stats->syncp);
+		DEV_STATS_INC(secy->netdev, rx_dropped);
 		return false;
 	}
 
 	if (secy->validate_frames != MACSEC_VALIDATE_DISABLED) {
+		unsigned int msdu_len = macsec_msdu_len(skb);
 		u64_stats_update_begin(&rxsc_stats->syncp);
 		if (hdr->tci_an & MACSEC_TCI_E)
-			rxsc_stats->stats.InOctetsDecrypted += skb->len;
+			rxsc_stats->stats.InOctetsDecrypted += msdu_len;
 		else
-			rxsc_stats->stats.InOctetsValidated += skb->len;
+			rxsc_stats->stats.InOctetsValidated += msdu_len;
 		u64_stats_update_end(&rxsc_stats->syncp);
 	}
 
@@ -757,6 +784,8 @@ static bool macsec_post_decrypt(struct sk_buff *skb, struct macsec_secy *secy, u
 			u64_stats_update_begin(&rxsc_stats->syncp);
 			rxsc_stats->stats.InPktsNotValid++;
 			u64_stats_update_end(&rxsc_stats->syncp);
+			this_cpu_inc(rx_sa->stats->InPktsNotValid);
+			DEV_STATS_INC(secy->netdev, rx_errors);
 			return false;
 		}
 
@@ -849,9 +878,9 @@ static void macsec_decrypt_done(struct crypto_async_request *base, int err)
 
 	macsec_finalize_skb(skb, macsec->secy.icv_len,
 			    macsec_extra_len(macsec_skb_cb(skb)->has_sci));
+	len = skb->len;
 	macsec_reset_skb(skb, macsec->secy.netdev);
 
-	len = skb->len;
 	if (gro_cells_receive(&macsec->gro_cells, skb) == NET_RX_SUCCESS)
 		count_rx(dev, len);
 
@@ -1042,6 +1071,7 @@ static enum rx_handler_result handle_not_macsec(struct sk_buff *skb)
 			u64_stats_update_begin(&secy_stats->syncp);
 			secy_stats->stats.InPktsNoTag++;
 			u64_stats_update_end(&secy_stats->syncp);
+			DEV_STATS_INC(macsec->secy.netdev, rx_dropped);
 			continue;
 		}
 
@@ -1151,6 +1181,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 		u64_stats_update_begin(&secy_stats->syncp);
 		secy_stats->stats.InPktsBadTag++;
 		u64_stats_update_end(&secy_stats->syncp);
+		DEV_STATS_INC(secy->netdev, rx_errors);
 		goto drop_nosa;
 	}
 
@@ -1161,11 +1192,15 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 		/* If validateFrames is Strict or the C bit in the
 		 * SecTAG is set, discard
 		 */
+		struct macsec_rx_sa *active_rx_sa = macsec_active_rxsa_get(rx_sc);
 		if (hdr->tci_an & MACSEC_TCI_C ||
 		    secy->validate_frames == MACSEC_VALIDATE_STRICT) {
 			u64_stats_update_begin(&rxsc_stats->syncp);
 			rxsc_stats->stats.InPktsNotUsingSA++;
 			u64_stats_update_end(&rxsc_stats->syncp);
+			DEV_STATS_INC(secy->netdev, rx_errors);
+			if (active_rx_sa)
+				this_cpu_inc(active_rx_sa->stats->InPktsNotUsingSA);
 			goto drop_nosa;
 		}
 
@@ -1175,6 +1210,8 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 		u64_stats_update_begin(&rxsc_stats->syncp);
 		rxsc_stats->stats.InPktsUnusedSA++;
 		u64_stats_update_end(&rxsc_stats->syncp);
+		if (active_rx_sa)
+			this_cpu_inc(active_rx_sa->stats->InPktsUnusedSA);
 		goto deliver;
 	}
 
@@ -1195,6 +1232,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 			u64_stats_update_begin(&rxsc_stats->syncp);
 			rxsc_stats->stats.InPktsLate++;
 			u64_stats_update_end(&rxsc_stats->syncp);
+			DEV_STATS_INC(macsec->secy.netdev, rx_dropped);
 			goto drop;
 		}
 	}
@@ -1223,6 +1261,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 deliver:
 	macsec_finalize_skb(skb, secy->icv_len,
 			    macsec_extra_len(macsec_skb_cb(skb)->has_sci));
+	len = skb->len;
 	macsec_reset_skb(skb, secy->netdev);
 
 	if (rx_sa)
@@ -1230,12 +1269,11 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 	macsec_rxsc_put(rx_sc);
 
 	skb_orphan(skb);
-	len = skb->len;
 	ret = gro_cells_receive(&macsec->gro_cells, skb);
 	if (ret == NET_RX_SUCCESS)
 		count_rx(dev, len);
 	else
-		macsec->secy.netdev->stats.rx_dropped++;
+		DEV_STATS_INC(macsec->secy.netdev, rx_dropped);
 
 	rcu_read_unlock();
 
@@ -1272,6 +1310,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 			u64_stats_update_begin(&secy_stats->syncp);
 			secy_stats->stats.InPktsNoSCI++;
 			u64_stats_update_end(&secy_stats->syncp);
+			DEV_STATS_INC(macsec->secy.netdev, rx_errors);
 			continue;
 		}
 
@@ -1290,7 +1329,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 			secy_stats->stats.InPktsUnknownSCI++;
 			u64_stats_update_end(&secy_stats->syncp);
 		} else {
-			macsec->secy.netdev->stats.rx_dropped++;
+			DEV_STATS_INC(macsec->secy.netdev, rx_dropped);
 		}
 	}
 
@@ -3399,21 +3438,21 @@ static netdev_tx_t macsec_start_xmit(struct sk_buff *skb,
 
 	if (!secy->operational) {
 		kfree_skb(skb);
-		dev->stats.tx_dropped++;
+		DEV_STATS_INC(dev, tx_dropped);
 		return NETDEV_TX_OK;
 	}
 
+	len = skb->len;
 	skb = macsec_encrypt(skb, dev);
 	if (IS_ERR(skb)) {
 		if (PTR_ERR(skb) != -EINPROGRESS)
-			dev->stats.tx_dropped++;
+			DEV_STATS_INC(dev, tx_dropped);
 		return NETDEV_TX_OK;
 	}
 
 	macsec_count_tx(skb, &macsec->secy.tx_sc, macsec_skb_cb(skb)->tx_sa);
 
 	macsec_encrypt_finish(skb, dev);
-	len = skb->len;
 	ret = dev_queue_xmit(skb);
 	count_tx(dev, ret, len);
 	return ret;
@@ -3641,8 +3680,9 @@ static void macsec_get_stats64(struct net_device *dev,
 
 	dev_fetch_sw_netstats(s, dev->tstats);
 
-	s->rx_dropped = dev->stats.rx_dropped;
-	s->tx_dropped = dev->stats.tx_dropped;
+	s->rx_dropped = atomic_long_read(&dev->stats.__rx_dropped);
+	s->tx_dropped = atomic_long_read(&dev->stats.__tx_dropped);
+	s->rx_errors = atomic_long_read(&dev->stats.__rx_errors);
 }
 
 static int macsec_get_iflink(const struct net_device *dev)
diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index b330efb98209..f3b39af83a27 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -412,6 +412,17 @@ static int bcm54xx_resume(struct phy_device *phydev)
 	return bcm54xx_config_init(phydev);
 }
 
+static int bcm54810_read_mmd(struct phy_device *phydev, int devnum, u16 regnum)
+{
+	return -EOPNOTSUPP;
+}
+
+static int bcm54810_write_mmd(struct phy_device *phydev, int devnum, u16 regnum,
+			      u16 val)
+{
+	return -EOPNOTSUPP;
+}
+
 static int bcm54811_config_init(struct phy_device *phydev)
 {
 	int err, reg;
@@ -832,6 +843,8 @@ static struct phy_driver broadcom_drivers[] = {
 	.get_strings	= bcm_phy_get_strings,
 	.get_stats	= bcm54xx_get_stats,
 	.probe		= bcm54xx_phy_probe,
+	.read_mmd	= bcm54810_read_mmd,
+	.write_mmd	= bcm54810_write_mmd,
 	.config_init    = bcm54xx_config_init,
 	.config_aneg    = bcm5481_config_aneg,
 	.config_intr    = bcm_phy_config_intr,
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 6085a28cae3d..0429825a7179 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3061,6 +3061,8 @@ static int phy_probe(struct device *dev)
 			goto out;
 	}
 
+	phy_disable_interrupts(phydev);
+
 	/* Start out supporting everything. Eventually,
 	 * a controller will attach, and may modify one
 	 * or both of these values
@@ -3148,16 +3150,6 @@ static int phy_remove(struct device *dev)
 	return 0;
 }
 
-static void phy_shutdown(struct device *dev)
-{
-	struct phy_device *phydev = to_phy_device(dev);
-
-	if (phydev->state == PHY_READY || !phydev->attached_dev)
-		return;
-
-	phy_disable_interrupts(phydev);
-}
-
 /**
  * phy_driver_register - register a phy_driver with the PHY layer
  * @new_driver: new phy_driver to register
@@ -3181,7 +3173,6 @@ int phy_driver_register(struct phy_driver *new_driver, struct module *owner)
 	new_driver->mdiodrv.driver.bus = &mdio_bus_type;
 	new_driver->mdiodrv.driver.probe = phy_probe;
 	new_driver->mdiodrv.driver.remove = phy_remove;
-	new_driver->mdiodrv.driver.shutdown = phy_shutdown;
 	new_driver->mdiodrv.driver.owner = owner;
 	new_driver->mdiodrv.driver.probe_type = PROBE_FORCE_SYNCHRONOUS;
 
diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 4dfa9c610974..f99df92d211e 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2195,7 +2195,9 @@ static void team_setup(struct net_device *dev)
 
 	dev->hw_features = TEAM_VLAN_FEATURES |
 			   NETIF_F_HW_VLAN_CTAG_RX |
-			   NETIF_F_HW_VLAN_CTAG_FILTER;
+			   NETIF_F_HW_VLAN_CTAG_FILTER |
+			   NETIF_F_HW_VLAN_STAG_RX |
+			   NETIF_F_HW_VLAN_STAG_FILTER;
 
 	dev->hw_features |= NETIF_F_GSO_ENCAP_ALL;
 	dev->features |= dev->hw_features;
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index af335f8266c2..3eefe8171925 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3319,8 +3319,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 		}
 	}
 
-	_virtnet_set_queues(vi, vi->curr_queue_pairs);
-
 	/* serialize netdev register + virtio_device_ready() with ndo_open() */
 	rtnl_lock();
 
@@ -3333,6 +3331,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
+	_virtnet_set_queues(vi, vi->curr_queue_pairs);
+
 	rtnl_unlock();
 
 	err = virtnet_cpu_notif_add(vi);
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index bdd84765e646..765abe073228 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -239,6 +239,7 @@
 #define EP_STATE_ENABLED	1
 
 static const unsigned int pcie_gen_freq[] = {
+	GEN1_CORE_CLK_FREQ,	/* PCI_EXP_LNKSTA_CLS == 0; undefined */
 	GEN1_CORE_CLK_FREQ,
 	GEN2_CORE_CLK_FREQ,
 	GEN3_CORE_CLK_FREQ,
@@ -452,7 +453,11 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
 
 	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
 		PCI_EXP_LNKSTA_CLS;
-	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
+
+	if (speed >= ARRAY_SIZE(pcie_gen_freq))
+		speed = 0;
+
+	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed]);
 
 	/* If EP doesn't advertise L1SS, just return */
 	val = dw_pcie_readl_dbi(pci, pcie->cfg_link_cap_l1sub);
@@ -989,7 +994,11 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
 
 	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
 		PCI_EXP_LNKSTA_CLS;
-	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
+
+	if (speed >= ARRAY_SIZE(pcie_gen_freq))
+		speed = 0;
+
+	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed]);
 
 	tegra_pcie_enable_interrupts(pp);
 
diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstatic.c
index 1cac52870711..e6c90c0bb764 100644
--- a/drivers/pcmcia/rsrc_nonstatic.c
+++ b/drivers/pcmcia/rsrc_nonstatic.c
@@ -1053,6 +1053,8 @@ static void nonstatic_release_resource_db(struct pcmcia_socket *s)
 		q = p->next;
 		kfree(p);
 	}
+
+	kfree(data);
 }
 
 
diff --git a/drivers/soc/aspeed/aspeed-socinfo.c b/drivers/soc/aspeed/aspeed-socinfo.c
index 1ca140356a08..3f759121dc00 100644
--- a/drivers/soc/aspeed/aspeed-socinfo.c
+++ b/drivers/soc/aspeed/aspeed-socinfo.c
@@ -137,6 +137,7 @@ static int __init aspeed_socinfo_init(void)
 
 	soc_dev = soc_device_register(attrs);
 	if (IS_ERR(soc_dev)) {
+		kfree(attrs->machine);
 		kfree(attrs->soc_id);
 		kfree(attrs->serial_number);
 		kfree(attrs);
diff --git a/drivers/thunderbolt/retimer.c b/drivers/thunderbolt/retimer.c
index 566c03105fb8..1b7ab0bbd132 100644
--- a/drivers/thunderbolt/retimer.c
+++ b/drivers/thunderbolt/retimer.c
@@ -208,6 +208,21 @@ static ssize_t nvm_authenticate_show(struct device *dev,
 	return ret;
 }
 
+static void tb_retimer_nvm_authenticate_status(struct tb_port *port, u32 *status)
+{
+	int i;
+
+	tb_port_dbg(port, "reading NVM authentication status of retimers\n");
+
+	/*
+	 * Before doing anything else, read the authentication status.
+	 * If the retimer has it set, store it for the new retimer
+	 * device instance.
+	 */
+	for (i = 1; i <= TB_MAX_RETIMER_INDEX; i++)
+		usb4_port_retimer_nvm_authenticate_status(port, i, &status[i]);
+}
+
 static void tb_retimer_set_inbound_sbtx(struct tb_port *port)
 {
 	int i;
@@ -481,18 +496,16 @@ int tb_retimer_scan(struct tb_port *port, bool add)
 		return ret;
 
 	/*
-	 * Enable sideband channel for each retimer. We can do this
-	 * regardless whether there is device connected or not.
+	 * Immediately after sending enumerate retimers read the
+	 * authentication status of each retimer.
 	 */
-	tb_retimer_set_inbound_sbtx(port);
+	tb_retimer_nvm_authenticate_status(port, status);
 
 	/*
-	 * Before doing anything else, read the authentication status.
-	 * If the retimer has it set, store it for the new retimer
-	 * device instance.
+	 * Enable sideband channel for each retimer. We can do this
+	 * regardless whether there is device connected or not.
 	 */
-	for (i = 1; i <= TB_MAX_RETIMER_INDEX; i++)
-		usb4_port_retimer_nvm_authenticate_status(port, i, &status[i]);
+	tb_retimer_set_inbound_sbtx(port);
 
 	for (i = 1; i <= TB_MAX_RETIMER_INDEX; i++) {
 		/*
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 54173c23263c..67889c014414 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2387,12 +2387,13 @@ static void gsm_error(struct gsm_mux *gsm,
 static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
 {
 	int i;
-	struct gsm_dlci *dlci = gsm->dlci[0];
+	struct gsm_dlci *dlci;
 	struct gsm_msg *txq, *ntxq;
 
 	gsm->dead = true;
 	mutex_lock(&gsm->mutex);
 
+	dlci = gsm->dlci[0];
 	if (dlci) {
 		if (disc && dlci->state != DLCI_CLOSED) {
 			gsm_dlci_begin_close(dlci);
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index ad5b742a68cd..74e477016f25 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3274,6 +3274,7 @@ void serial8250_init_port(struct uart_8250_port *up)
 	struct uart_port *port = &up->port;
 
 	spin_lock_init(&port->lock);
+	port->pm = NULL;
 	port->ops = &serial8250_pops;
 	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
 
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index b0b27808c7c3..e0d576b88d7d 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -246,6 +246,7 @@ enum lpuart_type {
 	LS1028A_LPUART,
 	IMX7ULP_LPUART,
 	IMX8QXP_LPUART,
+	IMXRT1050_LPUART,
 };
 
 struct lpuart_port {
@@ -256,6 +257,7 @@ struct lpuart_port {
 	unsigned int		txfifo_size;
 	unsigned int		rxfifo_size;
 
+	u8			rx_watermark;
 	bool			lpuart_dma_tx_use;
 	bool			lpuart_dma_rx_use;
 	struct dma_chan		*dma_tx_chan;
@@ -280,33 +282,45 @@ struct lpuart_soc_data {
 	enum lpuart_type devtype;
 	char iotype;
 	u8 reg_off;
+	u8 rx_watermark;
 };
 
 static const struct lpuart_soc_data vf_data = {
 	.devtype = VF610_LPUART,
 	.iotype = UPIO_MEM,
+	.rx_watermark = 1,
 };
 
 static const struct lpuart_soc_data ls1021a_data = {
 	.devtype = LS1021A_LPUART,
 	.iotype = UPIO_MEM32BE,
+	.rx_watermark = 1,
 };
 
 static const struct lpuart_soc_data ls1028a_data = {
 	.devtype = LS1028A_LPUART,
 	.iotype = UPIO_MEM32,
+	.rx_watermark = 0,
 };
 
 static struct lpuart_soc_data imx7ulp_data = {
 	.devtype = IMX7ULP_LPUART,
 	.iotype = UPIO_MEM32,
 	.reg_off = IMX_REG_OFF,
+	.rx_watermark = 1,
 };
 
 static struct lpuart_soc_data imx8qxp_data = {
 	.devtype = IMX8QXP_LPUART,
 	.iotype = UPIO_MEM32,
 	.reg_off = IMX_REG_OFF,
+	.rx_watermark = 1,
+};
+static struct lpuart_soc_data imxrt1050_data = {
+	.devtype = IMXRT1050_LPUART,
+	.iotype = UPIO_MEM32,
+	.reg_off = IMX_REG_OFF,
+	.rx_watermark = 1,
 };
 
 static const struct of_device_id lpuart_dt_ids[] = {
@@ -315,6 +329,7 @@ static const struct of_device_id lpuart_dt_ids[] = {
 	{ .compatible = "fsl,ls1028a-lpuart",	.data = &ls1028a_data, },
 	{ .compatible = "fsl,imx7ulp-lpuart",	.data = &imx7ulp_data, },
 	{ .compatible = "fsl,imx8qxp-lpuart",	.data = &imx8qxp_data, },
+	{ .compatible = "fsl,imxrt1050-lpuart",	.data = &imxrt1050_data},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, lpuart_dt_ids);
@@ -1092,8 +1107,8 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 		unsigned long sr = lpuart32_read(&sport->port, UARTSTAT);
 
 		if (sr & (UARTSTAT_PE | UARTSTAT_FE)) {
-			/* Read DR to clear the error flags */
-			lpuart32_read(&sport->port, UARTDATA);
+			/* Clear the error flags */
+			lpuart32_write(&sport->port, sr, UARTSTAT);
 
 			if (sr & UARTSTAT_PE)
 				sport->port.icount.parity++;
@@ -1549,7 +1564,7 @@ static void lpuart_setup_watermark(struct lpuart_port *sport)
 	}
 
 	writeb(0, sport->port.membase + UARTTWFIFO);
-	writeb(1, sport->port.membase + UARTRWFIFO);
+	writeb(sport->rx_watermark, sport->port.membase + UARTRWFIFO);
 
 	/* Restore cr2 */
 	writeb(cr2_saved, sport->port.membase + UARTCR2);
@@ -1584,7 +1599,8 @@ static void lpuart32_setup_watermark(struct lpuart_port *sport)
 	lpuart32_write(&sport->port, val, UARTFIFO);
 
 	/* set the watermark */
-	val = (0x1 << UARTWATER_RXWATER_OFF) | (0x0 << UARTWATER_TXWATER_OFF);
+	val = (sport->rx_watermark << UARTWATER_RXWATER_OFF) |
+	      (0x0 << UARTWATER_TXWATER_OFF);
 	lpuart32_write(&sport->port, val, UARTWATER);
 
 	/* Restore cr2 */
@@ -2634,6 +2650,7 @@ OF_EARLYCON_DECLARE(lpuart32, "fsl,ls1028a-lpuart", ls1028a_early_console_setup)
 OF_EARLYCON_DECLARE(lpuart32, "fsl,imx7ulp-lpuart", lpuart32_imx_early_console_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,imx8ulp-lpuart", lpuart32_imx_early_console_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,imx8qxp-lpuart", lpuart32_imx_early_console_setup);
+OF_EARLYCON_DECLARE(lpuart32, "fsl,imxrt1050-lpuart", lpuart32_imx_early_console_setup);
 EARLYCON_DECLARE(lpuart, lpuart_early_console_setup);
 EARLYCON_DECLARE(lpuart32, lpuart32_early_console_setup);
 
@@ -2728,6 +2745,7 @@ static int lpuart_probe(struct platform_device *pdev)
 	sport->port.dev = &pdev->dev;
 	sport->port.type = PORT_LPUART;
 	sport->devtype = sdata->devtype;
+	sport->rx_watermark = sdata->rx_watermark;
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 097142ffb184..669e7606651a 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -70,6 +70,10 @@ static const struct ci_hdrc_imx_platform_flag imx7ulp_usb_data = {
 		CI_HDRC_PMQOS,
 };
 
+static const struct ci_hdrc_imx_platform_flag imx8ulp_usb_data = {
+	.flags = CI_HDRC_SUPPORTS_RUNTIME_PM,
+};
+
 static const struct of_device_id ci_hdrc_imx_dt_ids[] = {
 	{ .compatible = "fsl,imx23-usb", .data = &imx23_usb_data},
 	{ .compatible = "fsl,imx28-usb", .data = &imx28_usb_data},
@@ -80,6 +84,7 @@ static const struct of_device_id ci_hdrc_imx_dt_ids[] = {
 	{ .compatible = "fsl,imx6ul-usb", .data = &imx6ul_usb_data},
 	{ .compatible = "fsl,imx7d-usb", .data = &imx7d_usb_data},
 	{ .compatible = "fsl,imx7ulp-usb", .data = &imx7ulp_usb_data},
+	{ .compatible = "fsl,imx8ulp-usb", .data = &imx8ulp_usb_data},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, ci_hdrc_imx_dt_ids);
diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
index bac0f5458cab..2318c7906acd 100644
--- a/drivers/usb/chipidea/usbmisc_imx.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -135,7 +135,7 @@
 #define TXVREFTUNE0_MASK		(0xf << 20)
 
 #define MX6_USB_OTG_WAKEUP_BITS (MX6_BM_WAKEUP_ENABLE | MX6_BM_VBUS_WAKEUP | \
-				 MX6_BM_ID_WAKEUP)
+				 MX6_BM_ID_WAKEUP | MX6SX_BM_DPDM_WAKEUP_EN)
 
 struct usbmisc_ops {
 	/* It's called once when probe a usb device */
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index f2e841bc05c7..6377b9cf81a5 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1719,6 +1719,11 @@ static int dwc3_remove(struct platform_device *pdev)
 	pm_runtime_allow(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
+	/*
+	 * HACK: Clear the driver data, which is currently accessed by parent
+	 * glue drivers, before allowing the parent to suspend.
+	 */
+	platform_set_drvdata(pdev, NULL);
 	pm_runtime_set_suspended(&pdev->dev);
 
 	dwc3_free_event_buffers(dwc);
@@ -1766,9 +1771,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 	case DWC3_GCTL_PRTCAP_DEVICE:
 		if (pm_runtime_suspended(dwc->dev))
 			break;
-		spin_lock_irqsave(&dwc->lock, flags);
 		dwc3_gadget_suspend(dwc);
-		spin_unlock_irqrestore(&dwc->lock, flags);
 		synchronize_irq(dwc->irq_gadget);
 		dwc3_core_exit(dwc);
 		break;
@@ -1829,9 +1832,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 			return ret;
 
 		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
-		spin_lock_irqsave(&dwc->lock, flags);
 		dwc3_gadget_resume(dwc);
-		spin_unlock_irqrestore(&dwc->lock, flags);
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
 		if (!PMSG_IS_AUTO(msg)) {
diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 73c0c381e5d0..0180350a2c95 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -306,7 +306,16 @@ static void dwc3_qcom_interconnect_exit(struct dwc3_qcom *qcom)
 /* Only usable in contexts where the role can not change. */
 static bool dwc3_qcom_is_host(struct dwc3_qcom *qcom)
 {
-	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
+	struct dwc3 *dwc;
+
+	/*
+	 * FIXME: Fix this layering violation.
+	 */
+	dwc = platform_get_drvdata(qcom->dwc3);
+
+	/* Core driver may not have probed yet. */
+	if (!dwc)
+		return false;
 
 	return dwc->xhci;
 }
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index d76a4837615d..8ada601901cf 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2412,7 +2412,7 @@ static void __dwc3_gadget_set_speed(struct dwc3 *dwc)
 	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
 }
 
-static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
+static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on)
 {
 	u32			reg;
 	u32			timeout = 500;
@@ -2431,17 +2431,11 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 			reg &= ~DWC3_DCTL_KEEP_CONNECT;
 		reg |= DWC3_DCTL_RUN_STOP;
 
-		if (dwc->has_hibernation)
-			reg |= DWC3_DCTL_KEEP_CONNECT;
-
 		__dwc3_gadget_set_speed(dwc);
 		dwc->pullups_connected = true;
 	} else {
 		reg &= ~DWC3_DCTL_RUN_STOP;
 
-		if (dwc->has_hibernation && !suspend)
-			reg &= ~DWC3_DCTL_KEEP_CONNECT;
-
 		dwc->pullups_connected = false;
 	}
 
@@ -2487,7 +2481,22 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 	 * remaining event generated by the controller while polling for
 	 * DSTS.DEVCTLHLT.
 	 */
-	return dwc3_gadget_run_stop(dwc, false, false);
+	return dwc3_gadget_run_stop(dwc, false);
+}
+
+static int dwc3_gadget_soft_connect(struct dwc3 *dwc)
+{
+	/*
+	 * In the Synopsys DWC_usb31 1.90a programming guide section
+	 * 4.1.9, it specifies that for a reconnect after a
+	 * device-initiated disconnect requires a core soft reset
+	 * (DCTL.CSftRst) before enabling the run/stop bit.
+	 */
+	dwc3_core_soft_reset(dwc);
+
+	dwc3_event_buffers_setup(dwc);
+	__dwc3_gadget_start(dwc);
+	return dwc3_gadget_run_stop(dwc, true);
 }
 
 static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
@@ -2540,21 +2549,12 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 		return 0;
 	}
 
-	if (!is_on) {
-		ret = dwc3_gadget_soft_disconnect(dwc);
-	} else {
-		/*
-		 * In the Synopsys DWC_usb31 1.90a programming guide section
-		 * 4.1.9, it specifies that for a reconnect after a
-		 * device-initiated disconnect requires a core soft reset
-		 * (DCTL.CSftRst) before enabling the run/stop bit.
-		 */
-		dwc3_core_soft_reset(dwc);
+	synchronize_irq(dwc->irq_gadget);
 
-		dwc3_event_buffers_setup(dwc);
-		__dwc3_gadget_start(dwc);
-		ret = dwc3_gadget_run_stop(dwc, true, false);
-	}
+	if (!is_on)
+		ret = dwc3_gadget_soft_disconnect(dwc);
+	else
+		ret = dwc3_gadget_soft_connect(dwc);
 
 	pm_runtime_put(dwc->dev);
 
@@ -3529,7 +3529,7 @@ static void dwc3_gadget_endpoint_stream_event(struct dwc3_ep *dep,
 		 * streams are updated, and the device controller will not be
 		 * triggered to generate ERDY to move the next stream data. To
 		 * workaround this and maintain compatibility with various
-		 * hosts, force to reinitate the stream until the host is ready
+		 * hosts, force to reinitiate the stream until the host is ready
 		 * instead of waiting for the host to prime the endpoint.
 		 */
 		if (DWC3_VER_IS_WITHIN(DWC32, 100A, ANY)) {
@@ -4051,30 +4051,6 @@ static void dwc3_gadget_suspend_interrupt(struct dwc3 *dwc,
 	dwc->link_state = next;
 }
 
-static void dwc3_gadget_hibernation_interrupt(struct dwc3 *dwc,
-		unsigned int evtinfo)
-{
-	unsigned int is_ss = evtinfo & BIT(4);
-
-	/*
-	 * WORKAROUND: DWC3 revison 2.20a with hibernation support
-	 * have a known issue which can cause USB CV TD.9.23 to fail
-	 * randomly.
-	 *
-	 * Because of this issue, core could generate bogus hibernation
-	 * events which SW needs to ignore.
-	 *
-	 * Refers to:
-	 *
-	 * STAR#9000546576: Device Mode Hibernation: Issue in USB 2.0
-	 * Device Fallback from SuperSpeed
-	 */
-	if (is_ss ^ (dwc->speed == USB_SPEED_SUPER))
-		return;
-
-	/* enter hibernation here */
-}
-
 static void dwc3_gadget_interrupt(struct dwc3 *dwc,
 		const struct dwc3_event_devt *event)
 {
@@ -4092,11 +4068,7 @@ static void dwc3_gadget_interrupt(struct dwc3 *dwc,
 		dwc3_gadget_wakeup_interrupt(dwc);
 		break;
 	case DWC3_DEVICE_EVENT_HIBER_REQ:
-		if (dev_WARN_ONCE(dwc->dev, !dwc->has_hibernation,
-					"unexpected hibernation event\n"))
-			break;
-
-		dwc3_gadget_hibernation_interrupt(dwc, event->event_info);
+		dev_WARN_ONCE(dwc->dev, true, "unexpected hibernation event\n");
 		break;
 	case DWC3_DEVICE_EVENT_LINK_STATUS_CHANGE:
 		dwc3_gadget_linksts_change_interrupt(dwc, event->event_info);
@@ -4437,38 +4409,40 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 
 int dwc3_gadget_suspend(struct dwc3 *dwc)
 {
+	unsigned long flags;
+	int ret;
+
 	if (!dwc->gadget_driver)
 		return 0;
 
-	dwc3_gadget_run_stop(dwc, false, false);
+	ret = dwc3_gadget_soft_disconnect(dwc);
+	if (ret)
+		goto err;
+
+	spin_lock_irqsave(&dwc->lock, flags);
 	dwc3_disconnect_gadget(dwc);
-	__dwc3_gadget_stop(dwc);
+	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return 0;
+
+err:
+	/*
+	 * Attempt to reset the controller's state. Likely no
+	 * communication can be established until the host
+	 * performs a port reset.
+	 */
+	if (dwc->softconnect)
+		dwc3_gadget_soft_connect(dwc);
+
+	return ret;
 }
 
 int dwc3_gadget_resume(struct dwc3 *dwc)
 {
-	int			ret;
-
 	if (!dwc->gadget_driver || !dwc->softconnect)
 		return 0;
 
-	ret = __dwc3_gadget_start(dwc);
-	if (ret < 0)
-		goto err0;
-
-	ret = dwc3_gadget_run_stop(dwc, true, false);
-	if (ret < 0)
-		goto err1;
-
-	return 0;
-
-err1:
-	__dwc3_gadget_stop(dwc);
-
-err0:
-	return ret;
+	return dwc3_gadget_soft_connect(dwc);
 }
 
 void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index a8d1e8b192c5..f975dc03a190 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -915,8 +915,11 @@ static void __gs_console_push(struct gs_console *cons)
 	}
 
 	req->length = size;
+
+	spin_unlock_irq(&cons->lock);
 	if (usb_ep_queue(ep, req, GFP_ATOMIC))
 		req->length = 0;
+	spin_lock_irq(&cons->lock);
 }
 
 static void gs_console_work(struct work_struct *work)
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 30ae4237f3dd..564864f039d2 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -879,10 +879,10 @@ static void vduse_dev_irq_inject(struct work_struct *work)
 {
 	struct vduse_dev *dev = container_of(work, struct vduse_dev, inject);
 
-	spin_lock_irq(&dev->irq_lock);
+	spin_lock_bh(&dev->irq_lock);
 	if (dev->config_cb.callback)
 		dev->config_cb.callback(dev->config_cb.private);
-	spin_unlock_irq(&dev->irq_lock);
+	spin_unlock_bh(&dev->irq_lock);
 }
 
 static void vduse_vq_irq_inject(struct work_struct *work)
@@ -890,10 +890,10 @@ static void vduse_vq_irq_inject(struct work_struct *work)
 	struct vduse_virtqueue *vq = container_of(work,
 					struct vduse_virtqueue, inject);
 
-	spin_lock_irq(&vq->irq_lock);
+	spin_lock_bh(&vq->irq_lock);
 	if (vq->ready && vq->cb.callback)
 		vq->cb.callback(vq->cb.private);
-	spin_unlock_irq(&vq->irq_lock);
+	spin_unlock_bh(&vq->irq_lock);
 }
 
 static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
diff --git a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
index 061a105afb86..27c3ee5df8de 100644
--- a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
+++ b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
@@ -518,7 +518,9 @@ static int mmphw_probe(struct platform_device *pdev)
 		ret = -ENOENT;
 		goto failed;
 	}
-	clk_prepare_enable(ctrl->clk);
+	ret = clk_prepare_enable(ctrl->clk);
+	if (ret)
+		goto failed;
 
 	/* init global regs */
 	ctrl_set_default(ctrl);
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index fe696aafaed8..f4d43d60d710 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -572,9 +572,8 @@ static void virtio_mmio_release_dev(struct device *_d)
 	struct virtio_device *vdev =
 			container_of(_d, struct virtio_device, dev);
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
-	struct platform_device *pdev = vm_dev->pdev;
 
-	devm_kfree(&pdev->dev, vm_dev);
+	kfree(vm_dev);
 }
 
 /* Platform device */
@@ -585,7 +584,7 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 	unsigned long magic;
 	int rc;
 
-	vm_dev = devm_kzalloc(&pdev->dev, sizeof(*vm_dev), GFP_KERNEL);
+	vm_dev = kzalloc(sizeof(*vm_dev), GFP_KERNEL);
 	if (!vm_dev)
 		return -ENOMEM;
 
diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
index 1e327fb1ad20..0141858188c5 100644
--- a/drivers/watchdog/sp5100_tco.c
+++ b/drivers/watchdog/sp5100_tco.c
@@ -89,7 +89,7 @@ static enum tco_reg_layout tco_reg_layout(struct pci_dev *dev)
 	    sp5100_tco_pci->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS &&
 	    sp5100_tco_pci->revision >= AMD_ZEN_SMBUS_PCI_REV) {
 		return efch_mmio;
-	} else if (dev->vendor == PCI_VENDOR_ID_AMD &&
+	} else if ((dev->vendor == PCI_VENDOR_ID_AMD || dev->vendor == PCI_VENDOR_ID_HYGON) &&
 	    ((dev->device == PCI_DEVICE_ID_AMD_HUDSON2_SMBUS &&
 	     dev->revision >= 0x41) ||
 	    (dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS &&
@@ -561,6 +561,8 @@ static const struct pci_device_id sp5100_tco_pci_tbl[] = {
 	  PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_KERNCZ_SMBUS, PCI_ANY_ID,
 	  PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_AMD_KERNCZ_SMBUS, PCI_ANY_ID,
+	  PCI_ANY_ID, },
 	{ 0, },			/* End of list */
 };
 MODULE_DEVICE_TABLE(pci, sp5100_tco_pci_tbl);
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index d24cef671c1a..4ca6828586af 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1475,11 +1475,14 @@ void btrfs_mark_bg_unused(struct btrfs_block_group *bg)
 {
 	struct btrfs_fs_info *fs_info = bg->fs_info;
 
+	trace_btrfs_add_unused_block_group(bg);
 	spin_lock(&fs_info->unused_bgs_lock);
 	if (list_empty(&bg->bg_list)) {
 		btrfs_get_block_group(bg);
-		trace_btrfs_add_unused_block_group(bg);
 		list_add_tail(&bg->bg_list, &fs_info->unused_bgs);
+	} else {
+		/* Pull out the block group from the reclaim_bgs list. */
+		list_move_tail(&bg->bg_list, &fs_info->unused_bgs);
 	}
 	spin_unlock(&fs_info->unused_bgs_lock);
 }
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 5e191860e8a8..0e9236a745b8 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4636,8 +4636,7 @@ int btrfs_cancel_balance(struct btrfs_fs_info *fs_info)
 		}
 	}
 
-	BUG_ON(fs_info->balance_ctl ||
-		test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags));
+	ASSERT(!test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags));
 	atomic_dec(&fs_info->balance_cancel_req);
 	mutex_unlock(&fs_info->balance_mutex);
 	return 0;
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index c9481289266c..b5ae209539ff 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -848,11 +848,11 @@ struct dentry *
 cifs_smb3_do_mount(struct file_system_type *fs_type,
 	      int flags, struct smb3_fs_context *old_ctx)
 {
-	int rc;
-	struct super_block *sb = NULL;
-	struct cifs_sb_info *cifs_sb = NULL;
 	struct cifs_mnt_data mnt_data;
+	struct cifs_sb_info *cifs_sb;
+	struct super_block *sb;
 	struct dentry *root;
+	int rc;
 
 	/*
 	 * Prints in Kernel / CIFS log the attempted mount operation
@@ -863,11 +863,9 @@ cifs_smb3_do_mount(struct file_system_type *fs_type,
 	else
 		cifs_info("Attempting to mount %s\n", old_ctx->UNC);
 
-	cifs_sb = kzalloc(sizeof(struct cifs_sb_info), GFP_KERNEL);
-	if (cifs_sb == NULL) {
-		root = ERR_PTR(-ENOMEM);
-		goto out;
-	}
+	cifs_sb = kzalloc(sizeof(*cifs_sb), GFP_KERNEL);
+	if (!cifs_sb)
+		return ERR_PTR(-ENOMEM);
 
 	cifs_sb->ctx = kzalloc(sizeof(struct smb3_fs_context), GFP_KERNEL);
 	if (!cifs_sb->ctx) {
@@ -910,10 +908,8 @@ cifs_smb3_do_mount(struct file_system_type *fs_type,
 
 	sb = sget(fs_type, cifs_match_super, cifs_set_super, flags, &mnt_data);
 	if (IS_ERR(sb)) {
-		root = ERR_CAST(sb);
 		cifs_umount(cifs_sb);
-		cifs_sb = NULL;
-		goto out;
+		return ERR_CAST(sb);
 	}
 
 	if (sb->s_root) {
@@ -944,13 +940,9 @@ cifs_smb3_do_mount(struct file_system_type *fs_type,
 	deactivate_locked_super(sb);
 	return root;
 out:
-	if (cifs_sb) {
-		if (!sb || IS_ERR(sb)) {  /* otherwise kill_sb will handle */
-			kfree(cifs_sb->prepath);
-			smb3_cleanup_fs_context(cifs_sb->ctx);
-			kfree(cifs_sb);
-		}
-	}
+	kfree(cifs_sb->prepath);
+	smb3_cleanup_fs_context(cifs_sb->ctx);
+	kfree(cifs_sb);
 	return root;
 }
 
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index e65fbae9e804..9e8a69f9421e 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4671,9 +4671,9 @@ static int cifs_readpage_worker(struct file *file, struct page *page,
 
 io_error:
 	kunmap(page);
-	unlock_page(page);
 
 read_complete:
+	unlock_page(page);
 	return rc;
 }
 
@@ -4865,9 +4865,11 @@ void cifs_oplock_break(struct work_struct *work)
 	struct cifsFileInfo *cfile = container_of(work, struct cifsFileInfo,
 						  oplock_break);
 	struct inode *inode = d_inode(cfile->dentry);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 	struct cifsInodeInfo *cinode = CIFS_I(inode);
-	struct cifs_tcon *tcon = tlink_tcon(cfile->tlink);
-	struct TCP_Server_Info *server = tcon->ses->server;
+	struct cifs_tcon *tcon;
+	struct TCP_Server_Info *server;
+	struct tcon_link *tlink;
 	int rc = 0;
 	bool purge_cache = false, oplock_break_cancelled;
 	__u64 persistent_fid, volatile_fid;
@@ -4876,6 +4878,12 @@ void cifs_oplock_break(struct work_struct *work)
 	wait_on_bit(&cinode->flags, CIFS_INODE_PENDING_WRITERS,
 			TASK_UNINTERRUPTIBLE);
 
+	tlink = cifs_sb_tlink(cifs_sb);
+	if (IS_ERR(tlink))
+		goto out;
+	tcon = tlink_tcon(tlink);
+	server = tcon->ses->server;
+
 	server->ops->downgrade_oplock(server, cinode, cfile->oplock_level,
 				      cfile->oplock_epoch, &purge_cache);
 
@@ -4925,18 +4933,19 @@ void cifs_oplock_break(struct work_struct *work)
 	/*
 	 * MS-SMB2 3.2.5.19.1 and 3.2.5.19.2 (and MS-CIFS 3.2.5.42) do not require
 	 * an acknowledgment to be sent when the file has already been closed.
-	 * check for server null, since can race with kill_sb calling tree disconnect.
 	 */
 	spin_lock(&cinode->open_file_lock);
-	if (tcon->ses && tcon->ses->server && !oplock_break_cancelled &&
-					!list_empty(&cinode->openFileList)) {
+	/* check list empty since can race with kill_sb calling tree disconnect */
+	if (!oplock_break_cancelled && !list_empty(&cinode->openFileList)) {
 		spin_unlock(&cinode->open_file_lock);
-		rc = tcon->ses->server->ops->oplock_response(tcon, persistent_fid,
-						volatile_fid, net_fid, cinode);
+		rc = server->ops->oplock_response(tcon, persistent_fid,
+						  volatile_fid, net_fid, cinode);
 		cifs_dbg(FYI, "Oplock release rc = %d\n", rc);
 	} else
 		spin_unlock(&cinode->open_file_lock);
 
+	cifs_put_tlink(tlink);
+out:
 	cifs_done_oplock_break(cinode);
 }
 
diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 8475a8653c3a..f6dd4fc8eaf4 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -34,6 +34,7 @@ static void exfat_get_uniname_from_ext_entry(struct super_block *sb,
 {
 	int i;
 	struct exfat_entry_set_cache *es;
+	unsigned int uni_len = 0, len;
 
 	es = exfat_get_dentry_set(sb, p_dir, entry, ES_ALL_ENTRIES);
 	if (!es)
@@ -52,7 +53,10 @@ static void exfat_get_uniname_from_ext_entry(struct super_block *sb,
 		if (exfat_get_entry_type(ep) != TYPE_EXTEND)
 			break;
 
-		exfat_extract_uni_name(ep, uniname);
+		len = exfat_extract_uni_name(ep, uniname);
+		uni_len += len;
+		if (len != EXFAT_FILE_NAME_LEN || uni_len >= MAX_NAME_LENGTH)
+			break;
 		uniname += EXFAT_FILE_NAME_LEN;
 	}
 
@@ -1032,7 +1036,8 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 			if (entry_type == TYPE_EXTEND) {
 				unsigned short entry_uniname[16], unichar;
 
-				if (step != DIRENT_STEP_NAME) {
+				if (step != DIRENT_STEP_NAME ||
+				    name_len >= MAX_NAME_LENGTH) {
 					step = DIRENT_STEP_FILE;
 					continue;
 				}
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index ca6ee1cbccd5..51b44da4a0d6 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -980,7 +980,14 @@ static int gfs2_show_options(struct seq_file *s, struct dentry *root)
 {
 	struct gfs2_sbd *sdp = root->d_sb->s_fs_info;
 	struct gfs2_args *args = &sdp->sd_args;
-	int val;
+	unsigned int logd_secs, statfs_slow, statfs_quantum, quota_quantum;
+
+	spin_lock(&sdp->sd_tune.gt_spin);
+	logd_secs = sdp->sd_tune.gt_logd_secs;
+	quota_quantum = sdp->sd_tune.gt_quota_quantum;
+	statfs_quantum = sdp->sd_tune.gt_statfs_quantum;
+	statfs_slow = sdp->sd_tune.gt_statfs_slow;
+	spin_unlock(&sdp->sd_tune.gt_spin);
 
 	if (is_ancestor(root, sdp->sd_master_dir))
 		seq_puts(s, ",meta");
@@ -1035,17 +1042,14 @@ static int gfs2_show_options(struct seq_file *s, struct dentry *root)
 	}
 	if (args->ar_discard)
 		seq_puts(s, ",discard");
-	val = sdp->sd_tune.gt_logd_secs;
-	if (val != 30)
-		seq_printf(s, ",commit=%d", val);
-	val = sdp->sd_tune.gt_statfs_quantum;
-	if (val != 30)
-		seq_printf(s, ",statfs_quantum=%d", val);
-	else if (sdp->sd_tune.gt_statfs_slow)
+	if (logd_secs != 30)
+		seq_printf(s, ",commit=%d", logd_secs);
+	if (statfs_quantum != 30)
+		seq_printf(s, ",statfs_quantum=%d", statfs_quantum);
+	else if (statfs_slow)
 		seq_puts(s, ",statfs_quantum=0");
-	val = sdp->sd_tune.gt_quota_quantum;
-	if (val != 60)
-		seq_printf(s, ",quota_quantum=%d", val);
+	if (quota_quantum != 60)
+		seq_printf(s, ",quota_quantum=%d", quota_quantum);
 	if (args->ar_statfs_percent)
 		seq_printf(s, ",statfs_percent=%d", args->ar_statfs_percent);
 	if (args->ar_errors != GFS2_ERRORS_DEFAULT) {
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index d24e12d348d4..9a1744955d1c 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -849,6 +849,7 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 	if (err)
 		goto out1;
 
+	err = -EINVAL;
 	/* Call mi_remove_attr() in reverse order to keep pointers 'arr_move' valid. */
 	while (to_free > 0) {
 		struct ATTRIB *b = arr_move[--nb];
@@ -857,7 +858,8 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 
 		attr = mi_insert_attr(mi, b->type, Add2Ptr(b, name_off),
 				      b->name_len, asize, name_off);
-		WARN_ON(!attr);
+		if (!attr)
+			goto out1;
 
 		mi_get_ref(mi, &le_b[nb]->ref);
 		le_b[nb]->id = attr->id;
@@ -867,17 +869,20 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 		attr->id = le_b[nb]->id;
 
 		/* Remove from primary record. */
-		WARN_ON(!mi_remove_attr(NULL, &ni->mi, b));
+		if (!mi_remove_attr(NULL, &ni->mi, b))
+			goto out1;
 
 		if (to_free <= asize)
 			break;
 		to_free -= asize;
-		WARN_ON(!nb);
+		if (!nb)
+			goto out1;
 	}
 
 	attr = mi_insert_attr(&ni->mi, ATTR_LIST, NULL, 0,
 			      lsize + SIZEOF_RESIDENT, SIZEOF_RESIDENT);
-	WARN_ON(!attr);
+	if (!attr)
+		goto out1;
 
 	attr->non_res = 0;
 	attr->flags = 0;
@@ -897,9 +902,10 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 	kfree(ni->attr_list.le);
 	ni->attr_list.le = NULL;
 	ni->attr_list.size = 0;
+	return err;
 
 out:
-	return err;
+	return 0;
 }
 
 /*
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 3c823613de97..0ae70010b01d 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -154,7 +154,7 @@ int ntfs_fix_post_read(struct NTFS_RECORD_HEADER *rhdr, size_t bytes,
 	/* Check errors. */
 	if ((fo & 1) || fo + fn * sizeof(short) > SECTOR_SIZE || !fn-- ||
 	    fn * SECTOR_SIZE > bytes) {
-		return -EINVAL; /* Native chkntfs returns ok! */
+		return -E_NTFS_CORRUPT;
 	}
 
 	/* Get fixup pointer. */
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 124eba7238fd..7705adc926b8 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1112,6 +1112,12 @@ int indx_read(struct ntfs_index *indx, struct ntfs_inode *ni, CLST vbn,
 	*node = in;
 
 out:
+	if (err == -E_NTFS_CORRUPT) {
+		ntfs_inode_err(&ni->vfs_inode, "directory corrupted");
+		ntfs_set_state(ni->mi.sbi, NTFS_DIRTY_ERROR);
+		err = -EINVAL;
+	}
+
 	if (ib != in->index)
 		kfree(ib);
 
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index fc0eb93c76de..510ed2ea1c48 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -54,6 +54,8 @@ enum utf16_endian;
 #define E_NTFS_NONRESIDENT		556
 /* NTFS specific error code about punch hole. */
 #define E_NTFS_NOTALIGNED		557
+/* NTFS specific error code when on-disk struct is corrupted. */
+#define E_NTFS_CORRUPT			558
 
 
 /* sbi->flags */
diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 41f6e578966b..938fc286963f 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -124,7 +124,7 @@ int mi_read(struct mft_inode *mi, bool is_mft)
 	struct rw_semaphore *rw_lock = NULL;
 
 	if (is_mounted(sbi)) {
-		if (!is_mft) {
+		if (!is_mft && mft_ni) {
 			rw_lock = &mft_ni->file.run_lock;
 			down_read(rw_lock);
 		}
@@ -148,7 +148,7 @@ int mi_read(struct mft_inode *mi, bool is_mft)
 		ni_lock(mft_ni);
 		down_write(rw_lock);
 	}
-	err = attr_load_runs_vcn(mft_ni, ATTR_DATA, NULL, 0, &mft_ni->file.run,
+	err = attr_load_runs_vcn(mft_ni, ATTR_DATA, NULL, 0, run,
 				 vbo >> sbi->cluster_bits);
 	if (rw_lock) {
 		up_write(rw_lock);
@@ -180,6 +180,12 @@ int mi_read(struct mft_inode *mi, bool is_mft)
 	return 0;
 
 out:
+	if (err == -E_NTFS_CORRUPT) {
+		ntfs_err(sbi->sb, "mft corrupted");
+		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+		err = -EINVAL;
+	}
+
 	return err;
 }
 
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index b2d64f3c974b..08031638bbee 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -32,6 +32,7 @@ struct ovl_sb {
 };
 
 struct ovl_layer {
+	/* ovl_free_fs() relies on @mnt being the first member! */
 	struct vfsmount *mnt;
 	/* Trap in ovl inode cache */
 	struct inode *trap;
@@ -42,6 +43,14 @@ struct ovl_layer {
 	int fsid;
 };
 
+/*
+ * ovl_free_fs() relies on @mnt being the first member when unmounting
+ * the private mounts created for each layer. Let's check both the
+ * offset and type.
+ */
+static_assert(offsetof(struct ovl_layer, mnt) == 0);
+static_assert(__same_type(typeof_member(struct ovl_layer, mnt), struct vfsmount *));
+
 struct ovl_path {
 	const struct ovl_layer *layer;
 	struct dentry *dentry;
diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
index 2c8860e406bd..0417360a6db9 100644
--- a/include/linux/iopoll.h
+++ b/include/linux/iopoll.h
@@ -53,6 +53,7 @@
 		} \
 		if (__sleep_us) \
 			usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
+		cpu_relax(); \
 	} \
 	(cond) ? 0 : -ETIMEDOUT; \
 })
@@ -95,6 +96,7 @@
 		} \
 		if (__delay_us) \
 			udelay(__delay_us); \
+		cpu_relax(); \
 	} \
 	(cond) ? 0 : -ETIMEDOUT; \
 })
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index a2042c418686..51f5b24af834 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -71,6 +71,23 @@ struct unwind_hint {
 	static void __used __section(".discard.func_stack_frame_non_standard") \
 		*__func_stack_frame_non_standard_##func = func
 
+/*
+ * STACK_FRAME_NON_STANDARD_FP() is a frame-pointer-specific function ignore
+ * for the case where a function is intentionally missing frame pointer setup,
+ * but otherwise needs objtool/ORC coverage when frame pointers are disabled.
+ */
+#ifdef CONFIG_FRAME_POINTER
+#define STACK_FRAME_NON_STANDARD_FP(func) STACK_FRAME_NON_STANDARD(func)
+#else
+#define STACK_FRAME_NON_STANDARD_FP(func)
+#endif
+
+#define ANNOTATE_NOENDBR					\
+	"986: \n\t"						\
+	".pushsection .discard.noendbr\n\t"			\
+	_ASM_PTR " 986b\n\t"					\
+	".popsection\n\t"
+
 #else /* __ASSEMBLY__ */
 
 /*
@@ -123,6 +140,13 @@ struct unwind_hint {
 	.popsection
 .endm
 
+.macro ANNOTATE_NOENDBR
+.Lhere_\@:
+	.pushsection .discard.noendbr
+	.quad	.Lhere_\@
+	.popsection
+.endm
+
 #endif /* __ASSEMBLY__ */
 
 #else /* !CONFIG_STACK_VALIDATION */
@@ -132,12 +156,16 @@ struct unwind_hint {
 #define UNWIND_HINT(sp_reg, sp_offset, type, end)	\
 	"\n\t"
 #define STACK_FRAME_NON_STANDARD(func)
+#define STACK_FRAME_NON_STANDARD_FP(func)
+#define ANNOTATE_NOENDBR
 #else
 #define ANNOTATE_INTRA_FUNCTION_CALL
 .macro UNWIND_HINT type:req sp_reg=0 sp_offset=0 end=0
 .endm
 .macro STACK_FRAME_NON_STANDARD func:req
 .endm
+.macro ANNOTATE_NOENDBR
+.endm
 #endif
 
 #endif /* CONFIG_STACK_VALIDATION */
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index a960de68ac69..6047058d6703 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -148,6 +148,10 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 		if (gso_type & SKB_GSO_UDP)
 			nh_off -= thlen;
 
+		/* Kernel has a special handling for GSO_BY_FRAGS. */
+		if (gso_size == GSO_BY_FRAGS)
+			return -EINVAL;
+
 		/* Too small packets are not really GSO ones. */
 		if (skb->len - nh_off > gso_size) {
 			shinfo->gso_size = gso_size;
diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem.h
index 5a91b548ecc0..8d52c4506762 100644
--- a/include/media/v4l2-mem2mem.h
+++ b/include/media/v4l2-mem2mem.h
@@ -588,7 +588,14 @@ void v4l2_m2m_buf_queue(struct v4l2_m2m_ctx *m2m_ctx,
 static inline
 unsigned int v4l2_m2m_num_src_bufs_ready(struct v4l2_m2m_ctx *m2m_ctx)
 {
-	return m2m_ctx->out_q_ctx.num_rdy;
+	unsigned int num_buf_rdy;
+	unsigned long flags;
+
+	spin_lock_irqsave(&m2m_ctx->out_q_ctx.rdy_spinlock, flags);
+	num_buf_rdy = m2m_ctx->out_q_ctx.num_rdy;
+	spin_unlock_irqrestore(&m2m_ctx->out_q_ctx.rdy_spinlock, flags);
+
+	return num_buf_rdy;
 }
 
 /**
@@ -600,7 +607,14 @@ unsigned int v4l2_m2m_num_src_bufs_ready(struct v4l2_m2m_ctx *m2m_ctx)
 static inline
 unsigned int v4l2_m2m_num_dst_bufs_ready(struct v4l2_m2m_ctx *m2m_ctx)
 {
-	return m2m_ctx->cap_q_ctx.num_rdy;
+	unsigned int num_buf_rdy;
+	unsigned long flags;
+
+	spin_lock_irqsave(&m2m_ctx->cap_q_ctx.rdy_spinlock, flags);
+	num_buf_rdy = m2m_ctx->cap_q_ctx.num_rdy;
+	spin_unlock_irqrestore(&m2m_ctx->cap_q_ctx.rdy_spinlock, flags);
+
+	return num_buf_rdy;
 }
 
 /**
diff --git a/include/net/sock.h b/include/net/sock.h
index 93a6717213ae..6b12b62417e0 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1381,6 +1381,12 @@ static inline bool sk_has_memory_pressure(const struct sock *sk)
 	return sk->sk_prot->memory_pressure != NULL;
 }
 
+static inline bool sk_under_global_memory_pressure(const struct sock *sk)
+{
+	return sk->sk_prot->memory_pressure &&
+		!!*sk->sk_prot->memory_pressure;
+}
+
 static inline bool sk_under_memory_pressure(const struct sock *sk)
 {
 	if (!sk->sk_prot->memory_pressure)
diff --git a/include/net/tls.h b/include/net/tls.h
index bf3d63a52788..eda0015c5c59 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -179,6 +179,8 @@ struct tls_offload_context_tx {
 
 	struct scatterlist sg_tx_data[MAX_SKB_FRAGS];
 	void (*sk_destruct)(struct sock *sk);
+	struct work_struct destruct_work;
+	struct tls_context *ctx;
 	u8 driver_state[] __aligned(8);
 	/* The TLS layer reserves room for driver specific state
 	 * Currently the belief is that there is not enough
diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index b4526668072e..27596f3b4aef 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -43,13 +43,13 @@ void *dma_common_contiguous_remap(struct page *page, size_t size,
 	void *vaddr;
 	int i;
 
-	pages = kmalloc_array(count, sizeof(struct page *), GFP_KERNEL);
+	pages = kvmalloc_array(count, sizeof(struct page *), GFP_KERNEL);
 	if (!pages)
 		return NULL;
 	for (i = 0; i < count; i++)
 		pages[i] = nth_page(page, i);
 	vaddr = vmap(pages, count, VM_DMA_COHERENT, prot);
-	kfree(pages);
+	kvfree(pages);
 
 	return vaddr;
 }
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index e1cef097b0df..db7cefd196ce 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -535,6 +535,7 @@ struct trace_buffer {
 	unsigned			flags;
 	int				cpus;
 	atomic_t			record_disabled;
+	atomic_t			resizing;
 	cpumask_var_t			cpumask;
 
 	struct lock_class_key		*reader_lock_key;
@@ -2137,7 +2138,7 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 
 	/* prevent another thread from changing buffer sizes */
 	mutex_lock(&buffer->mutex);
-
+	atomic_inc(&buffer->resizing);
 
 	if (cpu_id == RING_BUFFER_ALL_CPUS) {
 		/*
@@ -2276,6 +2277,7 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 		atomic_dec(&buffer->record_disabled);
 	}
 
+	atomic_dec(&buffer->resizing);
 	mutex_unlock(&buffer->mutex);
 	return 0;
 
@@ -2296,6 +2298,7 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 		}
 	}
  out_err_unlock:
+	atomic_dec(&buffer->resizing);
 	mutex_unlock(&buffer->mutex);
 	return err;
 }
@@ -5497,6 +5500,15 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
 	if (local_read(&cpu_buffer_b->committing))
 		goto out_dec;
 
+	/*
+	 * When resize is in progress, we cannot swap it because
+	 * it will mess the state of the cpu buffer.
+	 */
+	if (atomic_read(&buffer_a->resizing))
+		goto out_dec;
+	if (atomic_read(&buffer_b->resizing))
+		goto out_dec;
+
 	buffer_a->buffers[cpu] = cpu_buffer_b;
 	buffer_b->buffers[cpu] = cpu_buffer_a;
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ae7005af78c3..d4c381f06b7b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1872,9 +1872,10 @@ update_max_tr_single(struct trace_array *tr, struct task_struct *tsk, int cpu)
 		 * place on this CPU. We fail to record, but we reset
 		 * the max trace buffer (no one writes directly to it)
 		 * and flag that it failed.
+		 * Another reason is resize is in progress.
 		 */
 		trace_array_printk_buf(tr->max_buffer.buffer, _THIS_IP_,
-			"Failed to swap buffers due to commit in progress\n");
+			"Failed to swap buffers due to commit or resize in progress\n");
 	}
 
 	WARN_ON_ONCE(ret && ret != -EAGAIN && ret != -EBUSY);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9dd54247029a..0770286ecf0b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6375,9 +6375,14 @@ static inline int l2cap_le_command_rej(struct l2cap_conn *conn,
 	if (!chan)
 		goto done;
 
+	chan = l2cap_chan_hold_unless_zero(chan);
+	if (!chan)
+		goto done;
+
 	l2cap_chan_lock(chan);
 	l2cap_chan_del(chan, ECONNREFUSED);
 	l2cap_chan_unlock(chan);
+	l2cap_chan_put(chan);
 
 done:
 	mutex_unlock(&conn->chan_lock);
diff --git a/net/core/sock.c b/net/core/sock.c
index 1f9401d757cb..ae1e9e2b8255 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2880,7 +2880,7 @@ void __sk_mem_reduce_allocated(struct sock *sk, int amount)
 	if (mem_cgroup_sockets_enabled && sk->sk_memcg)
 		mem_cgroup_uncharge_skmem(sk->sk_memcg, amount);
 
-	if (sk_under_memory_pressure(sk) &&
+	if (sk_under_global_memory_pressure(sk) &&
 	    (sk_memory_allocated(sk) < sk_prot_mem_limits(sk, 0)))
 		sk_leave_memory_pressure(sk);
 }
diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index efe25a0172e6..df23319adc80 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -287,12 +287,12 @@ static netdev_tx_t vti_tunnel_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
-		xfrm_decode_session(skb, &fl, AF_INET);
 		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+		xfrm_decode_session(skb, &fl, AF_INET);
 		break;
 	case htons(ETH_P_IPV6):
-		xfrm_decode_session(skb, &fl, AF_INET6);
 		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
+		xfrm_decode_session(skb, &fl, AF_INET6);
 		break;
 	default:
 		goto tx_err;
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 50bba370486e..a8592c187b32 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -582,7 +582,9 @@ void tcp_retransmit_timer(struct sock *sk)
 	    tcp_stream_is_thin(tp) &&
 	    icsk->icsk_retransmits <= TCP_THIN_LINEAR_RETRIES) {
 		icsk->icsk_backoff = 0;
-		icsk->icsk_rto = min(__tcp_set_rto(tp), TCP_RTO_MAX);
+		icsk->icsk_rto = clamp(__tcp_set_rto(tp),
+				       tcp_rto_min(sk),
+				       TCP_RTO_MAX);
 	} else {
 		/* Use normal (exponential) backoff */
 		icsk->icsk_rto = min(icsk->icsk_rto << 1, TCP_RTO_MAX);
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 42c37ec832f1..190aa3b19591 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -570,12 +570,12 @@ vti6_tnl_xmit(struct sk_buff *skb, struct net_device *dev)
 		    vti6_addr_conflict(t, ipv6_hdr(skb)))
 			goto tx_err;
 
-		xfrm_decode_session(skb, &fl, AF_INET6);
 		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
+		xfrm_decode_session(skb, &fl, AF_INET6);
 		break;
 	case htons(ETH_P_IP):
-		xfrm_decode_session(skb, &fl, AF_INET);
 		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+		xfrm_decode_session(skb, &fl, AF_INET);
 		break;
 	default:
 		goto tx_err;
diff --git a/net/key/af_key.c b/net/key/af_key.c
index d34fed1a484a..258fa046f440 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -1848,9 +1848,9 @@ static int pfkey_dump(struct sock *sk, struct sk_buff *skb, const struct sadb_ms
 	if (ext_hdrs[SADB_X_EXT_FILTER - 1]) {
 		struct sadb_x_filter *xfilter = ext_hdrs[SADB_X_EXT_FILTER - 1];
 
-		if ((xfilter->sadb_x_filter_splen >=
+		if ((xfilter->sadb_x_filter_splen >
 			(sizeof(xfrm_address_t) << 3)) ||
-		    (xfilter->sadb_x_filter_dplen >=
+		    (xfilter->sadb_x_filter_dplen >
 			(sizeof(xfrm_address_t) << 3))) {
 			mutex_unlock(&pfk->dump_lock);
 			return -EINVAL;
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 29ec3ef63edc..d0b64c36471d 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -1802,6 +1802,7 @@ static int
 proc_do_sync_threshold(struct ctl_table *table, int write,
 		       void *buffer, size_t *lenp, loff_t *ppos)
 {
+	struct netns_ipvs *ipvs = table->extra2;
 	int *valp = table->data;
 	int val[2];
 	int rc;
@@ -1811,6 +1812,7 @@ proc_do_sync_threshold(struct ctl_table *table, int write,
 		.mode = table->mode,
 	};
 
+	mutex_lock(&ipvs->sync_mutex);
 	memcpy(val, valp, sizeof(val));
 	rc = proc_dointvec(&tmp, write, buffer, lenp, ppos);
 	if (write) {
@@ -1820,6 +1822,7 @@ proc_do_sync_threshold(struct ctl_table *table, int write,
 		else
 			memcpy(valp, val, sizeof(val));
 	}
+	mutex_unlock(&ipvs->sync_mutex);
 	return rc;
 }
 
@@ -4077,6 +4080,7 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 	ipvs->sysctl_sync_threshold[0] = DEFAULT_SYNC_THRESHOLD;
 	ipvs->sysctl_sync_threshold[1] = DEFAULT_SYNC_PERIOD;
 	tbl[idx].data = &ipvs->sysctl_sync_threshold;
+	tbl[idx].extra2 = ipvs;
 	tbl[idx++].maxlen = sizeof(ipvs->sysctl_sync_threshold);
 	ipvs->sysctl_sync_refresh_period = DEFAULT_SYNC_REFRESH_PERIOD;
 	tbl[idx++].data = &ipvs->sysctl_sync_refresh_period;
diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/nf_conntrack_proto_sctp.c
index 895e0ca54299..7247af51bdfc 100644
--- a/net/netfilter/nf_conntrack_proto_sctp.c
+++ b/net/netfilter/nf_conntrack_proto_sctp.c
@@ -49,8 +49,8 @@ static const unsigned int sctp_timeouts[SCTP_CONNTRACK_MAX] = {
 	[SCTP_CONNTRACK_COOKIE_WAIT]		= 3 SECS,
 	[SCTP_CONNTRACK_COOKIE_ECHOED]		= 3 SECS,
 	[SCTP_CONNTRACK_ESTABLISHED]		= 210 SECS,
-	[SCTP_CONNTRACK_SHUTDOWN_SENT]		= 300 SECS / 1000,
-	[SCTP_CONNTRACK_SHUTDOWN_RECD]		= 300 SECS / 1000,
+	[SCTP_CONNTRACK_SHUTDOWN_SENT]		= 3 SECS,
+	[SCTP_CONNTRACK_SHUTDOWN_RECD]		= 3 SECS,
 	[SCTP_CONNTRACK_SHUTDOWN_ACK_SENT]	= 3 SECS,
 	[SCTP_CONNTRACK_HEARTBEAT_SENT]		= 30 SECS,
 };
@@ -105,7 +105,7 @@ static const u8 sctp_conntracks[2][11][SCTP_CONNTRACK_MAX] = {
 	{
 /*	ORIGINAL	*/
 /*                  sNO, sCL, sCW, sCE, sES, sSS, sSR, sSA, sHS */
-/* init         */ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sSA, sCW},
+/* init         */ {sCL, sCL, sCW, sCE, sES, sCL, sCL, sSA, sCW},
 /* init_ack     */ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sSA, sCL},
 /* abort        */ {sCL, sCL, sCL, sCL, sCL, sCL, sCL, sCL, sCL},
 /* shutdown     */ {sCL, sCL, sCW, sCE, sSS, sSS, sSR, sSA, sCL},
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 1e84314fe334..1e2d1e4bdb74 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6719,6 +6719,7 @@ static int nft_set_catchall_flush(const struct nft_ctx *ctx,
 		ret = __nft_set_catchall_flush(ctx, set, &elem);
 		if (ret < 0)
 			break;
+		nft_set_elem_change_active(ctx->net, set, ext);
 	}
 
 	return ret;
diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index 29c7ae8789e9..73e606372b05 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -191,6 +191,9 @@ static int nft_dynset_init(const struct nft_ctx *ctx,
 	if (IS_ERR(set))
 		return PTR_ERR(set);
 
+	if (set->flags & NFT_SET_OBJECT)
+		return -EOPNOTSUPP;
+
 	if (set->ops->update == NULL)
 		return -EOPNOTSUPP;
 
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index a81829c10fea..32cfd0a84b0e 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1665,6 +1665,17 @@ static void nft_pipapo_commit(const struct nft_set *set)
 	priv->clone = new_clone;
 }
 
+static bool nft_pipapo_transaction_mutex_held(const struct nft_set *set)
+{
+#ifdef CONFIG_PROVE_LOCKING
+	const struct net *net = read_pnet(&set->net);
+
+	return lockdep_is_held(&nft_pernet(net)->commit_mutex);
+#else
+	return true;
+#endif
+}
+
 static void nft_pipapo_abort(const struct nft_set *set)
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
@@ -1673,7 +1684,7 @@ static void nft_pipapo_abort(const struct nft_set *set)
 	if (!priv->dirty)
 		return;
 
-	m = rcu_dereference(priv->match);
+	m = rcu_dereference_protected(priv->match, nft_pipapo_transaction_mutex_held(set));
 
 	new_clone = pipapo_clone(m);
 	if (IS_ERR(new_clone))
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index cf75969375cf..88785196a896 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -45,14 +45,14 @@
  */
 static DECLARE_RWSEM(device_offload_lock);
 
-static void tls_device_gc_task(struct work_struct *work);
+static struct workqueue_struct *destruct_wq __read_mostly;
 
-static DECLARE_WORK(tls_device_gc_work, tls_device_gc_task);
-static LIST_HEAD(tls_device_gc_list);
 static LIST_HEAD(tls_device_list);
 static LIST_HEAD(tls_device_down_list);
 static DEFINE_SPINLOCK(tls_device_lock);
 
+static struct page *dummy_page;
+
 static void tls_device_free_ctx(struct tls_context *ctx)
 {
 	if (ctx->tx_conf == TLS_HW) {
@@ -67,47 +67,44 @@ static void tls_device_free_ctx(struct tls_context *ctx)
 	tls_ctx_free(NULL, ctx);
 }
 
-static void tls_device_gc_task(struct work_struct *work)
+static void tls_device_tx_del_task(struct work_struct *work)
 {
-	struct tls_context *ctx, *tmp;
-	unsigned long flags;
-	LIST_HEAD(gc_list);
-
-	spin_lock_irqsave(&tls_device_lock, flags);
-	list_splice_init(&tls_device_gc_list, &gc_list);
-	spin_unlock_irqrestore(&tls_device_lock, flags);
-
-	list_for_each_entry_safe(ctx, tmp, &gc_list, list) {
-		struct net_device *netdev = ctx->netdev;
+	struct tls_offload_context_tx *offload_ctx =
+		container_of(work, struct tls_offload_context_tx, destruct_work);
+	struct tls_context *ctx = offload_ctx->ctx;
+	struct net_device *netdev = ctx->netdev;
 
-		if (netdev && ctx->tx_conf == TLS_HW) {
-			netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
-							TLS_OFFLOAD_CTX_DIR_TX);
-			dev_put(netdev);
-			ctx->netdev = NULL;
-		}
-
-		list_del(&ctx->list);
-		tls_device_free_ctx(ctx);
-	}
+	netdev->tlsdev_ops->tls_dev_del(netdev, ctx, TLS_OFFLOAD_CTX_DIR_TX);
+	dev_put(netdev);
+	ctx->netdev = NULL;
+	tls_device_free_ctx(ctx);
 }
 
 static void tls_device_queue_ctx_destruction(struct tls_context *ctx)
 {
 	unsigned long flags;
+	bool async_cleanup;
 
 	spin_lock_irqsave(&tls_device_lock, flags);
-	if (unlikely(!refcount_dec_and_test(&ctx->refcount)))
-		goto unlock;
+	if (unlikely(!refcount_dec_and_test(&ctx->refcount))) {
+		spin_unlock_irqrestore(&tls_device_lock, flags);
+		return;
+	}
 
-	list_move_tail(&ctx->list, &tls_device_gc_list);
+	list_del(&ctx->list); /* Remove from tls_device_list / tls_device_down_list */
+	async_cleanup = ctx->netdev && ctx->tx_conf == TLS_HW;
+	if (async_cleanup) {
+		struct tls_offload_context_tx *offload_ctx = tls_offload_ctx_tx(ctx);
 
-	/* schedule_work inside the spinlock
-	 * to make sure tls_device_down waits for that work.
-	 */
-	schedule_work(&tls_device_gc_work);
-unlock:
+		/* queue_work inside the spinlock
+		 * to make sure tls_device_down waits for that work.
+		 */
+		queue_work(destruct_wq, &offload_ctx->destruct_work);
+	}
 	spin_unlock_irqrestore(&tls_device_lock, flags);
+
+	if (!async_cleanup)
+		tls_device_free_ctx(ctx);
 }
 
 /* We assume that the socket is already connected */
@@ -302,36 +299,33 @@ static int tls_push_record(struct sock *sk,
 	return tls_push_sg(sk, ctx, offload_ctx->sg_tx_data, 0, flags);
 }
 
-static int tls_device_record_close(struct sock *sk,
-				   struct tls_context *ctx,
-				   struct tls_record_info *record,
-				   struct page_frag *pfrag,
-				   unsigned char record_type)
+static void tls_device_record_close(struct sock *sk,
+				    struct tls_context *ctx,
+				    struct tls_record_info *record,
+				    struct page_frag *pfrag,
+				    unsigned char record_type)
 {
 	struct tls_prot_info *prot = &ctx->prot_info;
-	int ret;
+	struct page_frag dummy_tag_frag;
 
 	/* append tag
 	 * device will fill in the tag, we just need to append a placeholder
 	 * use socket memory to improve coalescing (re-using a single buffer
 	 * increases frag count)
-	 * if we can't allocate memory now, steal some back from data
+	 * if we can't allocate memory now use the dummy page
 	 */
-	if (likely(skb_page_frag_refill(prot->tag_size, pfrag,
-					sk->sk_allocation))) {
-		ret = 0;
-		tls_append_frag(record, pfrag, prot->tag_size);
-	} else {
-		ret = prot->tag_size;
-		if (record->len <= prot->overhead_size)
-			return -ENOMEM;
+	if (unlikely(pfrag->size - pfrag->offset < prot->tag_size) &&
+	    !skb_page_frag_refill(prot->tag_size, pfrag, sk->sk_allocation)) {
+		dummy_tag_frag.page = dummy_page;
+		dummy_tag_frag.offset = 0;
+		pfrag = &dummy_tag_frag;
 	}
+	tls_append_frag(record, pfrag, prot->tag_size);
 
 	/* fill prepend */
 	tls_fill_prepend(ctx, skb_frag_address(&record->frags[0]),
 			 record->len - prot->overhead_size,
 			 record_type);
-	return ret;
 }
 
 static int tls_create_new_record(struct tls_offload_context_tx *offload_ctx,
@@ -507,18 +501,8 @@ static int tls_push_data(struct sock *sk,
 
 		if (done || record->len >= max_open_record_len ||
 		    (record->num_frags >= MAX_SKB_FRAGS - 1)) {
-			rc = tls_device_record_close(sk, tls_ctx, record,
-						     pfrag, record_type);
-			if (rc) {
-				if (rc > 0) {
-					size += rc;
-				} else {
-					size = orig_size;
-					destroy_record(record);
-					ctx->open_record = NULL;
-					break;
-				}
-			}
+			tls_device_record_close(sk, tls_ctx, record,
+						pfrag, record_type);
 
 			rc = tls_push_record(sk,
 					     tls_ctx,
@@ -1105,6 +1089,9 @@ int tls_set_device_offload(struct sock *sk, struct tls_context *ctx)
 	start_marker_record->len = 0;
 	start_marker_record->num_frags = 0;
 
+	INIT_WORK(&offload_ctx->destruct_work, tls_device_tx_del_task);
+	offload_ctx->ctx = ctx;
+
 	INIT_LIST_HEAD(&offload_ctx->records_list);
 	list_add_tail(&start_marker_record->list, &offload_ctx->records_list);
 	spin_lock_init(&offload_ctx->lock);
@@ -1362,7 +1349,7 @@ static int tls_device_down(struct net_device *netdev)
 
 	up_write(&device_offload_lock);
 
-	flush_work(&tls_device_gc_work);
+	flush_workqueue(destruct_wq);
 
 	return NOTIFY_DONE;
 }
@@ -1403,12 +1390,36 @@ static struct notifier_block tls_dev_notifier = {
 
 int __init tls_device_init(void)
 {
-	return register_netdevice_notifier(&tls_dev_notifier);
+	int err;
+
+	dummy_page = alloc_page(GFP_KERNEL);
+	if (!dummy_page)
+		return -ENOMEM;
+
+	destruct_wq = alloc_workqueue("ktls_device_destruct", 0, 0);
+	if (!destruct_wq) {
+		err = -ENOMEM;
+		goto err_free_dummy;
+	}
+
+	err = register_netdevice_notifier(&tls_dev_notifier);
+	if (err)
+		goto err_destroy_wq;
+
+	return 0;
+
+err_destroy_wq:
+	destroy_workqueue(destruct_wq);
+err_free_dummy:
+	put_page(dummy_page);
+	return err;
 }
 
 void __exit tls_device_cleanup(void)
 {
 	unregister_netdevice_notifier(&tls_dev_notifier);
-	flush_work(&tls_device_gc_work);
+	flush_workqueue(destruct_wq);
+	destroy_workqueue(destruct_wq);
 	clean_acked_data_flush();
+	put_page(dummy_page);
 }
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 7a076d5017d1..5264fe82e6ec 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2156,6 +2156,7 @@ static ssize_t unix_stream_sendpage(struct socket *socket, struct page *page,
 
 	if (false) {
 alloc_skb:
+		spin_unlock(&other->sk_receive_queue.lock);
 		unix_state_unlock(other);
 		mutex_unlock(&unix_sk(other)->iolock);
 		newskb = sock_alloc_send_pskb(sk, 0, 0, flags & MSG_DONTWAIT,
@@ -2195,6 +2196,7 @@ static ssize_t unix_stream_sendpage(struct socket *socket, struct page *page,
 		init_scm = false;
 	}
 
+	spin_lock(&other->sk_receive_queue.lock);
 	skb = skb_peek_tail(&other->sk_receive_queue);
 	if (tail && tail == skb) {
 		skb = newskb;
@@ -2225,14 +2227,11 @@ static ssize_t unix_stream_sendpage(struct socket *socket, struct page *page,
 	refcount_add(size, &sk->sk_wmem_alloc);
 
 	if (newskb) {
-		err = unix_scm_to_skb(&scm, skb, false);
-		if (err)
-			goto err_state_unlock;
-		spin_lock(&other->sk_receive_queue.lock);
+		unix_scm_to_skb(&scm, skb, false);
 		__skb_queue_tail(&other->sk_receive_queue, newskb);
-		spin_unlock(&other->sk_receive_queue.lock);
 	}
 
+	spin_unlock(&other->sk_receive_queue.lock);
 	unix_state_unlock(other);
 	mutex_unlock(&unix_sk(other)->iolock);
 
diff --git a/net/xfrm/xfrm_compat.c b/net/xfrm/xfrm_compat.c
index 8cbf45a8bcdc..655fe4ff8621 100644
--- a/net/xfrm/xfrm_compat.c
+++ b/net/xfrm/xfrm_compat.c
@@ -108,7 +108,7 @@ static const struct nla_policy compat_policy[XFRMA_MAX+1] = {
 	[XFRMA_ALG_COMP]	= { .len = sizeof(struct xfrm_algo) },
 	[XFRMA_ENCAP]		= { .len = sizeof(struct xfrm_encap_tmpl) },
 	[XFRMA_TMPL]		= { .len = sizeof(struct xfrm_user_tmpl) },
-	[XFRMA_SEC_CTX]		= { .len = sizeof(struct xfrm_sec_ctx) },
+	[XFRMA_SEC_CTX]		= { .len = sizeof(struct xfrm_user_sec_ctx) },
 	[XFRMA_LTIME_VAL]	= { .len = sizeof(struct xfrm_lifetime_cur) },
 	[XFRMA_REPLAY_VAL]	= { .len = sizeof(struct xfrm_replay_state) },
 	[XFRMA_REPLAY_THRESH]	= { .type = NLA_U32 },
diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 694eec6ca147..ded752e33dac 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -399,8 +399,8 @@ static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	switch (skb->protocol) {
 	case htons(ETH_P_IPV6):
-		xfrm_decode_session(skb, &fl, AF_INET6);
 		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
+		xfrm_decode_session(skb, &fl, AF_INET6);
 		if (!dst) {
 			fl.u.ip6.flowi6_oif = dev->ifindex;
 			fl.u.ip6.flowi6_flags |= FLOWI_FLAG_ANYSRC;
@@ -414,8 +414,8 @@ static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 		break;
 	case htons(ETH_P_IP):
-		xfrm_decode_session(skb, &fl, AF_INET);
 		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+		xfrm_decode_session(skb, &fl, AF_INET);
 		if (!dst) {
 			struct rtable *rt;
 
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index eb0952dbf423..ff56b6a0162e 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -527,7 +527,7 @@ static void xfrm_update_ae_params(struct xfrm_state *x, struct nlattr **attrs,
 	struct nlattr *rt = attrs[XFRMA_REPLAY_THRESH];
 	struct nlattr *mt = attrs[XFRMA_MTIMER_THRESH];
 
-	if (re) {
+	if (re && x->replay_esn && x->preplay_esn) {
 		struct xfrm_replay_state_esn *replay_esn;
 		replay_esn = nla_data(re);
 		memcpy(x->replay_esn, replay_esn,
@@ -1159,6 +1159,15 @@ static int xfrm_dump_sa(struct sk_buff *skb, struct netlink_callback *cb)
 					 sizeof(*filter), GFP_KERNEL);
 			if (filter == NULL)
 				return -ENOMEM;
+
+			/* see addr_match(), (prefix length >> 5) << 2
+			 * will be used to compare xfrm_address_t
+			 */
+			if (filter->splen > (sizeof(xfrm_address_t) << 3) ||
+			    filter->dplen > (sizeof(xfrm_address_t) << 3)) {
+				kfree(filter);
+				return -EINVAL;
+			}
 		}
 
 		if (attrs[XFRMA_PROTO])
@@ -2825,7 +2834,7 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
 	[XFRMA_ALG_COMP]	= { .len = sizeof(struct xfrm_algo) },
 	[XFRMA_ENCAP]		= { .len = sizeof(struct xfrm_encap_tmpl) },
 	[XFRMA_TMPL]		= { .len = sizeof(struct xfrm_user_tmpl) },
-	[XFRMA_SEC_CTX]		= { .len = sizeof(struct xfrm_sec_ctx) },
+	[XFRMA_SEC_CTX]		= { .len = sizeof(struct xfrm_user_sec_ctx) },
 	[XFRMA_LTIME_VAL]	= { .len = sizeof(struct xfrm_lifetime_cur) },
 	[XFRMA_REPLAY_VAL]	= { .len = sizeof(struct xfrm_replay_state) },
 	[XFRMA_REPLAY_THRESH]	= { .type = NLA_U32 },
@@ -2845,6 +2854,7 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
 	[XFRMA_SET_MARK]	= { .type = NLA_U32 },
 	[XFRMA_SET_MARK_MASK]	= { .type = NLA_U32 },
 	[XFRMA_IF_ID]		= { .type = NLA_U32 },
+	[XFRMA_MTIMER_THRESH]   = { .type = NLA_U32 },
 };
 EXPORT_SYMBOL_GPL(xfrma_policy);
 
diff --git a/sound/hda/hdac_regmap.c b/sound/hda/hdac_regmap.c
index fe3587547cfe..39610a15bcc9 100644
--- a/sound/hda/hdac_regmap.c
+++ b/sound/hda/hdac_regmap.c
@@ -597,10 +597,9 @@ EXPORT_SYMBOL_GPL(snd_hdac_regmap_update_raw_once);
  */
 void snd_hdac_regmap_sync(struct hdac_device *codec)
 {
-	if (codec->regmap) {
-		mutex_lock(&codec->regmap_lock);
+	mutex_lock(&codec->regmap_lock);
+	if (codec->regmap)
 		regcache_sync(codec->regmap);
-		mutex_unlock(&codec->regmap_lock);
-	}
+	mutex_unlock(&codec->regmap_lock);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_regmap_sync);
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 965720b1d1b1..59e11a070c20 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10088,6 +10088,7 @@ static int patch_alc269(struct hda_codec *codec)
 	spec = codec->spec;
 	spec->gen.shared_mic_vref_pin = 0x18;
 	codec->power_save_node = 0;
+	spec->en_3kpull_low = true;
 
 #ifdef CONFIG_PM
 	codec->patch_ops.suspend = alc269_suspend;
@@ -10170,14 +10171,16 @@ static int patch_alc269(struct hda_codec *codec)
 		spec->shutup = alc256_shutup;
 		spec->init_hook = alc256_init;
 		spec->gen.mixer_nid = 0; /* ALC256 does not have any loopback mixer path */
-		if (codec->bus->pci->vendor == PCI_VENDOR_ID_AMD)
-			spec->en_3kpull_low = true;
+		if (codec->core.vendor_id == 0x10ec0236 &&
+		    codec->bus->pci->vendor != PCI_VENDOR_ID_AMD)
+			spec->en_3kpull_low = false;
 		break;
 	case 0x10ec0257:
 		spec->codec_variant = ALC269_TYPE_ALC257;
 		spec->shutup = alc256_shutup;
 		spec->init_hook = alc256_init;
 		spec->gen.mixer_nid = 0;
+		spec->en_3kpull_low = false;
 		break;
 	case 0x10ec0215:
 	case 0x10ec0245:
@@ -10809,6 +10812,7 @@ enum {
 	ALC897_FIXUP_HP_HSMIC_VERB,
 	ALC897_FIXUP_LENOVO_HEADSET_MODE,
 	ALC897_FIXUP_HEADSET_MIC_PIN2,
+	ALC897_FIXUP_UNIS_H3C_X500S,
 };
 
 static const struct hda_fixup alc662_fixups[] = {
@@ -11248,6 +11252,13 @@ static const struct hda_fixup alc662_fixups[] = {
 		.chained = true,
 		.chain_id = ALC897_FIXUP_LENOVO_HEADSET_MODE
 	},
+	[ALC897_FIXUP_UNIS_H3C_X500S] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			{ 0x14, AC_VERB_SET_EAPD_BTLENABLE, 0 },
+			{}
+		},
+	},
 };
 
 static const struct snd_pci_quirk alc662_fixup_tbl[] = {
@@ -11409,6 +11420,7 @@ static const struct hda_model_fixup alc662_fixup_models[] = {
 	{.id = ALC662_FIXUP_USI_HEADSET_MODE, .name = "usi-headset"},
 	{.id = ALC662_FIXUP_LENOVO_MULTI_CODECS, .name = "dual-codecs"},
 	{.id = ALC669_FIXUP_ACER_ASPIRE_ETHOS, .name = "aspire-ethos"},
+	{.id = ALC897_FIXUP_UNIS_H3C_X500S, .name = "unis-h3c-x500s"},
 	{}
 };
 
diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index e59323fd5bf2..5e00aca0c418 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -4472,6 +4472,8 @@ static void rt5665_remove(struct snd_soc_component *component)
 	struct rt5665_priv *rt5665 = snd_soc_component_get_drvdata(component);
 
 	regmap_write(rt5665->regmap, RT5665_RESET, 0);
+
+	regulator_bulk_disable(ARRAY_SIZE(rt5665->supplies), rt5665->supplies);
 }
 
 #ifdef CONFIG_PM
diff --git a/sound/soc/meson/axg-tdm-formatter.c b/sound/soc/meson/axg-tdm-formatter.c
index cab7fa2851aa..4834cfd163c0 100644
--- a/sound/soc/meson/axg-tdm-formatter.c
+++ b/sound/soc/meson/axg-tdm-formatter.c
@@ -30,27 +30,32 @@ int axg_tdm_formatter_set_channel_masks(struct regmap *map,
 					struct axg_tdm_stream *ts,
 					unsigned int offset)
 {
-	unsigned int val, ch = ts->channels;
-	unsigned long mask;
-	int i, j;
+	unsigned int ch = ts->channels;
+	u32 val[AXG_TDM_NUM_LANES];
+	int i, j, k;
+
+	/*
+	 * We need to mimick the slot distribution used by the HW to keep the
+	 * channel placement consistent regardless of the number of channel
+	 * in the stream. This is why the odd algorithm below is used.
+	 */
+	memset(val, 0, sizeof(*val) * AXG_TDM_NUM_LANES);
 
 	/*
 	 * Distribute the channels of the stream over the available slots
-	 * of each TDM lane
+	 * of each TDM lane. We need to go over the 32 slots ...
 	 */
-	for (i = 0; i < AXG_TDM_NUM_LANES; i++) {
-		val = 0;
-		mask = ts->mask[i];
-
-		for (j = find_first_bit(&mask, 32);
-		     (j < 32) && ch;
-		     j = find_next_bit(&mask, 32, j + 1)) {
-			val |= 1 << j;
-			ch -= 1;
+	for (i = 0; (i < 32) && ch; i += 2) {
+		/* ... of all the lanes ... */
+		for (j = 0; j < AXG_TDM_NUM_LANES; j++) {
+			/* ... then distribute the channels in pairs */
+			for (k = 0; k < 2; k++) {
+				if ((BIT(i + k) & ts->mask[j]) && ch) {
+					val[j] |= BIT(i + k);
+					ch -= 1;
+				}
+			}
 		}
-
-		regmap_write(map, offset, val);
-		offset += regmap_get_reg_stride(map);
 	}
 
 	/*
@@ -63,6 +68,11 @@ int axg_tdm_formatter_set_channel_masks(struct regmap *map,
 		return -EINVAL;
 	}
 
+	for (i = 0; i < AXG_TDM_NUM_LANES; i++) {
+		regmap_write(map, offset, val[i]);
+		offset += regmap_get_reg_stride(map);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(axg_tdm_formatter_set_channel_masks);
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 35cbef171f4a..038d09f6203a 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -1040,12 +1040,22 @@ static int hda_generic_machine_select(struct snd_sof_dev *sdev)
 			pdata->machine = hda_mach;
 			pdata->tplg_filename = tplg_filename;
 
-			if (codec_num == 2) {
+			if (codec_num == 2 ||
+			    (codec_num == 1 && !HDA_IDISP_CODEC(bus->codec_mask))) {
 				/*
 				 * Prevent SoundWire links from starting when an external
 				 * HDaudio codec is used
 				 */
 				hda_mach->mach_params.link_mask = 0;
+			} else {
+				/*
+				 * Allow SoundWire links to start when no external HDaudio codec
+				 * was detected. This will not create a SoundWire card but
+				 * will help detect if any SoundWire codec reports as ATTACHED.
+				 */
+				struct sof_intel_hda_dev *hdev = sdev->pdata->hw_pdata;
+
+				hda_mach->mach_params.link_mask = hdev->info.link_mask;
 			}
 		}
 	}
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index efe62f19c4d2..6d332c9eb444 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -4431,6 +4431,35 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		}
 	}
 },
+{
+	/* Advanced modes of the Mythware XA001AU.
+	 * For the standard mode, Mythware XA001AU has ID ffad:a001
+	 */
+	USB_DEVICE_VENDOR_SPEC(0xffad, 0xa001),
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.vendor_name = "Mythware",
+		.product_name = "XA001AU",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = (const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 0,
+				.type = QUIRK_IGNORE_INTERFACE,
+			},
+			{
+				.ifnum = 1,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE,
+			},
+			{
+				.ifnum = 2,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE,
+			},
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},
 
 #undef USB_DEVICE_VENDOR_SPEC
 #undef USB_AUDIO_DEVICE
diff --git a/tools/include/linux/objtool.h b/tools/include/linux/objtool.h
index a2042c418686..51f5b24af834 100644
--- a/tools/include/linux/objtool.h
+++ b/tools/include/linux/objtool.h
@@ -71,6 +71,23 @@ struct unwind_hint {
 	static void __used __section(".discard.func_stack_frame_non_standard") \
 		*__func_stack_frame_non_standard_##func = func
 
+/*
+ * STACK_FRAME_NON_STANDARD_FP() is a frame-pointer-specific function ignore
+ * for the case where a function is intentionally missing frame pointer setup,
+ * but otherwise needs objtool/ORC coverage when frame pointers are disabled.
+ */
+#ifdef CONFIG_FRAME_POINTER
+#define STACK_FRAME_NON_STANDARD_FP(func) STACK_FRAME_NON_STANDARD(func)
+#else
+#define STACK_FRAME_NON_STANDARD_FP(func)
+#endif
+
+#define ANNOTATE_NOENDBR					\
+	"986: \n\t"						\
+	".pushsection .discard.noendbr\n\t"			\
+	_ASM_PTR " 986b\n\t"					\
+	".popsection\n\t"
+
 #else /* __ASSEMBLY__ */
 
 /*
@@ -123,6 +140,13 @@ struct unwind_hint {
 	.popsection
 .endm
 
+.macro ANNOTATE_NOENDBR
+.Lhere_\@:
+	.pushsection .discard.noendbr
+	.quad	.Lhere_\@
+	.popsection
+.endm
+
 #endif /* __ASSEMBLY__ */
 
 #else /* !CONFIG_STACK_VALIDATION */
@@ -132,12 +156,16 @@ struct unwind_hint {
 #define UNWIND_HINT(sp_reg, sp_offset, type, end)	\
 	"\n\t"
 #define STACK_FRAME_NON_STANDARD(func)
+#define STACK_FRAME_NON_STANDARD_FP(func)
+#define ANNOTATE_NOENDBR
 #else
 #define ANNOTATE_INTRA_FUNCTION_CALL
 .macro UNWIND_HINT type:req sp_reg=0 sp_offset=0 end=0
 .endm
 .macro STACK_FRAME_NON_STANDARD func:req
 .endm
+.macro ANNOTATE_NOENDBR
+.endm
 #endif
 
 #endif /* CONFIG_STACK_VALIDATION */
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index cf8ea3594125..a9c5d54f1688 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -728,5 +728,5 @@ bool arch_is_rethunk(struct symbol *sym)
 	return !strcmp(sym->name, "__x86_return_thunk") ||
 	       !strcmp(sym->name, "srso_untrain_ret") ||
 	       !strcmp(sym->name, "srso_safe_ret") ||
-	       !strcmp(sym->name, "__ret");
+	       !strcmp(sym->name, "retbleed_return_thunk");
 }
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f331780f0425..f9ff878d6ba1 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -370,7 +370,7 @@ static int decode_instructions(struct objtool_file *file)
 
 		if (!strcmp(sec->name, ".noinstr.text") ||
 		    !strcmp(sec->name, ".entry.text") ||
-		    !strncmp(sec->name, ".text.__x86.", 12))
+		    !strncmp(sec->name, ".text..__x86.", 13))
 			sec->noinstr = true;
 
 		for (offset = 0; offset < sec->sh.sh_size; offset += insn->len) {
@@ -1228,7 +1228,7 @@ static int add_jump_destinations(struct objtool_file *file)
 				continue;
 
 			/*
-			 * This is a special case for zen_untrain_ret().
+			 * This is a special case for retbleed_untrain_ret().
 			 * It jumps to __x86_return_thunk(), but objtool
 			 * can't find the thunk's starting RET
 			 * instruction, because the RET is also in the
@@ -2174,12 +2174,17 @@ static int decode_sections(struct objtool_file *file)
 	return 0;
 }
 
-static bool is_fentry_call(struct instruction *insn)
+static bool is_special_call(struct instruction *insn)
 {
-	if (insn->type == INSN_CALL &&
-	    insn->call_dest &&
-	    insn->call_dest->fentry)
-		return true;
+	if (insn->type == INSN_CALL) {
+		struct symbol *dest = insn->call_dest;
+
+		if (!dest)
+			return false;
+
+		if (dest->fentry)
+			return true;
+	}
 
 	return false;
 }
@@ -3125,7 +3130,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			if (ret)
 				return ret;
 
-			if (!no_fp && func && !is_fentry_call(insn) &&
+			if (!no_fp && func && !is_special_call(insn) &&
 			    !has_valid_stack_frame(&state)) {
 				WARN_FUNC("call without frame pointer save/setup",
 					  sec, insn->offset);
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh b/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
index 472bd023e2a5..b501b366367f 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
@@ -72,7 +72,8 @@ test_span_gre_ttl()
 
 	RET=0
 
-	mirror_install $swp1 ingress $tundev "matchall $tcflags"
+	mirror_install $swp1 ingress $tundev \
+		"prot ip flower $tcflags ip_prot icmp"
 	tc filter add dev $h3 ingress pref 77 prot $prot \
 		flower ip_ttl 50 action pass
 
diff --git a/tools/testing/selftests/net/forwarding/tc_actions.sh b/tools/testing/selftests/net/forwarding/tc_actions.sh
index 1e27031288c8..dd02ed4cacac 100755
--- a/tools/testing/selftests/net/forwarding/tc_actions.sh
+++ b/tools/testing/selftests/net/forwarding/tc_actions.sh
@@ -8,6 +8,8 @@ NUM_NETIFS=4
 source tc_common.sh
 source lib.sh
 
+require_command ncat
+
 tcflags="skip_hw"
 
 h1_create()
@@ -155,10 +157,10 @@ gact_trap_test()
 
 mirred_egress_to_ingress_tcp_test()
 {
-	local tmpfile=$(mktemp) tmpfile1=$(mktemp)
+	mirred_e2i_tf1=$(mktemp) mirred_e2i_tf2=$(mktemp)
 
 	RET=0
-	dd conv=sparse status=none if=/dev/zero bs=1M count=2 of=$tmpfile
+	dd conv=sparse status=none if=/dev/zero bs=1M count=2 of=$mirred_e2i_tf1
 	tc filter add dev $h1 protocol ip pref 100 handle 100 egress flower \
 		$tcflags ip_proto tcp src_ip 192.0.2.1 dst_ip 192.0.2.2 \
 			action ct commit nat src addr 192.0.2.2 pipe \
@@ -174,11 +176,11 @@ mirred_egress_to_ingress_tcp_test()
 		ip_proto icmp \
 			action drop
 
-	ip vrf exec v$h1 nc --recv-only -w10 -l -p 12345 -o $tmpfile1  &
+	ip vrf exec v$h1 ncat --recv-only -w10 -l -p 12345 -o $mirred_e2i_tf2 &
 	local rpid=$!
-	ip vrf exec v$h1 nc -w1 --send-only 192.0.2.2 12345 <$tmpfile
+	ip vrf exec v$h1 ncat -w1 --send-only 192.0.2.2 12345 <$mirred_e2i_tf1
 	wait -n $rpid
-	cmp -s $tmpfile $tmpfile1
+	cmp -s $mirred_e2i_tf1 $mirred_e2i_tf2
 	check_err $? "server output check failed"
 
 	$MZ $h1 -c 10 -p 64 -a $h1mac -b $h1mac -A 192.0.2.1 -B 192.0.2.1 \
@@ -195,7 +197,7 @@ mirred_egress_to_ingress_tcp_test()
 	tc filter del dev $h1 egress protocol ip pref 101 handle 101 flower
 	tc filter del dev $h1 ingress protocol ip pref 102 handle 102 flower
 
-	rm -f $tmpfile $tmpfile1
+	rm -f $mirred_e2i_tf1 $mirred_e2i_tf2
 	log_test "mirred_egress_to_ingress_tcp ($tcflags)"
 }
 
@@ -224,6 +226,8 @@ setup_prepare()
 
 cleanup()
 {
+	local tf
+
 	pre_cleanup
 
 	switch_destroy
@@ -234,6 +238,8 @@ cleanup()
 
 	ip link set $swp2 address $swp2origmac
 	ip link set $swp1 address $swp1origmac
+
+	for tf in $mirred_e2i_tf1 $mirred_e2i_tf2; do rm -f $tf; done
 }
 
 mirred_egress_redirect_test()
