Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E371B80E704
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjLLJD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLLJD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:03:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E167C7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:04:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647BEC433C9;
        Tue, 12 Dec 2023 09:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702371842;
        bh=gpWxqrQqtPBdeOZQDVvCLZQiG6hUIYYXSz5LWak22Mc=;
        h=From:To:Cc:Subject:Date:From;
        b=lDHj8OvOCxDjQ3VWmnU9FUBbW2KpaOgm5edsWgEbA/U2BV//dLI9wch27rQ+ZAjaT
         JJoELrQvE1VZkWAdCgqr07fLM04izHCjldTPmuoWoke1JiZYefkTvkb1OIG8EExrXV
         uw9FT4JYykeuZcZ6HS+QOCgSruWTbFSRit1/1bN+a5EqlxaH49P4BX1EQT+/tYl7Qs
         5rogMk424jJBZyh6b603CztXPjHfU8KBppPAV1OgschXpKg912g7bp+OzUNq5sODqh
         GuTErg4iG2JeCdJ6bv2VnMUidiu+g90G/iOXxtELqtjLPVoB8aAs1dO7dIXp9YSK7o
         GtRflju1Eq1JQ==
From:   Naveen N Rao <naveen@kernel.org>
To:     <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] selftests/ftrace: Add test to exercize function tracer across cpu hotplug
Date:   Tue, 12 Dec 2023 14:26:07 +0530
Message-ID: <20231212085607.1213210-1-naveen@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a test to exercize cpu hotplug with the function tracer active to
ensure that sensitive functions in idle path are excluded from being
traced. This helps catch issues such as the one fixed by commit
4b3338aaa74d ("powerpc/ftrace: Fix stack teardown in ftrace_no_trace").

Signed-off-by: Naveen N Rao <naveen@kernel.org>
---
 .../ftrace/test.d/ftrace/func_hotplug.tc      | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc
new file mode 100644
index 000000000000..49731a2b5c23
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc
@@ -0,0 +1,30 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: ftrace - function trace across cpu hotplug
+# requires: function:tracer
+
+if ! which nproc ; then
+  nproc() {
+    ls -d /sys/devices/system/cpu/cpu[0-9]* | wc -l
+  }
+fi
+
+NP=`nproc`
+
+if [ $NP -eq 1 ] ;then
+  echo "We can not test cpu hotplug in UP environment"
+  exit_unresolved
+fi
+
+echo 0 > tracing_on
+echo > trace
+: "Set CPU1 offline/online with function tracer enabled"
+echo function > current_tracer
+echo 1 > tracing_on
+(echo 0 > /sys/devices/system/cpu/cpu1/online)
+(echo "forked"; sleep 1)
+(echo 1 > /sys/devices/system/cpu/cpu1/online)
+echo 0 > tracing_on
+
+: "Check CPU1 events are recorded"
+grep -q -e "\[001\]" trace

base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.43.0

