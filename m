Return-Path: <linux-kernel+bounces-67703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B61FF856F70
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88821C212D4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC621419A1;
	Thu, 15 Feb 2024 21:38:10 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D4913B7A7
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 21:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708033090; cv=none; b=fbm+bvW+VRr5BKNkxhRSpc4OM+78E6ExOKDVKBXE8ODj/xYXFQLyU3O425sCqEXIj8mUZz4lQvyLkn0C9n5yPOn1IoR03pb8fY9UMQ9AGv0tHSI1umR5K6r3q/qUuhUhEK780w++HiYCzHy8AdCKFP7apVQnw1GEW6NO1rGdDJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708033090; c=relaxed/simple;
	bh=Lu+zE6BZH2MGtMtz/F2jcDo3QUDZOZuxm34lAIQAMHI=;
	h=Message-ID:Date:From:To:Cc:Subject; b=E+1wB4Hvrfa9Zmy8b4LAWQ2AoVlpjVYzb1mGEaStzLlidoE+KWVJhCOmZGzHJHo0DjMlVjdDl7Kqxx6/kXOsCRKD9WP1IQfqvYGHQVdKzxikNAcbeEhbyjpS588Vs14Te+5/lFp2gZosSAr2I96sPCntQa2Df8spV79+6Oxqe1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABCCC433F1;
	Thu, 15 Feb 2024 21:38:09 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rajSK-00000000ed2-21Gv;
	Thu, 15 Feb 2024 16:39:44 -0500
Message-ID: <20240215213916.385127578@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 15 Feb 2024 16:39:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/4] tracing: More fixes for v6.8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


More fixes for 6.8

- Fix a false positive kmemleak on saved cmdlines
  Now that the saved_cmdlines structure is allocated via alloc_page()
  and not via kmalloc() it has become invisible to kmemleak.
  The allocation done to one of its pointers was flagged as a
  dangling allocation leak. Make kmemleak aware of this allocation
  and free.

- Fix synthetic event dynamic strings.
  A update that cleaned up the synthetic event code removed the
  return value of trace_string(), and had it return zero instead
  of the length, causing dynamic strings in the synthetic event
  to always have zero size.

- Clean up documentation and header files for seq_buf

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/urgent

Head SHA1: 6efe4d18796934b8ada66c1c446510e7f2d9b972


Andy Shevchenko (2):
      seq_buf: Don't use "proxy" headers
      seq_buf: Fix kernel documentation

Steven Rostedt (Google) (1):
      tracing: Inform kmemleak of saved_cmdlines allocation

Thorsten Blum (1):
      tracing/synthetic: Fix trace_string() return value

----
 include/linux/seq_buf.h           | 17 ++++++++------
 kernel/trace/trace.c              |  3 +++
 kernel/trace/trace_events_synth.c |  3 ++-
 lib/seq_buf.c                     | 49 ++++++++++++++++++++++++---------------
 4 files changed, 45 insertions(+), 27 deletions(-)

