Return-Path: <linux-kernel+bounces-115831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FF3889C23
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 823F0B2B581
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFE1378C71;
	Mon, 25 Mar 2024 03:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIj4OWZB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957DF145B0D;
	Sun, 24 Mar 2024 23:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322006; cv=none; b=eoGvcv9RFnoqeyHGlt3hjlZcyEMMkcq6J4tLR7BQmXFD53O3Cy9DK/3OZSgRnS+wTf1QvLPzswO2K2F8U/fGoJSle7krLXN+/MNphWlyJxOii5ty6kYwKkaXSCO7VCGE98tvXfAsT71lytA0sX11+aQyQogeZI1/wSE3NqY0UoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322006; c=relaxed/simple;
	bh=KxKDHMnXXNeIqJdD5tAEXkK5ykdmBQbtB7cCktcMVQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCAJJkL2gfY+15n0zbT6ZiJzG4rCpbLOHD1mO3AM0e2Fg/nUE33cLqTDEZbVyQBNW6cnGxge+B4h6wU12IV+ws3479B2BBBDGIJCxw8fntmMcJhpOdHZ8uQJk1M+W3fby4vuI7Ah1jOKyXmkUdH/sjHFpCGpMqc2sFBLAyek4kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIj4OWZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC595C433C7;
	Sun, 24 Mar 2024 23:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322006;
	bh=KxKDHMnXXNeIqJdD5tAEXkK5ykdmBQbtB7cCktcMVQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iIj4OWZBxieTM80F2Zm5w8JKY7B/LgNAR2MhtVOxJAtEaNKrg+aQaJu8T+uK1eb54
	 59AOg6adVgaMWSu0742B5gNgCkfBMnun+o9ilMPpGyoPeTJKosVXknxyVn/IdiNAWh
	 Cf8QBYqRW7JxadNSK93ZAQ5dS32wAI8I637fjx/lehFC/YfGMdzsl1bkCSlGt1splN
	 G3/95F7JC1AjNVa4IfqVsl0uKTlUUIh+FuQAfD2ttTOIPPka27MoG8ytsxsZ1HGzHU
	 GLyelucmXa2LffD9y7q5otChPc4eW+VlBZ+JTY8LLywUdQsKRZcJFUnFwVz6bRwv+k
	 +hPvHx8Fa6NvA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 078/451] timekeeping: Fix cross-timestamp interpolation on counter wrap
Date: Sun, 24 Mar 2024 19:05:54 -0400
Message-ID: <20240324231207.1351418-79-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 221c8c404973a..c168931c78e01 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1186,7 +1186,7 @@ static bool cycle_between(u64 before, u64 test, u64 after)
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


