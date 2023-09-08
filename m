Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D199799119
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245641AbjIHUjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242000AbjIHUjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:39:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF894B2;
        Fri,  8 Sep 2023 13:39:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3C4C433C8;
        Fri,  8 Sep 2023 20:39:14 +0000 (UTC)
Date:   Fri, 8 Sep 2023 16:39:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [RESEND][PATCH] tracing/synthetic: Fix order of struct
 trace_dynamic_info
Message-ID: <20230908163929.2c25f3dc@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

Cc: stable@vger.kernel.org
Fixes: ddeea494a16f3 ("tracing/synthetic: Use union instead of casts")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---

 [ Resending to the correct mailing list this time :-p ]

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

