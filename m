Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FC48126DA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 06:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443163AbjLNFTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 00:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443156AbjLNFTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 00:19:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09520D0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 21:19:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332EAC433C7;
        Thu, 14 Dec 2023 05:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702531152;
        bh=LVMi+Y5VUaqqVncvLYXRxiyjMyHiWYY1uMv92cnuaJw=;
        h=From:To:Cc:Subject:Date:From;
        b=cCdOhjUhtrnh68iq1vuGawYw9QePyYjEHzbZfUs8QMRy5ypRKGn1W7aDc7j9HzIhB
         r4mZcWFgNUTnmxKYuHjNjyCi4lIufS5+7rDs4++i2KLCURi1JBMENv7nUF92tVHCLm
         wZlM7xI5ppszUO/kcrQj0lEftXEIxP5cN2EiyI/4+Xe57+ln6XpmETgixjH2RAqjuF
         o8hlKIXW48jr/P0HhUzS4qpkS4aKWW8p/kmqSb9sFYGnaDDywktqdDOlCQubL2v693
         gGPrPWddXgHG6JMoejOkniIjD/pTZN7aqX+8n8auZ28n+2P3QyjeNHNtdvmHOROKN0
         Y7CL9+/wre17g==
From:   Naveen N Rao <naveen@kernel.org>
To:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Srikar Dronamraju <srikar@linux.ibm.com>
Subject: [PATCH v4] trace/kprobe: Display the actual notrace function when rejecting a probe
Date:   Thu, 14 Dec 2023 10:47:02 +0530
Message-ID: <20231214051702.1687300-1-naveen@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to probe update_sd_lb_stats() using perf results in the below
message in the kernel log:
	trace_kprobe: Could not probe notrace function _text

This is because 'perf probe' specifies the kprobe location as an offset
from '_text':
	$ sudo perf probe -D update_sd_lb_stats
	p:probe/update_sd_lb_stats _text+1830728

However, the error message is misleading and doesn't help convey the
actual notrace function that is being probed. Fix this by looking up the
actual function name that is being probed. With this fix, we now get the
below message in the kernel log:
	trace_kprobe: Could not probe notrace function update_sd_lb_stats.constprop.0

Signed-off-by: Naveen N Rao <naveen@kernel.org>
---
v4: Use printk format specifier %ps with probe address to lookup the 
symbol, as suggested by Masami.

 kernel/trace/trace_kprobe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 3d7a180a8427..0017404d6e8d 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -487,8 +487,8 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
 		return -EINVAL;
 
 	if (within_notrace_func(tk)) {
-		pr_warn("Could not probe notrace function %s\n",
-			trace_kprobe_symbol(tk));
+		pr_warn("Could not probe notrace function %ps\n",
+			(void *)trace_kprobe_address(tk));
 		return -EINVAL;
 	}
 

base-commit: 4758560fa268cecfa1144f015aa9f2525d164b7e
-- 
2.43.0

