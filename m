Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5377813B0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 21:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379782AbjHRTnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 15:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379995AbjHRTmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 15:42:43 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B184EC2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 12:42:15 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bc0d39b52cso10026735ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 12:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1692387717; x=1692992517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7ci3vRgnbD84Ma3Cd7Iy4r3YW2QkAQDRD/x7G43pvo=;
        b=mLjEfWfHxV6EWgtjuOIdXGiCk0CxBcgLlxvHzccBkXv1GzhWZw1Q4ewVvEmU2l3OcG
         cD9n2thRWSFyKP5X0wkIlrrzaC/gv2tR1CTk5bkVva4fBeB+g+T8IpqAY4oh7NOOhG5n
         ZYtJQMqA++p4ETovq8zdGVbAbxtXZd4IvlNCGEt5lyR66oxPWBFhhXYPt2ntDNJ6zeWM
         XlsLH8c/kaoagbty1twx7B49JQ4C8wY7kZre/1wyT/9b7seaoim/O6UGltFtkQ8SOsYm
         tA6UHncCk2rll4CfcGsr89De9DLEE4fv9SPekm6e4W2UC+IT8kauHnrI22EmIAtWzKJO
         XOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692387717; x=1692992517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7ci3vRgnbD84Ma3Cd7Iy4r3YW2QkAQDRD/x7G43pvo=;
        b=XbBZ8OhcJyToG/YFvJUQe89JfDXLEQmQjksEid062cf3A1MYdCmHqICLljjHpni6FX
         kMrPm0GQcqb/VG6DmaKH1BvBhPiittJRyEFOmZubn0oGlfwI3XznfsyjFOfmQjkciz7j
         fWiM8sAocC6vNkSsXzC1RE6F1ZS9VsgK53mrCvghMFZrzp+1aX58Nmp52yYDU27055TR
         QgfyIkrpVtcFb0OFV3gqq7p4Z+yC2J5SLUme7Bpijp7292XG4cd+3/W/A80kvTVAbXgv
         kVYyx6p1w+gBBJfUu0RMI7o9g9xnKVScA/Ajl6NKHft35GvbmwxuPeG0+nE//1dlkxmX
         xUuQ==
X-Gm-Message-State: AOJu0YwJJTi6AZUmXD9Toxt7noAVoqi/bgPr5QEI8SPNWVzVoOkK/tCD
        TyQuetOUJDzEq6NPlZ8iFf/rRw==
X-Google-Smtp-Source: AGHT+IEO9oSVM/2424l6Met4cdx+Cq/LzfIkxlp0PfobX+jsrm1D8PqmNz92EVefC1RybqCebE1VlA==
X-Received: by 2002:a17:902:ab0e:b0:1bc:382b:6897 with SMTP id ik14-20020a170902ab0e00b001bc382b6897mr183904plb.13.1692387717021;
        Fri, 18 Aug 2023 12:41:57 -0700 (PDT)
Received: from evan.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id j10-20020a170902da8a00b001a5fccab02dsm2126614plx.177.2023.08.18.12.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 12:41:56 -0700 (PDT)
From:   Evan Green <evan@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Simon Hosie <shosie@rivosinc.com>,
        Evan Green <evan@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Samuel Holland <samuel@sholland.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v4 2/2] RISC-V: alternative: Remove feature_probe_func
Date:   Fri, 18 Aug 2023 12:41:36 -0700
Message-Id: <20230818194136.4084400-3-evan@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818194136.4084400-1-evan@rivosinc.com>
References: <20230818194136.4084400-1-evan@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we're testing unaligned memory copy and making that
determination generically, there are no more users of the vendor
feature_probe_func(). While I think it's probably going to need to come
back, there are no users right now, so let's remove it until it's
needed.

Signed-off-by: Evan Green <evan@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

---

(no changes since v1)

 arch/riscv/errata/thead/errata.c     |  8 --------
 arch/riscv/include/asm/alternative.h |  5 -----
 arch/riscv/kernel/alternative.c      | 19 -------------------
 arch/riscv/kernel/smpboot.c          |  1 -
 4 files changed, 33 deletions(-)

diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index be84b14f0118..0554ed4bf087 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -120,11 +120,3 @@ void thead_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
 	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
 		local_flush_icache_all();
 }
