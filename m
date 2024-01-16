Return-Path: <linux-kernel+bounces-27927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFC882F7E6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40D791F260F8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DBF129A8B;
	Tue, 16 Jan 2024 19:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVBt25rX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7FE129A74;
	Tue, 16 Jan 2024 19:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434598; cv=none; b=aaZONZOxWNbeN7OpjvhQCbGcQgrlDTCv9oOj58u0uzs6gS/0i4LhYOXUGga0h5VupX55ZCpfTAgYTnPjbkLJ13C2A/inDnNUSFIzasYTRPier9/RepD+ZkMsn1qMBhIoIo/3Qv1iOwPR7yYyemWLw2HJufnDVGhSNdBy3ba8N2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434598; c=relaxed/simple;
	bh=as60FRMoLYY3Y/+Ss6mPpIgP9rIDXYK52rIcTRa6+Ro=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=ZveOB8gswdX/xRdMPdu+0KI0XVZIg2k7SqXSCD/XOyjH572DqUgHtN4HOPGDthDbtcFNa+SD1u1W6acd7GBAz3eqbYAfRiA9rHnzdXFKn+8Sxr1Ig71WLZbNu6YpRyLDWzaw5zh4cYXDMb2GAyPu3q6618lAnqWuHSWFvNJkFOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVBt25rX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931A5C43399;
	Tue, 16 Jan 2024 19:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434597;
	bh=as60FRMoLYY3Y/+Ss6mPpIgP9rIDXYK52rIcTRa6+Ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GVBt25rXG9QG/iioFkQGGOuDcr9aDBI3AdlaEC7y8z/0EC8Wk65/G4OxJeNmgn/h0
	 LyUtoH7Qr4Cpiewk/pj6AzyKueYlqM4XL5JO1CUJLQ9khP+n3gjooSAro0ZHlXXdX2
	 JU1gUTVI0pcHu+csbAbj72z1Xr8wxRN0N65usxwCfr4C5gO7km2tl6k2KBcxbUwtIo
	 0hEfjm895yNliPHjwXHQHB7qVpvCbB763oiqIJ2ulAwoA6eH7qaJx0EKPbgdbxBle0
	 i7+9il0WhYcbsJeHXOSBmSwHeYtZlzrtwMF64dOCHH2zJanf6QLN6wfxQIs2/PGW41
	 JywZdQr8HcuEg==
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
Subject: [PATCH AUTOSEL 6.6 019/104] net: phy: micrel: fix ts_info value in case of no phc
Date: Tue, 16 Jan 2024 14:45:45 -0500
Message-ID: <20240116194908.253437-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
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
index 927d3d54658e..09c26ad35df9 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -3609,12 +3609,8 @@ static int lan8841_ts_info(struct mii_timestamper *mii_ts,
 
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


