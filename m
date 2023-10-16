Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DDE7CA879
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbjJPMtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 08:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbjJPMtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:49:12 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B40F3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 05:49:08 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:ce84:d8c0:f79a:fa0])
        by xavier.telenet-ops.be with bizsmtp
        id ycp52A00G0pDX7N01cp5bl; Mon, 16 Oct 2023 14:49:06 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qsN1q-006jX4-28;
        Mon, 16 Oct 2023 14:49:05 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qsN1t-00A3uN-Ck;
        Mon, 16 Oct 2023 14:49:05 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        David Ahern <dsahern@gmail.com>
Cc:     linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] neighbor: tracing: Move pin6 inside CONFIG_IPV6=y section
Date:   Mon, 16 Oct 2023 14:49:04 +0200
Message-Id: <60cb0b0c6266881e225160f80a83884607617921.1697460418.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_IPV6=n, and building with W=1:

    In file included from include/trace/define_trace.h:102,
		     from include/trace/events/neigh.h:255,
		     from net/core/net-traces.c:51:
    include/trace/events/neigh.h: In function ‘trace_event_raw_event_neigh_create’:
    include/trace/events/neigh.h:42:34: error: variable ‘pin6’ set but not used [-Werror=unused-but-set-variable]
       42 |                 struct in6_addr *pin6;
	  |                                  ^~~~
    include/trace/trace_events.h:402:11: note: in definition of macro ‘DECLARE_EVENT_CLASS’
      402 |         { assign; }                                                     \
	  |           ^~~~~~
    include/trace/trace_events.h:44:30: note: in expansion of macro ‘PARAMS’
       44 |                              PARAMS(assign),                   \
	  |                              ^~~~~~
    include/trace/events/neigh.h:23:1: note: in expansion of macro ‘TRACE_EVENT’
       23 | TRACE_EVENT(neigh_create,
	  | ^~~~~~~~~~~
    include/trace/events/neigh.h:41:9: note: in expansion of macro ‘TP_fast_assign’
       41 |         TP_fast_assign(
	  |         ^~~~~~~~~~~~~~
    In file included from include/trace/define_trace.h:103,
		     from include/trace/events/neigh.h:255,
		     from net/core/net-traces.c:51:
    include/trace/events/neigh.h: In function ‘perf_trace_neigh_create’:
    include/trace/events/neigh.h:42:34: error: variable ‘pin6’ set but not used [-Werror=unused-but-set-variable]
       42 |                 struct in6_addr *pin6;
	  |                                  ^~~~
    include/trace/perf.h:51:11: note: in definition of macro ‘DECLARE_EVENT_CLASS’
       51 |         { assign; }                                                     \
	  |           ^~~~~~
    include/trace/trace_events.h:44:30: note: in expansion of macro ‘PARAMS’
       44 |                              PARAMS(assign),                   \
	  |                              ^~~~~~
    include/trace/events/neigh.h:23:1: note: in expansion of macro ‘TRACE_EVENT’
       23 | TRACE_EVENT(neigh_create,
	  | ^~~~~~~~~~~
    include/trace/events/neigh.h:41:9: note: in expansion of macro ‘TP_fast_assign’
       41 |         TP_fast_assign(
	  |         ^~~~~~~~~~~~~~

Indeed, the variable pin6 is declared and initialized unconditionally,
while it is only used and needlessly re-initialized when support for
IPv6 is enabled.

Fix this by dropping the unused variable initialization, and moving the
variable declaration inside the existing section protected by a check
for CONFIG_IPV6.

Fixes: fc651001d2c5ca4f ("neighbor: Add tracepoint to __neigh_create")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
No changes in generated code.

 include/trace/events/neigh.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/neigh.h b/include/trace/events/neigh.h
index 5eaa1fa9917153f6..833143d0992e063b 100644
--- a/include/trace/events/neigh.h
+++ b/include/trace/events/neigh.h
@@ -39,7 +39,6 @@ TRACE_EVENT(neigh_create,
 	),
 
 	TP_fast_assign(
-		struct in6_addr *pin6;
 		__be32 *p32;
 
 		__entry->family = tbl->family;
@@ -47,7 +46,6 @@ TRACE_EVENT(neigh_create,
 		__entry->entries = atomic_read(&tbl->gc_entries);
 		__entry->created = n != NULL;
 		__entry->gc_exempt = exempt_from_gc;
-		pin6 = (struct in6_addr *)__entry->primary_key6;
 		p32 = (__be32 *)__entry->primary_key4;
 
 		if (tbl->family == AF_INET)
@@ -57,6 +55,8 @@ TRACE_EVENT(neigh_create,
 
 #if IS_ENABLED(CONFIG_IPV6)
 		if (tbl->family == AF_INET6) {
+			struct in6_addr *pin6;
+
 			pin6 = (struct in6_addr *)__entry->primary_key6;
 			*pin6 = *(struct in6_addr *)pkey;
 		}
-- 
2.34.1