-
-void thead_feature_probe_func(unsigned int cpu,
-			      unsigned long archid,
-			      unsigned long impid)
-{
-	if ((archid == 0) && (impid == 0))
-		per_cpu(misaligned_access_speed, cpu) = RISCV_HWPROBE_MISALIGNED_FAST;
-}
diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/include/asm/alternative.h
index 6a41537826a7..58ccd2f8cab7 100644
--- a/arch/riscv/include/asm/alternative.h
+++ b/arch/riscv/include/asm/alternative.h
@@ -30,7 +30,6 @@
 #define ALT_OLD_PTR(a)			__ALT_PTR(a, old_offset)
 #define ALT_ALT_PTR(a)			__ALT_PTR(a, alt_offset)
 
-void probe_vendor_features(unsigned int cpu);
 void __init apply_boot_alternatives(void);
 void __init apply_early_boot_alternatives(void);
 void apply_module_alternatives(void *start, size_t length);
@@ -53,15 +52,11 @@ void thead_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
 			     unsigned long archid, unsigned long impid,
 			     unsigned int stage);
 
-void thead_feature_probe_func(unsigned int cpu, unsigned long archid,
-			      unsigned long impid);
-
 void riscv_cpufeature_patch_func(struct alt_entry *begin, struct alt_entry *end,
 				 unsigned int stage);
 
 #else /* CONFIG_RISCV_ALTERNATIVE */
 
-static inline void probe_vendor_features(unsigned int cpu) { }
 static inline void apply_boot_alternatives(void) { }
 static inline void apply_early_boot_alternatives(void) { }
 static inline void apply_module_alternatives(void *start, size_t length) { }
diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
index 6b75788c18e6..85056153fa23 100644
--- a/arch/riscv/kernel/alternative.c
+++ b/arch/riscv/kernel/alternative.c
@@ -27,8 +27,6 @@ struct cpu_manufacturer_info_t {
 	void (*patch_func)(struct alt_entry *begin, struct alt_entry *end,
 				  unsigned long archid, unsigned long impid,
 				  unsigned int stage);
-	void (*feature_probe_func)(unsigned int cpu, unsigned long archid,
-				   unsigned long impid);
 };
 
 static void riscv_fill_cpu_mfr_info(struct cpu_manufacturer_info_t *cpu_mfr_info)
@@ -43,7 +41,6 @@ static void riscv_fill_cpu_mfr_info(struct cpu_manufacturer_info_t *cpu_mfr_info
 	cpu_mfr_info->imp_id = sbi_get_mimpid();
 #endif
 
-	cpu_mfr_info->feature_probe_func = NULL;
 	switch (cpu_mfr_info->vendor_id) {
 #ifdef CONFIG_ERRATA_SIFIVE
 	case SIFIVE_VENDOR_ID:
@@ -53,7 +50,6 @@ static void riscv_fill_cpu_mfr_info(struct cpu_manufacturer_info_t *cpu_mfr_info
 #ifdef CONFIG_ERRATA_THEAD
 	case THEAD_VENDOR_ID:
 		cpu_mfr_info->patch_func = thead_errata_patch_func;
-		cpu_mfr_info->feature_probe_func = thead_feature_probe_func;
 		break;
 #endif
 	default:
@@ -143,20 +139,6 @@ void riscv_alternative_fix_offsets(void *alt_ptr, unsigned int len,
 	}
 }
 
-/* Called on each CPU as it starts */
-void probe_vendor_features(unsigned int cpu)
-{
-	struct cpu_manufacturer_info_t cpu_mfr_info;
-
-	riscv_fill_cpu_mfr_info(&cpu_mfr_info);
-	if (!cpu_mfr_info.feature_probe_func)
-		return;
-
-	cpu_mfr_info.feature_probe_func(cpu,
-					cpu_mfr_info.arch_id,
-					cpu_mfr_info.imp_id);
-}
-
 /*
  * This is called very early in the boot process (directly after we run
  * a feature detect on the boot CPU). No need to worry about other CPUs
@@ -211,7 +193,6 @@ void __init apply_boot_alternatives(void)
 	/* If called on non-boot cpu things could go wrong */
 	WARN_ON(smp_processor_id() != 0);
 
-	probe_vendor_features(0);
 	_apply_alternatives((struct alt_entry *)__alt_start,
 			    (struct alt_entry *)__alt_end,
 			    RISCV_ALTERNATIVES_BOOT);
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 00ddbd2364dc..1b8da4e40a4d 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -247,7 +247,6 @@ asmlinkage __visible void smp_callin(void)
 	numa_add_cpu(curr_cpuid);
 	set_cpu_online(curr_cpuid, 1);
 	check_unaligned_access(curr_cpuid);
-	probe_vendor_features(curr_cpuid);
 
 	if (has_vector()) {
 		if (riscv_v_setup_vsize())
-- 
2.34.1

