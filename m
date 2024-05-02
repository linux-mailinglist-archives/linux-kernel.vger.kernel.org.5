Return-Path: <linux-kernel+bounces-166886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3B18BA15C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2E51F22989
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC0618133B;
	Thu,  2 May 2024 20:08:19 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE8615B988;
	Thu,  2 May 2024 20:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714680498; cv=none; b=n9cr/2Ddwy7HuUNg7H+wpqEbb1Jgfebq7yboIhuTLd8+Ek1VbGKc1nW3Jin3x3wzdDGZ+lfZN3joTKuAMUQJu2CKOCd7kYjj2PmPL18GsE244pv4ZeWEdI9D+9j2a26o7IO5A8h7eexReRqRPjCh90yGB+y/uNaw4nuViyUEeac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714680498; c=relaxed/simple;
	bh=MCakG2B6n4zjAvJKZ7YmI2VlY9h2ill9CPIR0VUB0P0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=oZsDkibiF9t55Wt5FizN1rY1Rcrg26o+99/kcw5CRiF9Z844SFok0Vs0xmCCvuo0H4oVQr520uY5syVz/dSlo9Veq5Ggo/DRtMSJkvk2NuQeoH/H5L4FJFl9mvF/4dpTBidpemDGMhQfUfBxMvyeAmeh3eI6PYtoLpe3YJNLNlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7881CC4AF1A;
	Thu,  2 May 2024 20:08:18 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s2cjp-00000003M3j-28cL;
	Thu, 02 May 2024 16:09:05 -0400
Message-ID: <20240502200905.370261163@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 02 May 2024 16:08:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [PATCH v3 1/6] eventfs: Free all of the eventfs_inode after RCU
References: <20240502200821.125580570@goodmis.org>
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

Cc: stable@vger.kernel.org
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



