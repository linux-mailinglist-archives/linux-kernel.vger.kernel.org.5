Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC0F810827
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 03:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378439AbjLMCT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 21:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378313AbjLMCTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 21:19:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E573107
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 18:19:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E676C433CB;
        Wed, 13 Dec 2023 02:19:28 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
        (envelope-from <rostedt@goodmis.org>)
        id 1rDEr6-00000002Trn-0psh;
        Tue, 12 Dec 2023 21:20:12 -0500
Message-ID: <20231213022011.985384265@goodmis.org>
User-Agent: quilt/0.67
Date:   Tue, 12 Dec 2023 21:19:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH v2 14/15] ringbuffer/selftest: Add basic selftest to test changing subbuf order
References: <20231213021914.361709558@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 .../ftrace/test.d/00basic/ringbuffer_order.tc | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_order.tc

diff --git a/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_order.tc b/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_order.tc
new file mode 100644
index 000000000000..5204c48a82f9
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
+	new_str=`awk ' /tracing_mark_write:/ { sub(/^.*tracing_mark_write: */,"");printf "%s", $0; exit}' trace`
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


