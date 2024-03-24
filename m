Return-Path: <linux-kernel+bounces-116313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D920D889E2A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2333F28EF1B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDE93D233E;
	Mon, 25 Mar 2024 03:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEnR/ZPe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24AE292283;
	Sun, 24 Mar 2024 23:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324244; cv=none; b=JYvXeTElU5a2H/Em41JwZzYVuRi2zBP2zppdsY6OurVGGfb8ItOZd1MplVZb+FFzRDJIPGptu0OQTXJNvnT/+2rLvLtnE36w74ivNaxNY1oWZb4+LidkA9czD/iNM18AZz/DMCttPguGV1LgDhGLIyovndu9hBvYcnsR7eCVctw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324244; c=relaxed/simple;
	bh=YBZ/Z3qxETClGZ9YmPiZZ8L2J5W54q8SBZw6ZTNOx0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2uDOTYZm0RwKvnyGnS9+2MObVAEx+q7LrLr6hbtxML/NdJVQ8gEi1lVK+vTkE3taRrVorOVQt4/qipExxdFBojj7Yrgc5fRAl1UMJu2Ls0BjBPzyngdhJ0+c5hmRVn13RO3Plc9bPrvV0oa1uOr6Shx3d14cz2GGv4yQEklfA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEnR/ZPe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3B7C43399;
	Sun, 24 Mar 2024 23:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324242;
	bh=YBZ/Z3qxETClGZ9YmPiZZ8L2J5W54q8SBZw6ZTNOx0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mEnR/ZPeKjwGmg6ld7U1XlTn1PkyUIqPCkuEkMwIMuXLHqQXRUqBa5JCq4yUm1Vs9
	 47Liz5L4WK9Ipo3S5vwfdwmJ2DHayn5QqAZPr7NKwNd8MEBTqErQo5UCgsRd3laiQk
	 NNbfQbNTVW0D5U+1sjewHBnwbiIaYCaV+moK+lpESQ5m/0DyWnDPtQPfpJzWRFTPc+
	 ga8ANuO/yY/Za9+4xoAbiTU+AzNjxqUYpG0bzMiE18g0IwyDBVLw4ln1d59u9awhVo
	 rjtuCbks1k+4xoRuqxBgyofaxsNVxLrSzbpnzvRfK9SpBDzPuP8qd7MiEmeAD3p77T
	 CnGJr6wONn5yg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 025/148] timekeeping: Fix cross-timestamp interpolation on counter wrap
Date: Sun, 24 Mar 2024 19:48:09 -0400
Message-ID: <20240324235012.1356413-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Peter Hilber <peter.hilber@opensynergy.com>

[ Upstream commit 84dccadd3e2a3f1a373826ad71e5ced5e76b0c00 ]

cycle_between() decides whether get_device_system_crosststamp() will
interpolate for older counter readings.

cycle_between() yields wrong results for a counter wrap-around where after
< before < test, and for the case after < test < before.

Fix the comparison logic.

Fixes: 2c756feb18d9 ("time: Add history to cross timestamp interface supporting slower devices")
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/r/20231218073849.35294-2-peter.hilber@opensynergy.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/timekeeping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 087f71183c3f2..7a306bad183bf 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1097,7 +1097,7 @@ static bool cycle_between(u64 before, u64 test, u64 after)
 {
 	if (test > before && test < after)
 		return true;
-	if (test < before && before > after)
+	if (before > after && (test > before || test < after))
 		return true;
 	return false;
 }
-- 
2.43.0


