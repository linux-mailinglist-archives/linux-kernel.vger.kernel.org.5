Return-Path: <linux-kernel+bounces-155078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7718AE50D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815AD1C22C9D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05241149DE7;
	Tue, 23 Apr 2024 11:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgbbcvYk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C569149C75;
	Tue, 23 Apr 2024 11:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872515; cv=none; b=GTKwE4YCJespbsLWngJb1j17eHRUxxj/QcKwaLh2pwIUjr0YyU7lxIyPm2rH7R7RWmd1AsJ6ROKd9Dv8FE9EcbATYusV8IOKlbtG9C9h+1dNo7oOs7NN7ITQm3IonAGMwvX6ENK2ynmzmPYUoTQkdX3BX1cYF7IUBHSd8RDCtBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872515; c=relaxed/simple;
	bh=hqt5mulurkipjNnc6TnmGfkZvKfoM15X91s6Krwm1Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ld0haAHH1StFyAE0Ju+HaATk68GBKnkaxgqpngxLOE+SDi/KI5cWWM8Dh0zuB2DzWQU5Yeh+AkGeXHIwgSRfmQaPitPXafsirsk5p19H03iVBaLTsSqazobncKdjU8KieGzSriBdkVUjsH5QDy59JL//xMqbq+6BzKNbzaDgPaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgbbcvYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4197C32783;
	Tue, 23 Apr 2024 11:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872514;
	bh=hqt5mulurkipjNnc6TnmGfkZvKfoM15X91s6Krwm1Vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IgbbcvYkDFXqSN/T9WdbuVy5k9Vfn9f/kEz3VS3jNZLb5KVQPSCYHwTWnFmlu+Jli
	 mybeTpgZStq4Z9xGSitW9Dv68cq7skYs3e/TiF2P9YZYNYqk+8Rr6YRCviQHrvUw1W
	 vgJaliM10GXjWAvTl6mBAGPC4rzN9ZYxoEJkp81eOE2pRYg0/JGhisX0pMFnmIML6g
	 eoXo9zaNGDrUR6jTpNgCBgFiRAz5E6HyOiTKHTzHVAjsN4ZHR9uDIEyaIiFPg1vBXF
	 iDEdvnJRk67YCsy7nJK0vzTMav5BJ5SMsUtQFk94yZxfGD4tnXdmRP62Krm+mnqFca
	 ENxgZESpnh0Ew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Sasha Levin <sashal@kernel.org>,
	mturquette@baylibre.com,
	linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 6/8] clk: Don't hold prepare_lock when calling kref_put()
Date: Tue, 23 Apr 2024 07:03:01 -0400
Message-ID: <20240423110304.1659456-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110304.1659456-1-sashal@kernel.org>
References: <20240423110304.1659456-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.274
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
index 67051ca60920a..9dddf5f555ab5 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3971,7 +3971,8 @@ void clk_unregister(struct clk *clk)
 	if (clk->core->ops == &clk_nodrv_ops) {
 		pr_err("%s: unregistered clock: %s\n", __func__,
 		       clk->core->name);
-		goto unlock;
+		clk_prepare_unlock();
+		return;
 	}
 	/*
 	 * Assign empty clock ops for consumers that might still hold
@@ -4002,11 +4003,10 @@ void clk_unregister(struct clk *clk)
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
 
@@ -4168,13 +4168,11 @@ void __clk_put(struct clk *clk)
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


