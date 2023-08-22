Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD81278380D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 04:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjHVCis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 22:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjHVCia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 22:38:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931AB189
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 19:38:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31A8C645A4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 02:38:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2DCC433CA;
        Tue, 22 Aug 2023 02:38:25 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qYHI1-001bZm-28;
        Mon, 21 Aug 2023 22:38:41 -0400
Message-ID: <20230822023841.473446159@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Aug 2023 22:38:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <vnagarnaik@google.com>, <shuah@kernel.org>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: [for-linus][PATCH 2/8] selftests/ftrace: Add a basic testcase for snapshot
References: <20230822023803.605698724@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zheng Yejian <zhengyejian1@huawei.com>

This testcase is constrived to reproduce a problem that the cpu buffers
become unavailable which is due to 'record_disabled' of array_buffer and
max_buffer being messed up.

Local test result after bugfix:
  # ./ftracetest test.d/00basic/snapshot1.tc
  === Ftrace unit tests ===
  [1] Snapshot and tracing_cpumask        [PASS]
  [2] (instance)  Snapshot and tracing_cpumask    [PASS]

  # of passed:  2
  # of failed:  0
  # of unresolved:  0
  # of untested:  0
  # of unsupported:  0
  # of xfailed:  0
  # of undefined(test bug):  0

Link: https://lkml.kernel.org/r/20230805033816.3284594-3-zhengyejian1@huawei.com

Cc: <mhiramat@kernel.org>
Cc: <vnagarnaik@google.com>
Cc: <shuah@kernel.org>
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../ftrace/test.d/00basic/snapshot1.tc        | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/snapshot1.tc

diff --git a/tools/testing/selftests/ftrace/test.d/00basic/snapshot1.tc b/tools/testing/selftests/ftrace/test.d/00basic/snapshot1.tc
new file mode 100644
index 000000000000..63b76cf2a360
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/00basic/snapshot1.tc
@@ -0,0 +1,31 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Snapshot and tracing_cpumask
+# requires: trace_marker tracing_cpumask snapshot
+# flags: instance
+
+# This testcase is constrived to reproduce a problem that the cpu buffers
+# become unavailable which is due to 'record_disabled' of array_buffer and
+# max_buffer being messed up.
+
+# Store origin cpumask
+ORIG_CPUMASK=`cat tracing_cpumask`
+
+# Stop tracing all cpu
+echo 0 > tracing_cpumask
+
+# Take a snapshot of the main buffer
+echo 1 > snapshot
+
+# Restore origin cpumask, note that there should be some cpus being traced
+echo ${ORIG_CPUMASK} > tracing_cpumask
+
+# Set tracing on
+echo 1 > tracing_on
+
+# Write a log into buffer
+echo "test input 1" > trace_marker
+
+# Ensure the log writed so that cpu buffers are still available
+grep -q "test input 1" trace
+exit 0
-- 
2.40.1
