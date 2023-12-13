Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47445811064
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377775AbjLMLoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbjLMLoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:44:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8F6B0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:44:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBDFC433C8;
        Wed, 13 Dec 2023 11:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702467875;
        bh=oMDLJR3QBu07Cmnnq8dPH187k2LYJ/Bh349mE/bY8oU=;
        h=From:To:Cc:Subject:Date:From;
        b=tQ1KpGhfjZNcUkxXi79TUZ0HBW1XEb69pN0LbOt68daPRWvfpzekQO7E2ChmRGle2
         biouldnHtCuf7fbc3D7CGX8xnzjCNyVqXM5mxEFveKEuBo1xGfVQSLRhLM+q3N/pfe
         P+H9Z3RCadbQrOKYIOPXwR9sY+UZbxxXqX7OkXoBQROxFhtXgXsPxVCNWshjb7adO1
         juZzy87gFjjUjxj7i1rLKg8da1JZZsn8sbBCHpUOVLItErdcomdop5XSD4YHl1av3D
         g1XduEVGHMzDJcOhR6klpIknCaAS/L6ebS4g8Rq5a9+h1aAvP9E+a0dfwFiI/8OnVA
         3/WJK1RrTqE7A==
From:   Naveen N Rao <naveen@kernel.org>
To:     <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2] selftests/ftrace: Add test to exercize function tracer across cpu hotplug
Date:   Wed, 13 Dec 2023 17:08:02 +0530
Message-ID: <20231213113802.1278600-1-naveen@kernel.org>
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
v2: Add a check for next available online cpu, as suggested by Masami.

 .../ftrace/test.d/ftrace/func_hotplug.tc      | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc
new file mode 100644
index 000000000000..ccfbfde3d942
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_hotplug.tc
@@ -0,0 +1,42 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
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
+  echo "We cannot test cpu hotplug in UP environment"
+  exit_unresolved
+fi
+
+# Find online cpu
+for i in /sys/devices/system/cpu/cpu[1-9]*; do
+	if [ -f $i/online ] && [ "$(cat $i/online)" = "1" ]; then
+		cpu=$i
+		break
+	fi
+done
+
+if [ -z "$cpu" ]; then
+	echo "We cannot test cpu hotplug with a single cpu online"
+	exit_unresolved
+fi
+
+echo 0 > tracing_on
+echo > trace
+
+: "Set $(basename $cpu) offline/online with function tracer enabled"
+echo function > current_tracer
+echo 1 > tracing_on
+(echo 0 > $cpu/online)
+(echo "forked"; sleep 1)
+(echo 1 > $cpu/online)
+echo 0 > tracing_on
+echo nop > current_tracer

base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.43.0

