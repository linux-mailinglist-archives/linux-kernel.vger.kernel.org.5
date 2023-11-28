Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AE97FC26F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346267AbjK1OyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346273AbjK1OyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:54:07 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C23E1727
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:54:13 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cfabcbda7bso27290565ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701183252; x=1701788052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4m04trocO8QoZj3cdN/f9S82XI37vaZYUmcpO0zJtiU=;
        b=FTn2DSq4W55DeYgBXdD/FJPA0m6PQ1vWZOJGMmfkgZ/OoyT1lvbCjym8E2Fx2G1t12
         cW+CNH7L2zL4XKfQgm8Zbna4LjGZ2LlnN3w1untIKBmtuiFDECe1Z9ZNIf7o8lBQI9o4
         HTkbvBRDZs3OlsP8NpcQ8ClHkoAUyvH7z5ocz+hqEVgj77UdS7HkDhlEoydk79db3CR+
         r8gBGH9wz/poXsF++gCBJp/jV4uLI4uJOMy1kty2p6jRLtIMBWlht1yfHRlXaNMJSNUf
         TSnzSOWCidDEyZSghkic70RUS4MWTqKlStn08N7R7yJeZyIypvgVVf/9aPEDHl0NejKV
         Q4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183252; x=1701788052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4m04trocO8QoZj3cdN/f9S82XI37vaZYUmcpO0zJtiU=;
        b=wj9MmMIoMRBJ510xdSVgvltIE/rcqOp7mhcWXA1my2bbuc/GkS+Ons/9sXCjYUJ56A
         4zxXKDXDk7iGHYAjNSBYiYu8JYP2jI5tK+VIeQY8ZQ1XVKsx7RdkwA3lwXLLHmhq/Bbp
         0N9I+WbbklpAqeR2W0wVj3AU5b/Q9I7Oq1lh6yXdCMWniMBjOs2DAFsiCEY/dxcq/6f+
         CjSatVvIFbCnjCNYVAvz8v3dcZ24DMTvHZxj8/EL4ZTJ4O1Oopsv05xzYELlfTBQVXE+
         Cd6rQGkFXOv9+BHCsTWQT0nxR/kZbLcynk8WfItlE0Fem1i52fi2T9Owa84dwNWwEYvs
         8v2Q==
X-Gm-Message-State: AOJu0YySV9M2jGTb3PKnc4qqa1T+zdIHUOy4rWuIkPxKGB/5gOHtTlNI
        NviA0vWCDLqs8jHCEsA+dW2Xtw==
X-Google-Smtp-Source: AGHT+IGXuZ+iyvAlrX/pLnzURWVAdu7BmENdq5XZ42sO3dIOOkgu9oI2dJBaf36rifwZKEx33JRxYA==
X-Received: by 2002:a17:902:ce90:b0:1cf:d9b5:5aba with SMTP id f16-20020a170902ce9000b001cfd9b55abamr7712485plg.30.1701183252164;
        Tue, 28 Nov 2023 06:54:12 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b001bf11cf2e21sm10281552plg.210.2023.11.28.06.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:54:11 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Anup Patel <anup@brainfault.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 01/15] KVM: riscv: selftests: Generate ISA extension reg_list using macros
Date:   Tue, 28 Nov 2023 20:23:43 +0530
Message-Id: <20231128145357.413321-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128145357.413321-1-apatel@ventanamicro.com>
References: <20231128145357.413321-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various ISA extension reg_list have common pattern so let us generate
these using macros.

We define two macros for the above purpose:
1) KVM_ISA_EXT_SIMPLE_CONFIG - Macro to generate reg_list for
   ISA extension without any additional ONE_REG registers
2) KVM_ISA_EXT_SUBLIST_CONFIG - Macro to generate reg_list for
   ISA extension with additional ONE_REG registers

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 .../selftests/kvm/riscv/get-reg-list.c        | 331 ++++--------------
 1 file changed, 76 insertions(+), 255 deletions(-)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 6bedaea95395..b6b4b6d7dacd 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -581,10 +581,6 @@ static __u64 base_skips_set[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_RISCV_TIMER_REG(state),
 };
 
-static __u64 h_regs[] = {
-	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_H,
-};
-
 static __u64 zicbom_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CONFIG | KVM_REG_RISCV_CONFIG_REG(zicbom_block_size),
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICBOM,
@@ -595,54 +591,6 @@ static __u64 zicboz_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICBOZ,
 };
 
