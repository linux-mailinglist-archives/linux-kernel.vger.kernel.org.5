Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED957F58B8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 07:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344818AbjKWG5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 01:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbjKWG5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 01:57:45 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244A8D47
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 22:57:26 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6cbc8199a2aso498921b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 22:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700722645; x=1701327445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zo9GRhTooUc/KviZnnIa42NwX6MC9ytBHXrHIhQGMDg=;
        b=WcazZeFYOHHmjOfZmSEbhf0zumLwVV6tPZFnaVqYjdL9dFTDZ7NBIEV+zwoeCkTE5O
         h704rp6nGrHQzlBoJft/kwVzrdmsFhSywtPtJB4dKVxlrVGBJP7R7dPZHs+SbOQmbqDA
         GhjN6r89S5oRi6p3H0nRnC/i/in8PdX6kA4Tb8IpsEIoHCqOT7U1yXp8kFamPXnIefcc
         xNCFnV2Wog6IQIcPbKLhB5mNxD4ftmL3z01juNTJDonFB/rqJwXG6Z0qvJMTGZQ+WSz9
         e9VJB5QARX8FgyaOKlSiQwK1APzfSddLRwizqLw4bbonoCohmqGdglPDXXEiOI8+dnQh
         jRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700722645; x=1701327445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zo9GRhTooUc/KviZnnIa42NwX6MC9ytBHXrHIhQGMDg=;
        b=YtyOqd5ybTS66DAPfHlVEaUBetriveCK0ktn8zuntlBSyJKVEKzVWNDFhNKIwxLrW8
         R4vC0Wjg9ga14ZzyWeyE9+oxwxARWZbfEoAlSIgrnmfQ/XnQpP8hDyq1CRQamvrWHZXI
         RITxm1r8srHY5fhiBqclEfTIW/AuCSvly55jJ2HNTONkFjLWo8q5evpQwIS2qabiOsZK
         sEU2kRIuj/Jzk8GwUz8fGkbGXkKNnk7YsFSuJHECVHMlWXVyQNkJ6wHEFg7UWNKog2nO
         lfcFH3ef5HzrgyedZVhhYJ8KA/ajtuT5ptm3aNoHmEQnyAdhY6P4pLCxMppYYX8ws6Kt
         GXqQ==
X-Gm-Message-State: AOJu0YzRq40iAFzxMzEkUzI5Hn4fcpMmKIHHmplrIrrac1IW7cG8wq7y
        qskJenkyhHTYb9QNgLPbFW287Q==
X-Google-Smtp-Source: AGHT+IFC8CTJwQfCdcwwV65icXEzK+yHQwysBVFM0GjAc8siyhBsnU47kygIO6p8RgVConNr22R8sQ==
X-Received: by 2002:a05:6a00:1f08:b0:6cb:a431:2d75 with SMTP id be8-20020a056a001f0800b006cba4312d75mr5099452pfb.7.1700722645519;
        Wed, 22 Nov 2023 22:57:25 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id w37-20020a634765000000b005bd2b3a03eesm615437pgk.6.2023.11.22.22.57.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Nov 2023 22:57:25 -0800 (PST)
From:   Xu Lu <luxu.kernel@bytedance.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, ardb@kernel.org, anup@brainfault.org,
        atishp@atishpatra.org
Cc:     dengliang.1214@bytedance.com, xieyongji@bytedance.com,
        lihangjing@bytedance.com, songmuchun@bytedance.com,
        punit.agrawal@bytedance.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH V1 00/11] riscv: Introduce 64K base page
Date:   Thu, 23 Nov 2023 14:56:57 +0800
Message-Id: <20231123065708.91345-1-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some existing architectures like ARM supports base page larger than 4K
as their MMU supports more page sizes. Thus, besides hugetlb page and
transparent huge page, there is another way for these architectures to
enjoy the benefits of fewer TLB misses without worrying about cost of
splitting and merging huge pages. However, on architectures with only
4K MMU, larger base page is unavailable now.

This patch series attempts to break through the limitation of MMU and
supports larger base page on RISC-V, which only supports 4K page size
now.

