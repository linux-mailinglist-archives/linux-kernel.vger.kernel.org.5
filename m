Return-Path: <linux-kernel+bounces-54800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A9184B3EB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EF281F24B86
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8D7136668;
	Tue,  6 Feb 2024 11:33:35 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7354D134748;
	Tue,  6 Feb 2024 11:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707219212; cv=none; b=toSh0inuM0BxM83f1Ztx+pY/fhvmgKmQGuo12vmIAgiai0KGYgbus55wAlSynXOqIIFDnmrE7QnOtXJ+qrK3+3nt6hUG/bzSVkyV5cOtNdIvGJsDSK25CsZEQMtZKj8WBBOFefurHj0c7QNrZZIzuPNWh6RETQh65IQ9hSDxmMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707219212; c=relaxed/simple;
	bh=sfvjVRo/uEnLvIM2+rrv73QKbK6qOK2EnD7X46CxfoY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=hb3tnC/C6Y5E4VwA76ssI6bMjNdArdGl+HfIM4ZFKizne9War8xNBspclfGuD5qred3/c5orKlCNl6YieLCMroZdNB10x10nxfPEvUSWMhIoIbCGSct01Ay6pAwPUkpPHWwKxg58G/GDRkLr/FJYg6FwVbyYeKjwmW83HKHIIlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E2DC43601;
	Tue,  6 Feb 2024 11:33:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXJiC-00000006aMp-1QiL;
	Tue, 06 Feb 2024 06:34:00 -0500
Message-ID: <20240206113400.202745776@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 06:32:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Christian Brauner <brauner@kernel.org>,
 Al Viro <viro@ZenIV.linux.org.uk>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 kernel test robot <oliver.sang@intel.com>
Subject: [v6.7][PATCH v2 13/23] tracefs: Zero out the tracefs_inode when allocating it
References: <20240206113158.822006147@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

eventfs uses the tracefs_inode and assumes that it's already initialized
to zero. That is, it doesn't set fields to zero (like ti->private) after
getting its tracefs_inode. This causes bugs due to stale values.

Just initialize the entire structure to zero on allocation so there isn't
any more surprises.

This is a partial fix to access to ti->private. The assignment still needs
to be made before the dentry is instantiated.

Link: https://lore.kernel.org/linux-trace-kernel/20240131185512.315825944@goodmis.org

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
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
(cherry picked from commit d81786f53aec14fd4d56263145a0635afbc64617)
---
 fs/tracefs/inode.c    | 6 ++++--
 fs/tracefs/internal.h | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index e1b172c0e091..888e42087847 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -38,8 +38,6 @@ static struct inode *tracefs_alloc_inode(struct super_block *sb)
 	if (!ti)
 		return NULL;
 
-	ti->flags = 0;
-
 	return &ti->vfs_inode;
 }
 
@@ -779,7 +777,11 @@ static void init_once(void *foo)
 {
 	struct tracefs_inode *ti = (struct tracefs_inode *) foo;
 
+	/* inode_init_once() calls memset() on the vfs_inode portion */
 	inode_init_once(&ti->vfs_inode);
+
+	/* Zero out the rest */
+	memset_after(ti, 0, vfs_inode);
 }
 
 static int __init tracefs_init(void)
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 91c2bf0b91d9..7d84349ade87 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -11,9 +11,10 @@ enum {
 };
 
 struct tracefs_inode {
+	struct inode            vfs_inode;
+	/* The below gets initialized with memset_after(ti, 0, vfs_inode) */
 	unsigned long           flags;
 	void                    *private;
-	struct inode            vfs_inode;
 };
 
 /*
-- 
2.43.0



