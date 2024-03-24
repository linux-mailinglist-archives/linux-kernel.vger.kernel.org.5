Return-Path: <linux-kernel+bounces-114090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF1688885A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47E4F284929
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F15014F9F5;
	Sun, 24 Mar 2024 23:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMvgGnGW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994A520013D;
	Sun, 24 Mar 2024 23:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321385; cv=none; b=mEPwjplk0nsfGVepSyfjmFRPm3O9sZuzoRlIht/TPmkteCu5UeTKBJsMGCMoTZH124alzgn0SuS2/50KmZqsol4kU+/Cpj9ilXK/lMYQ2MdKvME18pSWNuGoKnZoyEaVPlGbvTt4NTr5y46hiOSVH2/WD07alPKOBnyBVxHoXKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321385; c=relaxed/simple;
	bh=23eHHuh/DV2k7PZWl6XBVkeG9jJGgENpTKhIC6FWxGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j6YcpRMEpWdjAWoJfDSDVj6J1Tn55OPOCeMcrd6z4xLyAcnFVrLbT4vOS0veKBGIDAWhf4lGcTBUnZlIV4AZ7uY6KoNVUmAYuSw4NtdfFzsuIyyLmAUPILiBEnfQxNRzi7KuDF/LqfofIymUmr6VmdOt/UovdX//SGSpFTQF8/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMvgGnGW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CFEC43330;
	Sun, 24 Mar 2024 23:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321384;
	bh=23eHHuh/DV2k7PZWl6XBVkeG9jJGgENpTKhIC6FWxGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XMvgGnGWPmN2jdvPTeoI+N7gyhHGLwk63QYPTAmwI7pukCATSty96IWfKaNWufcs+
	 3b+YIClyLJdthIsK7qZZzHnqHzJUWgxRfjcLnipzndrx2N8VkAHY+6Tw+SeMsjmWuM
	 3uVIfRH0pHHTPebcb2mb6QMYP6wLT4NZJQ+r3XL2+ximHFPHeTGIuK33OyIWgyaF9u
	 XMYQ6rlV0T4IAfCv5jAhNr1FAsro+PQgbdBOzDbLtrcfgmBcP+G2TfZ5YxK5nPNpQb
	 wh5y1fRd/FvZba+d80FSvit932U0Nnh4lkFUptWABBXgrsnEEqWlSwXYOY61M69lkR
	 gmT/jkEPFSH7g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 108/638] timekeeping: Fix cross-timestamp interpolation on counter wrap
Date: Sun, 24 Mar 2024 18:52:25 -0400
Message-ID: <20240324230116.1348576-109-sashal@kernel.org>
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
index 266d02809dbb1..8f35455b62509 100644
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


