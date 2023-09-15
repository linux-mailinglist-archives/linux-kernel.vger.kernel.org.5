Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A5E7A18CD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjIOI3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjIOI3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:29:07 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76D72720
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:27:18 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c364fb8a4cso17244315ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1694766438; x=1695371238; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/d7/3Obm53ZQCMrVF3c99mLRUxxcGODrgFkkmXmmWh0=;
        b=QHOm3Gw7e6m6el/CLOvbN5PcwyOqHuMKAwNywmcAq4L4eqF2Mgxl9GdN1ZA3Nh2Tk7
         Y878T6k/NpsbZyZxxVorq9gZufaU3ua0cXqlexHmVLoOjAqIyiyw1y4w16k8GqoYgL9i
         yLBv3TmQ7cL4QRFbNuvvDs30fZGaDRnxYAdzMZjG5zkDweYr7zBD/1rb+pnHp55WCtaS
         jhhwfB/aiQAvXhILJCDF6tr0NS487cnNq4fax2A0hPP/j0oDeGoaBCeNQbh327KhjH+n
         H6+Onp5R+d+dL6Joh9SorYvMVrTbzdUbDt+YZrJELwFLZ5KoPRBYwp0dMEEhtUH7lH9H
         0iqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694766438; x=1695371238;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/d7/3Obm53ZQCMrVF3c99mLRUxxcGODrgFkkmXmmWh0=;
        b=ThVoeju3hBU5R2tVrd2E1zKRoyvD8dltDYCBMqoCIItIcCXY5OrMT9Plhlp/GGSAuy
         WIPCkzFBAQknMs49Ky7G2xxWu13BlVv09ak1q21IkhiObB9+wKWp+bx9vLlB/+v4gHEQ
         cdyF8BmoRceHxQfmGEfGN8mjSm/W4rf+EzZSNh7++ICoEELubiyhTWNc5TLgQ7YbSJxp
         MUqomfqNrmuCNjt1xk81k27utaKOEg72OplvG7S0cWM5Td+dp8x1R3vK/xaFCn6gZj7E
         iWV0bfXeID5TbiRCMbPY2bunUxVelSsleZZHsIuYHle/UfeJqVU9CHOveX7uFiKedNOC
         +zIQ==
X-Gm-Message-State: AOJu0Yz7opQqMHi4bQLJMEBkBpOl/rhkLHnJ8XyddtrrFihmsAYhiGYk
        uqFYQ/bswpx0gISwN2OiM7uzzw==
X-Google-Smtp-Source: AGHT+IHb/zp8g1xE9ziKFa7Tv818CMTUMg4AfS9OmCA5Lgzj6xUNvLbPabyCw1dijiXKaviQ0VILnA==
X-Received: by 2002:a17:902:d2cd:b0:1c3:e5bf:a9f8 with SMTP id n13-20020a170902d2cd00b001c3e5bfa9f8mr1188084plc.19.1694766438315;
        Fri, 15 Sep 2023 01:27:18 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902ab8400b001c0af36dd64sm2912806plr.162.2023.09.15.01.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 01:27:18 -0700 (PDT)
From:   Yong-Xuan Wang <yongxuan.wang@sifive.com>
To:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org
Cc:     greentime.hu@sifive.com, vincent.chen@sifive.com, tjytimi@163.com,
        alex@ghiti.fr, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        wchen <waylingii@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        David Hildenbrand <david@redhat.com>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Charlie Jenkins <charlie@rivosinc.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Evan Green <evan@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] RISC-V: Detect and Enable Svadu Extension Support
Date:   Fri, 15 Sep 2023 08:26:57 +0000
Message-Id: <20230915082701.3643-2-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230915082701.3643-1-yongxuan.wang@sifive.com>
References: <20230915082701.3643-1-yongxuan.wang@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We detect Svadu extension support from DTB and add arch_has_hw_pte_young()
to enable optimization in MGLRU and __wp_page_copy_user() if Svadu
extension is available.

Signed-off-by: Jinyu Tang <tjytimi@163.com>
Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 arch/riscv/include/asm/csr.h     | 1 +
 arch/riscv/include/asm/hwcap.h   | 1 +
 arch/riscv/include/asm/pgtable.h | 6 ++++++
 arch/riscv/kernel/cpufeature.c   | 1 +
 4 files changed, 9 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 777cb8299551..10648b372a2a 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -194,6 +194,7 @@
 /* xENVCFG flags */
 #define ENVCFG_STCE			(_AC(1, ULL) << 63)
 #define ENVCFG_PBMTE			(_AC(1, ULL) << 62)
+#define ENVCFG_HADE			(_AC(1, ULL) << 61)
 #define ENVCFG_CBZE			(_AC(1, UL) << 7)
 #define ENVCFG_CBCFE			(_AC(1, UL) << 6)
 #define ENVCFG_CBIE_SHIFT		4
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index b7b58258f6c7..1013661d6516 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -58,6 +58,7 @@
 #define RISCV_ISA_EXT_ZICSR		40
 #define RISCV_ISA_EXT_ZIFENCEI		41
 #define RISCV_ISA_EXT_ZIHPM		42
+#define RISCV_ISA_EXT_SVADU		43
 
 #define RISCV_ISA_EXT_MAX		64
 
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index b2ba3f79cfe9..f3d077dff8ac 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -629,6 +629,12 @@ static inline pgprot_t pgprot_writecombine(pgprot_t _prot)
 	return __pgprot(prot);
 }
 
+#define arch_has_hw_pte_young arch_has_hw_pte_young
+static inline bool arch_has_hw_pte_young(void)
+{
+	return riscv_has_extension_likely(RISCV_ISA_EXT_SVADU);
+}
+
 /*
  * THP functions
  */
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 1cfbba65d11a..ead378c04991 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -178,6 +178,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
 	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
+	__RISCV_ISA_EXT_DATA(svadu, RISCV_ISA_EXT_SVADU),
 	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
 	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
 	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
-- 
2.17.1

