Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0006978A4D5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 05:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjH1DxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 23:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjH1Dw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 23:52:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3FC0C6
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 20:52:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F27722F4;
        Sun, 27 Aug 2023 20:53:30 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.57.227])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0CD7E3F738;
        Sun, 27 Aug 2023 20:52:48 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/mmap: Define DEFAULT_STACK_GUARD_GAP
Date:   Mon, 28 Aug 2023 09:22:48 +0530
Message-Id: <20230828035248.678960-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This just defines a macro constant i.e DEFAULT_STACK_GUARD_GAP representing
the default gap, guarding the stack mapping. This does not cause functional
changes.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/mman.h | 3 +++
 mm/mmap.c            | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/mman.h b/include/linux/mman.h
index cee1e4b566d8..cbcd20a071c0 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -8,6 +8,9 @@
 #include <linux/atomic.h>
 #include <uapi/linux/mman.h>
 
+/* Default gap for stack mapping is 256 pages */
+#define DEFAULT_STACK_GUARD_GAP (256UL << PAGE_SHIFT)
+
 /*
  * Arrange for legacy / undefined architecture specific flags to be
  * ignored by mmap handling code.
diff --git a/mm/mmap.c b/mm/mmap.c
index 3937479d0e07..8679750333bb 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2120,7 +2120,7 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 }
 
 /* enforced gap between the expanding stack and other mappings. */
-unsigned long stack_guard_gap = 256UL<<PAGE_SHIFT;
+unsigned long stack_guard_gap = DEFAULT_STACK_GUARD_GAP;
 
 static int __init cmdline_parse_stack_guard_gap(char *p)
 {
-- 
2.30.2

