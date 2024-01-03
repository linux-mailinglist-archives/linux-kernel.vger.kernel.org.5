Return-Path: <linux-kernel+bounces-15048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 402C28226A9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90FF2283EA8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0470115C6;
	Wed,  3 Jan 2024 01:51:27 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFE017981
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 01:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF21C433C8;
	Wed,  3 Jan 2024 01:51:26 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rKqQm-00000000k5G-1GON;
	Tue, 02 Jan 2024 20:52:28 -0500
Message-ID: <20240103015043.912131206@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 02 Jan 2024 20:50:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/2] tracing: Two more small fixes for v6.7-rc8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


tracing fixes for v6.7-rc8:

- Fix a NULL kernel dereference in set_gid() on tracefs mounting.
  When tracefs is mounted with "gid=1000", it will update the existing
  dentries to have the new gid. The tracefs_inode which is retrieved
  by a container_of(dentry->d_inode) has flags to see if the inode
  belongs to the eventfs system.

  The issue that was fixed was if getdents() was called on tracefs
  that was previously mounted, and was not closed. It will leave
  a "cursor dentry" in the subdirs list of the current dentries that
  set_gid() walks. On a remount of tracefs, the container_of(dentry->d_inode)
  will dereference a NULL pointer and cause a crash when referenced.

  Simply have a check for dentry->d_inode to see if it is NULL and if
  so, skip that entry.

- Fix the bits of the eventfs_inode structure. The "is_events" bit
  was taken  from the nr_entries field, but the nr_entries field wasn't
  updated to be 30 bits and was still 31. Including the "is_freed" bit
  this would use 33 bits which would make the structure use another
  integer for just one bit.

Steven Rostedt (Google) (2):
      tracefs: Check for dentry->d_inode exists in set_gid()
      eventfs: Fix bitwise fields for "is_events"

----
 fs/tracefs/inode.c    | 4 ++++
 fs/tracefs/internal.h | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

