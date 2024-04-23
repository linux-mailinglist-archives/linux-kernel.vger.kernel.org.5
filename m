Return-Path: <linux-kernel+bounces-155060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9858AE4DB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8F8CB24AED
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111701448E9;
	Tue, 23 Apr 2024 11:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ydu2Cdv2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505C014431C;
	Tue, 23 Apr 2024 11:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872483; cv=none; b=Cv9rXHgUm/argm+0eiqkpF+P6eqTp/agIOU8tmHeNqKd7JjIRH3DDtOl2SZ5MT9/z+0wl4xosKyEi2p4I7UieXkvz7pAxTKFXSgD/znsC2d6YLmsyKz7OlcUigAwFUhGSGYqUESzL08gIc5RwMLqJQHN8Mz5sO7Z3XHQpsA4ht4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872483; c=relaxed/simple;
	bh=xO1L8ozLXNkLGNcQZU7QghmdPKLrycyXyH72uitmLwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYcN85C55ZzmjxdYJQ3tAkR7xssf1/mCCT0blPYSnR5/f6+HkTH5QnrcPewkXTH4qW/D9FzFdASrI3XcJ0/qJfGTBEGEtMwGoXdOqZOm/ZjYh4i1boAeryQX+0F8GPNsjANHkAUGuAzJVoKbUEk+KBlqvajOql41YrbpjT6bBxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ydu2Cdv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64055C3277B;
	Tue, 23 Apr 2024 11:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872483;
	bh=xO1L8ozLXNkLGNcQZU7QghmdPKLrycyXyH72uitmLwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ydu2Cdv2Ww3g5/udzj4aBy2cCBmdmyQ2XB5BhiCOR3le+HzxwxhIm/HEZ5vMmt6lK
	 UCmyP+kSPHOntT1TLz0TUY4i4stPcAggYF/AzoANZBXAPKQOd7wyiOQM9j06oyAo++
	 APIQIlL9j8TB8IKGW2BfjPh+Re8ZLmqlQEbAhgaUBbqUBj/DTZVrNuE7Z8nRYix64P
	 30qG6wm+xe76L6/Kt9oygWEUc3NhVpKDPRzhIKq4jWYM0frvEfWlvB4N/qqSEI7yUv
	 EvTUuJV1F5ByskYftLIZFrKAiKaHnDks4YT+IlgW83dTYUVvtEi922ZANq9Ty29xvo
	 RaDKLXEIm+wYg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Sasha Levin <sashal@kernel.org>,
	mturquette@baylibre.com,
	linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 6/9] clk: Don't hold prepare_lock when calling kref_put()
Date: Tue, 23 Apr 2024 07:02:28 -0400
Message-ID: <20240423110233.1659071-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110233.1659071-1-sashal@kernel.org>
References: <20240423110233.1659071-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.156
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
index 84397af4fb336..7a3b992ca3e40 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4137,7 +4137,8 @@ void clk_unregister(struct clk *clk)
 	if (ops == &clk_nodrv_ops) {
 		pr_err("%s: unregistered clock: %s\n", __func__,
 		       clk->core->name);
-		goto unlock;
+		clk_prepare_unlock();
+		return;
 	}
 	/*
 	 * Assign empty clock ops for consumers that might still hold
@@ -4171,11 +4172,10 @@ void clk_unregister(struct clk *clk)
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
 
@@ -4381,13 +4381,11 @@ void __clk_put(struct clk *clk)
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


