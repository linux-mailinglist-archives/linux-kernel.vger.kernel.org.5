Return-Path: <linux-kernel+bounces-116547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D180488A098
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 871F61F3A3E5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824FD14AD04;
	Mon, 25 Mar 2024 07:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j//bXvid"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E351411FA;
	Mon, 25 Mar 2024 05:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711345446; cv=none; b=kNZPyIFE8ztzNxxgx1f2U/1yxfOh/F4U2pRPxORbYcUSSqBS5OYqrQ4Ueq8YpVtManMYhAli3N0QL7qXPwOqz8TlTPSAKZ3XOohb6+DIzCBqJUCzVSkesxvJcczcr6icCI1epRAWC3CIMTqG9BjBn1zeWIzvBFFJ5tHzNATfoRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711345446; c=relaxed/simple;
	bh=Ebgj0Nt45MSQylBAQb/ipK17BeMfXqqF17IfQS77LBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SU1HkUo5vLTnltpwg4YKq/p25hnE58F9syhj9GvUw11Y8gAwi6GbxnCKgjvmeFhS/45YOT+aFgKWWjHN/beZF3uG9kj1ZLdjVFxkC3/8QZOsRvlL3MQrdIe324EB35MwzJWHcgaEiRmLRwRMT//bXqrXHHeANz6DO2SyG5qUaEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j//bXvid; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A768CC43390;
	Mon, 25 Mar 2024 05:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711345446;
	bh=Ebgj0Nt45MSQylBAQb/ipK17BeMfXqqF17IfQS77LBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j//bXvidAIkdDazt0r7y2ZHZ02McaI9rpv2Su0kkHR3ZNbEd8FeCIhG+oqYl/Id27
	 VOsY9J3JBSk4Vx2dGG393gXdwz/735FaVlXczWX9+G50YICY377hJbjIBKkBNRj+SO
	 92Tq0HOf4DOWV4PHMZVyf+NKnAaPs/aSgB7cEGUIA5+TBcgk+iZNkaIJnyuZLvFgg/
	 v7shSq1RQAU8W4M+nH03LUIi0s2xp3jpZykAEsi5u1vYcALx7m97GChU72fWjhURX4
	 GSa4G7C+C7wR+dXlVZN5RLC9ZNBLLR2YjPt/E0mqVO5ehSRiFBq6R7pOuEvS/jHNRX
	 QkOOZJRjT3v0g==
From: Stephen Boyd <sboyd@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	patches@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 2/5] clk: Don't hold prepare_lock when calling kref_put()
Date: Sun, 24 Mar 2024 22:43:59 -0700
Message-ID: <20240325054403.592298-3-sboyd@kernel.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
In-Reply-To: <20240325054403.592298-1-sboyd@kernel.org>
References: <20240325054403.592298-1-sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't need to hold the prepare_lock when dropping a ref on a struct
clk_core. The release function is only freeing memory and any code with
a pointer reference has already unlinked anything pointing to the
clk_core. This reduces the holding area of the prepare_lock a bit.

Note that we also don't call free_clk() with the prepare_lock held.
There isn't any reason to do that.

Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 44e71736477d..9fc522c26de8 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4448,7 +4448,8 @@ void clk_unregister(struct clk *clk)
 	if (ops == &clk_nodrv_ops) {
 		pr_err("%s: unregistered clock: %s\n", __func__,
 		       clk->core->name);
-		goto unlock;
+		clk_prepare_unlock();
+		return;
 	}
 	/*
 	 * Assign empty clock ops for consumers that might still hold
@@ -4482,11 +4483,10 @@ void clk_unregister(struct clk *clk)
 	if (clk->core->protect_count)
 		pr_warn("%s: unregistering protected clock: %s\n",
 					__func__, clk->core->name);
+	clk_prepare_unlock();
 
 	kref_put(&clk->core->ref, __clk_release);
 	free_clk(clk);
-unlock:
-	clk_prepare_unlock();
 }
 EXPORT_SYMBOL_GPL(clk_unregister);
 
@@ -4645,13 +4645,11 @@ void __clk_put(struct clk *clk)
 	if (clk->min_rate > 0 || clk->max_rate < ULONG_MAX)
 		clk_set_rate_range_nolock(clk, 0, ULONG_MAX);
 
-	owner = clk->core->owner;
-	kref_put(&clk->core->ref, __clk_release);
-
 	clk_prepare_unlock();
 
+	owner = clk->core->owner;
+	kref_put(&clk->core->ref, __clk_release);
 	module_put(owner);
-
 	free_clk(clk);
 }
 
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


