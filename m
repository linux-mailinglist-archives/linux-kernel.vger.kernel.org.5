Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A08765BC0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjG0S7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjG0S7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:59:09 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68F32D73
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:59:05 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fc04692e20so14368955e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690484344; x=1691089144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDamHVk4ujUG+CHbAQWQotzld5TgznJ3XAxjQYSqNSU=;
        b=IdGa66UtIIFbYYRT34X7nXZCEdzcXTUXP42pHU+fRDakhGzxioo4R0X4pMQHNU3UvT
         cb6zYYiY1GSCrHL23POq5GqGsmx16xdh+ORbhy0jbLlh3508NDq2BU8MNyVptXqxHU3m
         z6Huh+dgLHgTmMh6/GFFtZgMKDfLTF/lLUhuu6lFFzZ5FfNz2M+UalL7Nxy2wcTt4Urm
         vHdUKMcDMqL0Rjs+nJEbZgdzu00ikS2T1OAVYH9IyrUU52fcpQTId9PDN+EBqrinVVD3
         YmbFuFktcTPCtmoQ7c19/s3iT4UVf0BCy+pzRa9E9o/mm8ujQqggxhdzJL4AmSxTKYKG
         +0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690484344; x=1691089144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDamHVk4ujUG+CHbAQWQotzld5TgznJ3XAxjQYSqNSU=;
        b=I2H6WEGVwxqZ6LuJhPmfQhzWC5HTC9bz7bNr4DlcqyRs0fjO4Qc78Z1XH5Bikk9FBI
         6F2bnrPZ38OKOh89QxU7xDAcToxmAQoX865IGIsx6RvY6JXRTBqpTvUpK5y3S7W6PlYv
         G0AorB/YNp9YIiAUcr2svS83nFwabUif24+BQjRylmtYdB+uxPVRrX1QP3GexPyZnVWg
         sDov2YKdZTYUei5oodgCDVtTS3DTFbGDzFPKmoWvg5K3e26aizYDK0kjMw/zd6eozXOE
         AdWs8Q2Piq03Z781/XVyV6AskoDXhQAXxe3wPq7RV5Xyr5jePQ9O5bBFiIpefWDULa2o
         8wcQ==
X-Gm-Message-State: ABy/qLYs1mF0e6o5tKTQC1otzYLmUFNnJDsddRa5HaMkHVZO1A8AD6iG
        A3ug8ALupwb25yr0/kb5akTw5w==
X-Google-Smtp-Source: APBJJlHhcGHjdWFgZg+N+yKc2Y2lhGlFYBwO6VQdAW4Af4g86WHeGB5c7zLJbHluWyguraWCOhnK6A==
X-Received: by 2002:a05:600c:aca:b0:3fb:a937:6024 with SMTP id c10-20020a05600c0aca00b003fba9376024mr2398881wmr.29.1690484344310;
        Thu, 27 Jul 2023 11:59:04 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 2-20020a05600c22c200b003fa96620b23sm5376517wmg.12.2023.07.27.11.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 11:59:04 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 3/4] riscv: Make __flush_tlb_range() loop over pte instead of flushing the whole tlb
Date:   Thu, 27 Jul 2023 20:55:52 +0200
Message-Id: <20230727185553.980262-4-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727185553.980262-1-alexghiti@rivosinc.com>
References: <20230727185553.980262-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when the range to flush covers more than one page (a 4K page or
a hugepage), __flush_tlb_range() flushes the whole tlb. Flushing the whole
tlb comes with a greater cost than flushing a single entry so we should
flush single entries up to a certain threshold so that:
threshold * cost of flushing a single entry < cost of flushing the whole
tlb.

This threshold is microarchitecture dependent and can/should be
overwritten by vendors.

Co-developed-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/tlbflush.c | 41 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 3e4acef1f6bc..8017d2130e27 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -24,13 +24,48 @@ static inline void local_flush_tlb_page_asid(unsigned long addr,
 			: "memory");
 }
 
+/*
+ * Flush entire TLB if number of entries to be flushed is greater
+ * than the threshold below. Platforms may override the threshold
+ * value based on marchid, mvendorid, and mimpid.
+ */
+static unsigned long tlb_flush_all_threshold __read_mostly = 64;
+
+static void local_flush_tlb_range_threshold_asid(unsigned long start,
+						 unsigned long size,
+						 unsigned long stride,
+						 unsigned long asid)
+{
+	u16 nr_ptes_in_range = DIV_ROUND_UP(size, stride);
+	int i;
+
+	if (nr_ptes_in_range > tlb_flush_all_threshold) {
+		if (asid != -1)
+			local_flush_tlb_all_asid(asid);
+		else
+			local_flush_tlb_all();
+		return;
+	}
+
+	for (i = 0; i < nr_ptes_in_range; ++i) {
+		if (asid != -1)
+			local_flush_tlb_page_asid(start, asid);
+		else
+			local_flush_tlb_page(start);
+		start += stride;
+	}
+}
+
 static inline void local_flush_tlb_range(unsigned long start,
 		unsigned long size, unsigned long stride)
 {
 	if (size <= stride)
 		local_flush_tlb_page(start);
-	else
+	else if (size == (unsigned long)-1)
 		local_flush_tlb_all();
+	else
+		local_flush_tlb_range_threshold_asid(start, size, stride, -1);
+
 }
 
 static inline void local_flush_tlb_range_asid(unsigned long start,
@@ -38,8 +73,10 @@ static inline void local_flush_tlb_range_asid(unsigned long start,
 {
 	if (size <= stride)
 		local_flush_tlb_page_asid(start, asid);
-	else
+	else if (size == (unsigned long)-1)
 		local_flush_tlb_all_asid(asid);
+	else
+		local_flush_tlb_range_threshold_asid(start, size, stride, asid);
 }
 
 static void __ipi_flush_tlb_all(void *info)
-- 
2.39.2

