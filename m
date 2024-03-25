Return-Path: <linux-kernel+bounces-117737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E0488AEF1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A484288665
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975497F48F;
	Mon, 25 Mar 2024 18:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMKbmKeT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB740745EF;
	Mon, 25 Mar 2024 18:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711392126; cv=none; b=uCYS6ud/2j0BbuABSp/aTfyEwxwZQ4rzdRpzdfX3MGglgkFnEHsMIEIjmcYdtqnqLu9de2dUOuIlapnlj4waOD1mSFGttHTI1nYB+7GCihs9bsAyXLL3ubg/uHPs9cs6iKxvrpNJWI1l9Dw21wblaqxGZpMSToGrMO5HEUAQUVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711392126; c=relaxed/simple;
	bh=vvJhydcOE1G8hnd/r4ClIZBuHsvIC5MR5ecFq88JZsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSjjHWWIMJTa+TqpG2vCw58VSHqR/zkhAvnM3USugA5FeG6hSwWet1a4sDrEHY8QJHg+r/s44z3cEanBwZQZOpkCK04DVDZfxaP0OFZWcO7UD3XeXfQp9cFhFRnin3Dm1sj8EFMe2xG/XUeO+Bk3nuQYuj7UI1Q6ClWLDwRDuHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMKbmKeT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08286C43399;
	Mon, 25 Mar 2024 18:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711392126;
	bh=vvJhydcOE1G8hnd/r4ClIZBuHsvIC5MR5ecFq88JZsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BMKbmKeTrw6tUatdTiMh4ux16rYfZVn39fgDHJb2ulJmItqk8Fu6FiALOyvbkI9/F
	 dSP1uxEA5ZBdw/Em49+9BwGevOROzO/SJG20Pe+Km+cxZWITTMGHI5yf0NwcSW5zSc
	 wr9k0y2zYEhqaszk7if1mDRYTk7CKWS+fr4A8NlYLPyNFRFN+nb/ALWb6ByZfq6bPc
	 oN2oG/J6PhCpmAnOorphY9rKTvnLb/+BmaRyOSk1zEl2ulMv5NMUaE7erQUoTeDQiU
	 avdkEKgI436+pdNQ9LX4CkplcSN6n5KiS4ij++k+zGqL/PN3pVg4lAWbh1aqmnr3XH
	 VIB/WPAYZrkIA==
From: Stephen Boyd <sboyd@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	patches@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2 1/5] clk: Remove prepare_lock hold assertion in __clk_release()
Date: Mon, 25 Mar 2024 11:41:55 -0700
Message-ID: <20240325184204.745706-2-sboyd@kernel.org>
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

Removing this assertion lets us move the kref_put() call outside the
prepare_lock section. We don't need to hold the prepare_lock here to
free memory and destroy the clk_core structure. We've already unlinked
the clk from the clk tree and by the time the release function runs
nothing holds a reference to the clk_core anymore so anything with the
pointer can't access the memory that's being freed anyway. Way back in
commit 496eadf821c2 ("clk: Use lockdep asserts to find missing hold of
prepare_lock") we didn't need to have this assertion either.

Fixes: 496eadf821c2 ("clk: Use lockdep asserts to find missing hold of prepare_lock")
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 2253c154a824..44e71736477d 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4353,8 +4353,6 @@ static void __clk_release(struct kref *ref)
 {
 	struct clk_core *core = container_of(ref, struct clk_core, ref);
 
-	lockdep_assert_held(&prepare_lock);
-
 	clk_core_free_parent_map(core);
 	kfree_const(core->name);
 	kfree(core);
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


