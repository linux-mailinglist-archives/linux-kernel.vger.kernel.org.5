Return-Path: <linux-kernel+bounces-114233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1B3888949
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D05CF1C2719E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CC625408F;
	Sun, 24 Mar 2024 23:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnVco60t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D366315216A;
	Sun, 24 Mar 2024 23:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321593; cv=none; b=o8kqd0PyHt1yLE4iA3u1nW6KSzH6BQ0Q7DBI8JIGnVQ0JWPd+B1d12uv5rpORGf8Y6m3QzXpeJhWFyxaiuiIWbGZw30oh5uNiT15Wt7KPh+symHDlQu3LSU4bJ0R2orAl8XsQqUgXzcpHdHgcG6GiT6t8wRrbQ8u40Gx5VSsxPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321593; c=relaxed/simple;
	bh=AFtDp0I19989MUL6aaJ2DsxhejQl4XuhXqLEYgx6LVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ORvRw0weGkqS+6jJrGj25Abtp9T7dBYZLRwpJxP5+VoZ0hJak70K5aLnmUBwgrCRaL/qqgWL9PVWx6nNjB3A1wurpBdMLOZQLCIE57YBZYBYKN631U7XcfaUO+WTp49FSQT6CrtBDPYJpj+d5sFRnIgrpOlL5nhb3W4BuGG8Bcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnVco60t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E244EC43390;
	Sun, 24 Mar 2024 23:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321592;
	bh=AFtDp0I19989MUL6aaJ2DsxhejQl4XuhXqLEYgx6LVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qnVco60toYoDibtZxwkdJXiY0iA4nk8AhUUxwvS2smH3W4fsUQrsdEoylBKTEnv91
	 ztGXgK16ugXhUGjIPK6n88B1Do+7lX3cEgTOAlytxhOETUveH9cuiBKDyaHoPr+imh
	 P1M5d558q/Len9ovTS5pkErVZPpjiKf7u6jB6Uj40D5gQ3yUTtKPUwNQUsSO2VvMOg
	 cISst1OaD2vlS/H0T5xiivELEcrbb+qi/mqpzHlTvp+zgW3zD+g9yvlZxUq3GJkuEM
	 yJ+FvLfuy9u9rhYUShBMNCBsV3wjJMPclK7Vzdn4/4My67vXIo58iIAXN65b3rO2mx
	 lACEywmOsPHBw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?K=C3=A9vin=20L=27h=C3=B4pital?= <kevin.lhopital@savoirfairelinux.com>,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 322/638] net: phy: fix phy_get_internal_delay accessing an empty array
Date: Sun, 24 Mar 2024 18:55:59 -0400
Message-ID: <20240324230116.1348576-323-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


