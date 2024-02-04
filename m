Return-Path: <linux-kernel+bounces-51345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B42EB848A0C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 02:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7162E285A62
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 01:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F21111706;
	Sun,  4 Feb 2024 01:18:08 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD226FB5;
	Sun,  4 Feb 2024 01:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707009486; cv=none; b=FMCWZgOz79ZTiH5/hmTapw4Dcyup0xI6XNNxiPlCqq355Dt2c3OkZh+JcAq+KFs1LnyQEKIfwBNcU+/wbRd34yde2bxkriGF4Tk8N2ar7mQPIyTuxf16FfeG8aM4AXZ4T7PLMdx05jV96trUhqV/qvURjeGuzPxGCdnS7yvJ8iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707009486; c=relaxed/simple;
	bh=GD76TU70lFmz5imut84Og/YwBOUVo8vHQeAC83rp8IM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=WBOoVIfQwaDjVCpet7mz0fKNmYG9ZLleHveUw6zTnrH6Vv8QTNwrWud97dFtPdGgf8oHkRFenaM1s48zSJV4r7Xl1JZ+v+GRGY/Ue1ptwELBD6ny+dqeD6a82cYRzsl/1kNl6kDAVL78oQphoukvBxoy3bHaHrdSZiaEfAWimmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F68C433B1;
	Sun,  4 Feb 2024 01:18:06 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rWR9Q-00000006OpL-2kK1;
	Sat, 03 Feb 2024 20:18:28 -0500
Message-ID: <20240204011828.512011833@goodmis.org>
User-Agent: quilt/0.67
Date: Sat, 03 Feb 2024 20:16:25 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Erick Archer <erick.archer@gmx.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [v6.7][PATCH 10/23] eventfs: Use kcalloc() instead of kzalloc()
References: <20240204011615.703023949@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Erick Archer <erick.archer@gmx.com>

As noted in the "Deprecated Interfaces, Language Features, Attributes,
and Conventions" documentation [1], size calculations (especially
multiplication) should not be performed in memory allocator (or similar)
function arguments due to the risk of them overflowing. This could lead
to values wrapping around and a smaller allocation being made than the
caller was expecting. Using those allocations could lead to linear
overflows of heap memory and other misbehaviors.

So, use the purpose specific kcalloc() function instead of the argument
size * count in the kzalloc() function.

[1] https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments

Link: https://lore.kernel.org/linux-trace-kernel/20240115181658.4562-1-erick.archer@gmx.com

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Link: https://github.com/KSPP/linux/issues/162
Signed-off-by: Erick Archer <erick.archer@gmx.com>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 10580d6b5012..6795fda2af19 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -97,7 +97,7 @@ static int eventfs_set_attr(struct mnt_idmap *idmap, struct dentry *dentry,
 	/* Preallocate the children mode array if necessary */
 	if (!(dentry->d_inode->i_mode & S_IFDIR)) {
 		if (!ei->entry_attrs) {
-			ei->entry_attrs = kzalloc(sizeof(*ei->entry_attrs) * ei->nr_entries,
+			ei->entry_attrs = kcalloc(ei->nr_entries, sizeof(*ei->entry_attrs),
 						  GFP_NOFS);
 			if (!ei->entry_attrs) {
 				ret = -ENOMEM;
@@ -874,7 +874,7 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 	}
 
 	if (size) {
-		ei->d_children = kzalloc(sizeof(*ei->d_children) * size, GFP_KERNEL);
+		ei->d_children = kcalloc(size, sizeof(*ei->d_children), GFP_KERNEL);
 		if (!ei->d_children) {
 			kfree_const(ei->name);
 			kfree(ei);
@@ -941,7 +941,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 		goto fail;
 
 	if (size) {
-		ei->d_children = kzalloc(sizeof(*ei->d_children) * size, GFP_KERNEL);
+		ei->d_children = kcalloc(size, sizeof(*ei->d_children), GFP_KERNEL);
 		if (!ei->d_children)
 			goto fail;
 	}
-- 
2.43.0



