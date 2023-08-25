Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7B0788F5D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 21:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjHYTsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 15:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjHYTsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 15:48:02 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AA42698
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 12:47:57 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68bed286169so1181564b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 12:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692992877; x=1693597677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRCZqfcIoPdjWycDLHPr9pRRfllmQvXWDcXX249Q0Rk=;
        b=eiVi6GUEjvcqj+2SlX8CkBk72qfjyCdowr9WAGoYR1YfPMBnZ5fJIC0gMFLQE5jFe/
         AZ64CnGR/sdsXFGGhrwjCJbioUqYAIlYZK3lNa48Qa4AK5dSvv4LDvWDFBhDfKVkgwMF
         tTV0VlQElY/FlpFt/rNgUwiGoOsy01MqJ/2bI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692992877; x=1693597677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRCZqfcIoPdjWycDLHPr9pRRfllmQvXWDcXX249Q0Rk=;
        b=lwi+MgRdIdvRm0EJXWYOK9MWb+PgKo9epPAHPYQRvqefKN9zjzAw2gll7qx+Q55G1y
         bV2uELPEzGIBaMgahrkdQP42mJ7QgV8pQdleyO84TtCXB+7jcQ+fwwUCT7FZych/puUd
         ewZ4E9x2nMx/SMc03P6SHqSYv6mgQXRHIbkZePt7yXFB8/1GXi/cRODxfd3gl7p1TlWb
         LLU2kWyPSow/60tRrQNp9jslgPivQPI8NItxIWBELvD/OTRcKAh9xH6j54H9BKbRsg/r
         VRD/9t0YG7Rno9EP/GvBWtZHdRGgLNtdl+Za6jQfrVbxbT4MqdlPgKRhuBQZi3Z5E/Fz
         VKsw==
X-Gm-Message-State: AOJu0YxJkWTxCoHb31soBusTC5TXaJpmf/zt7B+78G66Q8GLTCrrsBW7
        A1GWvB61lF3+2zxpvgeisxFb5/Vvkb+d42tbFJo=
X-Google-Smtp-Source: AGHT+IFSKug2EyO8CyjKx150dEE+7lb0gZsL7hrHvDAEvCps+/PY9kVg2rcZA4wm+qgMnv7ZCnmkGw==
X-Received: by 2002:a05:6a20:1441:b0:148:656b:9a1f with SMTP id a1-20020a056a20144100b00148656b9a1fmr23652914pzi.20.1692992877130;
        Fri, 25 Aug 2023 12:47:57 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x2-20020aa79182000000b00689e01ae8fcsm1926428pfa.206.2023.08.25.12.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 12:47:56 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kbuild@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 2/2] kbuild: Split internal config targets from .config into .fragment
Date:   Fri, 25 Aug 2023 12:47:53 -0700
Message-Id: <20230825194755.854823-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825194329.gonna.911-kees@kernel.org>
References: <20230825194329.gonna.911-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13600; i=keescook@chromium.org;
 h=from:subject; bh=WsGA2w70Z2jH6+E3FM9RqepsW5TMIoqDQO9WuzRD4IM=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk6QVpiPplcGybCpBXAOFBqTWSKZQd6b83G7SmR
 btUuusJB1KJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZOkFaQAKCRCJcvTf3G3A
 JtTQD/90/3TwiNJbod0/y+IQ3nFFarC3ro5zIc+s35NoFbhu/aboq+1GVWEGGXbEGyAwt/qDPdA
 EHOlaIDxIfZPLUTE4cnLHonEtEsWM+cvimQqDR8Ywcj98v7LVqyvAEmnbZNuCvaYdTIWDPCYJA7
 h/gdMQB4JuNgWy4kO06uWAwo5GUMrbghrLw9tzjy84Ywu4XclD1G+V9NOqvCAbzWQs95Te1o1eo
 bRt1GUpvfEVRq3hPvLZv/4njLwoHbvH6J7NlKAKU55LJFwGozNPdpE207mxM9N/VDcIrQpSegL4
 IpS87nenP2ZjHdVMX6OTHs5EzHRCICVK9NHbN8G61TX+ZwBlcdCwouYsdFMWRk8b6Tu6D9Ia6M7
 ZFK+HRaBeSmc1ds5LcVzwkVyazBvLlXsY7a+NkY1iKPhELinscjs46IeZkEvXtxbLOsVOND76o/
 SrQgPbGTLbMA0YIy/u7fxKwgAaHm3NxonjdVAqunkWTPSBn5I2kjdup0hkBFOl8vyI+p8F2HK9q
 FP73oUvIvq28fwCK5LAzNU8stFHKahUHQAdNm8BgHKBr3cM828AvZmqv8BCLRVuXRrvefjHhgpT
 Vy0dIafA7356d0vg1gp1Pxeakm+m1daIloarMPBWgpvWvKasYnV1wlANJHGPkNiL7psV6Llzxgv QjnNcERunEHTZag==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many Kconfig fragments are being used internally to construct hard-coded