-static __u64 svpbmt_regs[] = {
-	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SVPBMT,
-};
-
-static __u64 sstc_regs[] = {
-	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SSTC,
-};
-
-static __u64 svinval_regs[] = {
-	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SVINVAL,
-};
-
-static __u64 zihintpause_regs[] = {
-	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIHINTPAUSE,
-};
-
-static __u64 zba_regs[] = {
-	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBA,
-};
-
-static __u64 zbb_regs[] = {
-	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBB,
-};
-
-static __u64 zbs_regs[] = {
-	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBS,
-};
-
-static __u64 zicntr_regs[] = {
-	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICNTR,
-};
-
-static __u64 zicond_regs[] = {
-	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICOND,
-};
-
-static __u64 zicsr_regs[] = {
-	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICSR,
-};
-
-static __u64 zifencei_regs[] = {
-	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIFENCEI,
-};
-
-static __u64 zihpm_regs[] = {
-	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIHPM,
-};
-
 static __u64 aia_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(siselect),
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio1),
@@ -733,221 +681,94 @@ static __u64 fp_d_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_D,
 };
 
-#define BASE_SUBLIST \
+#define SUBLIST_BASE \
 	{"base", .regs = base_regs, .regs_n = ARRAY_SIZE(base_regs), \
 	 .skips_set = base_skips_set, .skips_set_n = ARRAY_SIZE(base_skips_set),}
-#define H_REGS_SUBLIST \
-	{"h", .feature = KVM_RISCV_ISA_EXT_H, .regs = h_regs, .regs_n = ARRAY_SIZE(h_regs),}
-#define ZICBOM_REGS_SUBLIST \
+#define SUBLIST_ZICBOM \
 	{"zicbom", .feature = KVM_RISCV_ISA_EXT_ZICBOM, .regs = zicbom_regs, .regs_n = ARRAY_SIZE(zicbom_regs),}
-#define ZICBOZ_REGS_SUBLIST \
+#define SUBLIST_ZICBOZ \
 	{"zicboz", .feature = KVM_RISCV_ISA_EXT_ZICBOZ, .regs = zicboz_regs, .regs_n = ARRAY_SIZE(zicboz_regs),}
-#define SVPBMT_REGS_SUBLIST \
-	{"svpbmt", .feature = KVM_RISCV_ISA_EXT_SVPBMT, .regs = svpbmt_regs, .regs_n = ARRAY_SIZE(svpbmt_regs),}
-#define SSTC_REGS_SUBLIST \
-	{"sstc", .feature = KVM_RISCV_ISA_EXT_SSTC, .regs = sstc_regs, .regs_n = ARRAY_SIZE(sstc_regs),}
-#define SVINVAL_REGS_SUBLIST \
-	{"svinval", .feature = KVM_RISCV_ISA_EXT_SVINVAL, .regs = svinval_regs, .regs_n = ARRAY_SIZE(svinval_regs),}
-#define ZIHINTPAUSE_REGS_SUBLIST \
-	{"zihintpause", .feature = KVM_RISCV_ISA_EXT_ZIHINTPAUSE, .regs = zihintpause_regs, .regs_n = ARRAY_SIZE(zihintpause_regs),}
-#define ZBA_REGS_SUBLIST \
-	{"zba", .feature = KVM_RISCV_ISA_EXT_ZBA, .regs = zba_regs, .regs_n = ARRAY_SIZE(zba_regs),}
-#define ZBB_REGS_SUBLIST \
-	{"zbb", .feature = KVM_RISCV_ISA_EXT_ZBB, .regs = zbb_regs, .regs_n = ARRAY_SIZE(zbb_regs),}
-#define ZBS_REGS_SUBLIST \
-	{"zbs", .feature = KVM_RISCV_ISA_EXT_ZBS, .regs = zbs_regs, .regs_n = ARRAY_SIZE(zbs_regs),}
-#define ZICNTR_REGS_SUBLIST \
-	{"zicntr", .feature = KVM_RISCV_ISA_EXT_ZICNTR, .regs = zicntr_regs, .regs_n = ARRAY_SIZE(zicntr_regs),}
-#define ZICOND_REGS_SUBLIST \
-	{"zicond", .feature = KVM_RISCV_ISA_EXT_ZICOND, .regs = zicond_regs, .regs_n = ARRAY_SIZE(zicond_regs),}
-#define ZICSR_REGS_SUBLIST \
-	{"zicsr", .feature = KVM_RISCV_ISA_EXT_ZICSR, .regs = zicsr_regs, .regs_n = ARRAY_SIZE(zicsr_regs),}
-#define ZIFENCEI_REGS_SUBLIST \
-	{"zifencei", .feature = KVM_RISCV_ISA_EXT_ZIFENCEI, .regs = zifencei_regs, .regs_n = ARRAY_SIZE(zifencei_regs),}
-#define ZIHPM_REGS_SUBLIST \
-	{"zihpm", .feature = KVM_RISCV_ISA_EXT_ZIHPM, .regs = zihpm_regs, .regs_n = ARRAY_SIZE(zihpm_regs),}
-#define AIA_REGS_SUBLIST \
+#define SUBLIST_AIA \
 	{"aia", .feature = KVM_RISCV_ISA_EXT_SSAIA, .regs = aia_regs, .regs_n = ARRAY_SIZE(aia_regs),}
