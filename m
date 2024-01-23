Return-Path: <linux-kernel+bounces-34670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 583558385F1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 04:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEAC4B2281D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8287817EB;
	Tue, 23 Jan 2024 03:13:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D81E810
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 03:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705979603; cv=none; b=KFe2iula5Q9DdbyJK1/KkYQz5xQ3uaZEb9AFstgxFU+RRJDgx/0/J3oxdgIa5Cb8uUYTEsTbiZTTeCVfg6KjdVwONkO2qb+iK2jinIvFDjiSo1PJktqLVMDwurFVFNEhphCidGq9teuj3WV/uGFXH5n0aCjLg2Zfgs+eKNouD3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705979603; c=relaxed/simple;
	bh=P9m3e0sqQC05bMtxDHPbp2+Kd/hzkQ3TRdYVPbYdiRM=;
	h=Message-ID:Date:From:To:Cc:Subject; b=BZFjUhDytw2XyIgaHKHZh59PvPwL+5VnyuIfwu0/mvlu1twgsCzhwAi4qKUwn0HzvXslXATLFKGvIagloMN7rMue21OjzoEJyZXDK5GtBDt5CqWZA9q9JAYGxBM7A8otRiSAihuxtzE6UmteM9JUjKnQHZkhrP32I5WrKEkALDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87E3C433F1;
	Tue, 23 Jan 2024 03:13:22 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rS7FU-00000002i8Q-2gGn;
	Mon, 22 Jan 2024 22:14:52 -0500
Message-ID: <20240123030826.619242906@goodmis.org>
User-Agent: quilt/0.67
Date: Mon, 22 Jan 2024 22:08:26 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/2] tracing/eventfs: Fixes for 6.8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Tracing and eventfs fixes for 6.8:

- Fix histogram tracing_map insertion.
  The tracing_map_insert copies the value into the elt variable and
  then assigns the elt to the entry value. But it is possible that
  the entry value becomes visible on other CPUs before the elt is
  fully initialized. This is fixed by adding a wmb() between the
  initialization of the elt variable and assigning it.

- Have eventfs directory have unique inode numbers. Having them be
  all the same proved to be a failure as the find application will
  think that the directories are causing loops, as it checks for
  directory loops via their inodes. Have the evenfs dir entries
  get their inodes assigned when they are referenced and then save
  them in the eventfs_inode structure.

Petr Pavlu (1):
      tracing: Ensure visibility when inserting an element into tracing_map

Steven Rostedt (Google) (1):
      eventfs: Save directory inodes in the eventfs_inode structure

----
 fs/tracefs/event_inode.c   | 14 +++++++++++---
 fs/tracefs/internal.h      |  7 ++++---
 kernel/trace/tracing_map.c |  7 ++++++-
 3 files changed, 21 insertions(+), 7 deletions(-)

