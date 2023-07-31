Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B809F768A2E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 05:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjGaDCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 23:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjGaDBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 23:01:50 -0400
Received: from mgamail.intel.com (unknown [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691B310D3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 20:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690772505; x=1722308505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fvxADxY5BIab9H/jxOPv33itdAgJ4iG5Ic68RJMukGM=;
  b=KgdJHdgfZ5JUkKIzm17ZU9Nkcd8dlu331T/mMk5hB2epJY+UvIGEaUtA
   /GMMrEtsTmHuydGmrfHewhLHHa2YEs/wZYckv/IT0uKUx0EnBU8W+8QYp
   Idtf7VQ9fIRMn1/GnUYMUj1sxTdv75x+1k9f4U6dmgNuQ6p17PFmfhS4T
   yUDSzHkE0qRU1a/+4xDFoUaRVhG1HYZgR7sb7j8z3d9XJlDDip93op9pR
   MmHElpzuhMob3JKS6bFT91Vnb9BKWS1V2fDxN1eDCbDOBpKyCGPfhDZba
   ouzx27S1PRcvn3JvF+MgQljZPVFhMXH4cPtVG75B18QFR+L5dZenafUa9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="353818828"
X-IronPort-AV: E=Sophos;i="6.01,243,1684825200"; 
   d="scan'208";a="353818828"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2023 20:01:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="1058771572"
X-IronPort-AV: E=Sophos;i="6.01,243,1684825200"; 
   d="scan'208";a="1058771572"
Received: from xpf.sh.intel.com ([10.239.182.130])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jul 2023 20:01:41 -0700
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     dvyukov@google.com, nogikh@google.com, linux-kernel@vger.kernel.org
Cc:     Pengfei Xu <pengfei.xu@intel.com>, Heng Su <heng.su@intel.com>,
        syzkaller@googlegroups.com, keescook@google.com, mingo@elte.hu,
        Mehta Sohil <sohil.mehta@intel.com>,
        kirill.shutemov@linux.intel.com, akpm@linux-foundation.org
Subject: [PATCH RESEND v1 1/1] x86/kernel: Increase kcov coverage under arch/x86/kernel folder
Date:   Mon, 31 Jul 2023 11:04:18 +0800
Message-Id: <06c0bb7b5f61e5884bf31180e8c122648c752010.1690771380.git.pengfei.xu@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1690771380.git.pengfei.xu@intel.com>
References: <cover.1690771380.git.pengfei.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently kcov instrument is disabled for object files under arch/x86/kernel
folder.
For object files under arch/x86/kernel, actually just disabling the kcov
instrument of files:"head32.o or head64.o and sev.o" could achieve
successful booting and provide kcov coverage for object files that do not
disable kcov instrument.
The additional kcov coverage collected from arch/x86/kernel folder helps
kernel fuzzing efforts to find bugs.

Link to related improvement discussion is below:
https://groups.google.com/g/syzkaller/c/Dsl-RYGCqs8/m/x-tfpTyFBAAJ
Related ticket is as follow:
https://bugzilla.kernel.org/show_bug.cgi?id=198443

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Tested-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 arch/x86/kernel/Makefile | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 4070a01c11b7..00df34c263cc 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -33,11 +33,10 @@ KCSAN_SANITIZE := n
 KMSAN_SANITIZE_head$(BITS).o				:= n
 KMSAN_SANITIZE_nmi.o					:= n
 
-# If instrumentation of this dir is enabled, boot hangs during first second.
-# Probably could be more selective here, but note that files related to irqs,
-# boot, dumpstack/stacktrace, etc are either non-interesting or can lead to
-# non-deterministic coverage.
-KCOV_INSTRUMENT		:= n
+# If instrumentation of the following files is enabled, boot hangs during
+# first second.
+KCOV_INSTRUMENT_head$(BITS).o				:= n
+KCOV_INSTRUMENT_sev.o					:= n
 
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
 
-- 
2.31.1

