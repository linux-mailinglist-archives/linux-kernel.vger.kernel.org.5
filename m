Return-Path: <linux-kernel+bounces-114984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4623888C56
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740DA299048
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1592E2D0E;
	Mon, 25 Mar 2024 00:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1v4P2Xq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7335317B505;
	Sun, 24 Mar 2024 23:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323723; cv=none; b=pUm3HZhqS9Qg6eTijNO+iwonR3Yb7iaR2+g9Pd8G7qriRBRRMDnUiYNDqsBUR+0XWyhkCH5Xr/63avK1cM6SasIEnXSieXDzRazPO6Da/+cn03QkNZZHwUSwgukvHPmol0zuwvKFkorYnhMx0a1HVub3s+jIoWcEIyP5TPfijKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323723; c=relaxed/simple;
	bh=XFtq3XqnESWaeOMaHoGj/4dYIEwo6DIjVgRSahMky7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S49W6Qo9Zt2VGfJOvbqBRky3kvypdFRjzqscoPKJ6JioCyIlyHz003483Gq04lL0ztk6tocgCqbBP3hDcIAioPiZiwAPRj1Ha/GQov17vQQHMshElkAmuZpyS5DqvA3GTnQj1RhAfQtA27fYoWBkd4/pPrABGqAWyKrnj9sCbZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1v4P2Xq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA2FC43390;
	Sun, 24 Mar 2024 23:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323722;
	bh=XFtq3XqnESWaeOMaHoGj/4dYIEwo6DIjVgRSahMky7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B1v4P2XqngBT8/2ITTy4obx5kDrzopTk/y4ud3ZO+nwin0EenbqRrQ1UkMYV5jpcH
	 0yPG6EJUwEJQ8HoiAZKinzj7XaoMMQ5o2RQjHSyLNAaJUEKQfyK2tmcVzxLuTk59tr
	 29JMQDVeJyuTOcQyJAxknxnuq79/scBke3F7UqoVaaA9cZEnvX+2+AjqR+u6S3S0j+
	 ciHV+HDJSA0wCEpJEQaB5YzyK7ey+AqM/teowObCKT8Bc1sTop85RlOnH0wRX2DgHY
	 bAiAtgCWT3B+AQ5VaGEzwOeRfLO/TYKwjnE3x4fAk9aJuu+izYalVTSTWjDohg3I01
	 y/CRPaKY4AMZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?K=C3=A9vin=20L=27h=C3=B4pital?= <kevin.lhopital@savoirfairelinux.com>,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 095/238] net: phy: fix phy_get_internal_delay accessing an empty array
Date: Sun, 24 Mar 2024 19:38:03 -0400
Message-ID: <20240324234027.1354210-96-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 095d16ceafcf8..8654e05ddc415 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2769,7 +2769,7 @@ s32 phy_get_internal_delay(struct phy_device *phydev, struct device *dev,
 	if (delay < 0)
 		return delay;
 
-	if (delay && size == 0)
+	if (size == 0)
 		return delay;
 
 	if (delay < delay_values[0] || delay > delay_values[size - 1]) {
-- 
2.43.0


