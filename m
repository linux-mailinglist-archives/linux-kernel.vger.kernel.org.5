Return-Path: <linux-kernel+bounces-5847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2394819012
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5C7287948
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1119E405DA;
	Tue, 19 Dec 2023 18:55:33 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719AC3DBA0;
	Tue, 19 Dec 2023 18:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44510C433CA;
	Tue, 19 Dec 2023 18:55:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rFfGZ-00000003R6M-35m7;
	Tue, 19 Dec 2023 13:56:31 -0500
Message-ID: <20231219185631.520496304@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 19 Dec 2023 13:54:28 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
 Vincent Donnefort <vdonnefort@google.com>,
 Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH v5 14/15] ringbuffer/selftest: Add basic selftest to test changing subbuf order
References: <20231219185414.474197117@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Add a self test that will write into the trace buffer with differ trace
sub buffer order sizes.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../ftrace/test.d/00basic/ringbuffer_order.tc | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_order.tc

diff --git a/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_order.tc b/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_order.tc
new file mode 100644
index 000000000000..ecbcc810e6c1
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_order.tc
@@ -0,0 +1,95 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Change the ringbuffer sub-buffer order
+# requires: buffer_subbuf_order
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
+data_offset=`get_buffer_data_offset`
+
+marker_meta=$((event_header_size+print_header_size))
+
+make_str() {
+        cnt=$1
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
+	echo $str > trace_marker
+
+	echo $str
+}
+
+test_buffer() {
+	orde=$1
+	page_size=$((4096<<order))
+
+	size=`get_buffer_data_size`
+
+	# the size must be greater than or equal to page_size - data_offset
+	page_size=$((page_size-data_offset))
+	if [ $size -lt $page_size ]; then
+		exit fail
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
+	new_str=`awk ' /tracing_mark_write:/ { sub(/^.*tracing_mark_write: /,"");printf "%s", $0; }' trace`
+
+	if [ "$new_str" != "$str" ]; then
+		exit fail;
+	fi
+}
+
+ORIG=`cat buffer_subbuf_order`
+
+# Could test bigger orders than 3, but then creating the string
+# to write into the ring buffer takes too long
+for a in 0 1 2 3 ; do
+	echo $a > buffer_subbuf_order
+	test_buffer $a
+done
+
+echo $ORIG > buffer_subbuf_order
+
-- 
2.42.0



