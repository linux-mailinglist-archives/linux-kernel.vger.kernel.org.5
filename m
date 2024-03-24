Return-Path: <linux-kernel+bounces-116322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD4B8895EE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2BE31F306E5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410D63D4763;
	Mon, 25 Mar 2024 03:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8azG9SF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CE0184436;
	Sun, 24 Mar 2024 23:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324275; cv=none; b=C1Cb8qJZBIvM3oZ+FciaS5tzA+yk8TdDa8+/s1K3ePxNOZpQQ9mhTiEFCmFuZrisHV/iIxG3u/O+DaDi8Bnx0tA9MQbZggXMWQ8H+4cnU8cyDwTuF8JODjYUf2pOe7Vv7nuFgay9n073ewW91E6vhccm2BnxyUvzBN4tE5Wkf+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324275; c=relaxed/simple;
	bh=RlpN8v+SpRk98+w7H3gbi89e8+2REgiqFkpTpNGHH7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwxqvzKLPUAnruOmdAisMyLn5LBD2Kn34DqqbxFgIiLPw98w1scnhvpsBduWTAg6g2YuEpRjGPA5Qwk4GtlGNG/8KGByd8fjvc3UoIxxmRf2cSxhr4jIeUKY6Ru6mrCL2xXFuCp2XCZYMHqqbUwwoX/+plWD/fNFADsmxDX4Pp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8azG9SF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA6EC433A6;
	Sun, 24 Mar 2024 23:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324275;
	bh=RlpN8v+SpRk98+w7H3gbi89e8+2REgiqFkpTpNGHH7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o8azG9SFh1c6klOLrgZI5bD+O5Me98wp8WKXBvEa7A0eAqKCf18CrvvT95YOLwLgO
	 bZUWxOiXd5sRTbHKSGo6s1sFJltqjfpijFz3eEnAHUNJy7pGNClenBY9yO8kDtcFHV
	 rL2AkknqD4jiobHnUdq0o2Ha1l+zO+6sOtUPYrgfSyy8PW3Pk2Zt5kwBZY0aYQodXN
	 zAC4JQKQzR9eGA/gaFIhTRDGcnqbEV4glxmHJ0RPJ6TujAtDZIM4WvTIsEHoIuyHhg
	 ppnk1MhZlupp9NhmxbeGzZhVlBm0Xrc7Z4ob4P/mhPWHpQX6XSaKRTzV8EOE1PUXPc
	 GYPk+SkvFb/xw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 054/148] sr9800: Add check for usbnet_get_endpoints
Date: Sun, 24 Mar 2024 19:48:38 -0400
Message-ID: <20240324235012.1356413-55-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index 8f8c9ede88c26..a5ff7df10505b 100644
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


