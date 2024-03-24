Return-Path: <linux-kernel+bounces-116041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9503889519
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8F11C2DDF2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746F827211A;
	Mon, 25 Mar 2024 03:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kc7s3wgI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0795E17652B;
	Sun, 24 Mar 2024 23:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323430; cv=none; b=Z8+Rehexy8sQTeH1cbQeehl7RKCpCOPgv9uFBsQotFr47NndUveCF8DpcSBtrVGHutxYD1kOauksoVeqrlurtmz6N5hflQWwjanxa8Gn+GThkP4wlTQpyjcxl3K7FSFDGRcIHAHQ+mMOWRssSO3HcGUxqTyDZ6piQbGbNrmP0ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323430; c=relaxed/simple;
	bh=zEo5HPGCkVk6f1ShXx2yoFamEJLmzLxZh76VBAylBns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jxga6mMaeGpqgVWDnK8sY+ml1QsspVqL90Nsaa0HjIYZ7BYQPMxLs97knN432bLeHCcjpOCcF40ow/9yvpf7ppscWg69TcpyQzAU/8MHCfMfs/c6tZJE9gEe81C/MRo/WhhVblNbm9vS6bMA0wi07Sp0RRKKPkBUWb8N43+kyvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kc7s3wgI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30674C433C7;
	Sun, 24 Mar 2024 23:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323429;
	bh=zEo5HPGCkVk6f1ShXx2yoFamEJLmzLxZh76VBAylBns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kc7s3wgIpbesxx6Y4Kdn0l8sFlWPKwrkcKHA5v+9T3IaeyVNSL0GjuISV2x/yO+Dr
	 N1GNQEl4YxvLwACsm5m9HD2HHK0mnBI72oXSgmCpX1hck/U1QWkMwKnomun+GFES87
	 Jhe1zawUjxVnxEwnLnS+eiST2A4/42Btnmx+XQsFGCi9L+FJL0sGT5YmdKeofa0Gzz
	 T2QhvrtkufzTF8HJZkmRmaAvuWS/M7uvKCrty5iDvvg/PPWO9zcFwscwcpWF4+l+Wo
	 gQG2Ukgv8bLrStWPI2Awmq2jmjXIYlJ2mRqo2V15aBzovkaitzx1PuJbbS6r32z1YW
	 5KCHgdOIPYbWA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 132/317] sr9800: Add check for usbnet_get_endpoints
Date: Sun, 24 Mar 2024 19:31:52 -0400
Message-ID: <20240324233458.1352854-133-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 576401c8b1bee..79358369c4565 100644
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


