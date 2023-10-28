Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E814A7DAA1B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 01:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjJ1XNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 19:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjJ1XNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 19:13:44 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFEFD6
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 16:13:42 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cc131e52f1so18759055ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 16:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1698534822; x=1699139622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+YSC/hhoRjtMopBh7FLE1bSq2O3YdveY+o3Gj9D1j+k=;
        b=UxmzIfftYYnNOz9waJLgkfrA1vz8CLxl09VIpvPuR/CmnJ38g9XlHwXRtdhVANiYY/
         PHYmCJogcqyWhTaCjjc8OGVJfnrQJKNaFzAmdSbx22YgrAvZwNGelfjbw1JmtZV9OJRd
         mNFOQW3yC6T4tpPLfA+TR5VHa7AIja0a02uHHHHFfGkJsw3I8P7sO91BP3yyZzVkJBAv
         0ua7vIHr6Nj0FW0EYUYlPfKmkscaEwmwVBT4uiI/FKQxajFThAcX/08liDZZmPnIEH4D
         2NukUhfR3KAHWcNlvhmXwPE/L8xSvTPetgqNz5WqkTwhx3EViXvha8+cem2/JEAAlxjC
         GrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698534822; x=1699139622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+YSC/hhoRjtMopBh7FLE1bSq2O3YdveY+o3Gj9D1j+k=;
        b=VW9aMAg+ExwdcTJjAOTOwnbmvrCgdctSBp6b25qVzFeovrQsbHlcZ3EzoycUjrkWYk
         ML5sJpD6l32QYMOcyGAOzLmUcK1ePDynOxFQSQhYrYKk5i80ywS/7qX/9axMIM8YecsU
         GENC34CbhFL2M16iLrgzjnJGe/lLVR7TvkbuSfWnejHDQ76yenAW0102FvB7EtFl7YDv
         8uAEG6hOarkFOkIoP4YYQ2mbhPeyjlNMWXZ1aAJNjEf3cLrYKAAuXsSzpmqRvasOmwiI
         AFlLhehe7BS2DHbDtP313SHgttnVdoRvFEQpVKDcVtkwgJ9Vqpl8WpyP67zsAdO6XXA5
         J4mg==
X-Gm-Message-State: AOJu0YwxlzBHBa+XUMSW5mjS3+D3dZMy0YXHBGKBglSV0cVx7pI/fr+D
        SjI1XXAUQHrae8ARBkIOcRVckw==
X-Google-Smtp-Source: AGHT+IF0JBsKL86F5ZkzVy7xM0AKZ7eTjPFOs+Rl6fenaIpINViQpBDxNJRC+nKxa/+obzBqy2Feog==
X-Received: by 2002:a17:903:11d1:b0:1cc:f41:8f82 with SMTP id q17-20020a17090311d100b001cc0f418f82mr8777732plh.16.1698534821805;
        Sat, 28 Oct 2023 16:13:41 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b001b8622c1ad2sm3679345ple.130.2023.10.28.16.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 16:13:41 -0700 (PDT)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 00/11] riscv: ASID-related and UP-related TLB flush enhancements
Date:   Sat, 28 Oct 2023 16:11:58 -0700
Message-ID: <20231028231339.3116618-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

[1]: https://lore.kernel.org/linux-riscv/20231019140151.21629-1-alexghiti@rivosinc.com/
---
This series is based on v5 of Alexandre's changes, which I have included
here so the series can be built by the CI bots. I will rebase once his
series is merged.

Changes in v2:
 - Rebase on Alexandre's "riscv: tlb flush improvements" series v5
 - Move the SMP/UP merge earlier in the series to avoid build issues
 - Make a copy of __flush_tlb_range() instead of adding ifdefs inside
 - local_flush_tlb_all() is the only function used on !MMU (smpboot.c)

Alexandre Ghiti (4):
  riscv: Improve tlb_flush()
  riscv: Improve flush_tlb_range() for hugetlb pages
  riscv: Make __flush_tlb_range() loop over pte instead of flushing the
    whole tlb
  riscv: Improve flush_tlb_kernel_range()

Samuel Holland (7):
  riscv: mm: Combine the SMP and UP TLB flush code
  riscv: Apply SiFive CIP-1200 workaround to single-ASID sfence.vma
  riscv: mm: Introduce cntx2asid/cntx2version helper macros
  riscv: mm: Use a fixed layout for the MM context ID
  riscv: mm: Make asid_bits a local variable
  riscv: mm: Preserve global TLB entries when switching contexts
  riscv: mm: Always use ASID to flush MM contexts

 arch/riscv/include/asm/errata_list.h |  12 +-
 arch/riscv/include/asm/mmu.h         |   3 +
 arch/riscv/include/asm/mmu_context.h |   2 -
 arch/riscv/include/asm/sbi.h         |   3 -
 arch/riscv/include/asm/tlb.h         |   8 +-
 arch/riscv/include/asm/tlbflush.h    |  59 +++++----
 arch/riscv/kernel/sbi.c              |  32 ++---
 arch/riscv/mm/Makefile               |   5 +-
 arch/riscv/mm/context.c              |  26 ++--
 arch/riscv/mm/tlbflush.c             | 184 ++++++++++++++++-----------
 10 files changed, 186 insertions(+), 148 deletions(-)

-- 
2.42.0

