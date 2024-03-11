Return-Path: <linux-kernel+bounces-99094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4810487835E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 799411C2165A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B9F626BC;
	Mon, 11 Mar 2024 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6PEyWbJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A2761688;
	Mon, 11 Mar 2024 15:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170040; cv=none; b=Ntr+mZvZYIzC1O91RaVNs9tFn1aHc+I7TpSJv7M134EzcD2wRvhSjqX8N5vtI6T661Ukk40rX2p5qQRZeXVPc6CFyw4dguqIqJXGdwIHNmQyrO1XpOI6NqOIabpprFHouUFCFQ9EQTOsRycVtNSJta+XUYyX6t/lpig/QL3sxB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170040; c=relaxed/simple;
	bh=d+U/DMyqrJmz9isk37XQbdH4HzIhR5FvXPZ0QF5sqY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IdeFK+dVSlYHqPo9XFOh4Rg5yB9UURzLsfa3ikQ39ySyfB9DWZZ4lKuZQWI74sPagYz7PNemYYmz/wXXpobMWDGAgzWKWZW+P31EL2TIp7f4MlwxKgTSS+dqH8sg8z9/mjsSJnsIqsAM4t6AvPd2cA4/cSgiv3/znI24Uh98lGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6PEyWbJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0852DC43330;
	Mon, 11 Mar 2024 15:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710170040;
	bh=d+U/DMyqrJmz9isk37XQbdH4HzIhR5FvXPZ0QF5sqY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E6PEyWbJnpkW518898zpXHAWfk5m0ttcshw0gbfxfnqWnt7R6lWs/IJ3JK1FbGET4
	 KHcigW+9ToppGQidRx45F9uTMOI5GuW+3hZxliV3h5iGa8lHxIR/HIeCVdztNCDHok
	 w+eYZDlPG/FAp4hYqfu3pOCTlOda5XHuhJc1I/xiLvQNPrShBhYce0fXqWgHkLprSS
	 lkra5trbWfc/RAr4PtT5BIBRhI3M5jQYIZsiiQowYeJrGt1YcnLUKisBhPILZV22lB
	 yEoh3zhEVRLyV06stlyK4ae4t3pQZ+nWXhWxde0SR7eunt/y6NiHxWb8Jj0i8Lze7E
	 hQPIkmjtJfTrA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andre Werner <andre.werner@systec-electronic.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	steve.glendinning@shawell.net,
	UNGLinuxDriver@microchip.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 03/13] net: smsc95xx: add support for SYS TEC USB-SPEmodule1
Date: Mon, 11 Mar 2024 11:13:38 -0400
Message-ID: <20240311151354.318293-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151354.318293-1-sashal@kernel.org>
References: <20240311151354.318293-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.81
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


