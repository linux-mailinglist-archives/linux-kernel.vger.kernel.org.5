Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390B9809B39
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 05:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573162AbjLHE6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 23:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHE6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 23:58:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C0A10F1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 20:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=0pDBs5pdkEcQyn7uANovljW+bimgmkmJLhzTHRolNmc=; b=lBx8QGMIrLylAcF3bKU8UUdVwx
        k0gRNbymp8WvD1+64JjV5wf1S/rdtj+S+od/N41rVJ5g3gSnP7Je8XNKRKDJuGA+De+A5xDf+PMF1
        IyaQBFExQF/j6o9apIEGV9qhU2oScKUnnsc1qjucQZEpU07QY7XacOw4Q3Ml5rDbZoJJmwVbSQrRW
        Lhct4Pa9ys5l0H0Qh3Xyqe/ptensfRCSOdD3E2rBBsSyWu8MbxNLPub32nkU8wy0WgNA1lJ1jp2SQ
        oC5yc1eJxWY2IBizvCaFiOjd8QKPPWSJ7duhV9vX3TpxMPmIm3syMz89o+YeFIWwYhXbr27rFgiGK
        L9BJmZ4w==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rBSwP-00EitM-3D;
        Fri, 08 Dec 2023 04:58:22 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH] init/Kconfig: move more items into the EXPERT menu
Date:   Thu,  7 Dec 2023 20:58:19 -0800
Message-ID: <20231208045819.2922-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KCMP, RSEQ, CACHESTAT_SYSCALL, and PC104 depend on EXPERT but not shown
in the EXPERT menu. Move some lines around so that they are displayed
in the EXPERT menu.

Drop one useless comment.

Change "enabled" to "enable" for DEBUG_RSEQ.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 init/Kconfig |  102 ++++++++++++++++++++++++-------------------------
 1 file changed, 50 insertions(+), 52 deletions(-)

diff -- a/init/Kconfig b/init/Kconfig
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1688,6 +1688,56 @@ config MEMBARRIER
 
 	  If unsure, say Y.
 
+config KCMP
+	bool "Enable kcmp() system call" if EXPERT
+	help
+	  Enable the kernel resource comparison system call. It provides
+	  user-space with the ability to compare two processes to see if they
+	  share a common resource, such as a file descriptor or even virtual
+	  memory space.
+
+	  If unsure, say N.
+
+config RSEQ
+	bool "Enable rseq() system call" if EXPERT
+	default y
+	depends on HAVE_RSEQ
+	select MEMBARRIER
+	help
+	  Enable the restartable sequences system call. It provides a
+	  user-space cache for the current CPU number value, which
+	  speeds up getting the current CPU number from user-space,
+	  as well as an ABI to speed up user-space operations on
+	  per-CPU data.
+
+	  If unsure, say Y.
+
+config DEBUG_RSEQ
+	default n
+	bool "Enable debugging of rseq() system call" if EXPERT
+	depends on RSEQ && DEBUG_KERNEL
+	help
+	  Enable extra debugging checks for the rseq system call.
+
+	  If unsure, say N.
+
+config CACHESTAT_SYSCALL
+	bool "Enable cachestat() system call" if EXPERT
+	default y
+	help
+	  Enable the cachestat system call, which queries the page cache
+	  statistics of a file (number of cached pages, dirty pages,
+	  pages marked for writeback, (recently) evicted pages).
+
+	  If unsure say Y here.
+
+config PC104
+	bool "PC/104 support" if EXPERT
+	help
+	  Expose PC/104 form factor device drivers and options available for
+	  selection and configuration. Enable this option if your target
+	  machine has a PC/104 bus.
+
 config KALLSYMS
 	bool "Load all symbols for debugging/ksymoops" if EXPERT
 	default y
@@ -1752,57 +1802,12 @@ config KALLSYMS_BASE_RELATIVE
 
 # end of the "standard kernel features (expert users)" menu
 
-# syscall, maps, verifier
-
 config ARCH_HAS_MEMBARRIER_CALLBACKS
 	bool
 
 config ARCH_HAS_MEMBARRIER_SYNC_CORE
 	bool
 
-config KCMP
-	bool "Enable kcmp() system call" if EXPERT
-	help
-	  Enable the kernel resource comparison system call. It provides
-	  user-space with the ability to compare two processes to see if they
-	  share a common resource, such as a file descriptor or even virtual
-	  memory space.
-
-	  If unsure, say N.
-
-config RSEQ
-	bool "Enable rseq() system call" if EXPERT
-	default y
-	depends on HAVE_RSEQ
-	select MEMBARRIER
-	help
-	  Enable the restartable sequences system call. It provides a
-	  user-space cache for the current CPU number value, which
-	  speeds up getting the current CPU number from user-space,
-	  as well as an ABI to speed up user-space operations on
-	  per-CPU data.
-
-	  If unsure, say Y.
-
-config CACHESTAT_SYSCALL
-	bool "Enable cachestat() system call" if EXPERT
-	default y
-	help
-	  Enable the cachestat system call, which queries the page cache
-	  statistics of a file (number of cached pages, dirty pages,
-	  pages marked for writeback, (recently) evicted pages).
-
-	  If unsure say Y here.
-
-config DEBUG_RSEQ
-	default n
-	bool "Enabled debugging of rseq() system call" if EXPERT
-	depends on RSEQ && DEBUG_KERNEL
-	help
-	  Enable extra debugging checks for the rseq system call.
-
-	  If unsure, say N.
-
 config HAVE_PERF_EVENTS
 	bool
 	help
@@ -1817,13 +1822,6 @@ config PERF_USE_VMALLOC
 	help
 	  See tools/perf/design.txt for details
 
-config PC104
-	bool "PC/104 support" if EXPERT
-	help
-	  Expose PC/104 form factor device drivers and options available for
-	  selection and configuration. Enable this option if your target
-	  machine has a PC/104 bus.
-
 menu "Kernel Performance Events And Counters"
 
 config PERF_EVENTS
