Return-Path: <linux-kernel+bounces-115350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4702889B0B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11CF11C340DE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE89B1EAD40;
	Mon, 25 Mar 2024 02:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWlK7JTt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CCE1D5651;
	Sun, 24 Mar 2024 22:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320566; cv=none; b=s1jVuuyO7WjGE3+uK4wzxcDRhVBeo4N2QBZ7q1VdlnaRg6/q9Ue1ex9fHW2+IB7OTYD/bURRJgEmOOaaasniIMK3a6nYmSa5zw7OEfVsBypF70nCs/vvrTHeX6S1G7YXdAE0p3g1E33GAkbGLbVVYzTdr0TjOFifo/lpdZxadjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320566; c=relaxed/simple;
	bh=23eHHuh/DV2k7PZWl6XBVkeG9jJGgENpTKhIC6FWxGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qC8/1oYj92nXSSipLDmm8g86ouNQ+Er3V79djzonXgJLJqpWo4IQg5jFFnMypTpqyiWOcjTK7ghI5E496TsdTHdEOkx4JHqKZMRZYCUxp84B7qV+c5oPri27f1apQMiOK8McJJ5/TQFARzfWaHty8AyjWODSfXQ0CekkGhJAYNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWlK7JTt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4EC6C433C7;
	Sun, 24 Mar 2024 22:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320565;
	bh=23eHHuh/DV2k7PZWl6XBVkeG9jJGgENpTKhIC6FWxGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bWlK7JTttHO9pKXqf3wVykt7L6l4JwkCRD9PUyZV1su7sWk3uf25e1lH7pBLkLIJP
	 YfqwiMPU+sRNPDup7d0RYHrM1miVNWPWShmsl2fYO681fWXOBQSGk8SK6omeMWZuel
	 f03mvHKoChbFgTx53CDd1RF92g88nan6tkdP+3EHlxP0znGO6BxEtnsliKoLYrBu6p
	 DlXejO5v/R7aTCOtrhfWMsdTunQTrKjBsVTnApEQRNkeCP9xXI0M65TebX/68Th12P
	 qCwKvIrSeyC9L1/RK0mOReBkYEHdaeyH52nIJ6Ee/E/d8imoTsFe+e7nyArv77jcMz
	 7/YC7ylQ7zptg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 126/713] timekeeping: Fix cross-timestamp interpolation on counter wrap
Date: Sun, 24 Mar 2024 18:37:32 -0400
Message-ID: <20240324224720.1345309-127-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


