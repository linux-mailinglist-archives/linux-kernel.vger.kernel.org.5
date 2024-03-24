Return-Path: <linux-kernel+bounces-115344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D969F889AED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F14D1F34ADA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88C41E7DEC;
	Mon, 25 Mar 2024 02:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tv10uR4Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E091411FF;
	Sun, 24 Mar 2024 22:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320522; cv=none; b=oqpuoeaeRveH/hHc52QcIiLq0aGLSFNiHp9BNpaHFBHi3GFdimXnijhQ4LrAmRqGEXDJBdc41P+ht9qIn3TeqHrfp+GFpZhusJ6jMgySR5mNUVX7CgqZjjPL7XscW6lxFu+jgnwIwT6KEP2YEUnS9wkpMy1P9v1QvBB5gjPGHOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320522; c=relaxed/simple;
	bh=xyAsRpzrs64a3QghDN5vH5iXt7S6hDMvZ9FQNW5X8ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gM0OzO905yYtj6cIOM9QoQ818DOxXb45ka2msoi957UT3TwB7sOA/xC1rN0jrdsQk3GqHb6SuC83C4U4bAhS7+bJB/ZMN98u1os9LO6g7ah7CR7M5giXQ5cULTlfACr6bcMv3fg5ouZJd3WMVfxgc5YCSpFzxENeISgAbEu7vQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tv10uR4Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1B2C433C7;
	Sun, 24 Mar 2024 22:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320521;
	bh=xyAsRpzrs64a3QghDN5vH5iXt7S6hDMvZ9FQNW5X8ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tv10uR4YkVg9+FBEToZGo7BlfdQJ1FzfsVyiXNpSRw3jAhVh3KIzRZ6WmrZwqhZmN
	 5UzG5SWDgxLST8nt+8GNGH2cnnXcJMgDGXtjkiJMsTMr3RH1LhwJ9l2QAiylJXedie
	 9oWzReN5xc0VbOzhpKpCgk38tGdfM7QhDZ5WgCsyBkJvgG2F9NogTKR9Mb6kJxSNZC
	 GDCYRIFwOdKFVG4tdtUaG5bSCXK+LZbfhj5Bc3rqowMsCEQ+Wcd3ae07L1MG1vKEF6
	 ImvGOx9CMzxz2PG4+2Ru0XfVi9SlGB6F74l8/x6Mmi2RtUi5BLz8oo19XnnT3D4+3t
	 oCQzAV0LkLQjA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Audra Mitchell <audra@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 082/713] workqueue.c: Increase workqueue name length
Date: Sun, 24 Mar 2024 18:36:48 -0400
Message-ID: <20240324224720.1345309-83-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Audra Mitchell <audra@redhat.com>

[ Upstream commit 31c89007285d365aa36f71d8fb0701581c770a27 ]

Currently we limit the size of the workqueue name to 24 characters due to
commit ecf6881ff349 ("workqueue: make workqueue->name[] fixed len")
Increase the size to 32 characters and print a warning in the event
the requested name is larger than the limit of 32 characters.

Signed-off-by: Audra Mitchell <audra@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Stable-dep-of: 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for unbound workqueues")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/workqueue.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 4f87b1851c74a..1c72a616b9888 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -108,7 +108,7 @@ enum {
 	RESCUER_NICE_LEVEL	= MIN_NICE,
 	HIGHPRI_NICE_LEVEL	= MIN_NICE,
 
-	WQ_NAME_LEN		= 24,
+	WQ_NAME_LEN		= 32,
 };
 
 /*
@@ -4673,6 +4673,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	va_list args;
 	struct workqueue_struct *wq;
 	struct pool_workqueue *pwq;
+	int len;
 
 	/*
 	 * Unbound && max_active == 1 used to imply ordered, which is no longer
@@ -4699,9 +4700,12 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	}
 
 	va_start(args, max_active);
-	vsnprintf(wq->name, sizeof(wq->name), fmt, args);
+	len = vsnprintf(wq->name, sizeof(wq->name), fmt, args);
 	va_end(args);
 
+	if (len >= WQ_NAME_LEN)
+		pr_warn_once("workqueue: name exceeds WQ_NAME_LEN. Truncating to: %s\n", wq->name);
+
 	max_active = max_active ?: WQ_DFL_ACTIVE;
 	max_active = wq_clamp_max_active(max_active, flags, wq->name);
 
-- 
2.43.0


