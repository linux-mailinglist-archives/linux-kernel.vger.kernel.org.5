Return-Path: <linux-kernel+bounces-155050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7F78AE4C0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7B51C20866
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4728B86254;
	Tue, 23 Apr 2024 11:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivwGHm8P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846961420BE;
	Tue, 23 Apr 2024 11:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872467; cv=none; b=BfTcMIDxCaEwc/YhtgpGNLZ3v9VcYM1G9R4GRFLzp79F1cr6sF10825HyRjX9QHFlKtmsMBxNEjrVMQMWJGc8blT651JgSZy3IupvP1qV8W/iRHY5h4Vz5kFvf/xutOdCLM3zxvDXL4aXW3NnstvT9mhZv51O2PNyKm/0L/c5D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872467; c=relaxed/simple;
	bh=T2Hcbh6C0t8gF8hreL4UJVEp/7ZX0lsv/Qoru1pHcSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hf1xQ2piy7ev+oMUNg7nl440RRrsmIfOxJUyT5W95fBsN5qECJQIY4GRJlf/voqKuGLhf1WNIUUdtAWxqbFO/ZDwQQ94XaMb0o0t49MVmjG88oCfJJIGiMIcncJOuigkED4CCwqD5ddl8SYAaQjovd7YUbh42GwS5ibw/BTbEbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivwGHm8P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A36FC116B1;
	Tue, 23 Apr 2024 11:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872467;
	bh=T2Hcbh6C0t8gF8hreL4UJVEp/7ZX0lsv/Qoru1pHcSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ivwGHm8PVVN5FNyOBaFQkrBtWf1AzCIbbLSAeoIH1biv20XAzLohbR1zWTKd5Neaf
	 UFX9pJDSTx/FpWwIOnUa7+8M/CNVXGEAYRj4ATMebd5UeVb+pHtNjhhC30oM9q5nVF
	 3dxuv0JzJVlqTe8A38ek6tPljn4D+VnCaww5qy5JBE1OueY/ESFsjzIrktd6okrOFI
	 TFWfUf8Tm/8rlfj/ipuCkX6QT8WI2z0/CQkiVLvtHg5JCdYOqXJyPVUNzQ4pSwOHIp
	 /1Df++gytplEIDwxOWvvWH/+5UMFFS6jxxm+1a2CjBUkDoQxSsUYTAKEqJ2M3yXh3+
	 rb2zL42083ZYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Sasha Levin <sashal@kernel.org>,
	mturquette@baylibre.com,
	linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 6/9] clk: Don't hold prepare_lock when calling kref_put()
Date: Tue, 23 Apr 2024 07:02:12 -0400
Message-ID: <20240423110217.1658879-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110217.1658879-1-sashal@kernel.org>
References: <20240423110217.1658879-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.87
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
index 9004e07182259..92c7537f52eeb 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4320,7 +4320,8 @@ void clk_unregister(struct clk *clk)
 	if (ops == &clk_nodrv_ops) {
 		pr_err("%s: unregistered clock: %s\n", __func__,
 		       clk->core->name);
-		goto unlock;
+		clk_prepare_unlock();
+		return;
 	}
 	/*
 	 * Assign empty clock ops for consumers that might still hold
@@ -4354,11 +4355,10 @@ void clk_unregister(struct clk *clk)
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
 
@@ -4517,13 +4517,11 @@ void __clk_put(struct clk *clk)
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


