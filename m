Return-Path: <linux-kernel+bounces-42122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C7F83FCAE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 04:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74307282F82
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EE410798;
	Mon, 29 Jan 2024 03:25:24 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B32AFC05
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 03:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706498724; cv=none; b=fFqlWbA/9XqcpjLfo5F1/Ctsb2Vs0mEG9YDYFVWFYqaHh8NeN0tTi7QBrNI6t1gSaBX//zGiilT2QWcc9YvYt33a5yYgmy7Bn5j/yN7ZGcg2Bhtiv7QfV1cQzmGfabV2N9F//NxUh7+Cs894i5raU+/kIhq5pLIS2iuO5qmNObc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706498724; c=relaxed/simple;
	bh=QkhB5DKLD5FW81o/GzGdGieZ/qaY5YnALLoLZPk7dNc=;
	h=Message-ID:Date:From:To:Cc:Subject; b=JZ+1QCqVQw7fe3hIhJ/SD64gsatr4bqyGs6d+P6AyQ5Swj9SlNxD9sYZ3nuHsibc5PAdAj7mSGOOFU5Ptbyi64ybI4KfP7ZBVsJqvZjAQ7OYw+I5NxfhhantTTmzj53l/hyonid2hPdsU1n1ndB8wG//4PlGiUJxDTPbxNg9vMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02597C43601;
	Mon, 29 Jan 2024 03:25:24 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rUIH6-00000004FqW-3IuT;
	Sun, 28 Jan 2024 22:25:32 -0500
Message-ID: <20240129032507.290291577@goodmis.org>
User-Agent: quilt/0.67
Date: Sun, 28 Jan 2024 22:25:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/2] tracing: A couple of updates for 6.8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


tracing: Two small fixes for tracefs and eventfs:

- Fix register_snapshot_trigger() on allocation error
  If the snashot fails to allocate, the register_snapshot_trigger() can
  still return success. If the call to tracing_alloc_snapshot_instance()
  returned anything but 0, it returned 0, but it should have been returing
  the error code from that allocation function.

- Remove leftover code from tracefs doing a dentry walk on remount.
  The update_gid() function was called by the tracefs code on remount
  to update the gid of eventfs, but that is no longer the case, but that
  code wasn't deleted. Nothing calls it. Remove it.

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/urgent

Head SHA1: 29142dc92c37d3259a33aef15b03e6ee25b0d188


Linus Torvalds (1):
      tracefs: remove stale 'update_gid' code

Masami Hiramatsu (Google) (1):
      tracing/trigger: Fix to return error if failed to alloc snapshot

----
 fs/tracefs/event_inode.c            | 38 -------------------------------------
 fs/tracefs/internal.h               |  1 -
 kernel/trace/trace_events_trigger.c |  6 ++++--
 3 files changed, 4 insertions(+), 41 deletions(-)

