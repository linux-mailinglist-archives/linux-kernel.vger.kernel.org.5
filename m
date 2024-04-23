Return-Path: <linux-kernel+bounces-155069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8176E8AE4F4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2B531C2153E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106E51482ED;
	Tue, 23 Apr 2024 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1xCf7CR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C55E147C75;
	Tue, 23 Apr 2024 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872499; cv=none; b=eUMUrqQNHH7OpkunM4vIa339a1r4XtKuyXbiBexm+1PsEjGHkUFnqacAnsRQvQVN5/vFIyLUGha4ujjPKfCVmyWu4p2CST8v9FLnzaaNSpfuOAcO/jJcPJWanqunp9HNT3248FfnbFy5JoYqd7jy4eWpj7V8HkfBooQ9grMhJTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872499; c=relaxed/simple;
	bh=It5ieeiGLQBbVO/VocXMayUZ4M94B8Ebxj9EVLkv/+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZZ6gBF5e1o7UaoccxnmhRoH6CY+8wtPvYHyFYGLjfeGwho/gZyElzpggaIaeBKqHSOFfKZhPrBbdP1F1Bkxni4OJSIFeb+qAj9RMZg+bOBvmD6xeH+U9Ob/5beVjsqZ8fv6COCfTj5RRebihM9iiVc6DL6oMtUgOia+wxu41jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1xCf7CR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF44C32782;
	Tue, 23 Apr 2024 11:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872499;
	bh=It5ieeiGLQBbVO/VocXMayUZ4M94B8Ebxj9EVLkv/+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A1xCf7CRI7iuIR96Ji+/Hx0dCxZzKDDkAz2AtM9aSz1ZAjBlNAQqajfqmrIjHM3ms
	 AsqNH4tV+URpN6q+hpl2Z4jux3zrxBoWSbGKBYmSZWrFCU+IuUMKOdcjJKBAitx2o2
	 OIfwlta8SZSDjwLDF2CodK5vmnfXnjlgjyjAd5f/+hl9yUBYlUaxeOnt1WGThPQLTf
	 NbYjxZCg2B9LOt9Vj3OwhhU1i+N8JHG/LcUYMG4DSPjlNfTUtpVD7WKuHxNjcEFzuE
	 Nr2g+2bsuAqgOb80DF7bSZrt5r7w9kcKbQZiGiPvzZLrgAbQbUDBg3oqggNhMKAKcE
	 FrjfAAgON81qg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Sasha Levin <sashal@kernel.org>,
	mturquette@baylibre.com,
	linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 6/9] clk: Don't hold prepare_lock when calling kref_put()
Date: Tue, 23 Apr 2024 07:02:44 -0400
Message-ID: <20240423110249.1659263-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110249.1659263-1-sashal@kernel.org>
References: <20240423110249.1659263-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.215
Content-Transfer-Encoding: 8bit

From: Stephen Boyd <sboyd@kernel.org>

[ Upstream commit 6f63af7511e7058f3fa4ad5b8102210741c9f947 ]

We don't need to hold the prepare_lock when dropping a ref on a struct
clk_core. The release function is only freeing memory and any code with
a pointer reference has already unlinked anything pointing to the
clk_core. This reduces the holding area of the prepare_lock a bit.

Note that we also don't call free_clk() with the prepare_lock held.
There isn't any reason to do that.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Link: https://lore.kernel.org/r/20240325184204.745706-3-sboyd@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index aa2f1f8aa2994..c64beabca7cde 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4096,7 +4096,8 @@ void clk_unregister(struct clk *clk)
 	if (ops == &clk_nodrv_ops) {
 		pr_err("%s: unregistered clock: %s\n", __func__,
 		       clk->core->name);
-		goto unlock;
+		clk_prepare_unlock();
+		return;
 	}
 	/*
 	 * Assign empty clock ops for consumers that might still hold
@@ -4130,11 +4131,10 @@ void clk_unregister(struct clk *clk)
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
 
@@ -4297,13 +4297,11 @@ void __clk_put(struct clk *clk)
 	    clk->max_rate < clk->core->req_rate)
 		clk_core_set_rate_nolock(clk->core, clk->core->req_rate);
 
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
2.43.0


