Return-Path: <linux-kernel+bounces-155034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048F28AE498
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3439A1C22BC6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D6F13C831;
	Tue, 23 Apr 2024 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZMEPApp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AC213C800;
	Tue, 23 Apr 2024 11:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872444; cv=none; b=b7MzGlEXTAncBkBjS8GTGu52zEHWnB7ZbyHYF/Lnn2gAPWXPmTlEylv7Kr6WjtuPXl9/TE6zCkk0s2kI48e49Z+jGN6w2wFtHRdMOGRXPuiAWL6Aah3FZ7fVnT9MtFrcK+CQRJKi28hmQbqiUP1zsEvRz2V2yTcGCuUjIaegE/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872444; c=relaxed/simple;
	bh=RIOvnGLtUegYNuiprTXdRRUJHhoAskSNgkBzPmiP8NA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0JqS5KTSaddrThVhwckrxCkcajOeIKHexDpfC5cv+56LnX0xoFy/YPxO37B2Tv/eqh5DVsaHp6ZTLvE8JrfzKOQCg8AvDqFEu+hpymXXSSKDI9ZbGX4/joGl+Tj41Uk8L6nhdA38MmwfN1NRRNz2NWMp5HpCnaAZl7rWdAU9GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZMEPApp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAF8C116B1;
	Tue, 23 Apr 2024 11:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872444;
	bh=RIOvnGLtUegYNuiprTXdRRUJHhoAskSNgkBzPmiP8NA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fZMEPAppLDDbvf7mieCzU1twMjrqLRZH9gS7XQ49M500tPObDuSijOf4XP1QMowMI
	 UJ3OY1mVdup/0aRZWVwu0UL3cUiZ74x0omKV7VANy23eeGPfXUxrCkl7QQKgqHVXAD
	 I6YoGBjrC9Xz7qHQjsp4eRrUkaGwNulyF2gjims7MZiHYL6DBh/5pgYqG2fioUo4Uw
	 q03XhgEE3K61uj13olh/z15u9G7hKRElYrT+k5pV8O+w62JSLKsafacu6dBPQsP11X
	 A2ln3jOobjxKanUkLBfNtm1hVaSUdEwIitUEOvgxBSFjDkD3SWw8fM0HbZYHMhNudW
	 i3Hyvp/RB4YMA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Sasha Levin <sashal@kernel.org>,
	mturquette@baylibre.com,
	linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 08/16] clk: Don't hold prepare_lock when calling kref_put()
Date: Tue, 23 Apr 2024 07:01:41 -0400
Message-ID: <20240423110151.1658546-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110151.1658546-1-sashal@kernel.org>
References: <20240423110151.1658546-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.28
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
index 50228cb0c5590..8b4043d456a8e 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4410,7 +4410,8 @@ void clk_unregister(struct clk *clk)
 	if (ops == &clk_nodrv_ops) {
 		pr_err("%s: unregistered clock: %s\n", __func__,
 		       clk->core->name);
-		goto unlock;
+		clk_prepare_unlock();
+		return;
 	}
 	/*
 	 * Assign empty clock ops for consumers that might still hold
@@ -4444,11 +4445,10 @@ void clk_unregister(struct clk *clk)
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
 
@@ -4607,13 +4607,11 @@ void __clk_put(struct clk *clk)
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
2.43.0


