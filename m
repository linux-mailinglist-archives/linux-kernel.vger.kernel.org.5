Return-Path: <linux-kernel+bounces-2046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CCE81574A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8FEE1F25B57
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C6D12E45;
	Sat, 16 Dec 2023 04:21:52 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CB51119E
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 04:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E80C433C7;
	Sat, 16 Dec 2023 04:21:51 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rEMCI-00000002yBl-336s;
	Fri, 15 Dec 2023 23:22:42 -0500
Message-ID: <20231216042242.519691764@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 15 Dec 2023 23:22:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-linus][PATCH 03/15] eventfs: Fix events beyond NAME_MAX blocking tasks
References: <20231216042214.905262999@goodmis.org>
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
2.42.0



