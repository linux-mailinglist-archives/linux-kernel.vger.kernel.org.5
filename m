Return-Path: <linux-kernel+bounces-73137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0538985BE0A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 388C31C21FAB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7FC6A8D9;
	Tue, 20 Feb 2024 14:05:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FD465BDD;
	Tue, 20 Feb 2024 14:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708437917; cv=none; b=Lm+NW0zclw4aQfQZjkUH2YhNJW2vevPDysQctaEikmKfCRTXu5RooSQ0L2LEhAM75GIXCXLuh1Yb625+Ks6/qilpHhqF7TvtdWn5oMchkUrRNTlsDosCx+lUzB8iRyWxNxW8rBWaDzGPnfnPahxCh7iAQ3uUgjzg0i07wVi71q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708437917; c=relaxed/simple;
	bh=EteAf7m6g8ZwJ4f+8sFnTF5mSQpmaFi6c6AiotBKWdE=;
	h=Message-ID:Date:From:To:Cc:Subject; b=Xbn3Q5epcn9dvJyJ2ngT4+AmGRREir2I7dXLBe5XfIT2GLhkYbzNIxqfV9Pu2O9SuVnLdXal6igTfgffSAvS9nmt1L8BwdEjrDlWRYuEiy1fHKCAT55lgh6JTJhFoClBxA7kcGkMmAzN7Gco+qP7n/sthKORoqA1PIqyOl7cE5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B5FC43394;
	Tue, 20 Feb 2024 14:05:17 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rcQlz-0000000266G-0djS;
	Tue, 20 Feb 2024 09:07:03 -0500
Message-ID: <20240220140613.782679360@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 20 Feb 2024 09:06:13 -0500
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
Subject: [PATCH v4 0/3] tracing: Changes to saved_cmdlines
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


The first patch is to consolidate the map_cmdline_to_pid into the allocate
page for the saved_cmdlines structure.

The second patch removes some open coded saved_cmdlines logic in trace.c
into a helper function to make it a cleaner move.

The third patch simply moves code around. The goal is to keep all the
saved_cmdlines logic in one place. Currently it's in two files (trace.c and
trace_sched_switch.c). Since trace.c is awfully large, move all the code to
trace_sched_switch.c, as that's its only purpose today anyway.

Changes since v3: https://lore.kernel.org/linux-trace-kernel/20240216210047.584712062@goodmis.org/

- The map_cmdline_to_pid field was moved into the pages allocated of the
  structure and that replaced the kmalloc. But that field still had
  kfree() called on it in the freeing of the structure which caused
  a memory corruption.

Steven Rostedt (Google) (3):
      tracing: Have saved_cmdlines arrays all in one allocation
      tracing: Move open coded processing of tgid_map into helper function
      tracing: Move saved_cmdline code into trace_sched_switch.c

----
 kernel/trace/trace.c              | 509 +------------------------------------
 kernel/trace/trace.h              |  10 +
 kernel/trace/trace_sched_switch.c | 515 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 528 insertions(+), 506 deletions(-)

