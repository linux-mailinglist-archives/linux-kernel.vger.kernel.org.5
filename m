Return-Path: <linux-kernel+bounces-114362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E811E888A02
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250FA1C28744
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19BC173340;
	Sun, 24 Mar 2024 23:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wu06LWrS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913C6216176;
	Sun, 24 Mar 2024 23:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321757; cv=none; b=g9Sb/acf5qMhWNbKFJlqvODc/t+Qh7vQO7rJX0VI5f7HwrBI0/l4Gj1mkYESoqIJxoJqu8QKP4/pkFquRPvKJppFXdfL/4X5XIUcqGDu7S3egLrday1ZVy3VfP/xeLQ70/bOaMIAKi6XOWK8ZLwtXSeIr+vp+nRhgKii+XVrhtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321757; c=relaxed/simple;
	bh=bp1Fpbg0r4rOlDDELyrOjAlejZsZMctkuCGncAfZ4/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pot6a6tN8ZEncAreZ7g+VCI/mWRTvwzPuYri8MBSmlNn8gR6u/YwGRVHd6vtYKCUgIyfQw5VMNA2+Wrprw9LV9752eNFymDbR9kRd6oY4CuPehD1aI8kLEaUO+6RKNwWVgnREmSFFaEko4wR+xTi+ZNZopy5LsbE6pKyfRsbpZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wu06LWrS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE42C43394;
	Sun, 24 Mar 2024 23:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321756;
	bh=bp1Fpbg0r4rOlDDELyrOjAlejZsZMctkuCGncAfZ4/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wu06LWrSa7qJMPKvLuc8XXsgcq28waC446n1pavEjXs9n5ikqWZOWk26gJf7qRZBT
	 wivVs3F9HlssLBb7QuFS6KNk3VDYcD/oFGU023jSNpTKM4XnPieMFQ04KQKpNSZv18
	 Zvsqx7io+hv1X+gRMCB1YlFCsLL2vqICinXFml3pK47sy3UjcPjSWA3gapSuDQXRTt
	 guDsHYfT9JZgs4lt5oXjcLSoYbLerzqciXE24O0LiJVQ8e58CP76e68s2p4kHmvuK0
	 E2YnKVht3LfL68yBndpXgrfSKWenbnFBnZwIXpkxw269wOKOz+erM/l9grNqld5zGv
	 eLwrNyiJPMveA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jianhua Lu <lujianhua000@gmail.com>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 484/638] backlight: ktz8866: Correct the check for of_property_read_u32
Date: Sun, 24 Mar 2024 18:58:41 -0400
Message-ID: <20240324230116.1348576-485-sashal@kernel.org>
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

From: Jianhua Lu <lujianhua000@gmail.com>

[ Upstream commit f1ac3c9825f99c93a9833beee6b78aa386e55b0b ]

of_property_read_u32 returns 0 when success, so reverse the
return value to get the true value.

Fixes: f8449c8f7355 ("backlight: ktz8866: Add support for Kinetic KTZ8866 backlight")
Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Link: https://lore.kernel.org/r/20240129122829.16248-1-lujianhua000@gmail.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/backlight/ktz8866.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/ktz8866.c b/drivers/video/backlight/ktz8866.c
index 9c980f2571ee3..014877b5a9848 100644
--- a/drivers/video/backlight/ktz8866.c
+++ b/drivers/video/backlight/ktz8866.c
@@ -97,20 +97,20 @@ static void ktz8866_init(struct ktz8866 *ktz)
 {
 	unsigned int val = 0;
 
-	if (of_property_read_u32(ktz->client->dev.of_node, "current-num-sinks", &val))
+	if (!of_property_read_u32(ktz->client->dev.of_node, "current-num-sinks", &val))
 		ktz8866_write(ktz, BL_EN, BIT(val) - 1);
 	else
 		/* Enable all 6 current sinks if the number of current sinks isn't specified. */
 		ktz8866_write(ktz, BL_EN, BIT(6) - 1);
 
-	if (of_property_read_u32(ktz->client->dev.of_node, "kinetic,current-ramp-delay-ms", &val)) {
+	if (!of_property_read_u32(ktz->client->dev.of_node, "kinetic,current-ramp-delay-ms", &val)) {
 		if (val <= 128)
 			ktz8866_write(ktz, BL_CFG2, BIT(7) | (ilog2(val) << 3) | PWM_HYST);
 		else
 			ktz8866_write(ktz, BL_CFG2, BIT(7) | ((5 + val / 64) << 3) | PWM_HYST);
 	}
 
-	if (of_property_read_u32(ktz->client->dev.of_node, "kinetic,led-enable-ramp-delay-ms", &val)) {
+	if (!of_property_read_u32(ktz->client->dev.of_node, "kinetic,led-enable-ramp-delay-ms", &val)) {
 		if (val == 0)
 			ktz8866_write(ktz, BL_DIMMING, 0);
 		else {
-- 
2.43.0


