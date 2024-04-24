Return-Path: <linux-kernel+bounces-156081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CFC8AFDAA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E12391C22543
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C8363D0;
	Wed, 24 Apr 2024 01:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CTsCqJ1X"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E12C5234;
	Wed, 24 Apr 2024 01:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713921348; cv=none; b=IvoVRgmBsDo06iN3XMWFauDVZ1cNQFaeFDvVckZEIbngre8XvKlLHsUbaZUZUu46uKvPairq98jshc8u1K4zjFi5XSkJEpEI7V7XBFbdtDxYGLpIWHhAHo1zNh5ZQX1qAkJLguTAQyYSeCCMSs1Q8q9Zp9I9l8ANKqNWVT5PIow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713921348; c=relaxed/simple;
	bh=6nOVtPzgwQ8YMGQdQlvdl4yzO0Qvhp4OZfO85QQ1eq8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qjKAG9+0oHVryJQb1oux4k/UMuDNBjktw2S8KwnTq6WbHLVlSzDPYbVtFLwl//qwhHeNG04F7t9/DWgYsMx4mS3wGHpLo5Yt3uSAqAyfR5LWLPemWL918CbeMf8ae7HhO+B1kbFvhxhrh9FMv7C8+BDmXQVg796ezmqVVcnK/6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CTsCqJ1X; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=HHXPX
	+9pagfvs8TsZYD/xEDVCaqlvLs2udxkw/6oAz8=; b=CTsCqJ1XpWM4rTRmxtZpj
	KXM3/Nqx3UIDEoACWaS7tMUFmWx2md+ivJAHasSNZsAWLiUL0KThSyX7tMgfGApj
	SFpTYAQFnrxNttROesb3Oc7oX2lB60rwqFOq7auwvBKNpQmIfd9UwbE22tcuy6hm
	X3f4r4B/DPzTBofUmxVy14=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wDHbwoQXShmsiBKBA--.58725S4;
	Wed, 24 Apr 2024 09:15:09 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jtornosm@redhat.com,
	andrew@lunn.ch,
	horms@kernel.org,
	hkallweit1@gmail.com,
	make_ruc2021@163.com
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: usb: ax88179_178a: Add check for usbnet_get_endpoints()
Date: Wed, 24 Apr 2024 09:14:54 +0800
Message-Id: <20240424011454.1554088-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHbwoQXShmsiBKBA--.58725S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruw4rZw1ktFyrZF1rKF4UJwb_yoW3urg_u3
	Z7Gwn3WF4jgF18Xr1DKw4avrW3Kan7X3Z7ZFs3t3sIqa4YqFn8Jrn2vrsxC3Z7WF4YvFnr
	Cwn2kFy3JryDKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNvtCUUUUUU==
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBFR-KC2XAlIm+TgAAsD

To avoid the failure of usbnet_get_endpoints(), we should check the
return value of the usbnet_get_endpoints().

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/net/usb/ax88179_178a.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 752f821a1990..cf8d19584725 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1288,7 +1288,9 @@ static int ax88179_bind(struct usbnet *dev, struct usb_interface *intf)
 {
 	struct ax88179_data *ax179_data;
 
-	usbnet_get_endpoints(dev, intf);
+	ret = usbnet_get_endpoints(dev, intf);
+	if (ret < 0)
+		return ret;
 
 	ax179_data = kzalloc(sizeof(*ax179_data), GFP_KERNEL);
 	if (!ax179_data)
-- 
2.37.2


