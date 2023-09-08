Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC25799116
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343791AbjIHUi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243773AbjIHUiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:38:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAB6C4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 13:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694205521; x=1725741521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qRz3N4dt9aOEvJciUns9J86RjO6vBdJBsn0ap5aaM8I=;
  b=duYONdGu2C79nFQSjrpaLiEdvDAH+dRdlcOk6Z6+YpTY0gFZdY1MDeVc
   ZAnDL91dw2PS5o2yNpDAN3C++4abzl8TG1rOoTlV+9WySqr3yJ3Pnldsy
   zWLOI3t4aXBCaw+lLL7k3KDV8WFY+scFMcx57sVLI2DcSMLs8FzGys3lG
   s86qOQ2xLbxdwZfbjHxXVxupy/+HP0PVOf0XBX3O4Xs3+Cpu6wrjuDAD1
   pNGg65LXZHNhGx05XeUdQJq5arKGhaQ6QHl3DuXBZD0uJc4sjw9p8wLqK
   wA8JSvGqQKLhs49Nf9K2gDRuwVGTR8Ntc3JDZfIVJVw5OObKe6p6ejCMj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="376650601"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="376650601"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 13:37:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="832781676"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="832781676"
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
Subject: [PATCH 3/3] x86/shstk: Add warning for shadow stack double unmap
Date:   Fri,  8 Sep 2023 13:36:55 -0700
Message-Id: <20230908203655.543765-4-rick.p.edgecombe@intel.com>
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

There are several ways a thread's shadow stacks can get unmapped. This
can happen on exit or exec, as well as error handling in exec or clone.
The task struct already keeps track of the thread's shadow stack. Use the
size variable to keep track of if the shadow stack has already been freed.

When an attempt to double unmap the thread shadow stack is caught, warn
about it and abort the operation.

Tested-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kernel/shstk.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index ad63252ebebc..59e15dd8d0f8 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -426,7 +426,18 @@ void shstk_free(struct task_struct *tsk)
 	if (!shstk->base)
 		return;
 
+	/*
+	 * shstk->base is NULL for CLONE_VFORK child tasks, and so is
+	 * normal. But size = 0 on a shstk->base is not normal and
+	 * indicated an attempt to free the thread shadow stack twice.
+	 * Warn about it.
+	 */
+	if (WARN_ON(!shstk->size))
+		return;
+
 	unmap_shadow_stack(shstk->base, shstk->size);
+
+	shstk->size = 0;
 }
 
 static int wrss_control(bool enable)
-- 
2.34.1

