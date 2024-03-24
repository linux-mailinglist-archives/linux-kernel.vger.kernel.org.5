Return-Path: <linux-kernel+bounces-115056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A08B58892F0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B15F2A2529
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1095113E40B;
	Mon, 25 Mar 2024 01:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bq4xxRq6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE583224A03;
	Sun, 24 Mar 2024 23:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324026; cv=none; b=scp8HPwJngTRAFXRRyBcru1RQMwrm6q6jWzYUojO4ULxKivn2+ZjEWHETutTU8M6/UBOaNbuL1za6VDG0fjfDMSjF1P+mowNKJIW6f6O3BTXGErmafILX6PresdiUbSURZRfZtclm275f6fNbBu5fkFUQv0qJ+A3iVL55Xqi0W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324026; c=relaxed/simple;
	bh=PY6QXC5NF5XvQGFaT52WK479ZqTA9uhgoUxN21uXupg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBzDZvbSA70vI1suASDqtuT7rw2g8G//31k0rrVSv+6w5Lvrh2gVTX6Dc72q4M/r8KC23Jq6iR53UM8+CbG1ye1eBBY7T8X2TArjw9F48KZjmlB+DqWwQm6A7Re9Xe7bHw+QDM3Cr3OHoEsAc9F9p30rM3fBC/zFZsHm8xA2fE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bq4xxRq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D30D3C433F1;
	Sun, 24 Mar 2024 23:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324025;
	bh=PY6QXC5NF5XvQGFaT52WK479ZqTA9uhgoUxN21uXupg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bq4xxRq6PAOpmV+B2wpo4srKLCOjZtKFDAP4l7pUWiGVojSZz5+cqCjm24WNvxOWs
	 uxC9avRNqkdZCVWyGFV7AVEF6XDy4uXXawxXT1N8K1qGULXM7lmA/op+99ZSw/JWpJ
	 e7UKJnII9RrO3YmNdsMoA0AEkvk7MizRnUm6AUr53S2xZiCcs7KCv+P/0BK4A+BXSX
	 6/i1tXIxfnMLQlUM9oT2jg1ajm8fWtfenWUmEmPImbi2NsuXX3kkAcZOHIh1MkDcFD
	 Yp7py/ENlWBtdDf9GNG0ABNwYnHi+CsmfjjhUtfEUGvVdjANVK/Y5XZd+GSaqzyISf
	 pGZjf67c0Zuvg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 026/183] timekeeping: Fix cross-timestamp interpolation on counter wrap
Date: Sun, 24 Mar 2024 19:43:59 -0400
Message-ID: <20240324234638.1355609-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index 105dd0b663291..5ae2b5b5ce4a0 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1099,7 +1099,7 @@ static bool cycle_between(u64 before, u64 test, u64 after)
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


