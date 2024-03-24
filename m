Return-Path: <linux-kernel+bounces-116045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B609889526
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0751F306AF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F35B273D8A;
	Mon, 25 Mar 2024 03:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAsueXXr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B02176544;
	Sun, 24 Mar 2024 23:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323436; cv=none; b=ujCIKAXz4hF0A0Or6zXjtRjeySC6f7SwPxlsVagPyR0mffRImuZVMk8LsPnbEUhZMHxVwg2fhVDqvmhPBaep4urJpLNrCbO8o3Qa9GoIc4P+F9ZcUdDxfix28fHyiz0VNvC7Ohrwhf+ZPxy6Ggq8Ly0TCjSig0tjAgJu1HvY1NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323436; c=relaxed/simple;
	bh=y0/SDoJTHZbC2KUnfOWqbDLyT9cqRrJ5ZiUthqZIIxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xc+Ffx8O96Hu+xh4nCTuSoIUSvUk+CPXAWrUSKZwq70r+B1d/bzUq8OmiuamY5dwOJYQet1lljjv7v6mxzbcxjfpp8+Qfu7CDAd3bs+qWW9JewoGMV7aPZTkRp4Wivfk7vCcnXRQFAVpnz3+01c/KcAt1ZEVUe6tAreQA+BakuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAsueXXr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15687C43390;
	Sun, 24 Mar 2024 23:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323435;
	bh=y0/SDoJTHZbC2KUnfOWqbDLyT9cqRrJ5ZiUthqZIIxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uAsueXXrqlxtkmtCegohlMdBMa0KvMyiuXboYgw6/KobejZHUnZit6ULtpaV/CUDo
	 7RHQqdFZOvIjBxM+FnygNuMsBdas+/xTowNtDTcaOPj/qfauODh6Mc9bhMEw9mgaMT
	 myV72TuYJCeEXwP04Z2R/GYugy8CjMliAa9sZs1s7vscu7aCcc2Ett+S75VxMcwM8R
	 PpgnQnL3RkNoxdSLmi96AOwKGPxSDl3z0FbxAy1mYp29C1vxlow/bDFwEGtEO185Wy
	 p7FMaGAiBnYLn5fFtUvsRBJnV3LKX+bli6sk7ykQVz+NVbudCptHJ+CrJ/aPoBqLPa
	 QnJe2zM5sG6WQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?K=C3=A9vin=20L=27h=C3=B4pital?= <kevin.lhopital@savoirfairelinux.com>,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 138/317] net: phy: fix phy_get_internal_delay accessing an empty array
Date: Sun, 24 Mar 2024 19:31:58 -0400
Message-ID: <20240324233458.1352854-139-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Kévin L'hôpital <kevin.lhopital@savoirfairelinux.com>

[ Upstream commit 4469c0c5b14a0919f5965c7ceac96b523eb57b79 ]

The phy_get_internal_delay function could try to access to an empty
array in the case that the driver is calling phy_get_internal_delay
without defining delay_values and rx-internal-delay-ps or
tx-internal-delay-ps is defined to 0 in the device-tree.
This will lead to "unable to handle kernel NULL pointer dereference at
virtual address 0". To avoid this kernel oops, the test should be delay
>= 0. As there is already delay < 0 test just before, the test could
only be size == 0.

Fixes: 92252eec913b ("net: phy: Add a helper to return the index for of the internal delay")
Co-developed-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Signed-off-by: Kévin L'hôpital <kevin.lhopital@savoirfairelinux.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phy_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 0429825a7179d..c1d6ebf12ec74 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2904,7 +2904,7 @@ s32 phy_get_internal_delay(struct phy_device *phydev, struct device *dev,
 	if (delay < 0)
 		return delay;
 
-	if (delay && size == 0)
+	if (size == 0)
 		return delay;
 
 	if (delay < delay_values[0] || delay > delay_values[size - 1]) {
-- 
2.43.0


