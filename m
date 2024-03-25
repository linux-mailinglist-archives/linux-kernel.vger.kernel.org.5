Return-Path: <linux-kernel+bounces-117738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B44BB88AEF2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDB6D1C3DF93
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFD280C0D;
	Mon, 25 Mar 2024 18:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXTm7SFx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDE0757E3;
	Mon, 25 Mar 2024 18:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711392127; cv=none; b=HQ6efbuJnrOQi+ELX4z66jsf2BAMv1P/h8K470G8qYZJEklCUrKV+RCNkV+XC7OjGS3x4VCua86NA5P0RmQxPJX9clRdgjruyvX4EtIsrA4uDoRzlECuYlRj/jd48IwrOr9mI+c4U+PuXtLZSLh0vXDp2PTYGXw156tuTv8x36k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711392127; c=relaxed/simple;
	bh=Oc5kvRHq0ucUhQzYgSZ1NBEHxsfc22nR4S713LRmA5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMGa/9NP3jMUg94kiQ1sFcLSr0LJPVCQhhATcHk1UYdBx/BIfh0EYFQjjRuiO4nGhl8beJ7BQtxTTgk84rxHJ1xbfv5G6TZEN7xMk+G8FDdL2w7HNmyeOuTfPbHlXoZ75IiAs+AeVwNT9h9Mn6sytcGziQNXSaWMGQVMeyuzqU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXTm7SFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DEAC433A6;
	Mon, 25 Mar 2024 18:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711392126;
	bh=Oc5kvRHq0ucUhQzYgSZ1NBEHxsfc22nR4S713LRmA5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cXTm7SFxCYGify3bM7fX8aO2vfYdDaF5JHeOV6tCOA1wOh+OHIsj8W0u2lrJz6/7C
	 M7FCyTcIdQMBFura6GHFNJ4J59wMLYDYA+381tUcy3azG1/4/KZpRObBmsoYKlbatr
	 Y0y+eE+T9idqWTqwWT1Wy1uFYzTBfYtcdZQviFVJUmad+Kga3BUTocAHL4XoiSsZ3K
	 w1WKDJ1MhluUB470BueWlPLE+kE1xHHQ9BYsMzRbSHU+z9Nd1pALCcTGi240ssTCRJ
	 1rFgASajzvAL4TtGmOA5l/E3D1/TURpKBRQUTy5VXT//Y3m70imlVWi3bQ1kRY3sfz
	 FPq2xt4nfKfdQ==
From: Stephen Boyd <sboyd@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	patches@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2 2/5] clk: Don't hold prepare_lock when calling kref_put()
Date: Mon, 25 Mar 2024 11:41:56 -0700
Message-ID: <20240325184204.745706-3-sboyd@kernel.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
In-Reply-To: <20240325184204.745706-1-sboyd@kernel.org>
References: <20240325184204.745706-1-sboyd@kernel.org>
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

Reviewed-by: Douglas Anderson <dianders@chromium.org>
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


