Return-Path: <linux-kernel+bounces-77283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F544860335
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32EFA288011
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8066E6AFBF;
	Thu, 22 Feb 2024 19:50:15 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACEC6E5EC;
	Thu, 22 Feb 2024 19:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708631415; cv=none; b=X2AFL0Ne0B91/qwn+v4KCKnLBIVNlbOQ2mPexNGIGXSC1FmrGenMupbmbLhLhAl+UB4uaYDPE63GUC5sgCf00o/doHiDkL9vn/h4yki46UwzFe5AjZZdu7U1NoKG5mvKw0GQb2InD1++5K6ADrxg7j9M9hz3WYEAwoSwm5JFsjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708631415; c=relaxed/simple;
	bh=9xM0zDSZnj/WQCIfmV1M1iafWnZdArwmz7MnQziBy8w=;
	h=Message-ID:Date:From:To:Cc:Subject; b=uVoutYr2WmIdEUkIi2eG8myLt5QnBcpgMEYyd/0T2Hy9qIZOiqYFsdiLq8sibwZ9yLv6P6e3eh96yVU9VJhJ0Heb2sZMQgJa+q8tJB56qd9SZQKThyTdiQXpN56+Zqt50XpW08adrPMol5V5tAFt4DeCiN0VuYDcdm0DGPWCZZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA95C433C7;
	Thu, 22 Feb 2024 19:50:14 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rdF6z-00000006fXj-32Nl;
	Thu, 22 Feb 2024 14:52:05 -0500
Message-ID: <20240222195111.139824528@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 22 Feb 2024 14:51:11 -0500
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
Subject: [PATCH 0/2] tracing: Optimize __string()/__assign_str() processing
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

Steven Rostedt (Google) (2):
      tracing: Rework __assign_str() and __string() to not duplicate getting the string
      tracing: Do not calculate strlen() twice for __string() fields

----
 include/trace/stages/stage2_data_offsets.h   |  4 ++--
 include/trace/stages/stage5_get_offsets.h    | 15 ++++++++++-----
 include/trace/stages/stage6_event_callback.h | 14 ++++++++++----
 3 files changed, 22 insertions(+), 11 deletions(-)

