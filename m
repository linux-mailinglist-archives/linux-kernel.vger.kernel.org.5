Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5177E05F2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 16:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344668AbjKCP7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 11:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344558AbjKCP7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 11:59:20 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5C9D4F;
        Fri,  3 Nov 2023 08:59:17 -0700 (PDT)
X-QQ-mid: bizesmtp87t1699027144tuxhh48b
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 03 Nov 2023 23:59:01 +0800 (CST)
X-QQ-SSF: 01200000000000B06000000A0000000
X-QQ-FEAT: LE7C6P2vL8TDvuFtQgm7U5nmg5IefRLiYgMU7BisqY8a+MfFY5YFw57t6eU2N
        mHG9XUzklv0HbI1UYbnludIhogZCI7W/IazcZj+b/17hSpDlk9STyb/1qy8aOE2wUbOzCOZ
        EJn/pf7LRNuuDgsl1ei03i4F64rI0B4WYb761k/inK0WMo/2LPTxfduiL64kC54tN2qYj6t
        hSep7h9sssI09uh7yXGRmhB/6Z75f2XrvS/dhZRHxDT6hhxRWQRSbLi4gjCZaegiLml9nXo
        uSCfn4EBkxIyImAQMxNPNtmyG7cYWqYRM00FNDOSz631ECpoP+OjLEe1sXE5O7xcvql3Riv
        8CaSaqWCZoYQNtMBmJ3hnYreg2Te9iyb3F76nRBVtDUVxQ8ajDjjBSD9mAMXg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6960832744754887515
From:   Yuan Tan <tanyuan@tinylab.org>
To:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        luc.vanoostenryck@gmail.com, linux-sparse@vger.kernel.org
Cc:     linux@weissschuh.net, palmer@rivosinc.com,
        paul.walmsley@sifive.com, paulburton@kernel.org,
        paulmck@kernel.org, tim.bird@sony.com, tsbogend@alpha.franken.de,
        w@1wt.eu, tanyuan@tinylab.org, i@maskray.me
Subject: [PATCH v1 03/14] compiler: add unique __SECTION_NAME()
Date:   Fri,  3 Nov 2023 23:58:59 +0800
Message-Id: <3c10b123c7ec27fbd942dd9a07d877743616c935.1699025537.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1699025537.git.tanyuan@tinylab.org>
References: <cover.1699025537.git.tanyuan@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhangjin Wu <falcon@tinylab.org>

The new section helper is added for LD_DEAD_CODE_DATA_ELIMINATION to
generate unique section name (strigified).

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
---
 include/linux/compiler.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 405b19cf6cf3..5a9cc3209b12 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -227,11 +227,25 @@ static inline void *offset_to_ptr(const int *off)
 
 #endif /* __ASSEMBLY__ */
 
+/* Import __stringify. */
+#ifndef __stringify
+#include <linux/stringify.h>
+#endif
+
 /* Quite-unique ID. */
 #ifndef __QUITE_UNIQUE_ID
 # define __QUITE_UNIQUE_ID(prefix) __PASTE(__PASTE(prefix, __LINE__), __COUNTER__)
 #endif
 
+/* Quite-unique Section NAME. */
+#ifndef __SECTION_NAME
+#ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
+# define __SECTION_NAME(prefix) __stringify(__QUITE_UNIQUE_ID(prefix.))
+#else
+# define __SECTION_NAME(prefix) __stringify(prefix)
+#endif
+#endif
+
 /* &a[0] degrades to a pointer: a different type from an array */
 #define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
 
-- 
2.34.1

