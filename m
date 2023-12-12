Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9768C80F7A0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377240AbjLLUPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjLLUPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:15:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922F1B7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:15:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644CBC433C7;
        Tue, 12 Dec 2023 20:15:50 +0000 (UTC)
Date:   Tue, 12 Dec 2023 15:16:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH v2] tracing/selftests: Add test to test max subbuf size with
 trace_marker
Message-ID: <20231212151632.25c9b67d@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

Now that the trace_marker can write up to the max size of the sub buffer.
Add a test to see if it actually can happen.

The README is updated to state that the trace_marker writes can be broken
up, and the test checks the README for that statement so that it does not
fail on older kernels that does not support this.

If the README does not have the specified update, the test will still test
if all the string is written, as that should work with older kernels.

Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/linux-trace-kernel/20231212135441.0337c3e9@gandalf.local.home/

- Fix description as it was a cut and paste from the subbuffer size tests
  that are not added yet.

 kernel/trace/trace.c                          |   1 +
 .../ftrace/test.d/00basic/trace_marker.tc     | 112 ++++++++++++++++++
 2 files changed, 113 insertions(+)
 create mode 100755 tools/testing/selftests/ftrace/test.d/00basic/trace_marker.tc

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2f8d59834c00..cbfcdd882590 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5595,6 +5595,7 @@ static const char readme_msg[] =
 	"       delta:   Delta difference against a buffer-wide timestamp\n"
 	"    absolute:   Absolute (standalone) timestamp\n"
 	"\n  trace_marker\t\t- Writes into this file writes into the kernel buffer\n"
+	"\n           May be broken into multiple events based on sub-buffer size.\n"
 	"\n  trace_marker_raw\t\t- Writes into this file writes binary data into the kernel buffer\n"
 	"  tracing_cpumask\t- Limit which CPUs to trace\n"
 	"  instances\t\t- Make sub-buffers with: mkdir instances/foo\n"
diff --git a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker.tc b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker.tc
new file mode 100755
index 000000000000..bf7f6f50c88a
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker.tc
@@ -0,0 +1,112 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Basic tests on writing to trace_marker
+# requires: trace_marker
+# flags: instance
+
+get_buffer_data_size() {
+	sed -ne 's/^.*data.*size:\([0-9][0-9]*\).*/\1/p' events/header_page
+}
+
+get_buffer_data_offset() {
+	sed -ne 's/^.*data.*offset:\([0-9][0-9]*\).*/\1/p' events/header_page
+}
+
+get_event_header_size() {
+	type_len=`sed -ne 's/^.*type_len.*:[^0-9]*\([0-9][0-9]*\).*/\1/p' events/header_event`
+	time_len=`sed -ne 's/^.*time_delta.*:[^0-9]*\([0-9][0-9]*\).*/\1/p' events/header_event`
+	array_len=`sed -ne 's/^.*array.*:[^0-9]*\([0-9][0-9]*\).*/\1/p' events/header_event`
+	total_bits=$((type_len+time_len+array_len))
+	total_bits=$((total_bits+7))
+	echo $((total_bits/8))
+}
+
+get_print_event_buf_offset() {
+	sed -ne 's/^.*buf.*offset:\([0-9][0-9]*\).*/\1/p' events/ftrace/print/format
+}
+
+event_header_size=`get_event_header_size`
+print_header_size=`get_print_event_buf_offset`
+
+# Find the README
+README=""
+if [ -f README ]; then
+	README="README"
+# instance?
+elif [ -f ../../README ]; then
+	README="../../README"
+fi
+
+testone=0
+if [ ! -z "$README" ]; then
+	if grep -q  "May be broken into multiple events based on sub-buffer size" $README; then
+		testone=1
+	fi
+fi
+
+data_offset=`get_buffer_data_offset`
+
+marker_meta=$((event_header_size+print_header_size))
+
+make_str() {
+        cnt=$1
+	# subtract two for \n\0 as marker adds these
+	cnt=$((cnt-2))
+	printf -- 'X%.0s' $(seq $cnt)
+}
+
+write_buffer() {
+	size=$1
+
+	str=`make_str $size`
+
+	# clear the buffer
+	echo > trace
+
+	# write the string into the marker
+	echo -n $str > trace_marker
+
+	echo $str
+}
+
+test_buffer() {
+
+	size=`get_buffer_data_size`
+	oneline_size=$((size-marker_meta))
+	echo size = $size
+	echo meta size = $marker_meta
+
+	if [ $testone -eq 1 ]; then
+		echo oneline size = $oneline_size
+
+		str=`write_buffer $oneline_size`
+
+		# Should be in one single event
+		new_str=`awk ' /tracing_mark_write:/ { sub(/^.*tracing_mark_write: */,"");printf "%s", $0; exit}' trace`
+
+		if [ "$new_str" != "$str" ]; then
+			exit fail;
+		fi
+	fi
+
+	# Now add a little more the meta data overhead will overflow
+
+	str=`write_buffer $size`
+
+	# Make sure the line was broken
+	new_str=`awk ' /tracing_mark_write:/ { sub(/^.*tracing_mark_write: /,"");printf "%s", $0; exit}' trace`
+
+	if [ "$new_str" = "$str" ]; then
+		exit fail;
+	fi
+
+	# Make sure the entire line can be found
+	new_str=`awk ' /tracing_mark_write:/ { sub(/^.*tracing_mark_write: */,"");printf "%s", $0; }' trace`
+
+	if [ "$new_str" != "$str" ]; then
+		exit fail;
+	fi
+}
+
+test_buffer
+
-- 
2.42.0

