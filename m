Return-Path: <linux-kernel+bounces-67705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A85CB856F72
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F62B1F22481
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C556A1419AE;
	Thu, 15 Feb 2024 21:38:10 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADE313DB8A;
	Thu, 15 Feb 2024 21:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708033090; cv=none; b=fzofpqFrCne97cb21cXFnr/hAmzjDz5HcRdt31N6qc/KH86vFrQc5QFvAznzDWIzZJ1ewMPzJ4m/nzULbl6NHwLjgi0gkyrIKkh+YmkpukWHY9VyR0dNzEJ8tMiv8/OKxnWJ/am6MEltpA3hKY/8b60VFFKHRmtLYogScuwWDwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708033090; c=relaxed/simple;
	bh=g+k8dVIgHQp4F/ACveGtoBHKj0W/K4gDHR8e9oQTBSw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=php4NzdkKEu5dE9+p24cXZa8IuKuEtsCNu6d/vyPGeh/tes0R74RIqPxRhpaS507vXtO1AXekF3oGlpN/H8s9HbYpdLn7t4gNT/Ekhw7LUH7SKy7+wS34f0AY4pUbvL4Nq7LCiVKaE7nCQ01hH8Yh2cW8YJbLhcE9GFnEtkUpuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB84BC43399;
	Thu, 15 Feb 2024 21:38:09 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rajSK-00000000ee2-3PlZ;
	Thu, 15 Feb 2024 16:39:44 -0500
Message-ID: <20240215213944.670781481@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 15 Feb 2024 16:39:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Thorsten Blum <thorsten.blum@toblux.com>
Subject: [for-linus][PATCH 2/4] tracing/synthetic: Fix trace_string() return value
References: <20240215213916.385127578@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Thorsten Blum <thorsten.blum@toblux.com>

Fix trace_string() by assigning the string length to the return variable
which got lost in commit ddeea494a16f ("tracing/synthetic: Use union
instead of casts") and caused trace_string() to always return 0.

Link: https://lore.kernel.org/linux-trace-kernel/20240214220555.711598-1-thorsten.blum@toblux.com

Cc: stable@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: ddeea494a16f ("tracing/synthetic: Use union instead of casts")
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index e7af286af4f1..c82b401a294d 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -441,8 +441,9 @@ static unsigned int trace_string(struct synth_trace_event *entry,
 	if (is_dynamic) {
 		union trace_synth_field *data = &entry->fields[*n_u64];
 
+		len = fetch_store_strlen((unsigned long)str_val);
 		data->as_dynamic.offset = struct_size(entry, fields, event->n_u64) + data_size;
-		data->as_dynamic.len = fetch_store_strlen((unsigned long)str_val);
+		data->as_dynamic.len = len;
 
 		ret = fetch_store_string((unsigned long)str_val, &entry->fields[*n_u64], entry);
 
-- 
2.43.0



