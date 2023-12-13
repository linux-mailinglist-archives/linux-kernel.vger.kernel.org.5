Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF88981200D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 21:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442604AbjLMUdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 15:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjLMUdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 15:33:16 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D705A3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 12:33:23 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c4846847eso36366935e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 12:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702499601; x=1703104401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNQI5S3fkIj7NrMfmbJzF3XH+7YYWzemWytVmilYcq0=;
        b=WVRAl3R21xwQkMOpR9necNcoq1nhk76GBd68uOazMxzmHArxHwjifNh9CG06V4Wzzg
         BSjMSJ+wBbzwrFQmczmBbONh3QEz3YQ9R7Ig/s0lbAjA49zFIsoXVVI3QWXcw7buEjMG
         KEP6wPYQyCaAAxa6+/kxsrJInjc3XZwLHP21MJpLuoL+5c4pdRpMjgvr/i/oXSCCqCnG
         SwhM9xppkygpBJBVOPlX/KjkZFKD38RkBykcAsY4KC84mCNV057omKgcvebGjWD1fG0n
         kMez+90O1CF0ThqC9ZCe2Eqgw+sSeEExP1Nsy9CNEbulRw9+z/jtyL0SRsm3tZ72ZCBp
         gwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702499601; x=1703104401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNQI5S3fkIj7NrMfmbJzF3XH+7YYWzemWytVmilYcq0=;
        b=mQ3gc5/J/nsyDkywmJYI0s68nTnjOW9ufqvbgOPa+Ps+y7xvKNYyA4hVa8o35FKLvb
         KhM6TnuLw9LvsMvGq4SAb9o2g9Gi4dZDEGuP9wF9eiwx/pkwcQpMPGlv82ZbjidP43JN
         SZZ5EwhWl0eFdzbM7fEqJAOIexYSnLMWJxw2Is6IJhr6QHv70mhIjUHzhim46jGE028Z
         zXNvw+gv7hXzYMTo8nyeeh3Ten4TCtqIBM4f4GQ1u7255Q5Yu1e0M+JFiZaZvc/MWPnL
         G5Em0FXEHNDc/VCPw8M6tRdpfZgBlJmtRyUkfCvbITvaczb6rRbpWxKEQ1LBzcTO/WTT
         EfBg==
X-Gm-Message-State: AOJu0Yzubo6aMGxCiQla0SnuLkZOjDg4g6+k1F0nPFLIAY76rFlG4FhJ
        B0hzokFpEHHCz2g7Pdc6XszeKQ==
X-Google-Smtp-Source: AGHT+IG3reTNU+mJ6s5WyJ1mAvW4tTpIucH1hcfMu/iPtp1tRfvP2HWAF0mMX3m2L1tivm7yEvDWGA==
X-Received: by 2002:a05:6000:174d:b0:336:36fb:84c8 with SMTP id m13-20020a056000174d00b0033636fb84c8mr990697wrf.107.1702499601505;
        Wed, 13 Dec 2023 12:33:21 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id p10-20020a5d458a000000b00336463625c0sm136243wrq.51.2023.12.13.12.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 12:33:21 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Russell King <linux@armlinux.org.uk>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 3/4] riscv: mm: Only compile pgtable.c if MMU
Date:   Wed, 13 Dec 2023 21:30:00 +0100
Message-Id: <20231213203001.179237-4-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231213203001.179237-1-alexghiti@rivosinc.com>
References: <20231213203001.179237-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All functions defined in there depend on MMU, so no need to compile it
for !MMU configs.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index 3a4dfc8babcf..2c869f8026a8 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -13,10 +13,9 @@ endif
 KCOV_INSTRUMENT_init.o := n
 
 obj-y += init.o
-obj-$(CONFIG_MMU) += extable.o fault.o pageattr.o
+obj-$(CONFIG_MMU) += extable.o fault.o pageattr.o pgtable.o
 obj-y += cacheflush.o
 obj-y += context.o
-obj-y += pgtable.o
 obj-y += pmem.o
 
 ifeq ($(CONFIG_MMU),y)
-- 
2.39.2

