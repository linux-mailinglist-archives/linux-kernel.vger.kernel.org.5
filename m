Return-Path: <linux-kernel+bounces-49105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C998465E2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970E01C24A95
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0681171C4;
	Fri,  2 Feb 2024 02:30:07 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C454FC03;
	Fri,  2 Feb 2024 02:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706841006; cv=none; b=apPK8tNkUTFn+ICTl4gXOkjFXfJNDPBA17RsFX30gMUrk/5jKaMQFZ+Nw4Tz99cWUKTHUFB80MyGkNeokNkFQ2COnGk8tNe6NAfq+Ob2Xyxm4T2VyT/RQ++TAOx2uOCjclRhk49p5GZ/VYQbTpf0GP+IE2jFjnAcj2tFHFZQhu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706841006; c=relaxed/simple;
	bh=c2ljJPiZws6OX2OlljjxZ50rg8MQ1U9fnX0GsF88OI4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Lt1aCBWheqeqzt3jbeEgLJS+OrkpfEGhiIEWzinPgR4w3Mbz36QIYeIR7y2ZnJ2DZLJ9VkRmxQqL8Iv9vsOwveYa6PAAnLyNTCd3fbUzBa6wnaIeFrqxgRK31go6MSpsiiytNvmSjQvGvPBVSLUZASWvGgavxJFgLasMutP7BFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC6CC43142;
	Fri,  2 Feb 2024 02:30:05 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rVjJv-00000005kBZ-45i4;
	Thu, 01 Feb 2024 21:30:23 -0500
Message-ID: <20240202023023.834732790@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 01 Feb 2024 21:30:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Christian Brauner <brauner@kernel.org>,
 Al Viro <viro@ZenIV.linux.org.uk>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Al Viro <viro@zeniv.linux.org.uk>
Subject: [for-linus][PATCH 12/13] eventfs: Remove fsnotify*() functions from lookup()
References: <20240202022959.515961549@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The dentries and inodes are created when referenced in the lookup code.
There's no reason to call fsnotify_*() functions when they are created by
a reference. It doesn't make any sense.

Link: https://lore.kernel.org/linux-trace-kernel/20240201002719.GS2087318@ZenIV/
Link: https://lore.kernel.org/linux-trace-kernel/20240201161617.166973329@goodmis.org

Cc: stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>
Fixes: a376007917776 ("eventfs: Implement functions to create files and dirs when accessed");
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index ca7daee7c811..9e031e5a2713 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -366,7 +366,6 @@ static struct dentry *lookup_file(struct eventfs_inode *parent_ei,
 	dentry->d_fsdata = get_ei(parent_ei);
 
 	d_add(dentry, inode);
-	fsnotify_create(dentry->d_parent->d_inode, dentry);
 	return NULL;
 };
 
@@ -408,7 +407,6 @@ static struct dentry *lookup_dir_entry(struct dentry *dentry,
 	inc_nlink(inode);
 	d_add(dentry, inode);
 	inc_nlink(dentry->d_parent->d_inode);
-	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
 	return NULL;
 }
 
-- 
2.43.0



