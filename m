Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0850978A527
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 07:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjH1FWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 01:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjH1FWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 01:22:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3B40127
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 22:22:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 919222F4;
        Sun, 27 Aug 2023 22:22:57 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.57.227])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 47D9E3F738;
        Sun, 27 Aug 2023 22:22:15 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/mmap: Tighten up cmdline_parse_stack_guard_gap()
Date:   Mon, 28 Aug 2023 10:52:12 +0530
Message-Id: <20230828052212.748872-1-anshuman.khandual@arm.com>
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

Currently kernel command line 'stack_guard_gap=', which does not provide an
explicit pages gap value, still assigns 0 to 'stack_guard_gap', which would
not have been expected. In such cases it should just retain the default gap
value (DEFAULT_STACK_GUARD_GAP). Instead let's assert a positive value for
input gap pages before proceeding any further. While here, this tightens up
cmdline_parse_stack_guard_gap() for other scenarios, where the command line
parameter 'stack_guard_gap' is not successfully handled as expected.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Depends on the following patch.

https://lore.kernel.org/all/20230828035248.678960-1-anshuman.khandual@arm.com/

 mm/mmap.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 8679750333bb..adaa81d95518 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2122,16 +2122,19 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 /* enforced gap between the expanding stack and other mappings. */
 unsigned long stack_guard_gap = DEFAULT_STACK_GUARD_GAP;
 
-static int __init cmdline_parse_stack_guard_gap(char *p)
+static int __init cmdline_parse_stack_guard_gap(char *str)
 {
 	unsigned long val;
-	char *endptr;
 
-	val = simple_strtoul(p, &endptr, 10);
-	if (!*endptr)
-		stack_guard_gap = val << PAGE_SHIFT;
+	if (!str)
+		return 0;
 
-	return 1;
+	val = simple_strtoul(str, &str, 10);
+	if (!*str && val) {
+		stack_guard_gap = val << PAGE_SHIFT;
+		return 1;
+	}
+	return 0;
 }
 __setup("stack_guard_gap=", cmdline_parse_stack_guard_gap);
 
-- 
2.30.2

