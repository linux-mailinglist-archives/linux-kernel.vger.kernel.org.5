Return-Path: <linux-kernel+bounces-71902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D6D85AC4C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D671C21987
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59705C5E4;
	Mon, 19 Feb 2024 19:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqdSM2r2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26015BAE1;
	Mon, 19 Feb 2024 19:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371891; cv=none; b=UVOjBbWalIEX+LFOUrO/ONFDudk4HA9B5HDFJVCcVyMyuNyqVM5+N4JSSFQPINXH8dnF9p8/cAxv5ZtFH7M3Lk9AWq82APAnQNcOOKlTQO1jT7mmXqag0dkTGtOQPMtsfCP4b4FCpH5YWYDuaBHLwXAfP2ARwiVzn72XBwloOB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371891; c=relaxed/simple;
	bh=N9nR7nwUdsukBui32rCfnM5+OryMCusxZ8X3or6m4gs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nZixfB0rYYq8AcyKehY0F1SuScN/nMe2x4oLn1gX6KImqKaH4QQqQcOTRF3TAOczurA2uh2DxPkPXBava3JEv+B5g8xWvikndPXIXsCvoBCvrbkb/VEegmMYvsiW5OTzI06WBxRGcw1OM0Mc86y0lqRRArYayXXhRlyP6BBrfow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqdSM2r2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D981C43394;
	Mon, 19 Feb 2024 19:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708371890;
	bh=N9nR7nwUdsukBui32rCfnM5+OryMCusxZ8X3or6m4gs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KqdSM2r2arnrE2pBIUDFF7hZiMjke6At78DYHjdLpERwp7GzGMMfZrZD/XkvVsvoL
	 iZ0gKt+cXZC2/Q6/wDxgAXwR2lScpDLfLDBK0fbWYh8QYEaBEUqQaD8GbSEYU19OnH
	 U++3UpC6Jpa+GOpKK5QyaegBWlVfHsoysde0a5MGIv1cNeG+RjS1KFiSJb8z408nxj
	 LTZLeZw/EPiwFOioMXDWha/73iN4Zoz2vCX2USa/2Djbqs9MMszoIsoedfNOl1FCfS
	 7RKT1NeXBEKPFeYON6dpCo1wCv301lTmRD+TNX3etwdGvFarVDTz+/bbCnHbR5kJo9
	 LiI+VOgnX3CPg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 20/20] Docs/admin-guide/mm/damon/reclaim: document auto-tuning parameters
Date: Mon, 19 Feb 2024 11:44:31 -0800
Message-Id: <20240219194431.159606-21-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240219194431.159606-1-sj@kernel.org>
References: <20240219194431.159606-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON_RECLAIM usage document for the user/self feedback based
auto-tuning of the quota.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 .../admin-guide/mm/damon/reclaim.rst          | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index 343e25b252f4..af05ae617018 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -117,6 +117,33 @@ milliseconds.
 
 1 second by default.
 
+quota_mem_pressure_us
+---------------------
+
+Desired level of memory pressure-stall time in microseconds.
+
+While keeping the caps that set by other quotas, DAMON_RECLAIM automatically
+increases and decreases the effective level of the quota aiming this level of
+memory pressure is incurred.  System-wide ``some`` memory PSI in microseconds
+per quota reset interval (``quota_reset_interval_ms``) is collected and
+compared to this value to see if the aim is satisfied.  Value zero means
+disabling this auto-tuning feature.
+
+Disabled by default.
+
+quota_autotune_feedback
+-----------------------
+
+User-specifiable feedback for auto-tuning of the effective quota.
+
+While keeping the caps that set by other quotas, DAMON_RECLAIM automatically
+increases and decreases the effective level of the quota aiming receiving this
+feedback of value ``10,000`` from the user.  DAMON_RECLAIM assumes the feedback
+value and the quota are positively proportional.  Value zero means disabling
+this auto-tuning feature.
+
+Disabled by default.
+
 wmarks_interval
 ---------------
 
-- 
2.39.2


