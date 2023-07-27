Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E90D765BB7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjG0S4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjG0S4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:56:04 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33B319A7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:56:02 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3177163aa97so1347878f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690484161; x=1691088961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5FhI2SLAGzFPgM0XDlLYh3qjUrSBQmA+KXnizzmLufc=;
        b=UEbP1zqhCFEiTaUL5idLu7vKPg1UFl76YwNFzxk+gTjDjuwDufCyOxWIareE7LpI7M
         hQcy4WocH73NHpscnoUE2uao5LPwfT3On28WKOhhuLLnmQgK8lo4dVzqOTGjTi33ALg6
         c0/7py79DrKXQQpO35r81d4LEai/ijN+47oqcZVg/oTep4drF+adrfWVrIMhYBBmOwwW
         qxvwQ4vQ6q+8AyNVn3Mh2geRJmizY2Xeum0eYyg0CTL4wZVWTEVTg/SJ7yek42Ifpb1Q
         vGQsJgw6HlMmZSxtyxv3qNun490/7QiQpcxjaTP1yWWjQtpMhCI8ZcM2CMV4nQfYfzYr
         FQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690484161; x=1691088961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5FhI2SLAGzFPgM0XDlLYh3qjUrSBQmA+KXnizzmLufc=;
        b=F9MDluOsvctErR0qf+su0t50kcTE35RDzUMBW9JhWnlH7o759w5m1OBUQS7kpzsNXZ
         gFTY4nz1gwaJ/ugdySBEcZfcK5BfuaNWP5rBjf0of8JodPlA2SYI70PK71vuSwOWCzL8
         vwHlfXmUx+RUrj/a4aFKQMhi3kpyaJKk8VaO8AOFWgyavc1XeI5Xco80kOfxiEsKSJUo
         3X52kzbw3uYGpBrZ82l/elwKPa5LnwLaOTh1FwhT8RcDCpScz3mksLdEiKcxjjbEhk/d
         73yPFFzgYtRJHmMbIq0kBu3pJyuIzXBUXwia6gc/TRSXIGv+7bkMLc05tBU/c8oenV3i
         V5Jw==
X-Gm-Message-State: ABy/qLZtHST10gdd/asdzos9gNOfgscHzz694QQsHVx6phHRdEIpRH1K
        hLmLpTQjDBL9DNZIiSK/Ep/bUg==
X-Google-Smtp-Source: APBJJlEReV5Op3Esz4H3z1WgrD5RqflHv8MjR+KBErCwj/H8fcva/UlqbpkT+CFwmLCi+oxSnh262A==
X-Received: by 2002:a05:6000:11cc:b0:317:7af4:5297 with SMTP id i12-20020a05600011cc00b003177af45297mr4780wrx.62.1690484161377;
        Thu, 27 Jul 2023 11:56:01 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d514d000000b003172510d19dsm2754302wrt.73.2023.07.27.11.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 11:56:00 -0700 (PDT)
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
Subject: [PATCH v2 0/4] riscv: tlb flush improvements
Date:   Thu, 27 Jul 2023 20:55:49 +0200
Message-Id: <20230727185553.980262-1-alexghiti@rivosinc.com>
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

This series optimizes the tlb flushes on riscv which used to simply
flush the whole tlb whatever the size of the range to flush or the size
of the stride.

Patch 3 introduces a threshold that is microarchitecture specific and
will very likely be modified by vendors, not sure though which mechanism
we'll use to do that (dt? alternatives? vendor initialization code?).

Next steps would be to implement:
- svinval extension as Mayuresh did here [1]
- BATCHED_UNMAP_TLB_FLUSH (I'll wait for arm64 patchset to land)
- MMU_GATHER_RCU_TABLE_FREE
- MMU_GATHER_MERGE_VMAS

Any other idea welcome.

[1] https://lore.kernel.org/linux-riscv/20230623123849.1425805-1-mchitale@ventanamicro.com/

Changes in v2:
- Make static tlb_flush_all_threshold, we'll figure out later how to
  override this value on a vendor basis, as suggested by Conor and Palmer
- Fix nommu build, as reported by Conor

Alexandre Ghiti (4):
  riscv: Improve flush_tlb()
  riscv: Improve flush_tlb_range() for hugetlb pages
  riscv: Make __flush_tlb_range() loop over pte instead of flushing the
    whole tlb
  riscv: Improve flush_tlb_kernel_range()

 arch/riscv/include/asm/tlb.h      |  8 ++-
 arch/riscv/include/asm/tlbflush.h | 12 ++--
 arch/riscv/mm/tlbflush.c          | 93 +++++++++++++++++++++++++++----
 3 files changed, 96 insertions(+), 17 deletions(-)

-- 
2.39.2

