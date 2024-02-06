Return-Path: <linux-kernel+bounces-54903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B486884B503
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C1828221A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9B313DB85;
	Tue,  6 Feb 2024 12:09:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2716F1386A8;
	Tue,  6 Feb 2024 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221363; cv=none; b=EOtQi83F3qgbvKzZQal4n20UQbfWOkvxzcAkwMhPlkFpvl9oaQ3BSdmhSZGv1QpSyhQao7w5KVSyYx6nwxks7pRPDEZfSWSAo0fcwjff0D4DcHkRnWKt14E5LlADXnQHtY66Qd9/AybVVhcA7cwM6lid8XXG83SIG9+1m4Y6/gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221363; c=relaxed/simple;
	bh=bXsar5R8Z/J/4GcAeyNBhLTiQlp64pDEtOV6uUPgCcU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=iwDdkAlUQr+Eu5VlJxUOYeuy9Wb+7XFlpGkbIBoXCmiPQidqM8K1Hj770LTw2s0MU8O1qBrwalrbKWykQIUOfq7n9g7acVkQhTvZOCM8NA6bSyhsjIcuhf/VZ4hl21EqFfqdxro817piU3auD8oajToz3PzNBhdwU6Olytw1Yww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C479FC433C7;
	Tue,  6 Feb 2024 12:09:22 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXKGt-00000006bFq-0z3I;
	Tue, 06 Feb 2024 07:09:51 -0500
Message-ID: <20240206120951.095364893@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 07:09:34 -0500
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
Subject: [v6.6][PATCH 29/57] eventfs: Make sure that parent->d_inode is locked in creating
 files/dirs
References: <20240206120905.570408983@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Since the locking of the parent->d_inode has been moved outside the
creation of the files and directories (as it use to be locked via a
conditional), add a WARN_ON_ONCE() to the case that it's not locked.

Link: https://lkml.kernel.org/r/20231121231112.853962542@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
(cherry picked from commit f49f950c217bfb40f11662bab39cb388d41e4cfb)
---
 fs/tracefs/event_inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 590e8176449b..0b90869fd805 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -327,6 +327,8 @@ create_file_dentry(struct eventfs_inode *ei, int idx,
 	struct dentry **e_dentry = &ei->d_children[idx];
 	struct dentry *dentry;
 
+	WARN_ON_ONCE(!inode_is_locked(parent->d_inode));
+
 	mutex_lock(&eventfs_mutex);
 	if (ei->is_freed) {
 		mutex_unlock(&eventfs_mutex);
@@ -430,6 +432,8 @@ create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
 {
 	struct dentry *dentry = NULL;
 
+	WARN_ON_ONCE(!inode_is_locked(parent->d_inode));
+
 	mutex_lock(&eventfs_mutex);
 	if (pei->is_freed || ei->is_freed) {
 		mutex_unlock(&eventfs_mutex);
-- 
2.43.0



