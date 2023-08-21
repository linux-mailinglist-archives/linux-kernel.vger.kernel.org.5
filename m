Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8551E782912
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbjHUMbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbjHUMbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:31:19 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891CBBE;
        Mon, 21 Aug 2023 05:31:16 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RTsHY0pyfzrSqg;
        Mon, 21 Aug 2023 20:29:45 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 21 Aug 2023 20:31:11 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     <surenb@google.com>, <willy@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
        <linux-s390@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH rfc -next v2 00/10] mm: convert to generic VMA lock-based page fault
Date:   Mon, 21 Aug 2023 20:30:46 +0800
Message-ID: <20230821123056.2109942-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a generic VMA lock-based page fault handler in mm core, and convert
architectures to use it, which eliminate architectures's duplicated
codes.

With it, we can avoid multiple changes in architectures's code if we 
add new feature or bugfix, in the end, enable this feature on ARM32
and Loongarch.

This is based on next-20230817, only built test.

v2: 
- convert "int arch_vma_check_access()" to "bool arch_vma_access_error()"
  still use __weak function for arch_vma_access_error(), which avoid to
  declare access_error() in architecture's(x86/powerpc/riscv/loongarch)
  headfile.
- re-use struct vm_fault instead of adding new struct vm_locked_fault,
  per Matthew Wilcox, add necessary pt_regs/fault error code/vm flags
  into vm_fault since they could be used in arch_vma_access_error()
- add special VM_FAULT_NONE and make try_vma_locked_page_fault() to
  return vm_fault_t

Kefeng Wang (10):
  mm: add a generic VMA lock-based page fault handler
  arm64: mm: use try_vma_locked_page_fault()
  x86: mm: use try_vma_locked_page_fault()
  s390: mm: use try_vma_locked_page_fault()
  powerpc: mm: use try_vma_locked_page_fault()
  riscv: mm: use try_vma_locked_page_fault()
  ARM: mm: try VMA lock-based page fault handling first
  loongarch: mm: cleanup __do_page_fault()
  loongarch: mm: add access_error() helper
  loongarch: mm: try VMA lock-based page fault handling first

 arch/arm/Kconfig          |   1 +
 arch/arm/mm/fault.c       |  35 ++++++++----
 arch/arm64/mm/fault.c     |  60 ++++++++-------------
 arch/loongarch/Kconfig    |   1 +
 arch/loongarch/mm/fault.c | 111 ++++++++++++++++++++++----------------
 arch/powerpc/mm/fault.c   |  66 +++++++++++------------
 arch/riscv/mm/fault.c     |  58 +++++++++-----------
 arch/s390/mm/fault.c      |  66 ++++++++++-------------
 arch/x86/mm/fault.c       |  55 ++++++++-----------
 include/linux/mm.h        |  17 ++++++
 include/linux/mm_types.h  |   2 +
 mm/memory.c               |  39 ++++++++++++++
 12 files changed, 278 insertions(+), 233 deletions(-)

-- 
2.27.0

