Return-Path: <linux-kernel+bounces-78454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9258613C1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649631F230AA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DF680C0C;
	Fri, 23 Feb 2024 14:17:09 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7F87F46E
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708697829; cv=none; b=d6gyH63yuCMqiQzq6cxuI6n0YYQQH1EvYGlN/dthqRXWKtcxisD87Q+/25qZ8P3xuMLMXRGstmsh2VdHuwii5K+wbsGsFKDlg2GJZwvS395hERuapzq9wMScbnBbexmC64QUgANcK3vNIAx2TSc2ZT1JPJNBFZs1hWf7cX47sa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708697829; c=relaxed/simple;
	bh=zYQCDr9hrLFweiad+Qinjuk9PQpfLW4WKjieIAuoI5c=;
	h=Message-ID:Date:From:To:Cc:Subject; b=IcdPi165dzaMLeMh9oHVQTCm8qq/jk4wyxcEOoxEEzQTFUxkdEugZsVQWIxCOvuiVaUkhhO27xbid9Y26/ctLgBOpsliy1EVuf96mIizHGK2UCN42IKsEpIwK9FRR4kbLdluogTsYMJZPiEjhJ7rOlEdLN6eG+2fE3B4SX4LRJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DDAC433F1;
	Fri, 23 Feb 2024 14:17:08 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rdWOD-000000077Kk-2NW1;
	Fri, 23 Feb 2024 09:19:01 -0500
Message-ID: <20240223141838.985298316@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 23 Feb 2024 09:18:38 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/13] tracing: Updates for 6.9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


Beau Belgrave (4):
      tracing/user_events: Prepare find/delete for same name events
      tracing/user_events: Introduce multi-format events
      selftests/user_events: Test multi-format events
      tracing/user_events: Document multi-format flag

John Garry (1):
      tracing: Use init_utsname()->release

Steven Rostedt (Google) (8):
      NFSD: Fix nfsd_clid_class use of __string_len() macro
      drm/i915: Add missing ; to __assign_str() macros in tracepoint code
      tracing: Rework __assign_str() and __string() to not duplicate getting the string
      tracing: Do not calculate strlen() twice for __string() fields
      tracing: Use ? : shortcut in trace macros
      tracing: Use EVENT_NULL_STR macro instead of open coding "(null)"
      tracing: Fix snapshot counter going between two tracers that use it
      tracing: Decrement the snapshot if the snapshot trigger fails to register

----
 Documentation/trace/user_events.rst                |  27 ++-
 drivers/gpu/drm/i915/display/intel_display_trace.h |   6 +-
 fs/nfsd/trace.h                                    |   2 +-
 include/linux/trace_events.h                       |   3 +
 include/trace/events/sunrpc.h                      |  12 +-
 include/trace/stages/stage2_data_offsets.h         |   4 +-
 include/trace/stages/stage5_get_offsets.h          |  15 +-
 include/trace/stages/stage6_event_callback.h       |  12 +-
 include/uapi/linux/user_events.h                   |   6 +-
 kernel/trace/trace.c                               |   6 +-
 kernel/trace/trace_events_trigger.c                |   5 +-
 kernel/trace/trace_events_user.c                   | 209 +++++++++++++++------
 tools/testing/selftests/user_events/abi_test.c     | 134 +++++++++++++
 13 files changed, 354 insertions(+), 87 deletions(-)

