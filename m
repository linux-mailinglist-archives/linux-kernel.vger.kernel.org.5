Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3ACC77655D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjHIQqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjHIQqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:46:38 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507F61BFA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 09:46:37 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe426b8583so61887105e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 09:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691599596; x=1692204396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LCB6J9xjkovo4nsL5var8Yeba5WXNTY3HlVH4wMSnQo=;
        b=ToePmrNnppd/Is0E7PAd+j29Nv5DFUjvi18bOflnM9U2nXEfSB4OmJTuUoQ+iE5SVW
         fJUPqV1RGbk2gV9dolFc9ZA4vRjS7062kNecnkUCSYw5YOarLb2c591nRpZMWLUfzKhJ
         tXlk/4tkJZN6qDfR9O6NFRsVPP3bms2MF3nF1rtBgVW8vsoWqXEPT4ohPmfp1CizLkbC
         J8X+dsSG43psOtrhYnaPM0mpNlYW19TqZtbRr+o2Pam9vbKY+bNz1eh9hpmBAq6J73lH
         db/hm3ocMgPBYXxSYtKUcaw0SmXAz2f+gZZ2XCjSYvjHtM2UdmX2qXVdNpIvKLmq7sbY
         BqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691599596; x=1692204396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LCB6J9xjkovo4nsL5var8Yeba5WXNTY3HlVH4wMSnQo=;
        b=O4zHZ12Iy1tSOo0zMv0Vy+s47WAzxwROA53gxmpI1Kr3q+aCUnIgEbJrkWbSut8fIL
         vu7gUZ55yQOUa1GhcdezdL14ZTXgpORWacC8shEmbHOE2VCeC4IprqI1czTEqr0HR699
         Lo4cQ4JiWxNP9IyCmXFp8+mP6v1tzHmMtgZkG2No/lhw6xvuqxR2BZF5adk11vkg0BfL
         Lix8lK2QMm8fIdRDLCJSTYZ3330LZs0i3WysIyvs8x4a2aN8tzXA6fICmASvomxjaDwS
         VdeYArGJCvachOfMszRJmz4OK+Zjk0NNe0FoBW18mND2poJFgNKSCdUAXSD4sQdvLveD
         23xg==
X-Gm-Message-State: AOJu0YxBjDVXbrd67zTEt5WXCFtE2qZ/ZS7Daxk9v3M/3ZvbRxd3WQZm
        X24As/TvP7qL6bY7w5bLEKAgnw==
X-Google-Smtp-Source: AGHT+IFBfy3CiF6uuHnwbQhdXVy+SfEPATMxJijXaIIO0WSpTUWJgGSbu4qQC+Iq/UGxZFGHXbgdmg==
X-Received: by 2002:a1c:4c12:0:b0:3fb:a0fc:1ba1 with SMTP id z18-20020a1c4c12000000b003fba0fc1ba1mr2651739wmf.35.1691599595638;
        Wed, 09 Aug 2023 09:46:35 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c205300b003fe17901fcdsm2453431wmg.32.2023.08.09.09.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 09:46:34 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Dylan Jhong <dylan@andestech.com>
Subject: [PATCH -fixes] mm: Add a call to flush_cache_vmap() in vmap_pfn()
Date:   Wed,  9 Aug 2023 18:46:33 +0200
Message-Id: <20230809164633.1556126-1-alexghiti@rivosinc.com>
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

flush_cache_vmap() must be called after new vmalloc mappings are
installed in the page table in order to allow architectures to make sure
the new mapping is visible.

Fixes: 3e9a9e256b1e ("mm: add a vmap_pfn function")
Reported-by: Dylan Jhong <dylan@andestech.com>
Closes: https://lore.kernel.org/linux-riscv/ZMytNY2J8iyjbPPy@atctrx.andestech.com/
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 mm/vmalloc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 93cf99aba335..228a4a5312f2 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2979,6 +2979,10 @@ void *vmap_pfn(unsigned long *pfns, unsigned int count, pgprot_t prot)
 		free_vm_area(area);
 		return NULL;
 	}
+
+	flush_cache_vmap((unsigned long)area->addr,
+			 (unsigned long)area->addr + count * PAGE_SIZE);
+
 	return area->addr;
 }
 EXPORT_SYMBOL_GPL(vmap_pfn);
-- 
2.39.2

