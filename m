Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8578799114
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245043AbjIHUip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjIHUio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:38:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B49171F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 13:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694205503; x=1725741503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/oBeqyFWl76PzM9VwB+Feq4kMe336opSwYwrN7s1tNE=;
  b=fcUV0sFBisXNYMGa/JMp4e/fl84ZQ85ZpVImrDdzVqj5WoXgbJgut7HZ
   HycQ9tB1CWhOJAPIQPZtDqeM4gsg84y3+ktFXMp5epYaG1/n+u0WPPd9L
   9G09gLO8NXlORr0ApXWEGQaC+KSH1OAE/LmQ8r1o1DFls0yTGGE5xdEhh
   S78lbVp51LMf6pMO6XbQBgaco0B5zxiPRBiLl130iYVeRkrpE39vECdCb
   jXYNY4IGrqVJMrw/CdNYETiMuUYLvHjUwxWNDWBHCMGR/2xeoixzY7dRw
   flx3BRxzhH2wiJHa/7IUOqiZGRgfwLbLEYPXEvtdFkdY/roGjGmPO30Mt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="376650592"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="376650592"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 13:37:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="832781672"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="832781672"
Received: from imilose-mobl.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.209.14.33])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 13:37:20 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, hjl.tools@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH 2/3] x86/shstk: Remove useless clone error handling
Date:   Fri,  8 Sep 2023 13:36:54 -0700
Message-Id: <20230908203655.543765-3-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908203655.543765-1-rick.p.edgecombe@intel.com>
References: <20230908203655.543765-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When clone fails after the shadow stack is allocated, any allocated shadow
stack is cleaned up in exit_thread() in copy_process(). So the logic in
copy_thread() is unneeded, and also will not handle failures that happen
outside of copy_thread().

In addition, since there is a second attempt to unmap the same shadow
stack, there is a race where an newly mapped region could get unmapped.

So remove the logic in copy_thread() and rely on exit_thread() to handle
clone failure.

Fixes: b2926a36b97a ("x86/shstk: Handle thread shadow stack")
Tested-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kernel/process.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 9f0909142a0a..b6f4e8399fca 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -257,13 +257,6 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	if (!ret && unlikely(test_tsk_thread_flag(current, TIF_IO_BITMAP)))
 		io_bitmap_share(p);
 
-	/*
-	 * If copy_thread() if failing, don't leak the shadow stack possibly
-	 * allocated in shstk_alloc_thread_stack() above.
-	 */
-	if (ret)
-		shstk_free(p);
-
 	return ret;
 }
 
-- 
2.34.1