targets and shouldn't be reachable directly through the build system.
Splitting these out also means that the "help" target can display only
the "complete" .config targets intended for general use. This is
especially useful for powerpc where most of the arch fragments aren't
intended to be consumed individually.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: x86@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kbuild@vger.kernel.org
Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/powerpc/Makefile                         | 26 +++++++++----------
 .../{32-bit.config => 32-bit.fragment}        |  0
 .../{64-bit.config => 64-bit.fragment}        |  0
 ...{85xx-32bit.config => 85xx-32bit.fragment} |  0
 ...{85xx-64bit.config => 85xx-64bit.fragment} |  0
 .../{85xx-hw.config => 85xx-hw.fragment}      |  0
 .../{85xx-smp.config => 85xx-smp.fragment}    |  0
 .../{86xx-hw.config => 86xx-hw.fragment}      |  0
 .../{86xx-smp.config => 86xx-smp.fragment}    |  0
 .../{altivec.config => altivec.fragment}      |  0
 .../configs/{be.config => be.fragment}        |  0
 .../{book3s_32.config => book3s_32.fragment}  |  0
 ...enet_base.config => corenet_base.fragment} |  0
 .../configs/{dpaa.config => dpaa.fragment}    |  0
 ...mb-nonhw.config => fsl-emb-nonhw.fragment} |  0
 .../configs/{guest.config => guest.fragment}  |  0
 .../configs/{le.config => le.fragment}        |  0
 ...85xx_base.config => mpc85xx_base.fragment} |  0
 ...86xx_base.config => mpc86xx_base.fragment} |  0
 .../{ppc64le.config => ppc64le.fragment}      |  0
 {kernel => arch/x86}/configs/x86_debug.config |  0
 .../{tiny-base.config => tiny-base.fragment}  |  0
 scripts/Makefile.defconf                      | 12 ++++++---
 scripts/kconfig/Makefile                      |  2 +-
 24 files changed, 22 insertions(+), 18 deletions(-)
 rename arch/powerpc/configs/{32-bit.config => 32-bit.fragment} (100%)
 rename arch/powerpc/configs/{64-bit.config => 64-bit.fragment} (100%)
 rename arch/powerpc/configs/{85xx-32bit.config => 85xx-32bit.fragment} (100%)
 rename arch/powerpc/configs/{85xx-64bit.config => 85xx-64bit.fragment} (100%)
 rename arch/powerpc/configs/{85xx-hw.config => 85xx-hw.fragment} (100%)
 rename arch/powerpc/configs/{85xx-smp.config => 85xx-smp.fragment} (100%)
 rename arch/powerpc/configs/{86xx-hw.config => 86xx-hw.fragment} (100%)
 rename arch/powerpc/configs/{86xx-smp.config => 86xx-smp.fragment} (100%)
 rename arch/powerpc/configs/{altivec.config => altivec.fragment} (100%)
 rename arch/powerpc/configs/{be.config => be.fragment} (100%)
 rename arch/powerpc/configs/{book3s_32.config => book3s_32.fragment} (100%)
 rename arch/powerpc/configs/{corenet_base.config => corenet_base.fragment} (100%)
 rename arch/powerpc/configs/{dpaa.config => dpaa.fragment} (100%)
 rename arch/powerpc/configs/{fsl-emb-nonhw.config => fsl-emb-nonhw.fragment} (100%)
 rename arch/powerpc/configs/{guest.config => guest.fragment} (100%)
 rename arch/powerpc/configs/{le.config => le.fragment} (100%)
 rename arch/powerpc/configs/{mpc85xx_base.config => mpc85xx_base.fragment} (100%)
 rename arch/powerpc/configs/{mpc86xx_base.config => mpc86xx_base.fragment} (100%)
 rename arch/powerpc/configs/{ppc64le.config => ppc64le.fragment} (100%)
 rename {kernel => arch/x86}/configs/x86_debug.config (100%)
 rename kernel/configs/{tiny-base.config => tiny-base.fragment} (100%)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index dac7ca153886..b73f2b40a0bc 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -267,66 +267,66 @@ powernv_be_defconfig:
 
 generated_configs += mpc85xx_defconfig
 mpc85xx_defconfig:
