Return-Path: <linux-kernel+bounces-65266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C35C6854A5E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7246128E75D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828A254729;
	Wed, 14 Feb 2024 13:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIP2z1ZO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F4654670;
	Wed, 14 Feb 2024 13:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707916938; cv=none; b=AwrpfOA+BZv/ArCWE3qNyIFcDbv0nFyIJRBFnYU6SRJ5Ce6s8flvAdC4TmQm7FW3tBy29wx4oBbnfg8GUCgM6ZDNyC7Uw++o6j6XO2ZkKWRBkshu9TBklP/mAAovKO3ymDPsle/fOh+M7byjs/VDPsjYysQvdz9dnWs3QT0xiJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707916938; c=relaxed/simple;
	bh=bBRoDlO2YKY1ltZI6iH4y3v5GP17SnYkawVDUuqF5FA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bzL3w++1NrRKjC0m3w9HjT5PYsEDQVh1XML4ACuww11aCxgmpvhjAJdDX/3bEafeJywVCBZcTe95qBuH3AO/xAcbZ2I2/U2Wq6Z49Ca39llDUG1RVDJqMe5aHdS1mKZEdzsgOxnwFUZxKOCASB0uTN9AQHYltU1qKSgjS+9jgnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIP2z1ZO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E154C433C7;
	Wed, 14 Feb 2024 13:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707916938;
	bh=bBRoDlO2YKY1ltZI6iH4y3v5GP17SnYkawVDUuqF5FA=;
	h=From:To:Cc:Subject:Date:From;
	b=bIP2z1ZOkTF1YgpwaFaEpnlpasFryQboSHsOUKZGk+dpmRsNq/FL6pBiOb66gZG8W
	 9YlM2MnLYEc9jkznARRMQ+2qH9r9320YErVQbCDMrAFuMSNNNKu+AlMKdskS+UysSq
	 4R+Qz3YH46sDlXaYwtpaAdmp3kCxpHp9NcDtg/32luoxIygIo3gDQ1x5dT4pRYO8El
	 0N5Lb/Z7K+UY5WbGLsDeiHUdqoaDmHeJffYQUCPZsVB/pYb+rAJz16hivsB4UrCk+O
	 lnCqd38DXsd+rE7l0KhAWEcaPtvAeHzZW5xDLZT2gMoPVCZH0ZOM67imDLSpjdYc7N
	 P5lxb0eQRIy0A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org
Subject: [PATCH RFC 0/5] tracing/probes: Support function parameter access from return probe
Date: Wed, 14 Feb 2024 22:22:14 +0900
Message-Id: <170791693437.389532.6816883363982512874.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here is a series of patches to support accessing function entry data from
function *return* probes (including kretprobe and fprobe-exit event).

This allows us to access the results of some functions, which returns the
error code and its results are passed via function parameter, such as an
structure-initialization function.

For example, vfs_open() will link the file structure to the inode and update
mode. Thus we can trace that changes.

 # echo 'f vfs_open mode=file->f_mode:x32 inode=file->f_inode:x64' >> dynamic_events
 # echo 'f vfs_open%return mode=file->f_mode:x32 inode=file->f_inode:x64' >> dynamic_events 
 # echo 1 > events/fprobes/enable 
 # cat trace
              sh-131     [006] ...1.  1945.714346: vfs_open__entry: (vfs_open+0x4/0x40) mode=0x2 inode=0x0
              sh-131     [006] ...1.  1945.714358: vfs_open__exit: (do_open+0x274/0x3d0 <- vfs_open) mode=0x4d801e inode=0xffff888008470168
             cat-143     [007] ...1.  1945.717949: vfs_open__entry: (vfs_open+0x4/0x40) mode=0x1 inode=0x0
             cat-143     [007] ...1.  1945.717956: vfs_open__exit: (do_open+0x274/0x3d0 <- vfs_open) mode=0x4a801d inode=0xffff888005f78d28
             cat-143     [007] ...1.  1945.720616: vfs_open__entry: (vfs_open+0x4/0x40) mode=0x1 inode=0x0
             cat-143     [007] ...1.  1945.728263: vfs_open__exit: (do_open+0x274/0x3d0 <- vfs_open) mode=0xa800d inode=0xffff888004ada8d8

So as you can see those fields are initialized at exit.

TODO:
 - update README file
 - add/update ftracetest
 - update documents

Thank you,

---

Masami Hiramatsu (Google) (5):
      tracing/probes: Fix to search structure fields correctly
      tracing/fprobe-event: cleanup: Fix a wrong comment in fprobe event
      tracing/probes: Cleanup probe argument parser
      tracing/probes: cleanup: Set trace_probe::nr_args at trace_probe_init
      tracing/probes: Support $argN in return probe (kprobe and fprobe)


 kernel/trace/trace_btf.c        |    4 
 kernel/trace/trace_eprobe.c     |    8 -
 kernel/trace/trace_fprobe.c     |   59 ++++--
 kernel/trace/trace_kprobe.c     |   58 ++++-
 kernel/trace/trace_probe.c      |  417 ++++++++++++++++++++++++++++-----------
 kernel/trace/trace_probe.h      |   30 +++
 kernel/trace/trace_probe_tmpl.h |   10 -
 kernel/trace/trace_uprobe.c     |   14 +
 8 files changed, 433 insertions(+), 167 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

