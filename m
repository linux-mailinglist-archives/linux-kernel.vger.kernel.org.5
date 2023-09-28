Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB827B20FB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjI1PUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjI1PT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:19:58 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C39DAC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:19:57 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4064867903cso27979205e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695914395; x=1696519195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQIW28iugADvBEABL7y0pWJwukdro8ctMwfbqsan8LM=;
        b=OKkplhDhN8+0b9zz2wH9gA9M1LL2sK+ZFr0mvDSW4b+u7LAey9X1r7UNwMDQO29qLt
         EPCu1ZCNB4fdJ3spwaDGKhe6PmpkTZ2mUVNh+4YsaFPsuGXduwSbsvlFtQ7Ugw4Z8fRK
         ydPOB/PzdreN1WNuDLMfinPqOI4x4cVMw5RHZX7R9vP42Hq9/GfjmnRsloHlIk4W15Mm
         F6rPm3ZEC6acAsAsRzDps1bEA/S34D/bRkRTwLzI2aRtPRUl7FGFOCX51n+h7WfT2bpg
         oeLFMBBUFZUWbQvM4eYNPFz/46HZQl27nPvhuNuKKr6gCXO1JG3JabvVP9rmy07tJQL/
         uzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695914395; x=1696519195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQIW28iugADvBEABL7y0pWJwukdro8ctMwfbqsan8LM=;
        b=aIUGNcro6NFeltmfdPahuET+yAFf1FpwgFE/n6gsUKodTYkacyuxiz5CrbT/IOq8FH
         rUGl5jg7N6Hd2AvUVt/IT86RYxpxY1tyZjxdvBhBdqFEkmBJ5EndwRHtWlsBUx1SEZD3
         ZxVew4LeaNS5qTjKKJ3LcPtB3sjCF/f1ZI5wpRhIAVcyZUUcxd2Ysbh9168Z0FSPidLm
         +RA32Pddz4r3injASvstQICddEOxnKipa14MSCrBk0RuQkpezdnahiW8ltCRU/9TB7yj
         RsDG0bl+7rTlpPEvS96SeoHOFaQMDcomSH54p9Xg/GK9gKB56k33uQ2bEIcktV1In0Lu
         iz6Q==
X-Gm-Message-State: AOJu0YxySfnqfHaE9Ru+FFx37k8kwa7ObrmxxtXiFBFGxKVk/K6KeOyb
        MMwHjU9Zi0c1hIiNwL88RRL1Mw==
X-Google-Smtp-Source: AGHT+IEDhPiD3spqKlIFdXrJWeBlpdxdjvj34bobPi9FQk5MmYA/SlcbPlLXpJTTuzWJ13sPk2CNtA==
X-Received: by 2002:adf:eb47:0:b0:31f:e2b9:de1f with SMTP id u7-20020adfeb47000000b0031fe2b9de1fmr1247149wrn.24.1695914395323;
        Thu, 28 Sep 2023 08:19:55 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com ([2a02:8440:4541:1a11:c4e7:d9ee:586b:e201])
        by smtp.gmail.com with ESMTPSA id t6-20020a5d6906000000b00321773bb933sm950874wru.77.2023.09.28.08.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 08:19:54 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH -fixes 1/2] riscv: Handle VM_FAULT_[HWPOISON|HWPOISON_LARGE] faults instead of panicking
Date:   Thu, 28 Sep 2023 17:18:45 +0200
Message-Id: <20230928151846.8229-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230928151846.8229-1-alexghiti@rivosinc.com>
References: <20230928151846.8229-1-alexghiti@rivosinc.com>
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

We used to panic when such faults were encountered but we should handle
those faults gracefully for userspace by sending a SIGBUS to the process,
like most architectures do.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 6115d7514972..90d4ba36d1d0 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -72,7 +72,7 @@ static inline void mm_fault_error(struct pt_regs *regs, unsigned long addr, vm_f
 		}
 		pagefault_out_of_memory();
 		return;
-	} else if (fault & VM_FAULT_SIGBUS) {
+	} else if (fault & (VM_FAULT_SIGBUS | VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE)) {
 		/* Kernel mode? Handle exceptions or die */
 		if (!user_mode(regs)) {
 			no_context(regs, addr);
-- 
2.39.2

