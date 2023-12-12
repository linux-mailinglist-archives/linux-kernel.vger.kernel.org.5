Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95EF80F987
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377601AbjLLVg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377344AbjLLVg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:36:57 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C29FCF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:37:03 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40c2bb872e2so58038945e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702417021; x=1703021821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCOh69caXbVfDD+nz3SkSSNJ4LOnzQLxIG6SJxHDatw=;
        b=kWzrDwvMmsJfhjS2OUJRnJ7Jc8pQ0F63OTXPGjJ22mC4F4vrT8oZVF6y4dtUGmzr89
         O6nB8mV04/9zKblb2CRy9cwUQ4R+f9xObyOmNfsNP3Jx8SCLuzMXuiuhoZVESqrKlQl5
         pAso5bQGRGunHFW7dLf4KvDKSZUD59wYK1Qfi0j6pD6sFfA7MyIx+iG2fa9KnWGkUc2O
         zE2OW1EH4xOXd7mKfA54+crJjMXBkcMIPhOsDip4N/SVKxdy5aN7BxWJmTWidqPktrNi
         3aJTI4idDGfJ6+EKQSyyS4AXhoQjxVLY8xwnFEh3Vu9llT4mdaGsryoH+7j9FIPaw0E2
         lfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702417021; x=1703021821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCOh69caXbVfDD+nz3SkSSNJ4LOnzQLxIG6SJxHDatw=;
        b=NAHObNWkUuSNRoGmKOA8lQqpJQ6iTh2qi4ESovDKmtoWVshBqJonuRRZZtwaM0ZDK6
         KhTooBWvhmaEOcrU0bZR8OtGNkDK4UUHrPII3hY8peg7w1iEpAB4wYjtGraGWIty3cn6
         Wf6nUgZ4Adv4cIcKDFaqOwqPl7Bs/2mHE/VpfeFATZt21HYMmUHgbzRi53kp2smbHMg6
         mbOJCAIgNQc8hKpojekVVdo9ELHc668btOhuKm4ukiDbopwFIzpqhKFhU6fVODpixCgy
         lZUK7tpYxc3deF5pno3GOL1Y+fFsyddPIfGbAOR8yqYbM8dzJJ8FMLGwCxjHYOgSl0G1
         Vkkw==
X-Gm-Message-State: AOJu0Yxp7BbUb8tEu+MRqipGr48ZhR52B7QBhsJwmQWHYrTBeBlAKHHn
        tp95WE3BO+rLGJL7evVWXbEwOQ==
X-Google-Smtp-Source: AGHT+IFqqgEgVUuuLcp/jxl4AbRQVAxPSPDTSvhp/ckLGpwai+H0FWmy2ZTFwQBh1m466TRnZ7G6vg==
X-Received: by 2002:a05:600c:2814:b0:40b:5f03:b43f with SMTP id m20-20020a05600c281400b0040b5f03b43fmr1885174wmb.353.1702417021655;
        Tue, 12 Dec 2023 13:37:01 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id ay35-20020a05600c1e2300b0040b2b38a1fasm17954734wmb.4.2023.12.12.13.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 13:37:01 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 2/2] riscv: Enable pcpu page first chunk allocator
Date:   Tue, 12 Dec 2023 22:34:57 +0100
Message-Id: <20231212213457.132605-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231212213457.132605-1-alexghiti@rivosinc.com>
References: <20231212213457.132605-1-alexghiti@rivosinc.com>
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

As explained in commit 6ea529a2037c ("percpu: make embedding first chunk
allocator check vmalloc space size"), the embedding first chunk allocator
needs the vmalloc space to be larger than the maximum distance between
units which are grouped into NUMA nodes.

On a very sparse NUMA configurations and a small vmalloc area (for example,
it is 64GB in sv39), the allocation of dynamic percpu data in the vmalloc
area could fail.

So provide the pcpu page allocator as a fallback in case we fall into
such a sparse configuration (which happened in arm64 as shown by
commit 09cea6195073 ("arm64: support page mapping percpu first chunk
allocator")).

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/Kconfig         | 2 ++
 arch/riscv/mm/kasan_init.c | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7603bd8ab333..8ba4a63e0ae5 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -415,7 +415,9 @@ config NUMA
 	depends on SMP && MMU
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select GENERIC_ARCH_NUMA
+	select HAVE_SETUP_PER_CPU_AREA
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
+	select NEED_PER_CPU_PAGE_FIRST_CHUNK
 	select OF_NUMA
 	select USE_PERCPU_NUMA_NODE_ID
 	help
diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index 5e39dcf23fdb..4c9a2c527f08 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -438,6 +438,14 @@ static void __init kasan_shallow_populate(void *start, void *end)
 	kasan_shallow_populate_pgd(vaddr, vend);
 }
 
+#ifdef CONFIG_KASAN_VMALLOC
+void __init kasan_populate_early_vm_area_shadow(void *start, unsigned long size)
+{
+	kasan_populate(kasan_mem_to_shadow(start),
+		       kasan_mem_to_shadow(start + size));
+}
+#endif
+
 static void __init create_tmp_mapping(void)
 {
 	void *ptr;
-- 
2.39.2

