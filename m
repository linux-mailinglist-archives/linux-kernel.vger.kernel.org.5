Return-Path: <linux-kernel+bounces-113213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4891288825C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D2F28D2B5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774D517F386;
	Sun, 24 Mar 2024 22:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYBrp0tU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E30017F362;
	Sun, 24 Mar 2024 22:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320014; cv=none; b=McJuwx8tSYlnJSQxCcs1j7tR9WqlFdazpp2VtG7sVRvZOLhomhLrFqg3BgPOIMhsFhZnMDL5DWrxGVd9pnV89frHuf7PI/K0z6HF5XnWY6TDeMyy+MIo3tjMP86p5mlIMoMQcbdzxpdokNrdyjcjReRGx4awDgDReHgB4nlHI60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320014; c=relaxed/simple;
	bh=57sDBaEV7+i6YJcxG9jMYmtxVdI50Z1CD7GMNvOrjIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cD4SXCZPOTh5lYmu/VXKx0C2XWEIFnjd/u2nSet7RggwspuQqIoKdctWDd9cuRT7Lyc/OnUS1yB+jT/4Y5twYCdodxagtFfJtvfcflwUiO5c7IMgE3wByuhdB3gloanCfarDQ+S/EwJFBDJZAZGHwfNIUBK8S0DHmK6l0ypMw6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYBrp0tU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D8FC43399;
	Sun, 24 Mar 2024 22:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320014;
	bh=57sDBaEV7+i6YJcxG9jMYmtxVdI50Z1CD7GMNvOrjIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MYBrp0tUHruqe1CbkBI1rszUgJE5vmVAS6hnPKk1g684KHo9aihvj+y0etj4KrCOS
	 6Tb3vwih1216Q0eIE9E2S9tmQr94NC6O8rJzgeGj1wKjUXx8Ye2REl1D1u2BH8VF5K
	 l+VijeZwt1QZs8GSBAILKX73IGg7AIXbuGOJx4Rrw9I3x82kmPEuuHyhrPyONng49N
	 Cjd2UP2i9PNDJNjEgkmtNDIVKgEF4ZZQHfda8EuBO16yYa/5XR3h/zEZCX9cIfVF5N
	 9ovbaaXhwdJ5W2dLwQhazyhNKTyl8JSlSmkSpCu6cev0jMtBIbHCRYDJpmmNr0+qM1
	 KWuqEmjKtyoCw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 322/715] net: dsa: microchip: make sure drive strength configuration is not lost by soft reset
Date: Sun, 24 Mar 2024 18:28:21 -0400
Message-ID: <20240324223455.1342824-323-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Oleksij Rempel <o.rempel@pengutronix.de>

[ Upstream commit e3fb8e8ba72b053d05ca2602acdd6b869f9f296f ]

This driver has two separate reset sequence in different places:
- gpio/HW reset on start of ksz_switch_register()
- SW reset on start of ksz_setup()

The second one will overwrite drive strength configuration made in the
ksz_switch_register().

To fix it, move ksz_parse_drive_strength() from ksz_switch_register() to
ksz_setup().

Fixes: d67d7247f641 ("net: dsa: microchip: Add drive strength configuration")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://lore.kernel.org/r/20240304135612.814404-1-o.rempel@pengutronix.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/microchip/ksz_common.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 245dfb7a7a315..25a49708f4842 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2185,6 +2185,8 @@ static int ksz_pirq_setup(struct ksz_device *dev, u8 p)
 	return ksz_irq_common_setup(dev, pirq);
 }
 
+static int ksz_parse_drive_strength(struct ksz_device *dev);
+
 static int ksz_setup(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
@@ -2206,6 +2208,10 @@ static int ksz_setup(struct dsa_switch *ds)
 		return ret;
 	}
 
+	ret = ksz_parse_drive_strength(dev);
+	if (ret)
+		return ret;
+
 	/* set broadcast storm protection 10% rate */
 	regmap_update_bits(ksz_regmap_16(dev), regs[S_BROADCAST_CTRL],
 			   BROADCAST_STORM_RATE,
@@ -4242,10 +4248,6 @@ int ksz_switch_register(struct ksz_device *dev)
 	for (port_num = 0; port_num < dev->info->port_cnt; ++port_num)
 		dev->ports[port_num].interface = PHY_INTERFACE_MODE_NA;
 	if (dev->dev->of_node) {
-		ret = ksz_parse_drive_strength(dev);
-		if (ret)
-			return ret;
-
 		ret = of_get_phy_mode(dev->dev->of_node, &interface);
 		if (ret == 0)
 			dev->compat_interface = interface;
-- 
2.43.0


