Return-Path: <linux-kernel+bounces-6412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E145C819885
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D7D28779D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127F811C80;
	Wed, 20 Dec 2023 06:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="foyUaFl+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0316F125A2;
	Wed, 20 Dec 2023 06:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=8LwcoNWLw53BgmXy5gUdC1weECvf6zvN6TtH0526JlA=; b=foyUaFl+Vv1WsP8BPW2UH/v+Fa
	dJE7GexHhUblWUPRStMyDEZtH0At0hzA4dY6eXnmVA+PYWuiFk5lV9N5xMlbTrfOrrgfbfp9Ac2Zn
	ZZ7hvkpzZGtnXduuGsdRAItaZYzJ3mMl0iMz/u60dKG7s43VuD0tTZBt4YEP5qpfkkkQOGn3QOY74
	62nKH5ejoLIo0q+81pcRIeiNSwnEUyF8FBjELnKRYsUcziQBaZN39bOv+DOAUFCCM8B2Fv34fH/6V
	UpI4LE27dg6TSG+Z8HhTJ41t4y95ukuxnvNrMYclH2TTshwyHM8qb003KBlWOB6Ls1+L9kuFporJh
	B/Ksv9Aw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFpog-00GH3V-30;
	Wed, 20 Dec 2023 06:12:27 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing/synthetic: fix kernel-doc warnings
Date: Tue, 19 Dec 2023 22:12:26 -0800
Message-ID: <20231220061226.30962-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scripts/kernel-doc warns about using @args: for variadic arguments to
functions. Documentation/doc-guide/kernel-doc.rst says that this should
be written as @...: instead, so update the source code to match that,
preventing the warnings.

trace_events_synth.c:1165: warning: Excess function parameter 'args' description in '__synth_event_gen_cmd_start'
trace_events_synth.c:1714: warning: Excess function parameter 'args' description in 'synth_event_trace'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-trace-kernel@vger.kernel.org
---
 kernel/trace/trace_events_synth.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -1137,7 +1137,7 @@ EXPORT_SYMBOL_GPL(synth_event_add_fields
  * @cmd: A pointer to the dynevent_cmd struct representing the new event
  * @name: The name of the synthetic event
  * @mod: The module creating the event, NULL if not created from a module
- * @args: Variable number of arg (pairs), one pair for each field
+ * @...: Variable number of arg (pairs), one pair for each field
  *
  * NOTE: Users normally won't want to call this function directly, but
  * rather use the synth_event_gen_cmd_start() wrapper, which
@@ -1695,7 +1695,7 @@ __synth_event_trace_end(struct synth_eve
  * synth_event_trace - Trace a synthetic event
  * @file: The trace_event_file representing the synthetic event
  * @n_vals: The number of values in vals
- * @args: Variable number of args containing the event values
+ * @...: Variable number of args containing the event values
  *
  * Trace a synthetic event using the values passed in the variable
  * argument list.

