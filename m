Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221647BB441
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 11:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjJFJak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 05:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjJFJai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:30:38 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB0AD6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 02:30:35 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40566f89f6eso18224145e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 02:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696584633; x=1697189433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEPgDTMpIXvshpOSSpINtGH8/u8zbO38mo5vAWcHcCQ=;
        b=k9BtBlJmJR/2qj/wvv+FJu36Ar9VqGV5ju8UKsaW8OfRypR5mQL/VULPKIyZ6I9Nsq
         Z8vPxSiLv4o9L2X+MUR3VK0nCaIHBdwRGLMd4K7QwcgCCaleRoXh744ZcLa1+J0xPO2P
         f+RRAu+L/4z2QeBQpvjw56xpc7haD0v08CiSjvmOX0W9LtGlj5j2OzyXzApTGiPg/DA8
         IRaxWcqzesRvPQlDxVCO7nmagliW/UV46wAeaLHu/bdmlXvVlqRNbw5yKdVWSeDcJyD3
         lJjD225p5W8cX3RGIokr1713dg2wEStmiLPtEfgeIS171kk3m9f42ZFMgdBAVXWCOf97
         xiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696584633; x=1697189433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEPgDTMpIXvshpOSSpINtGH8/u8zbO38mo5vAWcHcCQ=;
        b=l9AnfVyKn2dkQCaM5G+QNk85KhEvEEjb7L1Pjn042M+CchxpEoBer4RFU5FqHk8ccQ
         GTfkFCGyc+hESNmcRvO4M39ngVOYlFrd8cu2MLAdQvk/k4Wi+13LIjzv7xvb25NsGbBC
         nmJNbvZq/XXPs1tqmCSpirT6TNHbVGDpAAUBV1lMLz5y+tgVsqzmZrJubq9ggh9r8576
         ziUElkLvQr8vQQ71MEaVcO5BXunC4xitJasbFU6u16u9COBvYVNMqOZnQxsOW/usWSmt
         KAVXbATJU929RAV0hOZHbdhEA15zkGM25qmVzup9zJI5N8/OCqRUUjv2GpUsnfdFaN0X
         E5Tw==
X-Gm-Message-State: AOJu0YxnypucjGLC8YTSSYFDM2RxcXwwq85Gt/Bn67MbUeqUY7zJCOs6
        T8UErL3orAJvOq5ErSMFq7YblQ==
X-Google-Smtp-Source: AGHT+IFzpVKciWuWfPAHKSdw21PYMXBkXodfZFcRtcTIK26f2duii9Xu2/UeFDeLVkoD/5+8XWF5LA==
X-Received: by 2002:adf:fb0b:0:b0:31f:c1b5:d4c1 with SMTP id c11-20020adffb0b000000b0031fc1b5d4c1mr6387300wrr.35.1696584633432;
        Fri, 06 Oct 2023 02:30:33 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id c16-20020a5d4f10000000b00324ae863ac1sm1211986wru.35.2023.10.06.02.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 02:30:33 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 1/2] riscv: Don't use PGD entries for the linear mapping
Date:   Fri,  6 Oct 2023 11:29:29 +0200
Message-Id: <20231006092930.15850-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231006092930.15850-1-alexghiti@rivosinc.com>
References: <20231006092930.15850-1-alexghiti@rivosinc.com>
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

Propagating changes at this level is cumbersome as we need to go through
all the page tables when that happens (either when changing the
permissions or when splitting the mapping).

Note that this prevents the use of 4MB mapping for sv32 and 1GB mapping for
sv39 in the linear mapping.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/init.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 0798bd861dcb..6dc61d3c392f 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -664,16 +664,16 @@ void __init create_pgd_mapping(pgd_t *pgdp,
 static uintptr_t __init best_map_size(phys_addr_t pa, uintptr_t va,
 				      phys_addr_t size)
 {
-	if (!(pa & (PGDIR_SIZE - 1)) && !(va & (PGDIR_SIZE - 1)) && size >= PGDIR_SIZE)
-		return PGDIR_SIZE;
-
-	if (!(pa & (P4D_SIZE - 1)) && !(va & (P4D_SIZE - 1)) && size >= P4D_SIZE)
+	if (pgtable_l5_enabled &&
+	    !(pa & (P4D_SIZE - 1)) && !(va & (P4D_SIZE - 1)) && size >= P4D_SIZE)
 		return P4D_SIZE;
 
-	if (!(pa & (PUD_SIZE - 1)) && !(va & (PUD_SIZE - 1)) && size >= PUD_SIZE)
+	if (pgtable_l4_enabled &&
+	    !(pa & (PUD_SIZE - 1)) && !(va & (PUD_SIZE - 1)) && size >= PUD_SIZE)
 		return PUD_SIZE;
 
-	if (!(pa & (PMD_SIZE - 1)) && !(va & (PMD_SIZE - 1)) && size >= PMD_SIZE)
+	if (IS_ENABLED(CONFIG_64BIT) &&
+	    !(pa & (PMD_SIZE - 1)) && !(va & (PMD_SIZE - 1)) && size >= PMD_SIZE)
 		return PMD_SIZE;
 
 	return PAGE_SIZE;
-- 
2.39.2

