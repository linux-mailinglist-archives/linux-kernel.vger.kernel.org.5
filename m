Return-Path: <linux-kernel+bounces-155072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C488AE4FD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BCA81F23751
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1BD14885C;
	Tue, 23 Apr 2024 11:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diWhzlFy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27D414883C;
	Tue, 23 Apr 2024 11:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872504; cv=none; b=MG7rDEQ7E/UVZyRfWuRQVgJ7elo2BUkrs0fJOe8JgL7nGIPXGeFKH5sOoUwrZ5NzAs0SPOGJ7o5gPqOSKg+633zBnRFAXAVKnVlMtXJL+XyFWQI61e4+ddb/796Tns9/Foicg2PzaPIdzYV3Wo6I/0vVfMK0OaiHJvPhKuIcSFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872504; c=relaxed/simple;
	bh=2CXFvEBh+79qRy6bDr6kpfO2wkmH7cn0aOJtpV1LBEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLWWmrVZuWHxgJHTpT8o8MCST89slFncvZdmhQk226e0KnIj7BtnRfUbpGMZMjkMB8zkzS2mvHQAxO4JYJ7Ji0Yo1ijrYJyJ9ibcqBRfuLvM0/BV4Xa4bKj+u8xJerVe5af1LW9EMqusajOAYRgqGxqPLlfnBrrqqkLLNWFO2c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diWhzlFy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7FA5C116B1;
	Tue, 23 Apr 2024 11:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872503;
	bh=2CXFvEBh+79qRy6bDr6kpfO2wkmH7cn0aOJtpV1LBEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=diWhzlFy5/ix5P/pfmWoU4jGRP50AWDn0+vIMObmYQGbgRym0C8PuErK+tTzBfR/C
	 0RzMttUDMll9dUQOyGtgSGpvr8wGZ3lzOt61TR5EjLtOJ8L3ubFMQXvQW6HOks1uv1
	 cYYxBMAnkgX0WsXBxGMsTLZKNqY/y57JWia4ZArOXOkmkjnvSbSyDAzm0Gbwkt7HYk
	 7b0fJsrikhz31DB0GwNMmmkrbxl3VCO/faTkAI6JIqzWaiBZJi4sX7Xxhl1kvZTHRV
	 k8GK636iPQkKI75EdFcqX1oXjFz0+qV0W4Yn4lcoDGU1EdUBXQ5umwHXVRZWd38Jgj
	 TEnMD4QlHrGZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vanillan Wang <vanillanwang@163.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	bjorn@mork.no,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 9/9] net:usb:qmi_wwan: support Rolling modules
Date: Tue, 23 Apr 2024 07:02:47 -0400
Message-ID: <20240423110249.1659263-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110249.1659263-1-sashal@kernel.org>
References: <20240423110249.1659263-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.215
Content-Transfer-Encoding: 8bit

From: Vanillan Wang <vanillanwang@163.com>

[ Upstream commit d362046021ea122309da8c8e0b6850c792ca97b5 ]

Update the qmi_wwan driver support for the Rolling
LTE modules.

- VID:PID 33f8:0104, RW101-GL for laptop debug M.2 cards(with RMNET
interface for /Linux/Chrome OS)
0x0104: RMNET, diag, at, pipe

Here are the outputs of usb-devices:
T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=5000 MxCh= 0
D:  Ver= 3.20 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
P:  Vendor=33f8 ProdID=0104 Rev=05.04
S:  Manufacturer=Rolling Wireless S.a.r.l.
S:  Product=Rolling Module
S:  SerialNumber=ba2eb033
C:  #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=896mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=01(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=84(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=40 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=86(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
E:  Ad=0f(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=88(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
E:  Ad=8e(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:  If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=usbfs
E:  Ad=05(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=89(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms

Signed-off-by: Vanillan Wang <vanillanwang@163.com>
Link: https://lore.kernel.org/r/20240416120713.24777-1-vanillanwang@163.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 3d342908f57a0..be2761d0bcd91 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1358,6 +1358,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x0489, 0xe0b5, 0)},	/* Foxconn T77W968 LTE with eSIM support*/
 	{QMI_FIXED_INTF(0x2692, 0x9025, 4)},    /* Cellient MPL200 (rebranded Qualcomm 05c6:9025) */
 	{QMI_QUIRK_SET_DTR(0x1546, 0x1342, 4)},	/* u-blox LARA-L6 */
+	{QMI_QUIRK_SET_DTR(0x33f8, 0x0104, 4)}, /* Rolling RW101 RMNET */
 
 	/* 4. Gobi 1000 devices */
 	{QMI_GOBI1K_DEVICE(0x05c6, 0x9212)},	/* Acer Gobi Modem Device */
-- 
2.43.0


