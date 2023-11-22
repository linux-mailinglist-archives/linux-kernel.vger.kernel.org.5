Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42CA7F3AFE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 02:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbjKVBIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 20:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjKVBIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 20:08:21 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92F8197
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:08:17 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6d7e6df999fso548191a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700615297; x=1701220097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5K3acMXD355Dnu5c/0LgKAwcyMlLGIb9WZpaCFq6NtI=;
        b=ThT2IOM5yS7YG8dGXAQODYsC0g9xmf8HYQO5pwUMFrmjdh4oUCbDSKornmANLtfZx0
         9uNHCb0bUfiMTUkzxIKastZ04T31Fd/tYly9vaL/N3Rsxkq+j2LM/RpQArC/F8CydDVN
         6n8NyLjlF19GrDFMrAZfAOxfxgHm9AaNRXXW7JMhTr8CLiY1LBgoYF9OTXM07Bd3Adco
         zdJzpLoKRrQjq+opWBwADTvnOgdMRchQ6J9PSPauqNZUApUMrV8fuq+nZ6oJmBYm4N03
         +wVbAjx956xs10FlzP/W8Ccor2YzIwTZkXeaxzty70JVeo0ACrEfgB3kVS023t4M4ARV
         G49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700615297; x=1701220097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5K3acMXD355Dnu5c/0LgKAwcyMlLGIb9WZpaCFq6NtI=;
        b=hu6lwqhKMrAua3Zhd1k53t7WXia7R2VGYi9jd+9o7B54VpWPk3hxrJ1y/R031S4UGp
         A8URM6bjP1QqUDKxHw/WsWRKdzyEhXyt63bp5kbVOTSGpfrSNXEOTiitdb0mtWaxC4QL
         dfMu3Pq/7I1US2hJJTb5MrAFfTOElx7BE2/G8TNPX5f8b6T9nA6UCgIxZt19p7W5U8ON
         0wMabWJ51YqfSNfFdEantg9GqaE+Ev3oPKcG1yXCRKTFaZdi8nqEb9UFhmgwjZ2kmz7W
         cQaL/dsiZbKfsW1S9EPyCYi/qP5QzPtjUBwvV0B2we9bBWs/lNzp9u5iTgROzvYirjC+
         Fipg==
X-Gm-Message-State: AOJu0Yy1GU7TZkb8w67uR4Get3XZQLX/OepORhzqvhJXJUgU27Fe+BIe
        DdV7iXhJbV2b7ef/CjS5out//mJlYa4VOgy5Xj8=
X-Google-Smtp-Source: AGHT+IH6/NUuwGldOP1aJCDWjPm+XWVk8E4Msjy4/jNiAvoh03MIiSiJCBFz4I47qP2HX2IfskLVbg==
X-Received: by 2002:a05:6870:816:b0:1f0:1c00:d860 with SMTP id fw22-20020a056870081600b001f01c00d860mr1172251oab.51.1700615297034;
        Tue, 21 Nov 2023 17:08:17 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id bn5-20020a056a00324500b006be047268d5sm8713961pfb.174.2023.11.21.17.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 17:08:16 -0800 (PST)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 0/8] riscv: ASID-related and UP-related TLB flush enhancements
Date:   Tue, 21 Nov 2023 17:07:11 -0800
Message-ID: <20231122010815.3545294-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While reviewing Alexandre Ghiti's "riscv: tlb flush improvements"
series[1], I noticed that most TLB flush functions end up as a call to
local_flush_tlb_all() when SMP is disabled. This series resolves that.
Along the way, I realized that we should be using single-ASID flushes
wherever possible, so I implemented that as well.

[1]: https://lore.kernel.org/linux-riscv/20231030133027.19542-1-alexghiti@rivosinc.com/

Changes in v3:
 - Fixed a performance regression caused by executing sfence.vma in a
   loop on implementations affected by SiFive CIP-1200
 - Rebased on v6.7-rc1

Changes in v2:
 - Move the SMP/UP merge earlier in the series to avoid build issues
 - Make a copy of __flush_tlb_range() instead of adding ifdefs inside
 - local_flush_tlb_all() is the only function used on !MMU (smpboot.c)

Samuel Holland (8):
  riscv: mm: Combine the SMP and UP TLB flush code
  riscv: Apply SiFive CIP-1200 workaround to single-ASID sfence.vma
  riscv: Avoid TLB flush loops when affected by SiFive CIP-1200
  riscv: mm: Introduce cntx2asid/cntx2version helper macros
  riscv: mm: Use a fixed layout for the MM context ID
  riscv: mm: Make asid_bits a local variable
  riscv: mm: Preserve global TLB entries when switching contexts
  riscv: mm: Always use ASID to flush MM contexts

 arch/riscv/errata/sifive/errata.c    |  3 ++
 arch/riscv/include/asm/errata_list.h | 12 ++++++-
 arch/riscv/include/asm/mmu.h         |  3 ++
 arch/riscv/include/asm/mmu_context.h |  2 --
 arch/riscv/include/asm/tlbflush.h    | 54 ++++++++++++++--------------
 arch/riscv/mm/Makefile               |  5 +--
 arch/riscv/mm/context.c              | 26 ++++++--------
 arch/riscv/mm/tlbflush.c             | 41 ++++++++-------------
 8 files changed, 70 insertions(+), 76 deletions(-)

-- 
2.42.0

