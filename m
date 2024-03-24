Return-Path: <linux-kernel+bounces-116151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDA9889BA0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2519B399BB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4723B2662;
	Mon, 25 Mar 2024 03:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJB+J5lc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A80917AF91;
	Sun, 24 Mar 2024 23:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323715; cv=none; b=JBLqJZW3Bt/UUJ54oYIv0gS3BnBBVXBBUlvOokNJaChgLqOvJbAH0oV/tyq5zyGb4Kl8CKKmRHwOOH60EmpYxnRL/ZKbPERVB5IvAE/YIpTjUDZFdTtdlTkl3Hp78fre/1xo65vJZ5K81wIsWd1dvoeZt4+6Xud4WT5F+Ki/l+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323715; c=relaxed/simple;
	bh=ExZL3/MFyzI92yOqyU4pBDdIcGauhn5Ds3d+UzfIZ/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ckTXINsKbfYb51B5AgEhQhq7X2j2S7Cfq5TDCGYhgq5flPav4Fz1So5i5Z1KkofoxrctmFFUTFaKnbG7PuFqxV+FYX+jpgmAIyZRu7tr7BQig7MmYgn4aqtoaNCIfA8dgDPfbjFa8kYdqxZJwgx4nFvxEcqzFLdzSMci9Nvl0NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJB+J5lc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C71C43390;
	Sun, 24 Mar 2024 23:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323715;
	bh=ExZL3/MFyzI92yOqyU4pBDdIcGauhn5Ds3d+UzfIZ/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HJB+J5lcu0PX/5vhbWjMP9E11fiXPAdWGxDLTGBmSsTl+f65Va8J6/D8NTQxEOuny
	 GORZFeCxz8S3WwVoD+ZZTAt/1XC1ygda5rXEvwDRJ3fmAsVHxGrsPL9BMx3I5xCPKQ
	 aarQxGX2hIfRg4RQd61woEbuh4CGwQM32LwuG/fPd1txaJvuvcLTSRcGGgUCGlgzqP
	 72KzeTiXpHeIexSJdmEe7xoR8kqgtxi7jDTAdM2J112QTE9xvuDlC7ZkPEIOMIpzmW
	 Fat3HHtimXV6WlkHkmyG5svVswiyIQBGu9m9DPb5zX43Tm+GOlTzq7UgPXhOFtbUwl
	 mmDTrjjDTNAUw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 088/238] sr9800: Add check for usbnet_get_endpoints
Date: Sun, 24 Mar 2024 19:37:56 -0400
Message-ID: <20240324234027.1354210-89-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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


