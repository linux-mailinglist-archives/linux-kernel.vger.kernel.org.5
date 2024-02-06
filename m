Return-Path: <linux-kernel+bounces-54875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5980A84B4AD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 135092880E3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDC6134CC2;
	Tue,  6 Feb 2024 12:09:19 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E17134CF6;
	Tue,  6 Feb 2024 12:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221358; cv=none; b=e/exCOCJksjG/gMh4PwkwFJzGkvAmguelspSiKkQsl2sWx2xRNnVNl3EaYso8vU20j2pJu/FLjtZY95B6ki8+NddTU/JS7x7lECs/ST+0PR6yXGmiTI2kPsoRlHESvnlZi8/oWtLbeFupWVSSSCDdtsTeXCq3MVZsGs0vG8g0ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221358; c=relaxed/simple;
	bh=HpCoj+t+vi2LdeF+PL28Fdd1rrAU/roBtR4tfXwNtSQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=E6g4UOilSYcux9lIczgGtniWZ7TP+58KMOX4B/+voQ8GrSGk0HXT0crw0eHKwxhHkBm2Kmy0oFNxvYn9eQB3sVoJIJP2SF7qXQgKQRdxgZe5CbW2JLAosA7e1qGicNUjc2UCE9OosH7ZaspG6tRNUEBTyk6uUb/xjFXpcXM/NrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68486C43399;
	Tue,  6 Feb 2024 12:09:18 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXKGo-00000006b2P-3XxX;
	Tue, 06 Feb 2024 07:09:46 -0500
Message-ID: <20240206120946.700644630@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 07:09:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [v6.6][PATCH 02/57] Revert "eventfs: Check for NULL ef in eventfs_set_attr()"
References: <20240206120905.570408983@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

This reverts commit d8f492a059728bbd397defbc9b8d2f4159d869b5.

The eventfs was not designed properly and may have some hidden bugs in it.
Linus rewrote it properly and I trust his version more than this one. Revert
the backported patches for 6.6 and re-apply all the changes to make it
equivalent to Linus's version.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index efbdc47c74dc..5fcfb634fec2 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -113,14 +113,14 @@ static int eventfs_set_attr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	mutex_lock(&eventfs_mutex);
 	ef = dentry->d_fsdata;
-	if (ef && ef->is_freed) {
+	if (ef->is_freed) {
 		/* Do not allow changes if the event is about to be removed. */
 		mutex_unlock(&eventfs_mutex);
 		return -ENODEV;
 	}
 
 	ret = simple_setattr(idmap, dentry, iattr);
-	if (!ret && ef)
+	if (!ret)
 		update_attr(ef, iattr);
 	mutex_unlock(&eventfs_mutex);
 	return ret;
-- 
2.43.0



