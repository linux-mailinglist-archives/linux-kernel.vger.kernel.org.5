Return-Path: <linux-kernel+bounces-112981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E3888803E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C9F280D68
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C30912C7F2;
	Sun, 24 Mar 2024 22:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giBgSok2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC6312C556;
	Sun, 24 Mar 2024 22:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319793; cv=none; b=laaDdGdBN4Tf2f5QumcU3ZBCh7U7hVaL5inWZkYgh6bTqoKjjmW8fWvJ5b8/bVHRsLNHvQVyhmyBa8Xj4SW7aacfnWTzBhaKNuwYwm1p9/ZXpYPrmE5vGlUlG8ZZzXLpj+avlyGHMFRE9zldZD8+pvFT2enQe4mVarsiTD2/5TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319793; c=relaxed/simple;
	bh=i/ETv3Z0+14MObVPjWUndDksu7lvCqc1LjL8w6W1XSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJ707RAc4Mzx0YtQnXKwZoxRwD7GeXqfxFa7OnG9zxYdIPygrMQtc/55awkv8ZNbecWis2GuJaqAzSgQ9h/ZfjACIh/ubpP++WYl4X//eFg8qanQJDCVHGpySznjXXluGLp5ggze2kGnwOf8f7lIwbC6MQHNUKhdx+YFTpKS7t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=giBgSok2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F50C43390;
	Sun, 24 Mar 2024 22:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319793;
	bh=i/ETv3Z0+14MObVPjWUndDksu7lvCqc1LjL8w6W1XSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=giBgSok27Toy35vP9wk4bqOwljP42SUjO3LM+WTGCNZ7ngJxn8nO0GKJ23+GMuLS0
	 F1f73RV2z4UIuMpkdifUU1/fkINHQ3gvCEWpxTGOrjJz4B82zn7s/Ne0Y15nXhPeh4
	 Uu2Cvt1WmkIpCchysKCAtvoIzrA9tA8NCp2DK2L4ijQqzFaohn2Z1feY82CQ2JjEvA
	 haMbftEjdwKfB2dZGOPVuXUIXaMJI2TzVX1ALoq/F0wbez5+VznTBttyay0/2QYDvQ
	 PYzAymCQeKz77/wfIwqeilt7kj8AXvcEVoAJo76l7Sxjs7/TcbCwqaTRBhl91UtFXl
	 4Pu/O9LL9salg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 094/715] af_unix: Annotate data-race of gc_in_progress in wait_for_unix_gc().
Date: Sun, 24 Mar 2024 18:24:33 -0400
Message-ID: <20240324223455.1342824-95-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


