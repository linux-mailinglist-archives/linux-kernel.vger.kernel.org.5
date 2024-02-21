Return-Path: <linux-kernel+bounces-74856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB67585DDAC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CA92B29B85
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD80F7F7D3;
	Wed, 21 Feb 2024 14:06:40 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5577BB16
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524400; cv=none; b=TAR1Rg1cFtVD1U91hxtQIgtjz0RsS7WZ1ERvv36HbCeXK8fDYY5iilwyGbzqThX3Z11tmj1+O+FqMpU0Mekj8Sz6FIsZxhy75RKrvupUpfc+wlfNI8gzKcftEQGck2wqoOgk6YgPMS/AwwyzA9xTRhnWkQKZM/RUzrLxxrT3EYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524400; c=relaxed/simple;
	bh=gtE6yciW706PpSRtyfkNsywud2GHgMWnZUBSjUtZ27I=;
	h=Message-ID:Date:From:To:Cc:Subject; b=D1NgHTZCLv22k3HA3E9d+KKw9xrK83mOiFYqP3RVY9NY61vx4c6Zynr4VwxlfLrxS/L49W0OPjuIbNoF/KdOltMMtK2ocGh9sUisDwRfFRiF6thTNh5nFovF77csrKcHLEUC+PIB/tH3gcSOhwMMXKF33vLzsiC/gIfLdaMS3Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA83C43390;
	Wed, 21 Feb 2024 14:06:39 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rcnGu-00000002i6u-00yF;
	Wed, 21 Feb 2024 09:08:28 -0500
Message-ID: <20240221140756.797572998@goodmis.org>
User-Agent: quilt/0.67
Date: Wed, 21 Feb 2024 09:07:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/11] tracing: Updates for v6.9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


Steven Rostedt (Google) (5):
      eventfs: Add WARN_ON_ONCE() to checks in eventfs_root_lookup()
      eventfs: Create eventfs_root_inode to store dentry
      tracing: Have saved_cmdlines arrays all in one allocation
      tracing: Move open coded processing of tgid_map into helper function
      tracing: Move saved_cmdline code into trace_sched_switch.c

Vincent Donnefort (6):
      ring-buffer: Zero ring-buffer sub-buffers
      ring-buffer: Introducing ring-buffer mapping functions
      tracing: Add snapshot refcount
      tracing: Allow user-space mapping of the ring-buffer
      Documentation: tracing: Add ring-buffer mapping
      ring-buffer/selftest: Add ring-buffer mapping test

----
 Documentation/trace/index.rst                  |   1 +
 Documentation/trace/ring-buffer-map.rst        | 106 ++++
 fs/tracefs/event_inode.c                       |  70 ++-
 fs/tracefs/internal.h                          |   2 -
 include/linux/ring_buffer.h                    |   7 +
 include/uapi/linux/trace_mmap.h                |  48 ++
 kernel/trace/ring_buffer.c                     | 385 ++++++++++++-
 kernel/trace/trace.c                           | 743 +++++++------------------
 kernel/trace/trace.h                           |  19 +-
 kernel/trace/trace_events_trigger.c            |  58 +-
 kernel/trace/trace_sched_switch.c              | 515 +++++++++++++++++
 tools/testing/selftests/ring-buffer/Makefile   |   8 +
 tools/testing/selftests/ring-buffer/config     |   2 +
 tools/testing/selftests/ring-buffer/map_test.c | 273 +++++++++
 14 files changed, 1671 insertions(+), 566 deletions(-)
 create mode 100644 Documentation/trace/ring-buffer-map.rst
 create mode 100644 include/uapi/linux/trace_mmap.h
 create mode 100644 tools/testing/selftests/ring-buffer/Makefile
 create mode 100644 tools/testing/selftests/ring-buffer/config
 create mode 100644 tools/testing/selftests/ring-buffer/map_test.c

