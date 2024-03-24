Return-Path: <linux-kernel+bounces-114116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B55D888885
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116501F26E97
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA4623DC58;
	Sun, 24 Mar 2024 23:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rrid0Fb+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CC0131E35;
	Sun, 24 Mar 2024 23:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321422; cv=none; b=FjnBehWRqBpiC+MDhUnb9S7Y2NafxhN9zTKDRYw0doncOECgE5K5YvLVTvhIwh0PYwi5vfCS4xN0wURkHxPwnf4mG555noE0J8P/D8tRCjYcT4/414y//mZqUjjNGhEcLQDbgYZBG/iw2SPWhHpKF6AT24kMoVKak4vbwibckJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321422; c=relaxed/simple;
	bh=i/ETv3Z0+14MObVPjWUndDksu7lvCqc1LjL8w6W1XSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mW/3ftMIpjrqoDYIpvz5BiglwJPYwSqGg7fOqAX3UOVjRgjaggCuj8KO1adR4X7X7qZaeY9URkU62q6Isf9eHU2ec9LvVG2vmJRdtzq/JUSfHb/1OE5IPVO/OneGjFDum16d00N9aANcuzoAibeiZs+HRQUVn4AMbsPap/YFmwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rrid0Fb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB7DC433F1;
	Sun, 24 Mar 2024 23:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321421;
	bh=i/ETv3Z0+14MObVPjWUndDksu7lvCqc1LjL8w6W1XSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rrid0Fb+ob0s0IbITjYanVsVDsHaGGFcthcDufPh5QJZogoaBBbXaGSh32Fm8EbVr
	 P88i6NRyPUDdUFAHP//hRP1AgIOu5m+GqKxT6hiuzYw3X4MuQ9ax6sQ3ZeTPOZGfrg
	 45EoUeiFKLSjRMuBTSQboOIhihEBxfitb3I6U2A0AQDfzz+72Fjk7l/AKoB1ATO2eG
	 vubXADg9uAngFNbCPtrNHQxMVbNXg4G2+uJ1AQEvdbaQUijqwS8HgIaZAggj+FkNAS
	 wNIRWx3OA+onoUAmesbG+9ZtROGriSnF2lnrgd1MPnEW/bL0KzwPACTsloKbegq58d
	 bDCvGDjCZqOCQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 145/638] af_unix: Annotate data-race of gc_in_progress in wait_for_unix_gc().
Date: Sun, 24 Mar 2024 18:53:02 -0400
Message-ID: <20240324230116.1348576-146-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 31e03207119a535d0b0e3b3a7f91983aeb2cb14d ]

gc_in_progress is changed under spin_lock(&unix_gc_lock),
but wait_for_unix_gc() reads it locklessly.

Let's use READ_ONCE().

Fixes: 5f23b734963e ("net: Fix soft lockups/OOM issues w/ unix garbage collector")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://lore.kernel.org/r/20240123170856.41348-2-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/unix/garbage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 2a81880dac7b7..027c86e804f8a 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -198,7 +198,7 @@ void wait_for_unix_gc(void)
 	if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC &&
 	    !READ_ONCE(gc_in_progress))
 		unix_gc();
-	wait_event(unix_gc_wait, gc_in_progress == false);
+	wait_event(unix_gc_wait, !READ_ONCE(gc_in_progress));
 }
 
 /* The external entry point: unix_gc() */
-- 
2.43.0


