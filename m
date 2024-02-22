Return-Path: <linux-kernel+bounces-77375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B18CD860489
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2AAA1C235AC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C92E13790E;
	Thu, 22 Feb 2024 21:12:52 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD0C73F30;
	Thu, 22 Feb 2024 21:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708636371; cv=none; b=qBHZUv/EiDLdd0hFyVrU2bOF2pPy6rXVV6wv95qs0IcP1ctKqM4P6hKFyRhYHvgLm+Gx51HiWWmyhi6MzI/p8M+4BtSMaW/L/z7metv72x+Qkvt10Dvx34bsYNxQJ5oQTjB3T0XGofKnx4SBwN+tzrfqeRmGIdQp7nDetND7ffs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708636371; c=relaxed/simple;
	bh=q2gN7JZMXEO4eGjTHjmn+gKip7svp7iLkDc5IBDr6N0=;
	h=Message-ID:Date:From:To:Cc:Subject; b=iu8wDECD0IRgxGB3eUHzM/xpR1nPPqntVuuWn/h4quvyIbhjXeeQrKgaXUsKbPSkyI+MQzjFYXVBYgHVCoPgOLeytw6BGBtiezRppg7+njMNgZcuvmO8A+J0FkYYbA15A00f/5kcrUuxxowLram5VLdPm4tcif6cc1iTsjrhnlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FC7C433F1;
	Thu, 22 Feb 2024 21:12:51 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rdGOw-00000006hpt-2X1q;
	Thu, 22 Feb 2024 16:14:42 -0500
Message-ID: <20240222211415.255659509@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 22 Feb 2024 16:14:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 0/4] tracing: Optimize __string()/__assign_str() processing
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The TRACE_EVENT() macro handles dynamic strings by having:

  TP_PROTO(struct some_struct *s),
  TP_ARGS(s),
  TP_STRUCT__entry(
        __string(my_string, s->string)
 ),
 TP_fast_assign(
        __assign_str(my_string, s->string);
 )
 TP_printk("%s", __get_str(my_string))

There's even some code that may call a function helper to find the
s->string value. The problem with the above is that the work to get the
s->string is done twice. Once at the __string() and again in the
__assign_str().

The length of the string is calculated via a strlen(), not once, but
twice (using strcpy). The length is actually already recorded in the data
location from __string() and here's no reason to call strcpy() in
__assign_str() as the length is already known.

The __string() macro uses dynamic_array() which has a helper structure that
is created holding the offsets and length of the string fields. Instead of
finding the string twice, just save it off in another field in that helper
structure, and have __assign_str() use that instead.

Changes since v1: https://lore.kernel.org/linux-trace-kernel/20240222195111.139824528@goodmis.org/

- Both the __dynamic_array() and __rel_dynamic_array() macros end with
  a semicolon and are used by __string() and __rel_string()
  respectively. But __string() doesn't have a semicolon after
  __dynamic_array() but __rel_string does have a semicolon after
  __rel_dynamic_array() which is unneeded. Remove the unnecessary
  semicolon to keep the two consistent.

- Fixed __rel_string_len() that was incorrectly using __get_str() and
  not __get_rel_str().

- Added two cleanup patches. One to use the ?: shortcut and the other
  to use the new macro EVENT_NULL_STR instead of open coding "(null)"
  as the string must be consistent between __string() and __assign_str().

Steven Rostedt (Google) (4):
      tracing: Rework __assign_str() and __string() to not duplicate getting the string
      tracing: Do not calculate strlen() twice for __string() fields
      tracing: Use ? : shortcut in trace macros
      tracing: Use EVENT_NULL_STR macro instead of open coding "(null)"

----
 include/linux/trace_events.h                 |  3 +++
 include/trace/events/sunrpc.h                | 12 ++++++------
 include/trace/stages/stage2_data_offsets.h   |  4 ++--
 include/trace/stages/stage5_get_offsets.h    | 15 ++++++++++-----
 include/trace/stages/stage6_event_callback.h | 12 ++++++++----
 5 files changed, 29 insertions(+), 17 deletions(-)

