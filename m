Return-Path: <linux-kernel+bounces-114236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFA388894F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9A99B222BC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5AA254F8F;
	Sun, 24 Mar 2024 23:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kdat+2Ue"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A487512AAC0;
	Sun, 24 Mar 2024 23:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321585; cv=none; b=BJ8C7BaKB1X8WaQQLXLtBMNokwApLKz852PBTgpW4iw3Xx5VT8SwKSdWro62oLaGXch0XIxIIM4QRwyL5cPWYuV0MCEyFF9/L5rKgd42RrWpB/4oTGe7zqrKZGX/X9yR/KSUzyWnpPBiJWPaDAJf1mnnXW6mHEg3wuZ7Bn5ajMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321585; c=relaxed/simple;
	bh=cF4utwkVIlwsuri+yGIzK8zQ7Xl4PGNgqJiLSyNkDDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDiSHNSidZTVi/0XMByKEtL4VRt2zALkQqTw513vQvwMVFRXUfVVPCePIa/ulMsV0KTBF63wmJwfFD6PwZBvMAiDeldXGbPU5Ct0gcbYLP/wEI4vLu8idDyCBJmjZTDhVYZGmkTZyZdTGVlruFGi0gM3rd2UKB/ClPthmWlQg3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kdat+2Ue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC2EC433F1;
	Sun, 24 Mar 2024 23:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321584;
	bh=cF4utwkVIlwsuri+yGIzK8zQ7Xl4PGNgqJiLSyNkDDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kdat+2UelAKLrsc3Rx+OdbFzmPj1xsHUIJJPBUQXTUkK7TnNqjdamPpboNQ8j2289
	 G5xfu7271MaV/eDXis6Jx72aT6IZyUNC0xyKVMkMTerBbnmFt+nt4jJ6SnxPBFaqJ9
	 6UiecBB+ydE0Ivid3TTxDs+elNdLdO8jcJiqTiTRzYzbJODiVIxFWVD+DES33fOXDd
	 xI8mGHj8o107IAe00CbkROn0dxRolEfjbZNvzzSyVDIfJK5fkm1zlsDxq8IhobI6Cw
	 VaBjh9hxQWhTBsgDBlPfCwH5E0VGDQnAHaobp8PsC7d9OlpyYjz/YZxjWQ4lpxTMf2
	 ORSTHReRqhwqg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 314/638] sr9800: Add check for usbnet_get_endpoints
Date: Sun, 24 Mar 2024 18:55:51 -0400
Message-ID: <20240324230116.1348576-315-sashal@kernel.org>
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

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit 07161b2416f740a2cb87faa5566873f401440a61 ]

Add check for usbnet_get_endpoints() and return the error if it fails
in order to transfer the error.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
Fixes: 19a38d8e0aa3 ("USB2NET : SR9800 : One chip USB2.0 USB2NET SR9800 Device Driver Support")
Link: https://lore.kernel.org/r/20240305075927.261284-1-nichen@iscas.ac.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/sr9800.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/sr9800.c b/drivers/net/usb/sr9800.c
index f5e19f3ef6cdd..4de5144821835 100644
--- a/drivers/net/usb/sr9800.c
+++ b/drivers/net/usb/sr9800.c
@@ -737,7 +737,9 @@ static int sr9800_bind(struct usbnet *dev, struct usb_interface *intf)
 
 	data->eeprom_len = SR9800_EEPROM_LEN;
 
-	usbnet_get_endpoints(dev, intf);
+	ret = usbnet_get_endpoints(dev, intf);
+	if (ret)
+		goto out;
 
 	/* LED Setting Rule :
 	 * AABB:CCDD
-- 
2.43.0


