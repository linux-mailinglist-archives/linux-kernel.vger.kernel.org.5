Return-Path: <linux-kernel+bounces-69334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B160E858785
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40ED9B216EA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9B913B2AB;
	Fri, 16 Feb 2024 21:00:14 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CFB28E2B;
	Fri, 16 Feb 2024 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708117213; cv=none; b=rMq6vydgQKJYUP7++LVyxLRrW50w8p1vWI2kgJod/fr17niAbJfWZeIbj5Linb7KR6hskeRW+C1Jwrf+2IEFm6MM5Jk2UOrgqBiJ7uRtpPiDipW5jh5ZSTYHQBvotH59kOArj/ik1Y7vWlK4N4rDQW6CF0Qq8Whe1WZ1MulsiJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708117213; c=relaxed/simple;
	bh=d1b39BTBcPpv6aNOIOnZGThK756SFXqll6sPwSKkkQA=;
	h=Message-ID:Date:From:To:Cc:Subject; b=BRMiFd0NQa/zk7at5MY//oWYbktzjYBNW88kDVFWhemI8xj3cbUo2twvduZRW1sDesj2jaeua4MiADLOYBEAJRyLZQTnF7zjvxdaR0SHHx7cdxOaw3cPdrgby4JxkLHvu6TwjO7+uirXiXwquZi5H2A6kYgaGd3WXi9eduqC3gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5BEC433F1;
	Fri, 16 Feb 2024 21:00:13 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rb5LC-000000013BK-1TSV;
	Fri, 16 Feb 2024 16:01:50 -0500
Message-ID: <20240216210047.584712062@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 16 Feb 2024 16:00:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>,
 Vincent Donnefort <vdonnefort@google.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Mete Durlu <meted@linux.ibm.com>
Subject: [PATCH v3 0/3] tracing: Changes to saved_cmdlines
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


Repost of "tracing: Fix wasted memory in saved_cmdlines logic" (hence the v3:
v2 at: https://lore.kernel.org/linux-trace-kernel/20240213115232.5fd9e611@gandalf.local.home/)
That patch was based on the two other patches in this series, but
I forgot to post those two other patches.

Instead of applying the update to the saved_cmdlines logic on top of the
two phantom patches, apply it first. This way it can be backported
nicely. I put a "Fixes" tag on it but not a Cc stable as it's more of
a nice to have than fixing any bug (besides wasting some memory).

The second two patches simply move code around. The goal is to keep
all the saved_cmdlines logic in one place. Currently it's in two files
(trace.c and trace_sched_switch.c). Since trace.c is awfully large,
move all the code to trace_sched_switch.c, as that's its only purpose
today anyway.

The first patch is the saved_cmdlines update to consolidate memory.

The second patch removes some open coded saved_cmdlines logic in trace.c
into a helper function to make it a cleaner move.

The last patch simply moves the code from trace.c into trace_sched_switch.c

Steven Rostedt (Google) (3):
      tracing: Have saved_cmdlines arrays all in one allocation
      tracing: Move open coded processing of tgid_map into helper function
      tracing: Move saved_cmdline code into trace_sched_switch.c

----
 kernel/trace/trace.c              | 509 +------------------------------------
 kernel/trace/trace.h              |  10 +
 kernel/trace/trace_sched_switch.c | 516 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 529 insertions(+), 506 deletions(-)

