Return-Path: <linux-kernel+bounces-115443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA198893EB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 330FC1F2FBCA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3AF214136;
	Mon, 25 Mar 2024 02:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFJSGcY/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5C1146A89;
	Sun, 24 Mar 2024 22:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320805; cv=none; b=OlOQdzTmQeOTT/+pMqAu0tFpNdJ2tGqHSmzjy2Lep2UwNngvnpHHXBgQsN2qgMlREPohZhdfdb7L5/w9QbymLbnmEEgmNTzapDb6gHdMdJuNdzR4KR7NAzSwLFD155aMta8bQcRYqO+v3FkvEELJ+7sfruNrLHrpA8dl9mrGXH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320805; c=relaxed/simple;
	bh=AFtDp0I19989MUL6aaJ2DsxhejQl4XuhXqLEYgx6LVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cet7pocx8uSYIrc+9kHs/cY8VnJOY9ZVUGDWjZWcCYbyGQMYkWZ2dc/tafO2+AAnBZl9yq/EcxNmJdH014v4aVvngCLK7w8HP+J9D/SpWv3A2YdCz+JU9aPrukKWufTIwGyZzdcKkXLvPz/l499LUdzHxE4osqwqTy/mtuI/LvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFJSGcY/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5F6C433F1;
	Sun, 24 Mar 2024 22:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320804;
	bh=AFtDp0I19989MUL6aaJ2DsxhejQl4XuhXqLEYgx6LVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XFJSGcY/XAlQ+aIvoCiaDzPfwIxmU8iuY9nf9hkuTe34v/aF88opMQuls+NEU4bWn
	 1k61S4GDYVtnoSsYzoSxKmFh9SHogJDqxcLL+VQKCM/b5S21/HMQiVcHjChWfNtgOR
	 vf38rTM12zWpAgykc+c5jkeQJaOIkDetUjQfge0Ueh3XrelYfO4uI8Gn22DHSPYNmw
	 GEg5TUf9SqLPBZ47nMalqIlsN2UHd5w5kX5JYXQGHAwzrEQCF3Ham2nIM3+JG6whpm
	 e1HePYPOkmABWG1A1iRbN5Bx6W1ieaBmd2sJaNTzZ5kbBURJGjCQ30JTnerw4wF8jx
	 VdjO9KppSF3JA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?K=C3=A9vin=20L=27h=C3=B4pital?= <kevin.lhopital@savoirfairelinux.com>,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 368/713] net: phy: fix phy_get_internal_delay accessing an empty array
Date: Sun, 24 Mar 2024 18:41:34 -0400
Message-ID: <20240324224720.1345309-369-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index a42df2c1bd043..bbc459f97b7b0 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2954,7 +2954,7 @@ s32 phy_get_internal_delay(struct phy_device *phydev, struct device *dev,
 	if (delay < 0)
 		return delay;
 
-	if (delay && size == 0)
+	if (size == 0)
 		return delay;
 
 	if (delay < delay_values[0] || delay > delay_values[size - 1]) {
-- 
2.43.0


