Return-Path: <linux-kernel+bounces-54906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D4484B504
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBC861F22E52
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4B213DB9A;
	Tue,  6 Feb 2024 12:09:29 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A991386BD;
	Tue,  6 Feb 2024 12:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221363; cv=none; b=qnRT6Iobxg1lbn32nGnIVCSlBgDHPmaCXBOzUTf+WJ0AqeylxdCB/M0z8g0uFnhqtjKkxaS6ugTjYLqHOIOsfSQZy5Aja20o6xJT/rBOpRZgyiQGEAW81rxyMC+0hn52V7rRxcDOQdVnYQzCxkkYAHjksK/cf+ODjLo33lAH88A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221363; c=relaxed/simple;
	bh=SD2Ctw8XfUaOuPz+cDqcSSEYSx7EhLuOjt5hoKj8zpc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=qeEQq3REkzClJaKMN7lYX2/Var1q1m1BEBV8mSMuMf9KRKi1yEtq2IwOMdqonFbRn3iSLD75NY8M/YABf221Q1VJ3QTaRG7/UOwsdoZ38yjzwsxvOnnhe/D2+ClKHs7HCP+13W/+oPt1RZBKw3LLDkgqyEfi08UDRaytnzChvtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A4BC43394;
	Tue,  6 Feb 2024 12:09:22 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXKGt-00000006bGL-1eGZ;
	Tue, 06 Feb 2024 07:09:51 -0500
Message-ID: <20240206120951.255146556@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 07:09:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Beau Belgrave <beaub@linux.microsoft.com>
Subject: [v6.6][PATCH 30/57] eventfs: Fix events beyond NAME_MAX blocking tasks
References: <20240206120905.570408983@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Beau Belgrave <beaub@linux.microsoft.com>

Eventfs uses simple_lookup(), however, it will fail if the name of the
entry is beyond NAME_MAX length. When this error is encountered, eventfs
still tries to create dentries instead of skipping the dentry creation.
When the dentry is attempted to be created in this state d_wait_lookup()
will loop forever, waiting for the lookup to be removed.

Fix eventfs to return the error in simple_lookup() back to the caller
instead of continuing to try to create the dentry.

Link: https://lore.kernel.org/linux-trace-kernel/20231210213534.497-1-beaub@linux.microsoft.com

Fixes: 63940449555e ("eventfs: Implement eventfs lookup, read, open functions")
Link: https://lore.kernel.org/linux-trace-kernel/20231208183601.GA46-beaub@linux.microsoft.com/
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
(cherry picked from commit 5eaf7f0589c0d88178f0fbeebe0e0b7108258707)
---
 fs/tracefs/event_inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 0b90869fd805..43e237864a42 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -546,6 +546,8 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 		if (strcmp(ei_child->name, name) != 0)
 			continue;
 		ret = simple_lookup(dir, dentry, flags);
+		if (IS_ERR(ret))
+			goto out;
 		create_dir_dentry(ei, ei_child, ei_dentry, true);
 		created = true;
 		break;
@@ -568,6 +570,8 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 			if (r <= 0)
 				continue;
 			ret = simple_lookup(dir, dentry, flags);
+			if (IS_ERR(ret))
+				goto out;
 			create_file_dentry(ei, i, ei_dentry, name, mode, cdata,
 					   fops, true);
 			break;
-- 
2.43.0



