Return-Path: <linux-kernel+bounces-156434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2AF8B02C3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18F89B23AFF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8C6158855;
	Wed, 24 Apr 2024 06:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AukXqEkZ"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA497157499;
	Wed, 24 Apr 2024 06:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941858; cv=none; b=Lj2PhLk25r9kDzYzNm/Jo0AJC2RaMtLfLy2UpTR9VwBDwmaIILa5UeQFdojZcPkttXL3aRcRv0MUYUQFQh6/icntoNjw5UCWErKPuW8JYrsMedwpD9Jx0MGTVxTXApQmu4SC1JvtLRFeTkH4K+1XDhbQCqUlXm03cHli3HCOAsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941858; c=relaxed/simple;
	bh=4M75hS8XdGgB27pG91ABOzG8oYFy2pFxUFNJPq7UJVI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=noAeInJdrzC4ddKq8kdUR20xke6Sp5w/XnJtuB+n49YzXXPL5eCQ0Vsrr84peajgJk36CtyYiLK013I+UpXlnd/UeDBUALnppr+rEMVlHlgV1fzz/ZtcoACcWDr///Skdt5q+uA1rUaX0J7SXYadwWALcjaW1gHgE5cjJN1D8y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AukXqEkZ; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=DjKTL
	b/Hzmerf/tiPBtGXwro+rqebqKp1eua6xwlMow=; b=AukXqEkZJzqCCQMAJju49
	Ub8DdX3+R54S7e66piVwKAJXSVYYcblIlUMhfHVKozDGL2PQJFm+N2g2B/EaR0Pm
	Iv0vZciMqIPLRFakNzhSvBeJ1ij8kSSgLyX6hkTM1+/TErpxjwvDdrZvTG5ZQNkX
	eeRQ19PZw7izp9vnLN9HaI=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by gzga-smtp-mta-g2-3 (Coremail) with SMTP id _____wDnFz0krShmD3q+CA--.62207S4;
	Wed, 24 Apr 2024 14:56:56 +0800 (CST)
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
Subject: [PATCH v2] net: usb: ax88179_178a: Add check for usbnet_get_endpoints()
Date: Wed, 24 Apr 2024 14:56:34 +0800
Message-Id: <20240424065634.1870027-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnFz0krShmD3q+CA--.62207S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruw4rZw4UAFy7GrWDury8Xwb_yoWfWrb_u3
	Z7Gwn7Wr4jgF48Wr4DGw4avrWfKa1kXwn7uF4kK3sIq3WYq3WDJrn2vrnxC3Z7WF40vFnr
	Cw1qyFy3JryDtjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNvtCUUUUUU==
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBFRTKC2XAlI2PswABsB

To avoid the failure of usbnet_get_endpoints(), we should check the
return value of the usbnet_get_endpoints().

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/net/usb/ax88179_178a.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 752f821a1990..388ea178c91d 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1287,8 +1287,11 @@ static void ax88179_get_mac_addr(struct usbnet *dev)
 static int ax88179_bind(struct usbnet *dev, struct usb_interface *intf)
 {
 	struct ax88179_data *ax179_data;
+	int ret;
 
-	usbnet_get_endpoints(dev, intf);
+	ret = usbnet_get_endpoints(dev, intf);
+	if (ret < 0)
+		return ret;
 
 	ax179_data = kzalloc(sizeof(*ax179_data), GFP_KERNEL);
 	if (!ax179_data)
-- 
2.37.2


