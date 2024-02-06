Return-Path: <linux-kernel+bounces-54900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5323284B4FB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867DB1C23FD1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B574513C1D8;
	Tue,  6 Feb 2024 12:09:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63376137C50;
	Tue,  6 Feb 2024 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221362; cv=none; b=tVK6AdJ3G/zmj3OJL2IPFPsXOnFykIxBix/c9qbm6gaMiiq/MLr6H+pNaEcn548dnObYaq2SD+A/58ipWjAFOeaZKIa+kAwNwAyxkZJB/vWMBrCDzCLKKADsJQA2igWUBqFPQTLgMcwJlxBjd0S+w1Cm6sGOfSU8IHjcDGdGSEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221362; c=relaxed/simple;
	bh=hnDief3HS3NBM6ZKYIfuGnDzLR4JMdJjWA5KdzPNiEA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ZuGZOJ6BGESYHJOJEkRPGwZA/WW6WkeR+RyOkmGKx+udkrpJpKaLl9GEy+kq321qqrnRMbIabVRegGpT1lQrFgpg525PZHm79zHs9AymxEfMezITI5K7pHBLJl/EX6MRGukRJiD5oNr3mFLEhJ7D7a/jGFJ7+xj5ZOUICwdsODk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51081C43390;
	Tue,  6 Feb 2024 12:09:22 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXKGs-00000006bEL-39Zw;
	Tue, 06 Feb 2024 07:09:50 -0500
Message-ID: <20240206120950.611237633@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 07:09:31 -0500
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
 Josef Bacik <josef@toxicpanda.com>
Subject: [v6.6][PATCH 26/57] eventfs: Use GFP_NOFS for allocation when eventfs_mutex is held
References: <20240206120905.570408983@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

If memory reclaim happens, it can reclaim file system pages. The file
system pages from eventfs may take the eventfs_mutex on reclaim. This
means that allocation while holding the eventfs_mutex must not call into
filesystem reclaim. A lockdep splat uncovered this.

Link: https://lkml.kernel.org/r/20231121231112.373501894@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: 28e12c09f5aa0 ("eventfs: Save ownership and mode")
Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Reported-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
(cherry picked from commit 4763d635c907baed212664dc579dde1663bb2676)
---
 fs/tracefs/event_inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 3eb6c622a74d..56d192f0ead8 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -95,7 +95,7 @@ static int eventfs_set_attr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (!(dentry->d_inode->i_mode & S_IFDIR)) {
 		if (!ei->entry_attrs) {
 			ei->entry_attrs = kzalloc(sizeof(*ei->entry_attrs) * ei->nr_entries,
-						  GFP_KERNEL);
+						  GFP_NOFS);
 			if (!ei->entry_attrs) {
 				ret = -ENOMEM;
 				goto out;
@@ -627,7 +627,7 @@ static int add_dentries(struct dentry ***dentries, struct dentry *d, int cnt)
 {
 	struct dentry **tmp;
 
-	tmp = krealloc(*dentries, sizeof(d) * (cnt + 2), GFP_KERNEL);
+	tmp = krealloc(*dentries, sizeof(d) * (cnt + 2), GFP_NOFS);
 	if (!tmp)
 		return -1;
 	tmp[cnt] = d;
-- 
2.43.0