-#define SMSTATEEN_REGS_SUBLIST \
+#define SUBLIST_SMSTATEEN \
 	{"smstateen", .feature = KVM_RISCV_ISA_EXT_SMSTATEEN, .regs = smstateen_regs, .regs_n = ARRAY_SIZE(smstateen_regs),}
-#define FP_F_REGS_SUBLIST \
+#define SUBLIST_FP_F \
 	{"fp_f", .feature = KVM_RISCV_ISA_EXT_F, .regs = fp_f_regs, \
 		.regs_n = ARRAY_SIZE(fp_f_regs),}
-#define FP_D_REGS_SUBLIST \
+#define SUBLIST_FP_D \
 	{"fp_d", .feature = KVM_RISCV_ISA_EXT_D, .regs = fp_d_regs, \
 		.regs_n = ARRAY_SIZE(fp_d_regs),}
 
-static struct vcpu_reg_list h_config = {
-	.sublists = {
-	BASE_SUBLIST,
-	H_REGS_SUBLIST,
-	{0},
-	},
-};
-
-static struct vcpu_reg_list zicbom_config = {
-	.sublists = {
-	BASE_SUBLIST,
-	ZICBOM_REGS_SUBLIST,
-	{0},
-	},
-};
-
-static struct vcpu_reg_list zicboz_config = {
-	.sublists = {
-	BASE_SUBLIST,
-	ZICBOZ_REGS_SUBLIST,
-	{0},
-	},
-};
-
-static struct vcpu_reg_list svpbmt_config = {
-	.sublists = {
-	BASE_SUBLIST,
-	SVPBMT_REGS_SUBLIST,
-	{0},
-	},
-};
-
-static struct vcpu_reg_list sstc_config = {
-	.sublists = {
-	BASE_SUBLIST,
-	SSTC_REGS_SUBLIST,
-	{0},
-	},
-};
-
-static struct vcpu_reg_list svinval_config = {
-	.sublists = {
-	BASE_SUBLIST,
-	SVINVAL_REGS_SUBLIST,
-	{0},
-	},
-};
-
-static struct vcpu_reg_list zihintpause_config = {
-	.sublists = {
-	BASE_SUBLIST,
-	ZIHINTPAUSE_REGS_SUBLIST,
-	{0},
-	},
-};
-
-static struct vcpu_reg_list zba_config = {
-	.sublists = {
-	BASE_SUBLIST,
-	ZBA_REGS_SUBLIST,
-	{0},
-	},
-};
-
-static struct vcpu_reg_list zbb_config = {
-	.sublists = {
-	BASE_SUBLIST,
-	ZBB_REGS_SUBLIST,
-	{0},
-	},
-};
-
-static struct vcpu_reg_list zbs_config = {
-	.sublists = {
-	BASE_SUBLIST,
-	ZBS_REGS_SUBLIST,
-	{0},
-	},
-};
-
-static struct vcpu_reg_list zicntr_config = {
-	.sublists = {
-	BASE_SUBLIST,
-	ZICNTR_REGS_SUBLIST,
-	{0},
-	},
-};
-
-static struct vcpu_reg_list zicond_config = {
-	.sublists = {
-	BASE_SUBLIST,
-	ZICOND_REGS_SUBLIST,
-	{0},
-	},
-};
-
-static struct vcpu_reg_list zicsr_config = {
-	.sublists = {
-	BASE_SUBLIST,
-	ZICSR_REGS_SUBLIST,
-	{0},
-	},
-};
-
-static struct vcpu_reg_list zifencei_config = {
-	.sublists = {
-	BASE_SUBLIST,
-	ZIFENCEI_REGS_SUBLIST,
-	{0},
-	},
-};
-
-static struct vcpu_reg_list zihpm_config = {
-	.sublists = {
-	BASE_SUBLIST,
-	ZIHPM_REGS_SUBLIST,
-	{0},
-	},
-};
-
-static struct vcpu_reg_list aia_config = {
-	.sublists = {
-	BASE_SUBLIST,
-	AIA_REGS_SUBLIST,
-	{0},
-	},
-};
-
-static struct vcpu_reg_list smstateen_config = {
-	.sublists = {
-	BASE_SUBLIST,
-	SMSTATEEN_REGS_SUBLIST,
-	{0},
-	},
-};
-
-static struct vcpu_reg_list fp_f_config = {
-	.sublists = {
-	BASE_SUBLIST,
-	FP_F_REGS_SUBLIST,
-	{0},
-	},
-};
-
-static struct vcpu_reg_list fp_d_config = {
-	.sublists = {
-	BASE_SUBLIST,
-	FP_D_REGS_SUBLIST,
-	{0},
-	},
-};
+#define KVM_ISA_EXT_SIMPLE_CONFIG(ext, extu)			\
+static __u64 regs_##ext[] = {					\
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG |			\
+	KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_##extu,	\
+};								\
+static struct vcpu_reg_list config_##ext = {			\
+	.sublists = {						\
+		SUBLIST_BASE,					\
+		{						\
+			.name = #ext,				\
+			.feature = KVM_RISCV_ISA_EXT_##extu,	\
+			.regs = regs_##ext,			\
+			.regs_n = ARRAY_SIZE(regs_##ext),	\
+		},						\
+		{0},						\
+	},							\
+}								\
+
+#define KVM_ISA_EXT_SUBLIST_CONFIG(ext, extu)			\
+static struct vcpu_reg_list config_##ext = {			\
+	.sublists = {						\
+		SUBLIST_BASE,					\
+		SUBLIST_##extu,					\
+		{0},						\
+	},							\
+}								\
+
+/* Note: The below list is alphabetically sorted. */
+
+KVM_ISA_EXT_SUBLIST_CONFIG(aia, AIA);
+KVM_ISA_EXT_SUBLIST_CONFIG(fp_f, FP_F);
+KVM_ISA_EXT_SUBLIST_CONFIG(fp_d, FP_D);
+KVM_ISA_EXT_SIMPLE_CONFIG(h, H);
+KVM_ISA_EXT_SUBLIST_CONFIG(smstateen, SMSTATEEN);
+KVM_ISA_EXT_SIMPLE_CONFIG(sstc, SSTC);
+KVM_ISA_EXT_SIMPLE_CONFIG(svinval, SVINVAL);
+KVM_ISA_EXT_SIMPLE_CONFIG(svnapot, SVNAPOT);
+KVM_ISA_EXT_SIMPLE_CONFIG(svpbmt, SVPBMT);
+KVM_ISA_EXT_SIMPLE_CONFIG(zba, ZBA);
+KVM_ISA_EXT_SIMPLE_CONFIG(zbb, ZBB);
+KVM_ISA_EXT_SIMPLE_CONFIG(zbs, ZBS);
+KVM_ISA_EXT_SUBLIST_CONFIG(zicbom, ZICBOM);
+KVM_ISA_EXT_SUBLIST_CONFIG(zicboz, ZICBOZ);
+KVM_ISA_EXT_SIMPLE_CONFIG(zicntr, ZICNTR);
+KVM_ISA_EXT_SIMPLE_CONFIG(zicond, ZICOND);
+KVM_ISA_EXT_SIMPLE_CONFIG(zicsr, ZICSR);
+KVM_ISA_EXT_SIMPLE_CONFIG(zifencei, ZIFENCEI);
+KVM_ISA_EXT_SIMPLE_CONFIG(zihintpause, ZIHINTPAUSE);
+KVM_ISA_EXT_SIMPLE_CONFIG(zihpm, ZIHPM);
 
 struct vcpu_reg_list *vcpu_configs[] = {
-	&h_config,
-	&zicbom_config,
-	&zicboz_config,
-	&svpbmt_config,
-	&sstc_config,
-	&svinval_config,
-	&zihintpause_config,
-	&zba_config,
-	&zbb_config,
-	&zbs_config,
-	&zicntr_config,
-	&zicond_config,
-	&zicsr_config,
-	&zifencei_config,
-	&zihpm_config,
-	&aia_config,
-	&smstateen_config,
-	&fp_f_config,
-	&fp_d_config,
+	&config_aia,
+	&config_fp_f,
+	&config_fp_d,
+	&config_h,
+	&config_smstateen,
+	&config_sstc,
+	&config_svinval,
+	&config_svnapot,
+	&config_svpbmt,
+	&config_zba,
+	&config_zbb,
+	&config_zbs,
+	&config_zicbom,
+	&config_zicboz,
+	&config_zicntr,
+	&config_zicond,
+	&config_zicsr,
+	&config_zifencei,
+	&config_zihintpause,
+	&config_zihpm,
 };
 int vcpu_configs_n = ARRAY_SIZE(vcpu_configs);
-- 
2.34.1

