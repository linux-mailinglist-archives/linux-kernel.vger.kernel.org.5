Return-Path: <linux-kernel+bounces-19040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D697E82671E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 02:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 998C4281C7F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 01:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AF1EA8;
	Mon,  8 Jan 2024 01:31:47 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB800800;
	Mon,  8 Jan 2024 01:31:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787EAC433C8;
	Mon,  8 Jan 2024 01:31:45 +0000 (UTC)
Date: Sun, 7 Jan 2024 20:32:58 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andy Shevchenko <andy@kernel.org>, Tom
 Zanussi <zanussi@kernel.org>
Subject: [PATCH] tracing histograms: Simplify parse_actions() function
Message-ID: <20240107203258.37e26d2b@gandalf.local.home>
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

The parse_actions() function uses 'len = str_has_prefix()' to test which
action is in the string being parsed. But then it goes and repeats the
logic for each different action. This logic can be simplified and
duplicate code can be removed as 'len' contains the length of the found
prefix which should be used for all actions.

Link: https://lore.kernel.org/all/20240107112044.6702cb66@gandalf.local.home/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 49 ++++++++++++++++----------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5ecf3c8bde20..6ece1308d36a 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -4805,36 +4805,35 @@ static int parse_actions(struct hist_trigger_data *hist_data)
 	int len;
 
 	for (i = 0; i < hist_data->attrs->n_actions; i++) {
+		enum handler_id hid = 0;
+		char *action_str;
+
 		str = hist_data->attrs->action_str[i];
 
-		if ((len = str_has_prefix(str, "onmatch("))) {
-			char *action_str = str + len;
+		if ((len = str_has_prefix(str, "onmatch(")))
+			hid = HANDLER_ONMATCH;
+		else if ((len = str_has_prefix(str, "onmax(")))
+			hid = HANDLER_ONMAX;
+		else if ((len = str_has_prefix(str, "onchange(")))
+			hid = HANDLER_ONCHANGE;
 
-			data = onmatch_parse(tr, action_str);
-			if (IS_ERR(data)) {
-				ret = PTR_ERR(data);
-				break;
-			}
-		} else if ((len = str_has_prefix(str, "onmax("))) {
-			char *action_str = str + len;
+		action_str = str + len;
 
-			data = track_data_parse(hist_data, action_str,
-						HANDLER_ONMAX);
-			if (IS_ERR(data)) {
-				ret = PTR_ERR(data);
-				break;
-			}
-		} else if ((len = str_has_prefix(str, "onchange("))) {
-			char *action_str = str + len;
+		switch (hid) {
+		case HANDLER_ONMATCH:
+			data = onmatch_parse(tr, action_str);
+			break;
+		case HANDLER_ONMAX:
+		case HANDLER_ONCHANGE:
+			data = track_data_parse(hist_data, action_str, hid);
+			break;
+		default:
+			data = ERR_PTR(-EINVAL);
+			break;
+		}
 
-			data = track_data_parse(hist_data, action_str,
-						HANDLER_ONCHANGE);
-			if (IS_ERR(data)) {
-				ret = PTR_ERR(data);
-				break;
-			}
-		} else {
-			ret = -EINVAL;
+		if (IS_ERR(data)) {
+			ret = PTR_ERR(data);
 			break;
 		}
 
-- 
2.42.0


