Return-Path: <linux-kernel+bounces-142723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C4D8A2F66
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50E3F1C2101D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2219082883;
	Fri, 12 Apr 2024 13:29:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ACF824A5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712928572; cv=none; b=O1WedcXt1qeEKhtVeSkLRTZWIUq0k2wO4mmo9woH2gBkobXBL+PlNy7/ASr5PX4Y8J7fjWWaxkbVCy1gdbb6ldg/roBgptdvcwjvXbPBIEVSOFmx0s+A6XEI0EgOIZ9VGfmKXCfu93Zo9iJ/LWU30QtCWzUCbDB1CBlKdQtRzT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712928572; c=relaxed/simple;
	bh=wb27C6YDs2SEano/0L13BedK6zkVHFjvN0jOfsycobQ=;
	h=Message-ID:Date:From:To:Cc:Subject; b=QD/Ac2d7Zpli52nYcJEHibKLzi9X3AcLYrYiaERzNbBFAamKq62Ze7XJ3fLtK3KG/Fhkq9V/XN/qm2CbGwWVuxTHWtMYvUTUEeNvwyGs1GpDT4Qc9PLwU9a9cBZ9ZnwN/hcXQCspWVx06mcno7ZPWj1+yPBsQEAQiJX3yE63tYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4838FC113CC;
	Fri, 12 Apr 2024 13:29:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rvH0n-000000012ow-3O2L;
	Fri, 12 Apr 2024 09:32:13 -0400
Message-ID: <20240412133152.723632549@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 12 Apr 2024 09:31:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/4] tracing: Fixes for v6.9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Tracing fixes for 6.9:

- Fix the buffer_percent accounting as it is dependent on three variables:
  1) pages_read - number of subbuffers read
  2) pages_lost - number of subbuffers lost due to overwrite
  3) pages_touched - number of pages that a writer entered
  These three counters only increment, and to know how many active pages
  there are on the buffer at any given time, the pages_read and
  pages_lost are subtracted from pages_touched. But the pages touched
  was incremented whenever any writer went to the next subbuffer even
  if it wasn't the only one, so it was incremented more than it should
  be causing the counter for how many subbuffers currently have content
  incorrect, which caused the buffer_percent that holds waiters until
  the ring buffer is filled to a given percentage to wake up early.

- Fix warning of unused functions when PERF_EVENTS is not configured in

- Replace bad tab with space in Kconfig for FTRACE_RECORD_RECURSION_SIZE

- Fix to some kerneldoc function comments in eventfs code.

Arnd Bergmann (1):
      tracing: hide unused ftrace_event_id_fops

Prasad Pandit (1):
      tracing: Fix FTRACE_RECORD_RECURSION_SIZE Kconfig entry

Steven Rostedt (Google) (1):
      ring-buffer: Only update pages_touched when a new page is touched

Yang Li (1):
      eventfs: Fix kernel-doc comments to functions

----
 fs/tracefs/event_inode.c    | 14 ++++++++++----
 kernel/trace/Kconfig        |  2 +-
 kernel/trace/ring_buffer.c  |  6 +++---
 kernel/trace/trace_events.c |  4 ++++
 4 files changed, 18 insertions(+), 8 deletions(-)

