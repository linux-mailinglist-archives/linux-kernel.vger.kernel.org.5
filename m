Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98FD774226
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjHHRf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234812AbjHHRfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:35:06 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643D0222F6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:15:17 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bf9252eddso873541866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691511302; x=1692116102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ir2LJjZwabuF9C6QsJfPbcf5sMfeQJgiQaLcKB1+XvI=;
        b=DnFNdTJjYVPZQED43aWmmGTzddhchrom1zutV/842MMojbY9Uj7DB6Xy/+FUUaBj+E
         0OcFmjMC6UdL690MIaJicg9HQl8l7b3HR1rAsic84dLK8g/z0mgcdqA14Sb9wcXUoXvk
         db2qZz6iTRZJ1FzHcBvadtrqLhjSXT4215K/GYg0sVp1knza1mlQCmJfhTnokkgraEC3
         GZVjImvFA3xgABFilgiz3GkJLVQKXb391w3lFKDFRUxIQYaK1bW2CU9kaNauq9r3yB30
         QtrY8q/oUcUVa56VxNsp5mpg4Hpo107MaxwZMxIaDp893oNbMxC869ri0Hqm1izJiJHI
         dUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511302; x=1692116102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ir2LJjZwabuF9C6QsJfPbcf5sMfeQJgiQaLcKB1+XvI=;
        b=QftiEgdx950KdewxV4hZRcw9uP6hT+rtajFTjbBYqogsGm5LNtO16Tfzu9bmeG+PBN
         81rXqz8h2BeJOKJ1Ikw23z3CRbKE3HU2d/wsid49HKb0YmdFLAHhkOvwC0XRJ1oQ+5Vk
         FHj5rqSpjHiwmoLwtf9Bc0J8Sx7TV1Rpq/3hL3jWa+6queddWTcM4dq0zTqRilm4FD87
         2rI9pP2wD7KaiL3fD4zg+3Nbo3aCy23AxEZiHDFQqm6dqsoFkE/iBs828RVNQQKq1Wxx
         blaDkbrYiOWVng4pGmK5kAfYTmPRp/dbNn5eILxPzf2BnqtNQFi/E0Cmy9pku8uWI/OJ
         i7UQ==
X-Gm-Message-State: AOJu0YxvhfEhFkG8PIwY3qayaZVYN7n4urw/bgd9opXemH/QSHr7zZ0t
        AY5/THrHmBzN3plCHplRxQmNHuFU04lIUeSTi0s=
X-Google-Smtp-Source: AGHT+IHNPbQ5CqkafPiCZwOmZc651VJ17pY+C/qulLlrMSB5Qb3JQwe7oMYPbndENgFd6K1WsXwgFQ==
X-Received: by 2002:a7b:c3d2:0:b0:3fe:6640:f536 with SMTP id t18-20020a7bc3d2000000b003fe6640f536mr898522wmj.40.1691500031334;
        Tue, 08 Aug 2023 06:07:11 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id u3-20020adfed43000000b0031759e6b43fsm13703777wro.39.2023.08.08.06.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 06:07:10 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH -fixes] riscv: Do not allow vmap pud mappings for 3-level page table
Date:   Tue,  8 Aug 2023 15:07:09 +0200
Message-Id: <20230808130709.1502614-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vmalloc_fault() path was removed and to avoid syncing the vmalloc PGD
mappings, they are now preallocated. But if the kernel can use a PUD
mapping (which in sv39 is actually a PGD mapping) for large vmalloc
allocation, it will free the current unused preallocated PGD mapping and
install a new leaf one. Since there is no sync anymore, some page tables
lack this new mapping and that triggers a panic.

So only allow PUD mappings for sv48 and sv57.

Fixes: 7d3332be011e ("riscv: mm: Pre-allocate PGD entries for vmalloc/modules area")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/vmalloc.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/vmalloc.h b/arch/riscv/include/asm/vmalloc.h
index 58d3e447f191..924d01b56c9a 100644
--- a/arch/riscv/include/asm/vmalloc.h
+++ b/arch/riscv/include/asm/vmalloc.h
@@ -3,12 +3,14 @@
 
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
 
+extern bool pgtable_l4_enabled, pgtable_l5_enabled;
+
 #define IOREMAP_MAX_ORDER (PUD_SHIFT)
 
 #define arch_vmap_pud_supported arch_vmap_pud_supported
 static inline bool arch_vmap_pud_supported(pgprot_t prot)
 {
-	return true;
+	return pgtable_l4_enabled || pgtable_l5_enabled;
 }
 
 #define arch_vmap_pmd_supported arch_vmap_pmd_supported
-- 
2.39.2

