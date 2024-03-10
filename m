Return-Path: <linux-kernel+bounces-98263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D22EA87779F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 17:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74B6FB20E6E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 16:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B07B39863;
	Sun, 10 Mar 2024 16:37:54 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923D025778
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710088673; cv=none; b=XgzugW/Lr+QiahhRfi0VzVoSRCQxXcs2p+/RsiEhFaFG//8kfXzp/lIXHvvVYNcV6KRc2cxj8LY4UaIiTItrEKdvSMVkX1k3T0eEu09rspvUFjeYKDaZgXTIb5t3rr8tSG+KKjJ6vshwGZzwVutFuKb+FHbiAWjTvRxBFi3guSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710088673; c=relaxed/simple;
	bh=AAtDdhJO5hCCi/j/jGONq3SqyDTOuwe9pjdAewPXMXQ=;
	h=Message-ID:Date:From:To:Cc:Subject; b=C+zuC9POgYT+QTxMMiWcO1tnCL+KABhAOtCqWVH8yi2aPWiefMXkSiuP9ahL7F5t0yy/MdOWHsIdCtmZO7xBNU/zuYNLhLRwygshUzjZq4avFmJaeDE9cLf8FxcDrI9C6tLTtE3Ny5DJ7pqxt7D55uL1+ivVgV2iDPaGzK3svGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CA2C433C7;
	Sun, 10 Mar 2024 16:37:53 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rjMDL-00000001PaY-0mza;
	Sun, 10 Mar 2024 12:39:55 -0400
Message-ID: <20240310163218.425365963@goodmis.org>
User-Agent: quilt/0.67
Date: Sun, 10 Mar 2024 12:32:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/3] tracing/ring-buffer: Some fixes to ring buffer readers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Three fixes to the ring buffer wake ups:

1) ring_buffer_wait() should not loop.
   The ring_buffer_wait() does not have the full context (yet) on if it
   should loop or not. Just exit the loop as soon as its woken up and
   let the callers decide to loop or not (they already do, so it's a bit
   redundant).

2) Fix shortest_full field to be the smallest amount in the ring buffer that
   a waiter is waiting for. The "shortest_full" field is updated when a new
   waiter comes in and wants to wait for a smaller amount of data in the
   ring buffer than other waiters. But after all waiters are woken up, it's
   not reset, so if another waiter comes in wanting to wait for more data,
   it will be woken up when the ring buffer has a smaller amount from what
   the previous waiters were waiting for.

3) The wake up all waiters on close is incorrectly called frome .release()
   and not from .flush() so it will never wake up any waiters as the
   .release() will not get called until all .read() calls are finished. And the
   wakeup is for the waiters in those .read() calls.


Steven Rostedt (Google) (3):
      ring-buffer: Fix waking up ring buffer readers
      ring-buffer: Fix resetting of shortest_full
      tracing: Use .flush() call to wake up readers

----
 kernel/trace/ring_buffer.c | 169 ++++++++++++++++++++++++---------------------
 kernel/trace/trace.c       |  21 ++++--
 2 files changed, 106 insertions(+), 84 deletions(-)

