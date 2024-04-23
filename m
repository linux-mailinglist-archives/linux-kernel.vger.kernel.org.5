Return-Path: <linux-kernel+bounces-155063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D938AE4E3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DF72283179
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD76914534C;
	Tue, 23 Apr 2024 11:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ns0oWUgg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B8D14532E;
	Tue, 23 Apr 2024 11:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872488; cv=none; b=hEl/TyC/0esThrI9ZHaU3mAIAOUuO2WwDv74c+OMOfcd7I61tqGOamgWjCFqzSS30YdYlV7fKDi0lGq82ljMOw+mW02RD631pAHJ+HJ9XfEeJ67EkLXDIV0HhyQ8/oYsed6Q+1JiGuce3H3bMg6N40hmTCqvj4fLzalMv3+Etv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872488; c=relaxed/simple;
	bh=QvuDtT/UQwH/5ufRNQ79iiYTf4SWrf4R8+VzQmS231g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzzUzLNdaHt5LLCkCJhQ6v5AChPhTyqnGpAXLHhIBXzgw1K5LsMT+DQIX0FeXNowsLMYguues+i0y93dJ1k+dqbXEPtBVASYKhoO+5rRGON9Q870XcJNKMOp3T63p1uQ1XlHOeCixnyM8DFqF/m4tasT25D9XKz36Qy62bVP5os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ns0oWUgg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5C0C32782;
	Tue, 23 Apr 2024 11:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872487;
	bh=QvuDtT/UQwH/5ufRNQ79iiYTf4SWrf4R8+VzQmS231g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ns0oWUggEyZaEmV70knn5izZ810YMAAqNr9yiPt5Q/ZVytbAoR9EENxley+FptjMw
	 t4U9vR5CcyRZOeAFRvX1rpw+WMJ+B2Z9EO9zwzZyTl2B/yR/RPGK2B6nTdO2xTQJef
	 vAdreWitout/Flh9dvZ5qEp5qPOf901mO6s1v/gP61ipB1eACE59Lr6fykg/px2rjc
	 wBylicL6dzmTKPsmyZ+Yns47r8oueVEPHNPDMts0YexhraN97Pcngfj4ZTH4BeyqWO
	 /ROS2jK9g113vXn+mbN1X2354s0FcZ8TTz/WjXefkYUGIZv6eNbB9fM71LdifKZQOC
	 BOVmdUfglw2dA==
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
Subject: [PATCH AUTOSEL 5.15 9/9] net:usb:qmi_wwan: support Rolling modules
Date: Tue, 23 Apr 2024 07:02:31 -0400
Message-ID: <20240423110233.1659071-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110233.1659071-1-sashal@kernel.org>
References: <20240423110233.1659071-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.156
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
index 846ace9830d3b..89e1fac07a255 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1419,6 +1419,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x0489, 0xe0b5, 0)},	/* Foxconn T77W968 LTE with eSIM support*/
 	{QMI_FIXED_INTF(0x2692, 0x9025, 4)},    /* Cellient MPL200 (rebranded Qualcomm 05c6:9025) */
 	{QMI_QUIRK_SET_DTR(0x1546, 0x1342, 4)},	/* u-blox LARA-L6 */
+	{QMI_QUIRK_SET_DTR(0x33f8, 0x0104, 4)}, /* Rolling RW101 RMNET */
 
 	/* 4. Gobi 1000 devices */
 	{QMI_GOBI1K_DEVICE(0x05c6, 0x9212)},	/* Acer Gobi Modem Device */
-- 
2.43.0


