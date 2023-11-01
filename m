Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4000E7DE84B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 23:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347461AbjKAWsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 18:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347178AbjKAWsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 18:48:20 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDF6121
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 15:48:17 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b2e44c7941so217297b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 15:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698878896; x=1699483696; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Jfb6hOBzZpUnQKwLCoqR3E0xQBxJXpYyz1BMSpxkFw=;
        b=AmfD1r3qG8n9koFj1GoSDasXf486HXk9aasls16Olc0XChdXfnHzof6TpN4x4eJP/3
         aD5cQlazCOtdXIgrPijhbp4u84ekYGMUYthXHwd6drBskogS2fmfGVaiYKhJ/YU6rRex
         5Z/QPgBz+WUyYvIFqszD3qDDMPSk7QMsMjOUdRAfqNiDvxbWSR1pxa7WfsuY/l+2dOzB
         L6WUSrFjFz35txrEjpglVbmtIh3UHfJNqEMnDSFpoIIV3D7Dft//jlvSRw159+xvmspG
         C9oSioOLAZSBLblOgaKfGuemiTM3UMDpQLRbXSZQEybZBtjEnrT/GJF0WWji2IwgsVMB
         DjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698878896; x=1699483696;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Jfb6hOBzZpUnQKwLCoqR3E0xQBxJXpYyz1BMSpxkFw=;
        b=P8gOubxT7yssx8g0lxfvMhEA++90My0Ry4Do+kS8eHJ64kvfbzy4J22upWKVCC8/h0
         aMdsJUVcz61tF/7PsAapDeZuRmHJeEs3CpPqAnABae257IxxgaWRe6TFjYvXSgEjnVb6
         IQ1JpvLP5k9Bau1wOKFVVao3fi2mQb0leUjtDiohuwFZbGLZWxIiOEa4OG24lEzM0jQe
         yXqyFhjcnUG0pMcLgHxJY/pP3diXwhfwNHXugC3jqfWJCvaXHXIgfa/aMmjJH5+JOIWE
         PheEzfdnZKh9qzuk5KyEn4aQFWC86xvWJTqteQ2+Bh+KmwKFQryYQd6vkOEBcsGm6WMC
         ijZg==
X-Gm-Message-State: AOJu0YwOCfcLVxO/VrmxLN+V2JTOjazeCP1qPv5tGMa/g8VDeip629rw
        pKPiNqd8bFrBqBfRlrJCKyIo7EIX3M/NxS71S6E=
X-Google-Smtp-Source: AGHT+IFrRQ4RvXCeg9zgcc6gQJKyxMZycIJwRZBo6fv/AO0GuJFj60KRW9zeICB72WblOqK7tOZRDw==
X-Received: by 2002:a05:6808:13d6:b0:3b2:ef9a:4339 with SMTP id d22-20020a05680813d600b003b2ef9a4339mr21460103oiw.49.1698878896675;
        Wed, 01 Nov 2023 15:48:16 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id be24-20020a056808219800b003b274008e46sm376580oib.0.2023.11.01.15.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 15:48:16 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Wed, 01 Nov 2023 15:48:12 -0700
Subject: [PATCH v10 2/5] riscv: Add static key for misaligned accesses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231101-optimize_checksum-v10-2-a498577bb969@rivosinc.com>
References: <20231101-optimize_checksum-v10-0-a498577bb969@rivosinc.com>
In-Reply-To: <20231101-optimize_checksum-v10-0-a498577bb969@rivosinc.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 arch/riscv/include/asm/cpufeature.h |  3 +++
 arch/riscv/kernel/cpufeature.c      | 30 ++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index b139796392d0..febd9de4373e 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -7,6 +7,7 @@
 #define _ASM_CPUFEATURE_H
 
 #include <linux/bitmap.h>
+#include <linux/jump_label.h>
 #include <asm/hwcap.h>
 
 /*
@@ -32,4 +33,6 @@ extern struct riscv_isainfo hart_isa[NR_CPUS];
 
 int check_unaligned_access(void *unused);
 
+DECLARE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
+
 #endif
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 40bb854fcb96..8935481d32da 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -9,6 +9,7 @@
 #include <linux/acpi.h>
 #include <linux/bitmap.h>
 #include <linux/ctype.h>
+#include <linux/jump_label.h>
 #include <linux/log2.h>
 #include <linux/memory.h>
 #include <linux/module.h>
@@ -665,6 +666,35 @@ static int check_unaligned_access_all_cpus(void)
 
 arch_initcall(check_unaligned_access_all_cpus);
 
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
2.34.1

