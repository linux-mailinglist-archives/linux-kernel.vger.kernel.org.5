Return-Path: <linux-kernel+bounces-155016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FADB8AE467
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304841F2298E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9741304A6;
	Tue, 23 Apr 2024 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyDxlkUX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347E912F374;
	Tue, 23 Apr 2024 11:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872414; cv=none; b=IozpgWj/8K5nimfpr1ZI+naLUwxXD7JLybxFaAa/wMCODQPj0UGSHE0GBSgJ9P+HznmR1rnY/hET9AgEmlfBN4I9YcJUZfD7IMpl86raqZcc4tgSxe0UxEVAcuC5+57H+lcttRNopzLtkpKhIDCEdvmbMTnciOMtY7dSt+Wo9Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872414; c=relaxed/simple;
	bh=oL1JNah1Kmu5gW2l169tM144+RGae3wb0JqRXo6K5U4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wrzf49vkK/vQQKBWYarRk42nHLGkot4eaqS8rOjv+xyB1Xa8qnT5Qc9JX2qU48rvPGybSOyqRIJA4XRZfkgUgnmjKMZEfeSDvUNxUvMXI4ABbMpvXHD9ggxse+W4cMZdpGXxDHV0IIV6ieSpAAFc+MQ9slVFUG05rPCmaA7GVT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyDxlkUX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05811C2BD11;
	Tue, 23 Apr 2024 11:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872413;
	bh=oL1JNah1Kmu5gW2l169tM144+RGae3wb0JqRXo6K5U4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fyDxlkUXn8+mh8WgOo94gjXIejnYZqt8jBfKSJ29ecywyWnDAD6k0UpcOQ913YRWj
	 /YBZFlfbPBSHTgW4oYLi3fEeKrGepEmdUBtkmk8S6VTVbewo+X/eRhYIRrgbw6Z2Sz
	 VH2nUHGIwP4jZETeKW6K7OeLEAJXSyV7In0YZg2noS0Wv2wKxDl6MV9kfq6AxTUt13
	 +cOcNCRWKBcPMBtC5UscueuAGetUetgneejKW8zBH5Q2/ZDXIWn2lInputHCHCuwjI
	 fOZed1uI/nvZGrdla+ek6hCQhcbPy3rG82UGBewDuhzgfYoJQ7xAhi3l8J7DqwDYiL
	 GMfA1Bbv4Q2Mw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Sasha Levin <sashal@kernel.org>,
	mturquette@baylibre.com,
	linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 08/18] clk: Don't hold prepare_lock when calling kref_put()
Date: Tue, 23 Apr 2024 07:01:04 -0400
Message-ID: <20240423110118.1652940-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110118.1652940-1-sashal@kernel.org>
References: <20240423110118.1652940-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
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
index 20c4b28fed061..badb6fdf83a2a 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4453,7 +4453,8 @@ void clk_unregister(struct clk *clk)
 	if (ops == &clk_nodrv_ops) {
 		pr_err("%s: unregistered clock: %s\n", __func__,
 		       clk->core->name);
-		goto unlock;
+		clk_prepare_unlock();
+		return;
 	}
 	/*
 	 * Assign empty clock ops for consumers that might still hold
@@ -4487,11 +4488,10 @@ void clk_unregister(struct clk *clk)
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
 
@@ -4650,13 +4650,11 @@ void __clk_put(struct clk *clk)
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


