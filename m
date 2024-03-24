Return-Path: <linux-kernel+bounces-114743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 191C88890ED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40AD91C2CE84
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388671AC293;
	Mon, 25 Mar 2024 00:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VElcKbyE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F04219533;
	Sun, 24 Mar 2024 23:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323347; cv=none; b=fKtHDCv+2oScg3N0EYFJBRJUJ5CLdW/yKnVASv9yjhGRxxMniYyO896RU2lN3xxns7XG35BB5IY7CWM+VftVKBMhWnikGYy2mYFBzTnvPhqO2y0fly2Wo+HEEAC+6keOz9y4KXlZ7I9IGUVPAUYaAU1+8UEkhM2VXxRRsawGdWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323347; c=relaxed/simple;
	bh=cNs+3/cbxq/GxMxjAmY9I2UQAXHhTV2V/4AaQn7m6nI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOodsMW+KgPRgEX1qSqvl7WbkU+WIcQdSVUWTPkcCD8dZNr53AonnultiT+3ZrgPgMQ7SDQoLxK6LXTH7q23rPggKN8vTmGkFWWlN5zwLtsL38TqQVW8q8plMhpdz1tUmKzJr7jO2VsIe2RIC9+04HZscwE/HN6Ov8C8NwGLD54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VElcKbyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB04FC43394;
	Sun, 24 Mar 2024 23:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323346;
	bh=cNs+3/cbxq/GxMxjAmY9I2UQAXHhTV2V/4AaQn7m6nI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VElcKbyE7RgO/NCEzTdIhsGmsPxjqw3jhfjY2291cA9deAyv9k0RHmGQ6rnGNWziH
	 cktP1/6THbhnHZLXqYCClPUOqwTofMOARNtuAeuV/BQTJttdnrub1TMLPrfnhilul4
	 oM32gC6Fzi9Aun6+oP8j1K2FwRsDblAaCmnah78WEyh4dEOzXhVBvPHdESr+43ybLJ
	 2R7q22TiLRpzmpRsQDSKZYcU4aHMBJu+jmdpcLuJNyFO8veyyEhdSBsUvL4fV8ahmX
	 2GE28qvrJkobmpMJrxYXC5I4civq/bb2Ne0KNEgik9eFcyjoaqkGfvA/6nwY2voBs4
	 cdoauM7u34GKQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 046/317] timekeeping: Fix cross-timestamp interpolation on counter wrap
Date: Sun, 24 Mar 2024 19:30:26 -0400
Message-ID: <20240324233458.1352854-47-sashal@kernel.org>
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
index d921c1b256cf5..985aa75eedb24 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1169,7 +1169,7 @@ static bool cycle_between(u64 before, u64 test, u64 after)
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


