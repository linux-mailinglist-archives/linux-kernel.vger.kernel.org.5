Return-Path: <linux-kernel+bounces-27789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D65AF82F5F2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B7B1C2412B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD300224DD;
	Tue, 16 Jan 2024 19:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EL2c6aFC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276092233B;
	Tue, 16 Jan 2024 19:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434201; cv=none; b=rtvJz3GS8e+cG9IkSI5O1GGL2M49vLteYfscm4wcwrvP9F62MGvhhfQSSxbhG5CA5zNTlUJcoXjcz0d0YGXy0l3XhMbJgeOTUqC1PLZg5ddRnr8JiNEsOldzojUptqRLovFFKsxsdH/plVNWAmfv4bD1NCXMQ4a+jkE4JpZo0ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434201; c=relaxed/simple;
	bh=Zd2ANWWo3hDDPElFO8XG/z24mnZjQMYfjdtqmeTwkhk=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=HNur651003Yke19hZShYxSK2AXJrVSoBhuQv0kYH0kuAoxwF00feihqV4xsnHZees0QdSSItfHuTVxMwrnKeTdKujFWX1puBO3cL7vwlXj4mSsl8PiUIVPCVGNjtJO67MEHYwHACcB+eEVBaGoqqeBl8FLBeWJxAlu5p8akxCX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EL2c6aFC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBD5C433A6;
	Tue, 16 Jan 2024 19:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434201;
	bh=Zd2ANWWo3hDDPElFO8XG/z24mnZjQMYfjdtqmeTwkhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EL2c6aFCAuDvRZrw6p6uKwhjbN4EF4ApLZ5p8ZR27kPc8nfr2fF4vz8K3vrqcv5U1
	 KB3GBfIXoHQIf3huZEN0qUVU59j6t4T3H+9V9CWDG80fImM6hFh73x6ZXcnAMOPa1M
	 35yIdU4geNXke9fBw5fpbKNjuK7jZnjNo9y4l3+Iz2Gik863kHHQsgTOFcrQIrdDdM
	 Il38KNlyItO/PjGmnkDNBo+R/Mb0Rrr7ZzXxKBCYqGXONp0rbiVRIDVCJkLHDO2iEn
	 NYZcb9P2PRdSD7EyIa7473jCmlEZOAA62VgBaOumloIz1vekPBsrUuqfzJrHbK7V+n
	 dQmXdAUb4TFzw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 019/108] net: phy: micrel: fix ts_info value in case of no phc
Date: Tue, 16 Jan 2024 14:38:45 -0500
Message-ID: <20240116194225.250921-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Kory Maincent <kory.maincent@bootlin.com>

[ Upstream commit 915d25a9d69be969c1cc6c1dd0c3861f6da7b55e ]

In case of no phc we should not return SOFTWARE TIMESTAMPING flags as we do
not know whether the netdev supports of timestamping.
Remove it from the lan8841_ts_info and simply return 0.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/micrel.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 08e3915001c3..7c87378e473e 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -3631,12 +3631,8 @@ static int lan8841_ts_info(struct mii_timestamper *mii_ts,
 
 	info->phc_index = ptp_priv->ptp_clock ?
 				ptp_clock_index(ptp_priv->ptp_clock) : -1;
-	if (info->phc_index == -1) {
-		info->so_timestamping |= SOF_TIMESTAMPING_TX_SOFTWARE |
-					 SOF_TIMESTAMPING_RX_SOFTWARE |
-					 SOF_TIMESTAMPING_SOFTWARE;
+	if (info->phc_index == -1)
 		return 0;
-	}
 
 	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
 				SOF_TIMESTAMPING_RX_HARDWARE |
-- 
2.43.0


