Return-Path: <linux-kernel+bounces-53900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 039E784A7D6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4CD82934E3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCA2130AD4;
	Mon,  5 Feb 2024 20:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbwMetam"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C9012FF91;
	Mon,  5 Feb 2024 20:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707163989; cv=none; b=oS8IYh5MjtLxTH3SfMj0AkrZJwUP5Bzk0CySnBZy5QTmQmFUtmc/GlB8C4Dx+dOJ8/71ONgIWiUAryi0BTs8m6eAX1gzrYQfSB+IUoK5I79GyTiu2s5vn0QyeAbq6YP3exLyBLMRR/z6aKq328P7zD/tPAxg0h/Pcspvgo7oqvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707163989; c=relaxed/simple;
	bh=7ApW9U/PzSU6iKJ/LtKsXPuxdBO/3VMwuvwn+Gg1CK8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V62mTSmD/k9s62pGHj5GRIfBV1hhyV6uzQv6JHKLM8CTaOpOCNEvwuTYQIl1XYHEArDAY1wxZOw1fNG1j4LvZcNTJzRgBHMV6e7H8UAbe+Qo0WU/k5YPAXltTnrfXrnYeLKw9nnl3SG814VmJFeZlo7+86H0nI+cuDAsm3M55Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbwMetam; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3BAC43394;
	Mon,  5 Feb 2024 20:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707163988;
	bh=7ApW9U/PzSU6iKJ/LtKsXPuxdBO/3VMwuvwn+Gg1CK8=;
	h=From:To:Cc:Subject:Date:From;
	b=gbwMetamCLac9V45uSbSMx8UvaUkSokFP3rzkxc3h+C2pcjk1rBTcsAnTsA1duWne
	 uXRLbySle00rPGrT8heYd8Q9dcCiixdSCJDYnXrAeqem4ZFTLkgr496LjtdWhFPQtN
	 Te4+/E0se6NNT3w6eC+L+BgbU1ZmZcyTZKzjxpOtI9j2GgJubc57I+bPMCxS0l8MyR
	 bZ8weMmMZvdgbH/VzZuXFm98KE9c8Mb3s4Z4njyZ/gbqCKGdXmUG2ax5a0Rdl/3//H
	 7RWuUJF3AY8d1dohXRVEMEO13MQPixIfqg+XSAHxNNoRr/f/cYtb+fmMZAhn9bkXlh
	 jfeEOU8hmfh6g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] mm/damon/core: check apply interval in damon_do_apply_schemes()
Date: Mon,  5 Feb 2024 12:13:06 -0800
Message-Id: <20240205201306.88562-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kdamond_apply_schemes() checks apply intervals of schemes and avoid
further applying any schemes if no scheme passed its apply interval.
However, the following schemes applying function,
damon_do_apply_schemes() iterates all schemes without the apply interval
check.  As a result, the shortest apply interval is applied to all
schemes.  Fix the problem by checking the apply interval in
damon_do_apply_schemes().

Fixes: 42f994b71404 ("mm/damon/core: implement scheme-specific apply interval")
Cc: <stable@vger.kernel.org> # 6.7.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Sending the same patch[1] again because the subject of the patch was broken.

[1] https://lore.kernel.org/linux-mm/20240204204946.87265-1-sj@kernel.org/

 mm/damon/core.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0c144fb466b8..f444734cc613 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1064,6 +1064,9 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 	damon_for_each_scheme(s, c) {
 		struct damos_quota *quota = &s->quota;
 
+		if (c->passed_sample_intervals != s->next_apply_sis)
+			continue;
+
 		if (!s->wmarks.activated)
 			continue;
 
@@ -1216,10 +1219,6 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 		if (c->passed_sample_intervals != s->next_apply_sis)
 			continue;
 
-		s->next_apply_sis +=
-			(s->apply_interval_us ? s->apply_interval_us :
-			 c->attrs.aggr_interval) / sample_interval;
-
 		if (!s->wmarks.activated)
 			continue;
 
@@ -1235,6 +1234,14 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 		damon_for_each_region_safe(r, next_r, t)
 			damon_do_apply_schemes(c, t, r);
 	}
+
+	damon_for_each_scheme(s, c) {
+		if (c->passed_sample_intervals != s->next_apply_sis)
+			continue;
+		s->next_apply_sis +=
+			(s->apply_interval_us ? s->apply_interval_us :
+			 c->attrs.aggr_interval) / sample_interval;
+	}
 }
 
 /*
-- 
2.39.2


