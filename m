Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251CF81077B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 02:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378183AbjLMBSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 20:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378152AbjLMBSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 20:18:39 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F3F99
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 17:18:44 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-2030fbc2417so530092fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 17:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702430324; x=1703035124; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hqZmArtiXcDp/s2cDCE6VomUeBtSGPPb+28mpDKaCFA=;
        b=KucCqPgRNdBxdHYCeHek0CTVGOnVnjSG/P+mCD7WFFaXx+L8fQWDm+mlAbTSvqlMXW
         0SUxT7TkIrp+ELx7uigUy9bLMGThdifH228O1/7wS26Pz7DK21lKCO7andEtaEBdMi+x
         sHrQynGAZmszJ+9DDjsZRAZ50WXP0Ip/SmLJ37PZtZKdiy/SIYw4s9gefu8BKKFqPLq9
         1i3Z6hK1oeMKzrVwQLZLRlK2oEJumaTNTZdZJnGT9lBudt9YfPfLU8O6+IFCQxYawRxs
         qNdv/yjgFFcGTri+SiPdE3pUVc65Y4F2JymKDZzkPzZnyYYtXnXN+awWQy0lEII/7aNE
         zSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702430324; x=1703035124;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqZmArtiXcDp/s2cDCE6VomUeBtSGPPb+28mpDKaCFA=;
        b=EczorUm29WVfnR5LDHU4cl2z3PwjsxnC47itG85nPCx/6ZPJAmD8g3hFcVTZIP38ze
         kUerdqkx94V19JlP3CBNvBSjhXk0AbOKlrIP57jkJA5of8tgtqYUCjOemef3i4rgNSXG
         vY0nN7M24YL7SqHsQdFGElrKFoMtQWBUL4mcfZ+6pq8cZp+kL3jcn2KHIwJ0Ziis5gYB
         /pNec2WAZnfuGYzJTk80XukRq5oKKRisgyi40mtTSKlM/N5q7D4L+Iy5vCj74fWOZtsL
         piTk8wGkxWF/+ES27XZC1zYuUbZP/IoBfsKLfkKDxLoj44C/YTw8gbiEKT2xk8GWRJBI
         /S5w==
X-Gm-Message-State: AOJu0Ywx163mSGEUezMWRpf4+1+PpJh29ZQyIQGMXPA7HdsfE2Kuihhz
        AhQ+9yAO22Yn2hT3oZyvGjCzqew6GPUTGAsUk8U=
X-Google-Smtp-Source: AGHT+IGsFck0SPpUMTDPNRoS1a9HAh0lw70Bi5Pk17kbqt6QzyhyTNrEMPN91SoWLcSJQPWhOYh+bw==
X-Received: by 2002:a05:6871:20c6:b0:1fb:75c:4001 with SMTP id rz6-20020a05687120c600b001fb075c4001mr8324843oab.97.1702430324255;
        Tue, 12 Dec 2023 17:18:44 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id cy26-20020a056830699a00b006d9a339773csm172548otb.27.2023.12.12.17.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 17:18:43 -0800 (PST)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Tue, 12 Dec 2023 17:18:39 -0800
Subject: [PATCH v12 2/5] riscv: Add static key for misaligned accesses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-optimize_checksum-v12-2-419a4ba6d666@rivosinc.com>
References: <20231212-optimize_checksum-v12-0-419a4ba6d666@rivosinc.com>
In-Reply-To: <20231212-optimize_checksum-v12-0-419a4ba6d666@rivosinc.com>
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        Xiao Wang <xiao.w.wang@intel.com>,
        Evan Green <evan@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702430319; l=2270;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=zAvCCM1AIoiNlx7AQwltNFw7ekzVRWkGRkhZ8BNL3iE=;
 b=mhX85bB1xkJTvDWiO9LH4y8qdkyCuhl0OJGpKcki8af27Bjwiy5p7yu815B3I3qZ0Rfh+lfto
 f1c8q+01P7SDeQ4/BUdp2oRga8T4T4ieW8kC+gZMi3zzM0Sinc2hFWs
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support static branches depending on the value of misaligned accesses.
This will be used by a later patch in the series. All cpus must be
considered "fast" for this static branch to be flipped.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h |  2 ++
 arch/riscv/kernel/cpufeature.c      | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index a418c3112cd6..7b129e5e2f07 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -133,4 +133,6 @@ static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsi
 	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
 }
 
+DECLARE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
+
 #endif
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index b3785ffc1570..095eb6ebdcaa 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -10,6 +10,7 @@
 #include <linux/bitmap.h>
 #include <linux/cpuhotplug.h>
 #include <linux/ctype.h>
+#include <linux/jump_label.h>
 #include <linux/log2.h>
 #include <linux/memory.h>
 #include <linux/module.h>
@@ -728,6 +729,35 @@ void riscv_user_isa_enable(void)
 		csr_set(CSR_SENVCFG, ENVCFG_CBZE);
 }
 
+DEFINE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
+
+static int set_unaligned_access_static_branches(void)
+{
+	/*
+	 * This will be called after check_unaligned_access_all_cpus so the
+	 * result of unaligned access speed for all cpus will be available.
+	 */
+
+	int cpu;
+	bool fast_misaligned_access_speed = true;
+
+	for_each_online_cpu(cpu) {
+		int this_perf = per_cpu(misaligned_access_speed, cpu);
+
+		if (this_perf != RISCV_HWPROBE_MISALIGNED_FAST) {
+			fast_misaligned_access_speed = false;
+			break;
+		}
+	}
+
+	if (fast_misaligned_access_speed)
+		static_branch_enable(&fast_misaligned_access_speed_key);
+
+	return 0;
+}
+
+arch_initcall_sync(set_unaligned_access_static_branches);
+
 #ifdef CONFIG_RISCV_ALTERNATIVE
 /*
  * Alternative patch sites consider 48 bits when determining when to patch

-- 
2.43.0

