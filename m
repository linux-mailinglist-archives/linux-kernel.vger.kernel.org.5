Return-Path: <linux-kernel+bounces-54891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C4484B4D6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8F61F25E69
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A03C1386B0;
	Tue,  6 Feb 2024 12:09:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12BF135A75;
	Tue,  6 Feb 2024 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221360; cv=none; b=V3THxo0kpA6mH3QqlK/T453S/jmW8iK6Tx5r4YhLfvia+D9oQMUHeHqIKnjgGk4D+T7mRTCHUpLseslc4jCMKMCmfkVdmiRGqVFVZ+7bJ9IxaVQuoEAPGChEsUrkl70BLysYCapwKAoaHV+6rId35bWqIzD6c8Jk3bfbIcm9ctQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221360; c=relaxed/simple;
	bh=RVnqUM31lsQW7+iA50+4o8PZzFkXqjlihPk1b0+w1h0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=dTAZQCGEonNCyJC9GUJTcL5Q4qP0BrjW6IPKM3Af2P7k6PGOPjgbFzuGPPweD915+OHs3yu8mEl9GSU/64+CF4I0RsIHmy5ad7hBXmldu3ft/3IjzwHpZwdXRtkQsCMbys3/AYmH1jPuEIiv8XDo9QSAGfTCP919xJnsr7M86RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC917C433B1;
	Tue,  6 Feb 2024 12:09:20 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXKGr-00000006b9L-0VCC;
	Tue, 06 Feb 2024 07:09:49 -0500
Message-ID: <20240206120948.980929088@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 07:09:21 -0500
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
 Ajay Kaher <akaher@vmware.com>
Subject: [v6.6][PATCH 16/57] eventfs: Remove "is_freed" union with rcu head
References: <20240206120905.570408983@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The eventfs_inode->is_freed was a union with the rcu_head with the
assumption that when it was on the srcu list the head would contain a
pointer which would make "is_freed" true. But that was a wrong assumption
as the rcu head is a single link list where the last element is NULL.

Instead, split the nr_entries integer so that "is_freed" is one bit and
the nr_entries is the next 31 bits. As there shouldn't be more than 10
(currently there's at most 5 to 7 depending on the config), this should
not be a problem.

Link: https://lkml.kernel.org/r/20231101172649.049758712@goodmis.org

Cc: stable@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ajay Kaher <akaher@vmware.com>
Fixes: 63940449555e7 ("eventfs: Implement eventfs lookup, read, open functions")
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
(cherry picked from commit f2f496370afcbc5227d7002da28c74b91fed12ff)
---
 fs/tracefs/event_inode.c | 2 ++
 fs/tracefs/internal.h    | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 9f612a8f009d..1ce73acf3df0 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -824,6 +824,8 @@ static void eventfs_remove_rec(struct eventfs_inode *ei, struct list_head *head,
 		eventfs_remove_rec(ei_child, head, level + 1);
 	}
 
+	ei->is_freed = 1;
+
 	list_del_rcu(&ei->list);
 	list_add_tail(&ei->del_list, head);
 }
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 64fde9490f52..c7d88aaa949f 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -23,6 +23,7 @@ struct tracefs_inode {
  * @d_parent:   pointer to the parent's dentry
  * @d_children: The array of dentries to represent the files when created
  * @data:	The private data to pass to the callbacks
+ * @is_freed:	Flag set if the eventfs is on its way to be freed
  * @nr_entries: The number of items in @entries
  */
 struct eventfs_inode {
@@ -38,14 +39,13 @@ struct eventfs_inode {
 	 * Union - used for deletion
 	 * @del_list:	list of eventfs_inode to delete
 	 * @rcu:	eventfs_inode to delete in RCU
-	 * @is_freed:	node is freed if one of the above is set
 	 */
 	union {
 		struct list_head	del_list;
 		struct rcu_head		rcu;
-		unsigned long		is_freed;
 	};
-	int				nr_entries;
+	unsigned int			is_freed:1;
+	unsigned int			nr_entries:31;
 };
 
 static inline struct tracefs_inode *get_tracefs(const struct inode *inode)
-- 
2.43.0



