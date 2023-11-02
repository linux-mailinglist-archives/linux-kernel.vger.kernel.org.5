Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D347DF1F3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345636AbjKBMEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235294AbjKBMEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:04:37 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D007210C2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 05:01:46 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cacde97002so6391505ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 05:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1698926506; x=1699531306; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xJAq1yPvWqyGBi5ZsWwrpgoSqVAMHLxRpGtyjE8Lpog=;
        b=FF6zsVUmmvmiObdm3E4jVv+YYKMBNbt1a19Y9NAfSXN/nFqrzzMfScZnJBX8kf4nZA
         8FHUq2WU761da6atFkQLHgzpbAeq4tZQmzQA2z8CrWudON74aOvEAbuXyycyaVFVQ8am
         WF7/mXaP1pNkKtMEJ8QGmO0V8hX7lx3wZb1XkCPA7IHQSuAbwICwuXOLnvx4dgRP3gVu
         NTPdavCKuXQP5EcK9jW7GCvO8xy/kZRUsPZGodCC72VavmAwNTgmE+MbPz/vcQcvhlys
         dxq1GZixeOsV/hdb2OhnQ7pGulwDm8XJErbZtigIPYILkksJ9h2haDcrKoBM8hj3w88h
         KK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698926506; x=1699531306;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xJAq1yPvWqyGBi5ZsWwrpgoSqVAMHLxRpGtyjE8Lpog=;
        b=VU5FvIFdkpVoaHiqSWctZaeyCv+nx/Nww04I9m9AFWZZq1QC7I3rzPZOqg629TJBU8
         dzeN04qQjjWIlk8oEdgUWGyW/5kWMyRW0xLBzzZCASNrAJ/jVoU6I9BiOJYghsn+M2bW
         Pdzw4P72p79JfLMoRKDQItBW5MnfMeW/zzIrVjS4CXjauZ1KT2M6K+pLfXW2zKoGCCR6
         rVb+f+Zx9LRJLmZCtta+jAO2/UsXdqKGOUa0KlCBVFGXxoP317piDeaW/9VNE7Zi2Xon
         TjKZlLt2esVcs5TRNCFlLUxl5Bk2iVbk5MrysP7kF/E7KMtGCFWto3dsDgkJjNS8/6cX
         0dZg==
X-Gm-Message-State: AOJu0YxCIQ2SX9gamjgk+Jx8Ngaxw4Rc9OZ8HhPajL2JLN0PQfzPtQkb
        uzFf7Yed8ftLrG6AKYWodyfQDA==
X-Google-Smtp-Source: AGHT+IG/wfKGcDVJAiG/TgytNJy0AhVTei/c041lmiY2sl7WVz0x3oclhwrVt0acJHl8aFDX+bEK+w==
X-Received: by 2002:a17:902:db10:b0:1cc:5833:cf5e with SMTP id m16-20020a170902db1000b001cc5833cf5emr10617317plx.27.1698926506097;
        Thu, 02 Nov 2023 05:01:46 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id l12-20020a170902f68c00b001cc0f6028b8sm2969008plg.106.2023.11.02.05.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 05:01:45 -0700 (PDT)
From:   Yong-Xuan Wang <yongxuan.wang@sifive.com>
To:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org
Cc:     greentime.hu@sifive.com, vincent.chen@sifive.com, tjytimi@163.com,
        alex@ghiti.fr, conor.dooley@microchip.com, ajones@ventanamicro.com,
        Yong-Xuan Wang <yongxuan.wang@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Guo Ren <guoren@kernel.org>,
        Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        David Hildenbrand <david@redhat.com>,
        Charlie Jenkins <charlie@rivosinc.com>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Evan Green <evan@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] RISC-V: Detect and Enable Svadu Extension Support
Date:   Thu,  2 Nov 2023 12:01:22 +0000
Message-Id: <20231102120129.11261-2-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231102120129.11261-1-yongxuan.wang@sifive.com>
References: <20231102120129.11261-1-yongxuan.wang@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Svadu is a RISC-V extension for hardware updating of PTE A/D bits.

In this patch we detect Svadu extension support from DTB and
add arch_has_hw_pte_young() to enable optimization in MGLRU and
__wp_page_copy_user() if Svadu extension is available.

Co-developed-by: Jinyu Tang <tjytimi@163.com>
Signed-off-by: Jinyu Tang <tjytimi@163.com>
Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/include/asm/csr.h     | 1 +
 arch/riscv/include/asm/hwcap.h   | 1 +
 arch/riscv/include/asm/pgtable.h | 6 ++++++
 arch/riscv/kernel/cpufeature.c   | 1 +
 4 files changed, 9 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 777cb8299551..e6935fd48c0c 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -194,6 +194,7 @@
 /* xENVCFG flags */
 #define ENVCFG_STCE			(_AC(1, ULL) << 63)
 #define ENVCFG_PBMTE			(_AC(1, ULL) << 62)
+#define ENVCFG_ADUE			(_AC(1, ULL) << 61)
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
index b2ba3f79cfe9..028b700cd27b 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -629,6 +629,12 @@ static inline pgprot_t pgprot_writecombine(pgprot_t _prot)
 	return __pgprot(prot);
 }
 
+#define arch_has_hw_pte_young arch_has_hw_pte_young
+static inline bool arch_has_hw_pte_young(void)
+{
+	return riscv_has_extension_unlikely(RISCV_ISA_EXT_SVADU);
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

