Return-Path: <linux-kernel+bounces-114032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2066C888801
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F7C293C40
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F325922BC1F;
	Sun, 24 Mar 2024 23:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Twzad9vg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D6D14EC5F;
	Sun, 24 Mar 2024 23:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321322; cv=none; b=Z7ye4JjwZqXbFdzlIDnnZ+V030l86ZzCxBlLucpAs2Ng1I88xJi9RlKYBr6dhoF+9RQ6VqMy66VJzk6IcbJqHLkx2a9q03hDdloDD+wOY37Y6g35glVlDAHygXEo1VupjryfZFfrpWoVLDW2e8FLxdFOBVFMy+Yz0bQFoPpK3dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321322; c=relaxed/simple;
	bh=d+U/DMyqrJmz9isk37XQbdH4HzIhR5FvXPZ0QF5sqY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRquVIpLwOtb7b/WeGGjO2w9h3++n1PmNYegxu42QSrnbX4EG9zoL4EnXe2Je/fA15yWexXEjIIjVBG4ASTKyTeRCLOKNWHEW3MGoZRx711o3msHEiHtaOKeZIn/v2NDyNi3QY9Hfyq7iAud/KCrzSWVrXxqcg8a+tFSiFoK25o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Twzad9vg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C18C433C7;
	Sun, 24 Mar 2024 23:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321322;
	bh=d+U/DMyqrJmz9isk37XQbdH4HzIhR5FvXPZ0QF5sqY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Twzad9vgCpbn4B4tDnjfnu3Dm3gbsZWpdo/APy2dduYh4YxKwnHNtKgAFsKXletYW
	 ukTJEp3TBIUNzGFwzRzlVHe0teEFJb2PxEQ6t4CAmfMUoN+BM2zRwrOnwC8fQQuAaS
	 ZYYf2ZW3XiAUIMS4E2ZPdzx9Izjgoy7AcuMiCyGd9ZxU6KEGhruFCuuJK1AtHqHnQ/
	 M4+DQeM/U84youIkK5mMFXZumNqMwGYS5zXQ3MANrxC3qqXz4jYFxqLizFtdOakeYS
	 MsQUcDIedAfN6/LEDPmf0POfPDUKf5vGhJe7FBNGkKGWhbh6MJ8Hs4mg7yY03sb7I6
	 jwdkyjQkh7b6w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andre Werner <andre.werner@systec-electronic.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 045/638] net: smsc95xx: add support for SYS TEC USB-SPEmodule1
Date: Sun, 24 Mar 2024 18:51:22 -0400
Message-ID: <20240324230116.1348576-46-sashal@kernel.org>
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

From: Andre Werner <andre.werner@systec-electronic.com>

[ Upstream commit 45532b21dc2a692444b6ad5f71c253cca53e8103 ]

This patch adds support for the SYS TEC USB-SPEmodule1 10Base-T1L
ethernet device to the existing smsc95xx driver by adding the new
USB VID/PID pair.

Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
Link: https://lore.kernel.org/r/20240219053413.4732-1-andre.werner@systec-electronic.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/smsc95xx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index a530f20ee2575..2fa46baa589e5 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -2104,6 +2104,11 @@ static const struct usb_device_id products[] = {
 		USB_DEVICE(0x0424, 0x9E08),
 		.driver_info = (unsigned long) &smsc95xx_info,
 	},
+	{
+		/* SYSTEC USB-SPEmodule1 10BASE-T1L Ethernet Device */
+		USB_DEVICE(0x0878, 0x1400),
+		.driver_info = (unsigned long)&smsc95xx_info,
+	},
 	{
 		/* Microchip's EVB-LAN8670-USB 10BASE-T1S Ethernet Device */
 		USB_DEVICE(0x184F, 0x0051),
-- 
2.43.0


