Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F41080B8C4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 05:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjLJEFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 23:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjLJEEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 23:04:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8900310E
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 20:04:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C84EC433C9;
        Sun, 10 Dec 2023 04:04:15 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
        (envelope-from <rostedt@goodmis.org>)
        id 1rCB3k-000000021SI-24ci;
        Sat, 09 Dec 2023 23:04:52 -0500
Message-ID: <20231210040452.274868572@goodmis.org>
User-Agent: quilt/0.67
Date:   Sat, 09 Dec 2023 22:54:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 14/14] ringbuffer/selftest: Add basic selftest to test chaning subbuf order
References: <20231210035404.053677508@goodmis.org>
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

Add a self test that will write into the trace buffer with differ trace
sub buffer order sizes.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../ftrace/test.d/00basic/ringbuffer_order.tc | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_order.tc

diff --git a/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_order.tc b/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_order.tc
new file mode 100644
index 000000000000..c0d76dc724d3
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_order.tc
@@ -0,0 +1,46 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Change the ringbuffer size
+# requires: buffer_subbuf_order
+# flags: instance
+
+get_buffer_data_size() {
+	sed -ne 's/^.*data.*size:\([0-9][0-9]*\).*/\1/p' events/header_page
+}
+
+a="1234567890"
+
+make_str() {
+        cnt=$1
+        s=""
+        while [ $cnt -gt 10 ]; do
+                s="${s}${a}"
+                cnt=$((cnt-10))
+        done
+        while [ $cnt -gt 0 ]; do
+                s="${s}X"
+                cnt=$((cnt-1))
+        done
+        echo -n $s
+}
+
+test_buffer() {
+
+	size=`get_buffer_data_size`
+
+	str=`make_str $size`
+
+	echo $str > trace_marker
+
+	grep -q $a trace
+}
+
+ORIG=`cat buffer_subbuf_order`
+
+for a in `seq 0 4`; do
+	echo 0 > buffer_subbuf_order
+	test_buffer
+done
+
+echo $ORIG > buffer_subbuf_order
+
-- 
2.42.0


