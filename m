Return-Path: <linux-kernel+bounces-54797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8627484B3E7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9466B2230C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF10A13541F;
	Tue,  6 Feb 2024 11:33:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B65C1339A6;
	Tue,  6 Feb 2024 11:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707219211; cv=none; b=an8vO7GRstKip+ehyZT2mx3nrI9R2XUM2NP7KJA+PetsvXACkCn8HUeRjBnRDMzLFn0qdydQs1XGSGdH7ObW77WFHDsDVfNWyR+hdyVT294+cO/1k4ji9vgQ2nXF6WTv4x/8aSyDfqLNS8kE1RVqMCMLOtF+MmOCnd61xeBCE54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707219211; c=relaxed/simple;
	bh=S927KE9dYG/Lzm2Z83o0zTy+NJITK2h/kIEZaYEod3o=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=sCqYJT54z6FIHdc24IaW/wC9caSfmOuXrghXEbSjRwXecVCSz4S2zeT6j6VJ8Cb+lNLnU1Wt1KSZ6Kq5qpfPjXhqCfgHkW65Lquee75xAz9tQlVgZCBVOScCF3y0KedZu14hClkth3flYysQBIL5O89UD4oN+l/iT476YyVE+ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71994C3278F;
	Tue,  6 Feb 2024 11:33:31 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXJiB-00000006aLJ-3ZBf;
	Tue, 06 Feb 2024 06:33:59 -0500
Message-ID: <20240206113359.716264689@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 06:32:08 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Erick Archer <erick.archer@gmx.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [v6.7][PATCH v2 10/23] eventfs: Use kcalloc() instead of kzalloc()
References: <20240206113158.822006147@rostedt.homelinux.com>
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
(cherry picked from commit 1057066009c4325bb1d8430c9274894d0860e7c3)
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



