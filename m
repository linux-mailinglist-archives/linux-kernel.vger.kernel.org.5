Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC7C7DE7A9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346004AbjKAViM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 17:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345802AbjKAViG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 17:38:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD97B120;
        Wed,  1 Nov 2023 14:38:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD84C433CD;
        Wed,  1 Nov 2023 21:38:03 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qyIuY-00EdXf-1M;
        Wed, 01 Nov 2023 17:38:02 -0400
Message-ID: <20231101213802.233842141@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 01 Nov 2023 17:37:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [for-next][PATCH 03/12] tracing: Have the user copy of synthetic event address use correct
 context
References: <20231101213718.381015321@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

A synthetic event is created by the synthetic event interface that can
read both user or kernel address memory. In reality, it reads any
arbitrary memory location from within the kernel. If the address space is
in USER (where CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE is set) then
it uses strncpy_from_user_nofault() to copy strings otherwise it uses
strncpy_from_kernel_nofault().

But since both functions use the same variable there's no annotation to
what that variable is (ie. __user). This makes sparse complain.

Quiet sparse by typecasting the strncpy_from_user_nofault() variable to
a __user pointer.

Link: https://lore.kernel.org/linux-trace-kernel/20231031151033.73c42e23@gandalf.local.home

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Fixes: 0934ae9977c2 ("tracing: Fix reading strings from synthetic events");
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311010013.fm8WTxa5-lkp@intel.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 14cb275a0bab..846e02c0fb59 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -452,7 +452,7 @@ static unsigned int trace_string(struct synth_trace_event *entry,
 
 #ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 		if ((unsigned long)str_val < TASK_SIZE)
-			ret = strncpy_from_user_nofault(str_field, str_val, STR_VAR_LEN_MAX);
+			ret = strncpy_from_user_nofault(str_field, (const void __user *)str_val, STR_VAR_LEN_MAX);
 		else
 #endif
 			ret = strncpy_from_kernel_nofault(str_field, str_val, STR_VAR_LEN_MAX);
-- 
2.42.0
