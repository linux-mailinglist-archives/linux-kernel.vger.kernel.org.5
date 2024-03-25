Return-Path: <linux-kernel+bounces-116545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B25888A08E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C3A31C37055
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5471C1474C6;
	Mon, 25 Mar 2024 07:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTThkeOH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF94E1411F8;
	Mon, 25 Mar 2024 05:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711345445; cv=none; b=R6AXgi9qi2ywj+3fCz1G5XrC8KvGVNxsVtrEF7qlrN/ymEdk1DT2iILVhhTmu5eMbks4RkOXvImtlhThQKlUsbG7ssVmYb2yG6w1B/diCZis2JRNQi6HYEYRvbttXTlHYW8rPtovEDDLSC0wjafNbA04KPqR6ioNrxHF2+5owlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711345445; c=relaxed/simple;
	bh=HBI+Gf+zyj89/JIgSSOwlpZAPa/EE8Nn6UlvurY0Z5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M//o8P5fO1vrwMTpRpwcJQsSAHql1C0uHk3b8wMo2a+J2rQA4aOdMU8gpgzGfhTh3ja+N8ctd0T/5110dUBQ8bZQn9ZN1VOn0O9FlsHK+fTwld9rO4mGRL8dBZTjPp8XemFKXIdueD5fCN6Pg1Hf4z5XEe/0rYkHeuBM96+G2Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTThkeOH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26616C433F1;
	Mon, 25 Mar 2024 05:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711345445;
	bh=HBI+Gf+zyj89/JIgSSOwlpZAPa/EE8Nn6UlvurY0Z5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XTThkeOHfPQCOIB0JsWYniYn3zGCVag7AQoAX+3ReCt0+zf3H1hWM3mkDqdU22UYw
	 RDrHRdw4v7vTCFeGUj5sXSyy43ycTtEa3W7MwZ1dgqxDdiBau8j2tcilzUql7YdC2v
	 opvLa4RCA6uQZbUSIJogCKO1IoH+Py6Xx+1Gi7irAtakozBSVeXKkXaRhn6YRCsp3x
	 C/U3GNG7JdrwEH9oLj3BrjJZlHDin1KK56wPM0+KmoCFgbFaSxgU+ONfZJ2QDhMp3c
	 0+J+iAtodLB8fbVb8I8rDH5jnq5NjySJNhNc1Vp7sEpdp12LfvRy3u4b+FDm93WFQt
	 95SMZEDjyYPDg==
From: Stephen Boyd <sboyd@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	patches@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 1/5] clk: Remove prepare_lock hold assertion in __clk_release()
Date: Sun, 24 Mar 2024 22:43:58 -0700
Message-ID: <20240325054403.592298-2-sboyd@kernel.org>
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
Cc: Douglas Anderson <dianders@chromium.org>
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


