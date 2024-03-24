Return-Path: <linux-kernel+bounces-114509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEE9888AC7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABFB828B056
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFF5181478;
	Sun, 24 Mar 2024 23:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhO4u9uq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524021FB093;
	Sun, 24 Mar 2024 23:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322131; cv=none; b=A9WyGKBMzUfmteyzndRALi/ngvscePXNbW5v+szBi5FdwGxJDbM5FOyQrHMATqh7AHhaXVx3cLWGArSqLUM/Oja2rwUBjPP5iFq6zLIJAqeLfa6dQg1Gnp6XduxezNNS7nXDmcYTzPadyoC6IxLxCwpstrCOQnYvZV93NBVSmGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322131; c=relaxed/simple;
	bh=cF4utwkVIlwsuri+yGIzK8zQ7Xl4PGNgqJiLSyNkDDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRzjOBtxPgyMP3ZPrIuTs3X6vlZHcAjQW7hJSDRfdGctAU7U5fD58oe1FKaxhmtmYGhqHQkap/obfCSQcTtN2Mo7VcJh6zXl31k+crVxbD6PN1f0V4495fTAxX57x0oWlRlCQAqfS6dQ1/4ZsFFZWDep+mz9gj/jALRRqU6HJy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhO4u9uq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6DEC43390;
	Sun, 24 Mar 2024 23:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322129;
	bh=cF4utwkVIlwsuri+yGIzK8zQ7Xl4PGNgqJiLSyNkDDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZhO4u9uq1cxgLXz0Loa/gYBPsUYaIO8JfHZ/NXCnv2o7xN2dPKDwOV2zmtWu9KaxC
	 Vq1ueyr30V6lNc9A5ezbsIHKALjUUJlU3aeKwjnkSlqv52sfu17Esxc8hHWrEYfvx4
	 /HDk93XB1Y9urteW7/T7RdK30JWQ8YNKAxKQy/v1Nn7RgwBR37V4mm05RuEDVM0NO1
	 nkwLBMi9ygx8r9FBNiVLrId9PW6VqZUMEDAIMoJ6FXDoQcAoTT3XhylCGCNrJcprzw
	 4ouSIjvzxfwdd4dxo4H0Oy+L/wC6ItkNaxvZWbdtlABWumC6SFSp638SPpxnAop8DG
	 CXdrZ47dI9exw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 206/451] sr9800: Add check for usbnet_get_endpoints
Date: Sun, 24 Mar 2024 19:08:02 -0400
Message-ID: <20240324231207.1351418-207-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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


