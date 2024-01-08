Return-Path: <linux-kernel+bounces-19976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D2E8277C6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 570671F23C30
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B835654FB3;
	Mon,  8 Jan 2024 18:36:28 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBA854FA9;
	Mon,  8 Jan 2024 18:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A13CC433C9;
	Mon,  8 Jan 2024 18:36:27 +0000 (UTC)
Date: Mon, 8 Jan 2024 13:37:23 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Beau Belgrave <beaub@linux.microsoft.com>
Subject: [PATCH] tracing user_events: Simplify user_event_parse_field()
 parsing
Message-ID: <20240108133723.031cf322@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Instead of having a bunch of if statements with:

       len = str_has_prefix(field, "__data_loc unsigned ");
       if (len)
               goto skip_next;

       len = str_has_prefix(field, "__data_loc ");
       if (len)
               goto skip_next;

       len = str_has_prefix(field, "__rel_loc unsigned ");
       if (len)
               goto skip_next;

       len = str_has_prefix(field, "__rel_loc ");
       if (len)
               goto skip_next;

	goto parse;

 skip_next:

Consolidate it into a negative check and jump to parse if all the
str_has_prefix() calls fail. If one succeeds, it will just continue with
len equal to the proper string:

       if (!(len = str_has_prefix(field, "__data_loc unsigned ")) &&
           !(len = str_has_prefix(field, "__data_loc ")) &&
           !(len = str_has_prefix(field, "__rel_loc unsigned ")) &&
           !(len = str_has_prefix(field, "__rel_loc "))) {
               goto parse;
       }

 skip_next:

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 9365ce407426..ce0c5f1ded48 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1175,23 +1175,13 @@ static int user_event_parse_field(char *field, struct user_event *user,
 		goto skip_next;
 	}
 
-	len = str_has_prefix(field, "__data_loc unsigned ");
-	if (len)
-		goto skip_next;
-
-	len = str_has_prefix(field, "__data_loc ");
-	if (len)
-		goto skip_next;
-
-	len = str_has_prefix(field, "__rel_loc unsigned ");
-	if (len)
-		goto skip_next;
-
-	len = str_has_prefix(field, "__rel_loc ");
-	if (len)
-		goto skip_next;
+	if (!(len = str_has_prefix(field, "__data_loc unsigned ")) &&
+	    !(len = str_has_prefix(field, "__data_loc ")) &&
+	    !(len = str_has_prefix(field, "__rel_loc unsigned ")) &&
+	    !(len = str_has_prefix(field, "__rel_loc "))) {
+		goto parse;
+	}
 
-	goto parse;
 skip_next:
 	type = field;
 	field = strpbrk(field + len, " ");
-- 
2.43.0


