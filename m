Return-Path: <linux-kernel+bounces-49096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 830B48465D5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5E171C2311F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770BCE55E;
	Fri,  2 Feb 2024 02:30:05 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F101EC2CF;
	Fri,  2 Feb 2024 02:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706841005; cv=none; b=U2F9tgwiKbKMWmYdZMZcQgv+m2XIa2zqlPsJnXKN2bv3Ecm+Ori+/iKqkekKjMbVAQvmMSvt29zfrzCTfkkAIe4pGmn4z49fmEWFjeFgcN1sV4/WLbNWomllOvt5U8BLFsKN4I7YpNse53KhVMfaMAsGiSiD5As1nDL0TEJ8Q6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706841005; c=relaxed/simple;
	bh=Xuuj38zWAdqjpeYCtGvAUUvs1e01F3I0KslCF+lAPSw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=hJrR1AFM9b5Lq++pIEp4Z6kcq8dVZkyFzt+9DW86TZXZGcpS5AmVjlV2pmqzVewVJq5xtFI5tWiAnQzM/n/qD8+grpTiB5AxsQnsjRxf4qbUd4gw68DtTvP8/RB3RivggUz02UTmoBqGbHH9RVvznTmgbvVMyUo9zKISAb2DNf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E000C43399;
	Fri,  2 Feb 2024 02:30:04 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rVjJu-00000005k78-2En2;
	Thu, 01 Feb 2024 21:30:22 -0500
Message-ID: <20240202023022.390733076@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 01 Feb 2024 21:30:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>,
 Al Viro <viro@ZenIV.linux.org.uk>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 kernel test robot <oliver.sang@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [for-linus][PATCH 03/13] eventfs: Initialize the tracefs inode properly
References: <20240202022959.515961549@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Linus Torvalds <torvalds@linux-foundation.org>

The tracefs-specific fields in the inode were not initialized before the
inode was exposed to others through the dentry with 'd_instantiate()'.

Move the field initializations up to before the d_instantiate.

Link: https://lore.kernel.org/linux-trace-kernel/20240131185512.478449628@goodmis.org

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202401291043.e62e89dc-oliver.sang@intel.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 1c3dd0ad4660..824b1811e342 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -370,6 +370,8 @@ static struct dentry *create_dir(struct eventfs_inode *ei, struct dentry *parent
 
 	ti = get_tracefs(inode);
 	ti->flags |= TRACEFS_EVENT_INODE;
+	/* Only directories have ti->private set to an ei, not files */
+	ti->private = ei;
 
 	inc_nlink(inode);
 	d_instantiate(dentry, inode);
@@ -515,7 +517,6 @@ create_file_dentry(struct eventfs_inode *ei, int idx,
 static void eventfs_post_create_dir(struct eventfs_inode *ei)
 {
 	struct eventfs_inode *ei_child;
-	struct tracefs_inode *ti;
 
 	lockdep_assert_held(&eventfs_mutex);
 
@@ -525,9 +526,6 @@ static void eventfs_post_create_dir(struct eventfs_inode *ei)
 				 srcu_read_lock_held(&eventfs_srcu)) {
 		ei_child->d_parent = ei->dentry;
 	}
-
-	ti = get_tracefs(ei->dentry->d_inode);
-	ti->private = ei;
 }
 
 /**
-- 
2.43.0



