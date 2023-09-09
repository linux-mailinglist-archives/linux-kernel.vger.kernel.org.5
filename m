Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8F2799616
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 05:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243733AbjIIDY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 23:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbjIIDXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 23:23:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE621FF6;
        Fri,  8 Sep 2023 20:23:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E63C433CA;
        Sat,  9 Sep 2023 03:23:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qeoZb-000Yl7-0v;
        Fri, 08 Sep 2023 23:23:51 -0400
Message-ID: <20230909032351.104588615@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 08 Sep 2023 23:16:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: [for-linus][PATCH 15/15] tracing/synthetic: Fix order of struct trace_dynamic_info
References: <20230909031615.047488015@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

To make handling BIG and LITTLE endian better the offset/len of dynamic
fields of the synthetic events was changed into a structure of:

 struct trace_dynamic_info {
 #ifdef CONFIG_CPU_BIG_ENDIAN
	u16	offset;
	u16	len;
 #else
	u16	len;
	u16	offset;
 #endif
 };

to replace the manual changes of:

 data_offset = offset & 0xffff;
 data_offest = len << 16;

But if you look closely, the above is:

  <len> << 16 | offset

Which in little endian would be in memory:

 offset_lo offset_hi len_lo len_hi

and in big endian:

 len_hi len_lo offset_hi offset_lo

Which if broken into a structure would be:

 struct trace_dynamic_info {
 #ifdef CONFIG_CPU_BIG_ENDIAN
	u16	len;
	u16	offset;
 #else
	u16	offset;
	u16	len;
 #endif
 };

Which is the opposite of what was defined.

Fix this and just to be safe also add "__packed".

Link: https://lore.kernel.org/all/20230908154417.5172e343@gandalf.local.home/
Link: https://lore.kernel.org/linux-trace-kernel/20230908163929.2c25f3dc@gandalf.local.home

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Fixes: ddeea494a16f3 ("tracing/synthetic: Use union instead of casts")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/trace_events.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 12f875e9e69a..21ae37e49319 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -62,13 +62,13 @@ void trace_event_printf(struct trace_iterator *iter, const char *fmt, ...);
 /* Used to find the offset and length of dynamic fields in trace events */
 struct trace_dynamic_info {
 #ifdef CONFIG_CPU_BIG_ENDIAN
-	u16	offset;
 	u16	len;
+	u16	offset;
 #else
-	u16	len;
 	u16	offset;
+	u16	len;
 #endif
-};
+} __packed;
 
 /*
  * The trace entry - the most basic unit of tracing. This is what
-- 
2.40.1
