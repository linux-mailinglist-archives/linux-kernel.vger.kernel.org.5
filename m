Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D31F7E8055
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344917AbjKJSJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344073AbjKJSFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:05:48 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56471387AA
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:09:27 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507a3b8b113so2685344e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699625365; x=1700230165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNncknImGYd0G7MADnDhbFKl7Y37Hs80keyCtMwuCbk=;
        b=YY/K/GzRK0tHFcdeDuuvXZLWIU8pvr4LiFxNwxVaycV8AyG0/dQ73OldQoy5UfNvc+
         PBzvKwKOLpDxF+kgbZPdFXBweB2Rne1tFx0oxa+SU7i8+N5RB8XJVijg+yVYlCnyMczp
         rYde4d2U8EXENC/VdFsV2G1w6RdDTcDlrlfIqyCThsDMj5DTfQBTwKkNxfMToXZQLapR
         dOtcYiJzmVXldzPsCcIHgJzIY1/SAswcUdbo5zynpwKYhNCEIbRcDdKbZxkNnTi8x5Mq
         zYfnNhyqPy9YzRSf8lJm31+LUg44huokCRrnagBXH6Ms0cXF7/tR4Sl6ldV5qX4TzWEv
         m7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699625365; x=1700230165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNncknImGYd0G7MADnDhbFKl7Y37Hs80keyCtMwuCbk=;
        b=o3mFa8BbI/wG258BJDHA7fNlje/nz4VJjaNyskPDdeXpZ6xipBHuYGFsSdWJ0Ve4Bf
         3AQX+wi83c6iSj6ujzpYKXxO+pWA4uaKXe2itlJJPRcohUlelgRbPlI65dapfDpDNK1l
         vjpH2kHRWiJ5J41h8K8Z3BTG/0HY2ZovSmQl0mHVH8xsu3lV8L6Cd1nr4taPsnOozlJs
         iiiVhVVw7bk75j9n3YdskJbnm6VJxnlUC5qVIaqjy0HVe7kMu5XrasxXI50Q5zLJuZXb
         2UsB4evUiVdU4XiMaGinma4QMGLkDQsvPu3iaBZvvtmzRsM+H9t23CIRgaUTO5sx5Bq4
         OFEA==
X-Gm-Message-State: AOJu0YxS/nkUtU1ssv31b4analwMtIx1rHUJhiYS5vPd5g9qYUKa5ITb
        ey92ph8AvdKWd2n7R97p0wwHFQ==
X-Google-Smtp-Source: AGHT+IFnc5DDn6eDvAmwHfvD11R9Doa6XtjEu4mYLiLBs82TOIbZPRsbYbDAWR9qLMG/ZVUIcvzhnw==
X-Received: by 2002:a2e:2c15:0:b0:2c6:f51f:c96d with SMTP id s21-20020a2e2c15000000b002c6f51fc96dmr6506404ljs.13.1699625365568;
        Fri, 10 Nov 2023 06:09:25 -0800 (PST)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id b12-20020a05600c150c00b004083a105f27sm5173099wmg.26.2023.11.10.06.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 06:09:25 -0800 (PST)
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
Subject: [PATCH 2/2] riscv: Enable pcpu page first chunk allocator
Date:   Fri, 10 Nov 2023 15:07:21 +0100
Message-Id: <20231110140721.114235-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231110140721.114235-1-alexghiti@rivosinc.com>
References: <20231110140721.114235-1-alexghiti@rivosinc.com>
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
index 5b1e61aca6cf..7b82d8301e42 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -416,7 +416,9 @@ config NUMA
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

