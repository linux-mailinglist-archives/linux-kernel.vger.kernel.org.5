Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7F5811C47
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442500AbjLMSVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbjLMSUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:20:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73DCDD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:20:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A559C433CD;
        Wed, 13 Dec 2023 18:20:40 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
        (envelope-from <rostedt@goodmis.org>)
        id 1rDTrJ-00000002aCI-41W1;
        Wed, 13 Dec 2023 13:21:25 -0500
Message-ID: <20231213182125.736633005@goodmis.org>
User-Agent: quilt/0.67
Date:   Wed, 13 Dec 2023 13:17:50 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH v3 13/15] ring-buffer: Add documentation on the buffer_subbuf_order file
References: <20231213181737.791847466@goodmis.org>
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

Add to the documentation how to use the buffer_subbuf_order file to change
the size and how it affects what events can be added to the ring buffer.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/ftrace.rst | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 23572f6697c0..231d26ceedb0 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -203,6 +203,33 @@ of ftrace. Here is a list of some of the key files:
 
 	This displays the total combined size of all the trace buffers.
 
+  buffer_subbuf_order:
+
+	This sets or displays the sub buffer page size order. The ring buffer
+	is broken up into several same size "sub buffers". An event can not be
+	bigger than the size of the sub buffer. Normally, the sub buffer is
+	the size of the architecture's page (4K on x86). The sub buffer also
+	contains meta data at the start which also limits the size of an event.
+	That means when the sub buffer is a page size, no event can be larger
+	than the page size minus the sub buffer meta data.
+
+	The buffer_subbuf_order allows the user to change the size of the sub
+	buffer. As the sub buffer is a set of pages by the power of 2, thus
+	the sub buffer total size is defined by the order:
+
+	order		size
+	----		----
+	0		PAGE_SIZE
+	1		PAGE_SIZE * 2
+	2		PAGE_SIZE * 4
+	3		PAGE_SIZE * 8
+
+	Changing the order will change the sub buffer size allowing for events
+	to be larger than the page size.
+
+	Note: When changing the order, tracing is stopped and any data in the
+	ring buffer and the snapshot buffer will be discarded.
+
   free_buffer:
 
 	If a process is performing tracing, and the ring buffer	should be
-- 
2.42.0


