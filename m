Return-Path: <linux-kernel+bounces-116266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC24889DDD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABE9F1C35796
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EEC3C81FD;
	Mon, 25 Mar 2024 03:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBVW1uTQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1D52261AA;
	Sun, 24 Mar 2024 23:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324072; cv=none; b=YRF0S4+q2sRafDrsVcBZXXe35NYJ1CDUYbsvthRO+ttj2j83WlJUQUVT2pxTYrud5I5Dyw/gJzoygUMgur59smhz1/ZTWBEJvyqI48z8/emA8NjsrNRDY6cAmwnywT4pxp2jC69h2d+A7sEuRQuBMkhy94I62t2m+gLlM7VyrXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324072; c=relaxed/simple;
	bh=ExZL3/MFyzI92yOqyU4pBDdIcGauhn5Ds3d+UzfIZ/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IRUZwZdNMjmihGkOKM9sV/EdtQZlOY3JpTPim0ueVIOiLQjkFxjLDipjkVa79pTUOp1pYKwZr5uR6c2kUF1PeeeH8c89V6WZ6B4iK0SZGbXzV668SFnLqpUL6+1YeR7BverteWEZSNqVCtnuG9pOyUUWNwY2X7WxaxSA5U8Gex4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBVW1uTQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C44C433C7;
	Sun, 24 Mar 2024 23:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324070;
	bh=ExZL3/MFyzI92yOqyU4pBDdIcGauhn5Ds3d+UzfIZ/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mBVW1uTQN8WF3C98/puxssAKvpr2l51JMqZI3OQ7IcValmuaeKUtPP0Pn26qpLOvJ
	 v9KedXRK+2h2j14EkDhKgGoTYbl7JKr9JUls+0+ORKGDIMoQh3ja7NksbOKmP9XRNt
	 2H6ZpzBWxGRybUYxjaAfb6AH36xEcXBqYDBT8z3jYdDPxND8ZCAyvmS487dz7V/eyt
	 RaR6t8TwjhRwiELcgq3S7rRaRncsw6Z1t7K7ml5F4P+1GWqbVnBoUY/lJNlmOUTeBF
	 D3J6/bymJzPuYhudPiHRMQpRT+S0EYRvTnJwBDl/9jTo0wpUrdceiaQHDG39mF1eDJ
	 K7LaVT1GAtS7w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 071/183] sr9800: Add check for usbnet_get_endpoints
Date: Sun, 24 Mar 2024 19:44:44 -0400
Message-ID: <20240324234638.1355609-72-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index 681e0def6356b..a5332e99102a5 100644
--- a/drivers/net/usb/sr9800.c
+++ b/drivers/net/usb/sr9800.c
@@ -736,7 +736,9 @@ static int sr9800_bind(struct usbnet *dev, struct usb_interface *intf)
 
 	data->eeprom_len = SR9800_EEPROM_LEN;
 
-	usbnet_get_endpoints(dev, intf);
+	ret = usbnet_get_endpoints(dev, intf);
+	if (ret)
+		goto out;
 
 	/* LED Setting Rule :
 	 * AABB:CCDD
-- 
2.43.0


