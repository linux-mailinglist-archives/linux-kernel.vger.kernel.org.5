Return-Path: <linux-kernel+bounces-168379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3D18BB7C1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 438291C21DEF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5236584D1F;
	Fri,  3 May 2024 22:50:35 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D110280038;
	Fri,  3 May 2024 22:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714776634; cv=none; b=cdnCQ5d0ZEL5cgXr/yDcEXbAUaBSS7ZZSZW+H2sFaj6iAw0tppbRc6bIxOydX/kla5egz4zSeuZAQX2MvLJDy8Vg3lizQusR0WDUx8cg+EMv41u7kcNDIWV7u4405ka5S/yfbZ+U2v5EH8HCUOHhu4c5foO0pcBgv1PsXUI5Z/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714776634; c=relaxed/simple;
	bh=J3vNSDJFeIfDScHNg/+KPqU3RuxXUEMvLmcG3GsFWx4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=CQDfMuxwjaBu9YBY7krnKhu+ZJiToO9sE1t6bkCcI2fPEYdWLjoAVrCWHSsAz6lwWD9QXxgLgrmRHGXOANqEs6etxKcyocHqgpvFZjjb415u95PMpgTklxIu5YMLN9CvEnUsGIDPEJHGyQ7MeyFhmQqUQU25Wq69o4U5q4dgNOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB553C4AF1A;
	Fri,  3 May 2024 22:50:34 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s31je-00000000NLb-0vti;
	Fri, 03 May 2024 18:50:34 -0400
Message-ID: <20240503225034.079856045@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 03 May 2024 18:50:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 4/9] eventfs: Free all of the eventfs_inode after RCU
References: <20240503225013.519028385@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The freeing of eventfs_inode via a kfree_rcu() callback. But the content
of the eventfs_inode was being freed after the last kref. This is
dangerous, as changes are being made that can access the content of an
eventfs_inode from an RCU loop.

Instead of using kfree_rcu() use call_rcu() that calls a function to do
all the freeing of the eventfs_inode after a RCU grace period has expired.

Link: https://lore.kernel.org/linux-trace-kernel/20240502200905.370261163@goodmis.org

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: 43aa6f97c2d03 ("eventfs: Get rid of dentry pointers without refcounts")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index f5510e26f0f6..cc8b838bbe62 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -73,6 +73,21 @@ enum {
 
 #define EVENTFS_MODE_MASK	(EVENTFS_SAVE_MODE - 1)
 
+static void free_ei_rcu(struct rcu_head *rcu)
+{
+	struct eventfs_inode *ei = container_of(rcu, struct eventfs_inode, rcu);
+	struct eventfs_root_inode *rei;
+
+	kfree(ei->entry_attrs);
+	kfree_const(ei->name);
+	if (ei->is_events) {
+		rei = get_root_inode(ei);
+		kfree(rei);
+	} else {
+		kfree(ei);
+	}
+}
+
 /*
  * eventfs_inode reference count management.
  *
@@ -85,7 +100,6 @@ static void release_ei(struct kref *ref)
 {
 	struct eventfs_inode *ei = container_of(ref, struct eventfs_inode, kref);
 	const struct eventfs_entry *entry;
-	struct eventfs_root_inode *rei;
 
 	WARN_ON_ONCE(!ei->is_freed);
 
@@ -95,14 +109,7 @@ static void release_ei(struct kref *ref)
 			entry->release(entry->name, ei->data);
 	}
 
-	kfree(ei->entry_attrs);
-	kfree_const(ei->name);
-	if (ei->is_events) {
-		rei = get_root_inode(ei);
-		kfree_rcu(rei, ei.rcu);
-	} else {
-		kfree_rcu(ei, rcu);
-	}
+	call_rcu(&ei->rcu, free_ei_rcu);
 }
 
 static inline void put_ei(struct eventfs_inode *ei)
-- 
2.43.0



