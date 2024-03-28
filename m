Return-Path: <linux-kernel+bounces-113219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A71D9888268
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5727C1F21BE6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EDD180B77;
	Sun, 24 Mar 2024 22:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQL0JLHD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982F15CDE7;
	Sun, 24 Mar 2024 22:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320020; cv=none; b=HulcfdiclDH/kfDQ/lxj3PDL7SOYIBODR/tR7fuqORk8MDFLvmGaqyo+OXKZGZszA/3tbEDI+WAUmMRS6URUEyISCdZTJc9s0IjVyBRWZR11BSew8ZHXuJYc4p6iz6lYHphCh4JJQbJploic5JEJzBUYO0MwOFQyTpb9JF6UdU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320020; c=relaxed/simple;
	bh=HgEcKG5Vx/SjBZU6lXviRdeplvbHJ8xqQ+Kn3L/pG18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fzYr1Fdyqt52ZLy1YzP+9t3NTQJaPO7xiV7MysFsa2EDqVDyffiZoDa4MG3EuXL0pCiRBBGeqVoYOTg0GZ+TZUEjjli9tCkw8wmQ961C4/JrssxLdI8scy/I7T0GxRYchw/FEV85grEfTUFsLLCx+mHOrWS49lzVvaqnLw+zryc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQL0JLHD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB195C433C7;
	Sun, 24 Mar 2024 22:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320020;
	bh=HgEcKG5Vx/SjBZU6lXviRdeplvbHJ8xqQ+Kn3L/pG18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HQL0JLHDes9zlR4EmKxRBWiMIe+FQjOwNXYBMByuNNoS62Rk6IOtNgAztlgdVbXZZ
	 j2kUwc9sel3UZdjSKOuKQJEj7v+73TtBjLKG2D+doOOnme1I2dCW86gzDuU+lvwTND
	 TePcZeOfnaWamfUVk9ZWU0828OmTyTo0SAggkSahqtdfooYDS4FkmMDi7gl65jm84A
	 536i4cnF+ncTcMDuttENiVNKEBVFWGc3fjprEA3K77+ytaVwA91G80wzwtLXBytYzd
	 E71enE16l7YQfWd2AhYOa6XDFme868EwlWsoDJxOLM+aq5ynTyJg2HeEGkoNBUa18R
	 I4L3qAQO0z6TA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?K=C3=A9vin=20L=27h=C3=B4pital?= <kevin.lhopital@savoirfairelinux.com>,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 328/715] net: phy: fix phy_get_internal_delay accessing an empty array
Date: Sun, 24 Mar 2024 18:28:27 -0400
Message-ID: <20240324223455.1342824-329-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 3611ea64875ef..3ad9bbf65cbeb 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2959,7 +2959,7 @@ s32 phy_get_internal_delay(struct phy_device *phydev, struct device *dev,
 	if (delay < 0)
 		return delay;
 
-	if (delay && size == 0)
+	if (size == 0)
 		return delay;
 
 	if (delay < delay_values[0] || delay > delay_values[size - 1]) {
-- 
2.43.0


