Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02517B20FF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjI1PVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjI1PVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:21:01 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEB499
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:20:59 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40651a72807so8216075e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695914458; x=1696519258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/s3Y1W25iZQB1mJnL4ozyyAV3qeno6bbn8hB9vh6xc=;
        b=F+CHUd7FFAVzYpgpFrY09w2KQpVaU1qpPiIUIaUX9ftqRt9RmVWU/21jzsjBewE0AA
         ajfQWgfrT8Qu6CiK8L5ojW6FFnCDZer+wxc7TE8wTY4U3Az1zAsj+rKeu22kYSlp1ST6
         iuQ9BP8hiU5Q4MMcYcOte3cQK4be5sOal6s4Jdx8W29JChC7cFcyr/J1V5I2QsED7Dxw
         /jeh/qFXZrArG2RTh7DSnz2cZkJSS0IDwzX1QGP6ThFGHfNOVDuErbLIzUbic9Fae5F4
         r317UlC8/K0Lf8J3akh452ZDGsFb/vIddkBE4IuuL2rxu0LJ5n2Fp3LsVfAqnjJORmoS
         /dTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695914458; x=1696519258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/s3Y1W25iZQB1mJnL4ozyyAV3qeno6bbn8hB9vh6xc=;
        b=ExOzVXkAQKVBWkoTdu5eQUP1TBNuq1NECi71mWuaKZ+/NB9mEWdZNCp8BMrwkzwO0q
         N1EHzIWZ/qu+l4SHopuMHFnFHAjFQL4ciY0U5aFcultjhWY4uHg3Du/bwKgNsfEZD/sf
         hB+CkqeBBw1HTiHI5R19cIP71hbkcwDC9YVy3BpIe/O4U72ak/DC/ICbaU1O7PV/u+Ld
         QwULVFPegs9RiPqkmErncbS3QeeKV9azYfVV31aRz9eJpZFV2e0nLqP3xvtXOdMkAla4
         YU/vW3pcLUb94iLKnFOL11JPCukZID7WiWJv6Lmpr5fpkihUM0zqu2uf1UaIOvhrsBvm
         MBOQ==
X-Gm-Message-State: AOJu0Yy0T3Wae0xITXqI38Wsy4Z02D5Kb1pwtlXT8jLNsG2fZaxjSH1L
        2MB6GLg3NxG8mv4Ve61PFYlGvw==
X-Google-Smtp-Source: AGHT+IEd+ssB1Y2KqFPwYkco88+YASLbrAClJGH2m5sqO5EEDMYwFhwAMOmwIh6ZqOoIOyKuGB+f5w==
X-Received: by 2002:a5d:595e:0:b0:31a:e376:6bd6 with SMTP id e30-20020a5d595e000000b0031ae3766bd6mr1444503wri.45.1695914457749;
        Thu, 28 Sep 2023 08:20:57 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com ([2a02:8440:4541:1a11:c4e7:d9ee:586b:e201])
        by smtp.gmail.com with ESMTPSA id m26-20020a056000025a00b003233a31a467sm6038630wrz.34.2023.09.28.08.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 08:20:57 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH -fixes 2/2] riscv: Fix set_huge_pte_at() for NAPOT mappings when a swap entry is set
Date:   Thu, 28 Sep 2023 17:18:46 +0200
Message-Id: <20230928151846.8229-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230928151846.8229-1-alexghiti@rivosinc.com>
References: <20230928151846.8229-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used to determine the number of page table entries to set for a NAPOT
hugepage by using the pte value which actually fails when the pte to set is
a swap entry.

So take advantage of a recent fix for arm64 reported in [1] which
introduces the size of the mapping as an argument of set_huge_pte_at(): we
can then use this size to compute the number of page table entries to set
for a NAPOT region.

Fixes: 82a1a1f3bfb6 ("riscv: mm: support Svnapot in hugetlb page")
Reported-by: Ryan Roberts <ryan.roberts@arm.com>
Closes: https://lore.kernel.org/linux-arm-kernel/20230922115804.2043771-1-ryan.roberts@arm.com/ [1]
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/hugetlbpage.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index e4a2ace92dbe..b52f0210481f 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -183,15 +183,22 @@ void set_huge_pte_at(struct mm_struct *mm,
 		     pte_t pte,
 		     unsigned long sz)
 {
+	unsigned long hugepage_shift;
 	int i, pte_num;
 
-	if (!pte_napot(pte)) {
-		set_pte_at(mm, addr, ptep, pte);
-		return;
-	}
+	if (sz >= PGDIR_SIZE)
+		hugepage_shift = PGDIR_SHIFT;
+	else if (sz >= P4D_SIZE)
+		hugepage_shift = P4D_SHIFT;
+	else if (sz >= PUD_SIZE)
+		hugepage_shift = PUD_SHIFT;
+	else if (sz >= PMD_SIZE)
+		hugepage_shift = PMD_SHIFT;
+	else
+		hugepage_shift = PAGE_SHIFT;
 
-	pte_num = napot_pte_num(napot_cont_order(pte));
-	for (i = 0; i < pte_num; i++, ptep++, addr += PAGE_SIZE)
+	pte_num = sz >> hugepage_shift;
+	for (i = 0; i < pte_num; i++, ptep++, addr += (1 << hugepage_shift))
 		set_pte_at(mm, addr, ptep, pte);
 }
 
-- 
2.39.2