-	$(call merge_into_defconfig,mpc85xx_base.config,\
+	$(call merge_into_defconfig,mpc85xx_base.fragment,\
 		85xx-32bit 85xx-hw fsl-emb-nonhw)
 
 generated_configs += mpc85xx_smp_defconfig
 mpc85xx_smp_defconfig:
-	$(call merge_into_defconfig,mpc85xx_base.config,\
+	$(call merge_into_defconfig,mpc85xx_base.fragment,\
 		85xx-32bit 85xx-smp 85xx-hw fsl-emb-nonhw)
 
 generated_configs += corenet32_smp_defconfig
 corenet32_smp_defconfig:
-	$(call merge_into_defconfig,corenet_base.config,\
+	$(call merge_into_defconfig,corenet_base.fragment,\
 		85xx-32bit 85xx-smp 85xx-hw fsl-emb-nonhw dpaa)
 
 generated_configs += corenet64_smp_defconfig
 corenet64_smp_defconfig:
-	$(call merge_into_defconfig,corenet_base.config,\
+	$(call merge_into_defconfig,corenet_base.fragment,\
 		85xx-64bit 85xx-smp altivec 85xx-hw fsl-emb-nonhw dpaa)
 
 generated_configs += mpc86xx_defconfig
 mpc86xx_defconfig:
-	$(call merge_into_defconfig,mpc86xx_base.config,\
+	$(call merge_into_defconfig,mpc86xx_base.fragment,\
 		86xx-hw fsl-emb-nonhw)
 
 generated_configs += mpc86xx_smp_defconfig
 mpc86xx_smp_defconfig:
-	$(call merge_into_defconfig,mpc86xx_base.config,\
+	$(call merge_into_defconfig,mpc86xx_base.fragment,\
 		86xx-smp 86xx-hw fsl-emb-nonhw)
 
 generated_configs += ppc32_allmodconfig
 ppc32_allmodconfig:
-	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/book3s_32.config \
+	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/book3s_32.fragment \
 		-f $(srctree)/Makefile allmodconfig
 
 generated_configs += ppc_defconfig
 ppc_defconfig:
-	$(call merge_into_defconfig,book3s_32.config,)
+	$(call merge_into_defconfig,book3s_32.fragment,)
 
 generated_configs += ppc64le_allmodconfig
 ppc64le_allmodconfig:
-	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/le.config \
+	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/le.fragment \
 		-f $(srctree)/Makefile allmodconfig
 
 generated_configs += ppc64le_allnoconfig
 ppc64le_allnoconfig:
-	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/ppc64le.config \
+	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/ppc64le.fragment \
 		-f $(srctree)/Makefile allnoconfig
 
 generated_configs += ppc64_book3e_allmodconfig
 ppc64_book3e_allmodconfig:
-	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/85xx-64bit.config \
+	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/85xx-64bit.fragment \
 		-f $(srctree)/Makefile allmodconfig
 
 generated_configs += ppc32_randconfig
 ppc32_randconfig:
-	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/32-bit.config \
+	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/32-bit.fragment \
 		-f $(srctree)/Makefile randconfig
 
 generated_configs += ppc64_randconfig
 ppc64_randconfig:
-	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/64-bit.config \
+	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/64-bit.fragment \
 		-f $(srctree)/Makefile randconfig
 
 PHONY += $(generated_configs)
diff --git a/arch/powerpc/configs/32-bit.config b/arch/powerpc/configs/32-bit.fragment
similarity index 100%
rename from arch/powerpc/configs/32-bit.config
rename to arch/powerpc/configs/32-bit.fragment
diff --git a/arch/powerpc/configs/64-bit.config b/arch/powerpc/configs/64-bit.fragment
similarity index 100%
rename from arch/powerpc/configs/64-bit.config
rename to arch/powerpc/configs/64-bit.fragment
diff --git a/arch/powerpc/configs/85xx-32bit.config b/arch/powerpc/configs/85xx-32bit.fragment
similarity index 100%
rename from arch/powerpc/configs/85xx-32bit.config
rename to arch/powerpc/configs/85xx-32bit.fragment
diff --git a/arch/powerpc/configs/85xx-64bit.config b/arch/powerpc/configs/85xx-64bit.fragment
similarity index 100%
rename from arch/powerpc/configs/85xx-64bit.config
rename to arch/powerpc/configs/85xx-64bit.fragment
diff --git a/arch/powerpc/configs/85xx-hw.config b/arch/powerpc/configs/85xx-hw.fragment
similarity index 100%
rename from arch/powerpc/configs/85xx-hw.config
rename to arch/powerpc/configs/85xx-hw.fragment
diff --git a/arch/powerpc/configs/85xx-smp.config b/arch/powerpc/configs/85xx-smp.fragment
similarity index 100%
rename from arch/powerpc/configs/85xx-smp.config
rename to arch/powerpc/configs/85xx-smp.fragment
diff --git a/arch/powerpc/configs/86xx-hw.config b/arch/powerpc/configs/86xx-hw.fragment
similarity index 100%
rename from arch/powerpc/configs/86xx-hw.config
rename to arch/powerpc/configs/86xx-hw.fragment
diff --git a/arch/powerpc/configs/86xx-smp.config b/arch/powerpc/configs/86xx-smp.fragment
similarity index 100%
rename from arch/powerpc/configs/86xx-smp.config
rename to arch/powerpc/configs/86xx-smp.fragment
diff --git a/arch/powerpc/configs/altivec.config b/arch/powerpc/configs/altivec.fragment
similarity index 100%
rename from arch/powerpc/configs/altivec.config
rename to arch/powerpc/configs/altivec.fragment
diff --git a/arch/powerpc/configs/be.config b/arch/powerpc/configs/be.fragment
similarity index 100%
rename from arch/powerpc/configs/be.config
rename to arch/powerpc/configs/be.fragment
diff --git a/arch/powerpc/configs/book3s_32.config b/arch/powerpc/configs/book3s_32.fragment
similarity index 100%
rename from arch/powerpc/configs/book3s_32.config
rename to arch/powerpc/configs/book3s_32.fragment
diff --git a/arch/powerpc/configs/corenet_base.config b/arch/powerpc/configs/corenet_base.fragment
similarity index 100%
rename from arch/powerpc/configs/corenet_base.config
rename to arch/powerpc/configs/corenet_base.fragment
diff --git a/arch/powerpc/configs/dpaa.config b/arch/powerpc/configs/dpaa.fragment
similarity index 100%
rename from arch/powerpc/configs/dpaa.config
rename to arch/powerpc/configs/dpaa.fragment
diff --git a/arch/powerpc/configs/fsl-emb-nonhw.config b/arch/powerpc/configs/fsl-emb-nonhw.fragment
similarity index 100%
rename from arch/powerpc/configs/fsl-emb-nonhw.config
rename to arch/powerpc/configs/fsl-emb-nonhw.fragment
diff --git a/arch/powerpc/configs/guest.config b/arch/powerpc/configs/guest.fragment
similarity index 100%
rename from arch/powerpc/configs/guest.config
rename to arch/powerpc/configs/guest.fragment
diff --git a/arch/powerpc/configs/le.config b/arch/powerpc/configs/le.fragment
similarity index 100%
rename from arch/powerpc/configs/le.config
rename to arch/powerpc/configs/le.fragment
diff --git a/arch/powerpc/configs/mpc85xx_base.config b/arch/powerpc/configs/mpc85xx_base.fragment
similarity index 100%
rename from arch/powerpc/configs/mpc85xx_base.config
rename to arch/powerpc/configs/mpc85xx_base.fragment
diff --git a/arch/powerpc/configs/mpc86xx_base.config b/arch/powerpc/configs/mpc86xx_base.fragment
similarity index 100%
rename from arch/powerpc/configs/mpc86xx_base.config
rename to arch/powerpc/configs/mpc86xx_base.fragment
diff --git a/arch/powerpc/configs/ppc64le.config b/arch/powerpc/configs/ppc64le.fragment
similarity index 100%
rename from arch/powerpc/configs/ppc64le.config
rename to arch/powerpc/configs/ppc64le.fragment
diff --git a/kernel/configs/x86_debug.config b/arch/x86/configs/x86_debug.config
similarity index 100%
rename from kernel/configs/x86_debug.config
rename to arch/x86/configs/x86_debug.config
diff --git a/kernel/configs/tiny-base.config b/kernel/configs/tiny-base.fragment
similarity index 100%
rename from kernel/configs/tiny-base.config
rename to kernel/configs/tiny-base.fragment
diff --git a/scripts/Makefile.defconf b/scripts/Makefile.defconf
index ab271b2051a2..46d0ecdda391 100644
--- a/scripts/Makefile.defconf
+++ b/scripts/Makefile.defconf
@@ -6,11 +6,13 @@
 # Usage:
 #   $(call merge_into_defconfig,base_config,config_fragment1 config_fragment2 ...)
 #
-# Input config fragments without '.config' suffix
+# Input config fragments without '.config' or '.fragment' suffix
 define merge_into_defconfig
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh \
 		-m -O $(objtree) $(srctree)/arch/$(ARCH)/configs/$(1) \
-		$(foreach config,$(2),$(srctree)/arch/$(ARCH)/configs/$(config).config)
+		$(foreach config,$(2), \
+			$(wildcard $(srctree)/arch/$(ARCH)/configs/$(config).config \
+				   $(srctree)/arch/$(ARCH)/configs/$(config).fragment))
 	+$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
 endef
 
@@ -20,10 +22,12 @@ endef
 # Usage:
 #   $(call merge_into_defconfig_override,base_config,config_fragment1 config_fragment2 ...)
 #
-# Input config fragments without '.config' suffix
+# Input config fragments without '.config' or '.fragment' suffix
 define merge_into_defconfig_override
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh \
 		-Q -m -O $(objtree) $(srctree)/arch/$(ARCH)/configs/$(1) \
-		$(foreach config,$(2),$(srctree)/arch/$(ARCH)/configs/$(config).config)
+		$(foreach config,$(2), \
+			$(wildcard $(srctree)/arch/$(ARCH)/configs/$(config).config \
+				   $(srctree)/arch/$(ARCH)/configs/$(config).fragment))
 	+$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
 endef
diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 370ff6bba78d..a03388eb735f 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -102,7 +102,7 @@ configfiles=$(wildcard $(srctree)/kernel/configs/$(1) $(srctree)/arch/$(SRCARCH)
 
 PHONY += tinyconfig
 tinyconfig:
-	$(Q)KCONFIG_ALLCONFIG=kernel/configs/tiny-base.config $(MAKE) -f $(srctree)/Makefile allnoconfig
+	$(Q)KCONFIG_ALLCONFIG=kernel/configs/tiny-base.fragment $(MAKE) -f $(srctree)/Makefile allnoconfig
 	$(Q)$(MAKE) -f $(srctree)/Makefile tiny.config
 
 # CHECK: -o cache_dir=<path> working?
-- 
2.34.1

