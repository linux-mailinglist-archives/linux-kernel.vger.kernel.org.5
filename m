Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB90D803B7E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjLDR04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjLDR0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:26:55 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312AE83
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:27:02 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5caf61210e3so66086277b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 09:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701710821; x=1702315621; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M646tH9YYmwVxUliD4L7Z8ZBWWZDACIb65kUaN+JDEY=;
        b=lTt710ezl89QNlOsCBl4a9+pweU89TFCWVh9hqGjr29urQKjCQaQEuuk3oHrYnR8ld
         2GNveWe990ytW/1NxCWPohuoubvBzUqfem0UlypiZQU/eK01QD0PEkYE7bGcyomoFHF2
         k4FW+4Yfshiv5SNqKVcc/qUdSBWvNodeZAyR+fU4CdrLluxjWDJ5Ja7KRjcZdXvu1Xpr
         UhAyo6hDs3ZdjNbwMTgpoNer4uOiBoOwQ87zHFWJlbqAR/ON/LYK1RTVaTCg7KRb8rtK
         WPKeoYHTNWaTwN5Tnz9mYCrdsb/g+zaYck4oPW+DZiGBQlN6CI/PpN4msxXJOOBP+Wsl
         YY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701710821; x=1702315621;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M646tH9YYmwVxUliD4L7Z8ZBWWZDACIb65kUaN+JDEY=;
        b=aaKeX2LDnMT46cxs42k4ZPqdJRyYKLm42N2hukUOzuZupwe8kq6tOMng/3Fz6gkzXW
         SO+23N32KxwEJ6x7YpRzxKaBOONPLCpjaiaGdNcHRz2uGyJQUXVsm9EM0/ZPRCShoEFH
         Ok/tdumQLSBIXmtKXuHygOdS1B15LtBNSYM3CAmlrTr5n63Z+xFFO852QOdHMadBtceC
         w+ZSwlou5QhaNOAGf2kDgmaX+VNKTurI81th/cna20BH9xSQIpIWC4aSmwXUVp4oMaZ7
         ojMyhEbdt1UPzMo4+tnMpBjRTVpcrBWkKXgYytvxa8ROqba06TLTn8BSVTmI1Uzuodfw
         Xpag==
X-Gm-Message-State: AOJu0Yx55+kKIHw79GSnKBQc7036i5WOopn22hC6craxLcyCZIumW1pi
        R/jCf9AahbGrC6h25iONY3JP8PhSiDtWhzP5
X-Google-Smtp-Source: AGHT+IFU4tbIhHWbcBjJMUiGZh9G54veSthWxnyjrGsysWMzJ17YmnTeGnNZLoFKlU7bhRJcKNmlIXFlXDdpJGNN
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a0d:d60d:0:b0:5d3:9222:a83e with SMTP
 id y13-20020a0dd60d000000b005d39222a83emr415074ywd.10.1701710821479; Mon, 04
 Dec 2023 09:27:01 -0800 (PST)
Date:   Mon,  4 Dec 2023 17:26:44 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204172646.2541916-1-jthoughton@google.com>
Subject: [PATCH 0/2] arm64: hugetlb: Fix page fault loop for sw-dirty/hw-clean
 contiguous PTEs
From:   James Houghton <jthoughton@google.com>
To:     Steve Capper <steve.capper@arm.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is currently possible for a userspace application to enter a page
fault loop when using HugeTLB pages implemented with contiguous PTEs
when HAFDBS is not available. This happens because:
1. The kernel may sometimes write PTEs that are sw-dirty but hw-clean
   (PTE_DIRTY | PTE_RDONLY | PTE_WRITE).
2. If, during a write, the CPU uses a sw-dirty, hw-clean PTE in handling
   the memory access on a system without HAFDBS, we will get a page
   fault.
3. HugeTLB will check if it needs to update the dirty bits on the PTE.
   For contiguous PTEs, it will check to see if the pgprot bits need
   updating. In this case, HugeTLB wants to write a sequence of
   sw-dirty, hw-dirty PTEs, but it finds that all the PTEs it is about
   to overwrite are all pte_dirty() (pte_sw_dirty() => pte_dirty()),
   so it thinks no update is necessary.

Please see this[1] reproducer.

I think (though I may be wrong) that both step (1) and step (3) are
buggy.

The first patch in this series fixes step (3); instead of checking if
pte_dirty is matching in __cont_access_flags_changed, check pte_hw_dirty
and pte_sw_dirty separately.

The second patch in this series makes step (1) less likely to occur.
Without this patch, we can get the kernel to write a sw-dirty, hw-clean
PTE with the following steps (showing the relevant VMA flags and pgprot
bits):
i.   Create a valid, writable contiguous PTE.
       VMA vmflags:     VM_SHARED | VM_READ | VM_WRITE
       VMA pgprot bits: PTE_RDONLY | PTE_WRITE
       PTE pgprot bits: PTE_DIRTY | PTE_WRITE
ii.  mprotect the VMA to PROT_NONE.
       VMA vmflags:     VM_SHARED
       VMA pgprot bits: PTE_RDONLY
       PTE pgprot bits: PTE_DIRTY | PTE_RDONLY
iii. mprotect the VMA back to PROT_READ | PROT_WRITE.
       VMA vmflags:     VM_SHARED | VM_READ | VM_WRITE
       VMA pgprot bits: PTE_RDONLY | PTE_WRITE
       PTE pgprot bits: PTE_DIRTY | PTE_WRITE | PTE_RDONLY

Applying either one of the two patches in this patchset will fix the
particular issue with HugeTLB pages implemented with contiguous PTEs.
It's possible that only one of these patches should be taken, or that
the right fix is something else entirely.

[1]: https://gist.github.com/48ca/11d1e466deee032cb35aa8c2280f93b0

James Houghton (2):
  arm64: hugetlb: Distinguish between hw and sw dirtiness in
    __cont_access_flags_changed
  arm64: mm: Always make sw-dirty PTEs hw-dirty in pte_modify

 arch/arm64/include/asm/pgtable.h | 6 ++++++
 arch/arm64/mm/hugetlbpage.c      | 5 ++++-
 2 files changed, 10 insertions(+), 1 deletion(-)


base-commit: 645a9a454fdb7e698a63a275edca6a17ef97afc4
-- 
2.43.0.rc2.451.g8631bc7472-goog

