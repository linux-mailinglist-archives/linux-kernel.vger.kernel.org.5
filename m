Return-Path: <linux-kernel+bounces-51893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A628849078
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0347F282B71
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7F72562C;
	Sun,  4 Feb 2024 20:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrVlmveh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5EE286A6;
	Sun,  4 Feb 2024 20:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707079790; cv=none; b=Uezyccpl3FIjoHA/XM7jVytuIgvUi1VtYmHswzBV4yxGBLYQ4k0kk49OWy6gNi4bu7mZWwzVkr6fQ+1vCrsb/ad92Gk2mu1NgS68gNvYOCHsR82MXj6vEOa5BMQHJBmxKxF4OjcZH/0wPTv+PqgvQAAbHEiXb3OP1m/RbQbMsyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707079790; c=relaxed/simple;
	bh=ojWqsp/aBmsejpkcR12AdCvNFJNKEtttghVnPq6oxmo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PegV9SgRU1+7nEsMY98g+gW2tP2YYqfAAyamoIllnZbI+sLFe6bnzWxUwW1C5aowpNi/E0zcSgrWJrJGca+ld3Xt9bB7B1fsnAEwuqPiWsXTYrJstKL28pbDHL3THymNnZJo+C726fa/oNA4eBTPXAKnJ/WowaQJ4Zt3VEz/x9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrVlmveh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEA3C433F1;
	Sun,  4 Feb 2024 20:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707079789;
	bh=ojWqsp/aBmsejpkcR12AdCvNFJNKEtttghVnPq6oxmo=;
	h=From:To:Cc:Subject:Date:From;
	b=KrVlmvehk3qAqC+mImzdxev2eaBuCLiF9nGmJQWSJUbYP4cUxdbBXWqtTJ7yJWpgy
	 mdPXBGLldb83ha+ULf1yZBkhZW4ONAWapMVJ6P6uWEp2HryAOamInDXSWiESvcUCXs
	 gPnehXOU0ehnm+e0fYyZZUfUOjCX6wKN8Lq4sMsbHTDsvUlSEMCHvU7tWNdLAeSSLx
	 k0ZEMQR9yk/gau7hzbDCH+uuW8x6KHADGc/66gqc4yl9j6H7JoKShegAoDdgFz8mhO
	 2P3UMLO9l5xdWM1dhBRiIpRVyUWE2H3XpmmH5zJg0SCkNGRvRs5cr6tRT+7TXO1p5c
	 XdpsR48O2aXyw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon/core: check apply interval in
Date: Sun,  4 Feb 2024 12:49:46 -0800
Message-Id: <20240204204946.87265-1-sj@kernel.org>
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


