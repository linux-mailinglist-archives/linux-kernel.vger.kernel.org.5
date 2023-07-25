Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CB57619D8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjGYNYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjGYNWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:22:53 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480A91FEC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 06:22:50 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31751d7d96eso2216257f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 06:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690291369; x=1690896169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SwtTaSSywQCK+6eOzMzkFHCbywbdbCbQr7TZ7zLckhk=;
        b=aq8K6g1kNKVAXaB8qnVBVyLtEJCw6IO9Lv2x7L+0ECjGDne7M5Bm9519ngrBxeqQOv
         P59gcWCHJNnmhX7F0a3wa7Ho1ZNxKBoJaw+CysLoZCTpXK2QdmTNZzDeXjLmLW0ppoZy
         pPCkH29ysNp0p00fnqjBum/pmRXmF9UAN2eP3AEBVngA4SBk71IAmXTemgIbgN1WI91w
         eLn3KC73YZHADqy4+YlpcAYcgU11lgBS9erwG4oQt8lZ7vSlV9gTmQvVQdaEp93sCAxY
         MDbTSjFY6VdjH+Q/03QJQNo38iSo6siDDgds2H/QPrAIM2Sc8XuAow5pPL7nxy9Sq2bc
         RTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690291369; x=1690896169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SwtTaSSywQCK+6eOzMzkFHCbywbdbCbQr7TZ7zLckhk=;
        b=QyEUDWiRiE3lhkAhGxzPQdGzOcmOex3iu+ExuLEUqNDO2qJ/R0Wi3KLpdXOnRi42Hh
         IfCAo9lZdmYaNTaJ0AKmbUHJcXyKyqDpW2GVtaqlObZeKtjczhRA7A4rb0x/mxEQakxk
         l0gZ/D/xLXGnX4f+rjZLYZr6obql1VWImEfKsmP5Ej7h8zVOizUE3DXkm8zjXffyVzry
         FiNpIGgN8TPn6CrMPqo5QL1OpBU+9DIsmqTV4K2EEE5r0Dw82JZl/1HSvAcgbHfAHO00
         qK+8rX/EWSHWF7sXvhX81UyhMB9zBCekB3H5T+XvIv4kon/Tda5TEChan8MHxNuuBEJa
         qdCA==
X-Gm-Message-State: ABy/qLYTyqiricZImMRQpZJUn0Qi1dSzDGMPoZw2I7cqWy65vrUWs+en
        Qt90MWWi43d/8D2n29x54hJzdQ==
X-Google-Smtp-Source: APBJJlFymLrBaWWUbB5UjgLpC16CJw07bX0IHX8fcMSRniPWmXOiT8czHRNEnE1IFY6cpux2ayWVRg==
X-Received: by 2002:a5d:53c3:0:b0:317:568d:d69a with SMTP id a3-20020a5d53c3000000b00317568dd69amr6197749wrw.11.1690291368309;
        Tue, 25 Jul 2023 06:22:48 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id q7-20020adffec7000000b003143c532431sm16175035wrs.27.2023.07.25.06.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 06:22:47 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH -fixes] riscv: Implement flush_cache_vmap()
Date:   Tue, 25 Jul 2023 15:22:46 +0200
Message-Id: <20230725132246.817726-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISC-V kernel needs a sfence.vma after a page table modification: we
used to rely on the vmalloc fault handling to emit an sfence.vma, but
commit 7d3332be011e ("riscv: mm: Pre-allocate PGD entries for
vmalloc/modules area") got rid of this path for 64-bit kernels, so now we
need to explicitly emit a sfence.vma in flush_cache_vmap().

Note that we don't need to implement flush_cache_vunmap() as the generic
code should emit a flush tlb after unmapping a vmalloc region.

Fixes: 7d3332be011e ("riscv: mm: Pre-allocate PGD entries for vmalloc/modules area")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/cacheflush.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
index 8091b8bf4883..b93ffddf8a61 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -37,6 +37,10 @@ static inline void flush_dcache_page(struct page *page)
 #define flush_icache_user_page(vma, pg, addr, len) \
 	flush_icache_mm(vma->vm_mm, 0)
 
+#ifdef CONFIG_64BIT
+#define flush_cache_vmap(start, end)	flush_tlb_kernel_range(start, end)
+#endif
+
 #ifndef CONFIG_SMP
 
 #define flush_icache_all() local_flush_icache_all()
-- 
2.39.2

