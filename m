Return-Path: <linux-kernel+bounces-116022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 595A3889504
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DCEB1F301FF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DCA1802D8;
	Mon, 25 Mar 2024 03:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atyNmH5P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CAE175564;
	Sun, 24 Mar 2024 23:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323370; cv=none; b=AxM28JiePh9TCWsmovcNYJD/3g6kY3B31GNT2i6Ru6mWZi69xpRZ72yNhNuPB/Zckzfwa5oFZmfjqQYYSm51UiqjCsR8XguUrEWaff6gieg35/Ixn1H9QUEtl7Xw9eOTWpmOj5PA/mdCksTrv1Fd8ol9ylATkGF/3au7uyrL0u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323370; c=relaxed/simple;
	bh=ixIHT+JxOs9u7DVRarGZieExS4raCUeJ/OKOiBYn+fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbxXZAcHpTnDwMUutmoTIfy4+tDSzXX9hPDRJle/jhGsNzkul5Zu5/cZDEyRUN9nHitxdp5rniE/2LM06B5A1xI813mieQyK/GfmHxeFgEpYbSSW23ufOdoNXgBl1mAxxTipCXoTjZQhvMKD/O5Bx9AWWMUOnPKjgY8Eo3YmwhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atyNmH5P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C195C433C7;
	Sun, 24 Mar 2024 23:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323369;
	bh=ixIHT+JxOs9u7DVRarGZieExS4raCUeJ/OKOiBYn+fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=atyNmH5PhO/eXU7ard4GkshlsaK7g7ws8Hx7pTgzBqbf4Xw2kxcugAuZWcRNtmr1a
	 dLoBT+rZx/mMHgb8z1RY0KQGef2Y+EXQozm3iHfyY/Sha5OSymPVE0vRc6VsnYKHUw
	 WWnIxDL0vrx/i8YCg3VuoqutXRj//NCeDNTXhfUFFsBbOGll0f8alQTabDwK1sVP+f
	 gMxaaCuKWC6YwTjPoVy4pBw0Bw3wWC89MRubfttflAnC2r9bhFhy4MK4QJozh0O6mu
	 8uo314gwjafRZ0qV/iG5zIjIKiwfSdmu47HrRgnobUQ8NeXFBvCkMQCLPuMC83/+qJ
	 WfodMLyyeNRRw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 069/317] af_unix: Annotate data-race of gc_in_progress in wait_for_unix_gc().
Date: Sun, 24 Mar 2024 19:30:49 -0400
Message-ID: <20240324233458.1352854-70-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index ab2c83d58b62a..9bfffe2a7f020 100644
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