The key idea to implement larger base page based on 4K MMU is to
decouple the MMU page from the base page in view of kernel mm, which we
denote as software page. In contrary to software page, we denote the MMU
page as hardware page. Below is the difference between these two kinds
of pages.

1. Kernel memory management module manages, allocates and maps memory at
a granularity of software page, which should not be restricted by
MMU and can be larger than hardware page.

2. Architecture page table operations should be carried out from MMU's
perspective and page table entries are encoded at a granularity of
hardware page, which is 4K on RISC-V MMU now.

The main work to decouple these two kinds of pages lies in architecture
code. For example, we turn the pte_t struct to an array of page table
entries to match it with software page which can be larger than hardware
page, and adapt the page table operations accordingly. For 64K software
base page, the pte_t struct now contains 16 contiguous page table
entries which point to 16 contiguous 4K hardware pages.

To achieve the benefits of large base page, we applies Svnapot for each
base page's mapping. The Svnapot extension on RISC-V is like contiguous
PTE on ARM64. It allows ptes of a naturally aligned power-of 2 size
memory range be encoded in the same format to save the TLB space.

This patch series is the first version and is based on v6.7-rc1. This
version supports both bare metal and virtualization scenarios.

In the next versions, we will continue on the following works:

1. Reduce the memory usage of page table page as it only uses 4K space
while costs a whole base page.

2. When IMSIC interrupt file is smaller than 64K, extra isolation
measures for the interrupt file are needed. (S)PMP and IOPMP may be good
choices.

3. More consideration is needed to make this patch series collaborate
with folios better.

4. Support 64K base page on IOMMU.

5. The performance test is on schedule to verify the actual performance
improvement and the decrease in TLB miss rate.

Thanks in advance for comments.

Xu Lu (11):
  mm: Fix misused APIs on huge pte
  riscv: Introduce concept of hardware base page
  riscv: Adapt pte struct to gap between hw page and sw page
  riscv: Adapt pte operations to gap between hw page and sw page
  riscv: Decouple pmd operations and pte operations
  riscv: Distinguish pmd huge pte and napot huge pte
  riscv: Adapt satp operations to gap between hw page and sw page
  riscv: Apply Svnapot for base page mapping
  riscv: Adjust fix_btmap slots number to match variable page size
  riscv: kvm: Adapt kvm to gap between hw page and sw page
  riscv: Introduce 64K page size

 arch/Kconfig                        |   1 +
 arch/riscv/Kconfig                  |  28 +++
 arch/riscv/include/asm/fixmap.h     |   3 +-
 arch/riscv/include/asm/hugetlb.h    |  71 ++++++-
 arch/riscv/include/asm/page.h       |  16 +-
 arch/riscv/include/asm/pgalloc.h    |  21 ++-
 arch/riscv/include/asm/pgtable-32.h |   2 +-
 arch/riscv/include/asm/pgtable-64.h |  45 +++--
 arch/riscv/include/asm/pgtable.h    | 282 +++++++++++++++++++++++-----
 arch/riscv/kernel/efi.c             |   2 +-
 arch/riscv/kernel/head.S            |   4 +-
 arch/riscv/kernel/hibernate.c       |   3 +-
 arch/riscv/kvm/mmu.c                | 198 +++++++++++++------
 arch/riscv/mm/context.c             |   7 +-
 arch/riscv/mm/fault.c               |   1 +
 arch/riscv/mm/hugetlbpage.c         |  42 +++--
 arch/riscv/mm/init.c                |  25 +--
 arch/riscv/mm/kasan_init.c          |   7 +-
 arch/riscv/mm/pageattr.c            |   2 +-
 fs/proc/task_mmu.c                  |   2 +-
 include/asm-generic/hugetlb.h       |   7 +
 include/asm-generic/pgtable-nopmd.h |   1 +
 include/linux/pgtable.h             |   6 +
 mm/hugetlb.c                        |   2 +-
 mm/migrate.c                        |   5 +-
 mm/mprotect.c                       |   2 +-
 mm/rmap.c                           |  10 +-
 mm/vmalloc.c                        |   3 +-
 28 files changed, 616 insertions(+), 182 deletions(-)

-- 
2.20.1

