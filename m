Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0DC79B49C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347469AbjIKVYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244072AbjIKTDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:03:37 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4881AD8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:03:33 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4Rkx291PXKz9vSS;
        Mon, 11 Sep 2023 21:03:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nw_bHQy6cjNy; Mon, 11 Sep 2023 21:03:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Rkx2742kJz9vQn;
        Mon, 11 Sep 2023 21:03:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 839748B7AA;
        Mon, 11 Sep 2023 21:03:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 1Aha5oiT8Wcj; Mon, 11 Sep 2023 21:03:27 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.38])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EB0518B77E;
        Mon, 11 Sep 2023 21:03:26 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 38BJ3HXC3544184
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 21:03:17 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 38BJ3F803544183;
        Mon, 11 Sep 2023 21:03:15 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 00/19] cleanup/refactor pgtable.h
Date:   Mon, 11 Sep 2023 21:03:06 +0200
Message-ID: <cover.1694443576.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694458986; l=2457; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=cMC5CM0Co62UlKRzr9IgsouT1QS7HSdNBF4JZ/jKI4U=; b=SZjIrvl7eXBvcatDJaQ5T8kRxMzlWITwENi0XyNE+pEo+41yNIN71CSHevU1v9C6ynGI0BOzX tRTKTHrvPyQCapPPeW5D3wzxomwYfD4JGttFWaLC8hrkJaLI2PquNcY
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a cleanup of pgtable.h for nohash mainly

Main purpose is to refactor a lot of common code between
nohash/32 and nohash/64.

This series is a prerequisite for following series that will
rework PAGE flags and implement execute-only protection.

Christophe Leroy (19):
  powerpc/8xx: Fix pte_access_permitted() for PAGE_NONE
  powerpc/64e: Fix wrong test in __ptep_test_and_clear_young()
  powerpc/40x: Remove stale PTE_ATOMIC_UPDATES macro
  powerpc: Remove pte_ERROR()
  powerpc: Deduplicate prototypes of ptep_set_access_flags() and
    phys_mem_access_prot()
  powerpc: Refactor update_mmu_cache_range()
  powerpc: Untangle fixmap.h and pgtable.h and mmu.h
  powerpc/nohash: Remove {pte/pmd}_protnone()
  powerpc/nohash: Refactor declaration of {map/unmap}_kernel_page()
  powerpc/nohash: Move 8xx version of pte_update() into pte-8xx.h
  powerpc/nohash: Replace #ifdef CONFIG_44x by IS_ENABLED(CONFIG_44x) in
    pgtable.h
  powerpc/nohash: Refactor pte_update()
  powerpc/nohash: Refactor checking of no-change in pte_update()
  powerpc/nohash: Deduplicate _PAGE_CHG_MASK
  powerpc/nohash: Deduplicate pte helpers
  powerpc/nohash: Refactor ptep_test_and_clear_young()
  powerpc/nohash: Deduplicate ptep_set_wrprotect() and
    ptep_get_and_clear()
  powerpc/nohash: Refactor pte_clear()
  powerpc/nohash: Refactor __ptep_set_access_flags()

 arch/powerpc/include/asm/book3s/32/pgtable.h |  12 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h |   3 +-
 arch/powerpc/include/asm/book3s/pgtable.h    |  33 ---
 arch/powerpc/include/asm/fixmap.h            |  16 +-
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h |   1 -
 arch/powerpc/include/asm/nohash/32/pgtable.h | 201 +------------------
 arch/powerpc/include/asm/nohash/32/pte-40x.h |   3 -
 arch/powerpc/include/asm/nohash/32/pte-8xx.h |  64 ++++++
 arch/powerpc/include/asm/nohash/64/pgtable.h | 118 +----------
 arch/powerpc/include/asm/nohash/pgtable.h    | 182 +++++++++++++----
 arch/powerpc/include/asm/pgtable.h           |  32 +++
 arch/powerpc/mm/init_32.c                    |   1 +
 arch/powerpc/mm/mem.c                        |   1 +
 arch/powerpc/mm/nohash/8xx.c                 |   2 +
 arch/powerpc/mm/nohash/book3e_pgtable.c      |   2 +-
 arch/powerpc/mm/nohash/e500_hugetlbpage.c    |   3 +-
 arch/powerpc/platforms/8xx/cpm1.c            |   1 +
 17 files changed, 268 insertions(+), 407 deletions(-)

-- 
2.41.0

