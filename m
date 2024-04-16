Return-Path: <linux-kernel+bounces-146748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C338A6A42
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71651F21A5E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F6812AAC6;
	Tue, 16 Apr 2024 12:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oTToowc7"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416B912A152;
	Tue, 16 Apr 2024 12:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269290; cv=none; b=YGmPdp/j0XWKL5+k8VzvdvGiIw3PyVe2qUaTX3m1pNl4/0qtxPrSYZVnmbYzqrj5b0r8M3hR7YKidFF/57kOsskOS7NucKtqm3ApMG4RD8OsPKRASA9+xFnXaZuDO0E0faCiGRdpWdJ9Q8RYl9xxi+XkqNnSrMJbxAAYQImtjQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269290; c=relaxed/simple;
	bh=IAHSnrcKlcI8ozUz5u3hnsd15J+T6mwYexmmNVoCE8U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tlSIYkLOfG3TxmINl/rsuxY3nP2hYBUuUv6Swrsz3LzrZbkmIZdFb73ClX35uOUWV5W9WXvs+A61zTy1GMgpuo4rv3R4gEWOsg+DTOALgbw7CnUCea9Bwr+cP3HAq8r1M9u/qq1+8gg5ABOVuoKSe7eqnYWwyO0ORNzKNn+J79k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oTToowc7; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=If8AF
	FWxkDIUWXQPk3YZpE9a/mxnoJ4QeoIijjT/Lrg=; b=oTToowc7t04fDfWi6RkN3
	5T16wdYInp9nDcNJAIwSBNghByTLSG0OrhM+tIF63A8PwXidISn8dWfpD+0Yitl/
	2sLpCS8YPZW92+pc9DkFQAs0mydDCUdeWF/darGHWFuCzQdvtr1WnZB9wqtoYzvf
	O9/xUylc635/Gx6FIJ4wqM=
Received: from smtp.163.com (unknown [124.89.89.114])
	by gzga-smtp-mta-g1-4 (Coremail) with SMTP id _____wDntzTyaR5mIlBKBQ--.22456S4;
	Tue, 16 Apr 2024 20:07:15 +0800 (CST)
From: Vanillan Wang <vanillanwang@163.com>
To: bjorn@mork.no,
	davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vanillan Wang <vanillanwang@163.com>
Subject: [PATCH] net:usb:qmi_wwan: support Rolling modules
Date: Tue, 16 Apr 2024 20:07:13 +0800
Message-Id: <20240416120713.24777-1-vanillanwang@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDntzTyaR5mIlBKBQ--.22456S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrW8tF18Kr4xXw17WFy7trb_yoW5JF4kpa
	17Ga1fXF1rJF1Yk3ZIkF1xZaySq3Z7Wr12ka4UX3ySqFWxArs7Gr1YvrZ7Wr1q9r40yF4v
	qayDG3y8GF93GFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UDnYwUUUUU=
X-CM-SenderInfo: pydqxz5odq4tlqj6il2tof0z/1tbisgXCUmVOCw5ovQABsd

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
---
 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index e2e181378f41..edc34402e787 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1431,6 +1431,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x2692, 0x9025, 4)},    /* Cellient MPL200 (rebranded Qualcomm 05c6:9025) */
 	{QMI_QUIRK_SET_DTR(0x1546, 0x1312, 4)},	/* u-blox LARA-R6 01B */
 	{QMI_QUIRK_SET_DTR(0x1546, 0x1342, 4)},	/* u-blox LARA-L6 */
+	{QMI_QUIRK_SET_DTR(0x33f8, 0x0104, 4)}, /* Rolling RW101 RMNET */
 
 	/* 4. Gobi 1000 devices */
 	{QMI_GOBI1K_DEVICE(0x05c6, 0x9212)},	/* Acer Gobi Modem Device */
-- 
2.34.1


