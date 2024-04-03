Return-Path: <linux-kernel+bounces-129823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A378970C4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81F10B25FDD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75871487DD;
	Wed,  3 Apr 2024 13:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QH20x8O+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA54147C78
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150553; cv=none; b=pMEItVZ5AxnbQPwykqIBPrcWP5fnWA5chgodECKOC8QenjB/sRKQlUquRmJDEfjF6Meq7CL7HCbk0QeyBB5ElWsGUzRNzb+4clfM/LMQydZ7fIRki+Xb9a3+V0AexVhALip44hlUEeICFS7OUQDGd2JSGrXpcAwkACzcrrrwxI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150553; c=relaxed/simple;
	bh=Ndo6P4HXNk96m/JcjQ34cszq64ka8Y455qTX/uidaYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGo/jIKik4u6wPL88GLg76mOAybQSE7jrX4LEVAn399K/yhY88FQbPA1cCDeNtFKvpOnP/007bx4JHW74SQvolnWfsZvMhcRHmdXiOKsUgBzOHJHzWviS8XgmdMsJ/LLsjdOBLVMXLQypzP+Oacp8JlCSbGcQMeX6yWu25PniYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QH20x8O+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712150550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dJ3UUYfcQXqpkSvDCxCPnIRZI5MZIhj3p32tJhiB3ew=;
	b=QH20x8O+gjMtfGT023PQmi5NvmIuQQQ0Q7qI1aY6VyjLW+bkhHOYMuE0qRtBPNLcyca2BM
	Sba677sj3wyN7v3cdYzFyy7zUBCxPjVJCLsYV8ig/lVWpFox2rFT+UtcqPB3H7V8LZz//K
	6TQ+V5rgokIgd323kEKQnATRszDKAxE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-FUKu-y2CPpeDhkvIOXQXbw-1; Wed, 03 Apr 2024 09:22:27 -0400
X-MC-Unique: FUKu-y2CPpeDhkvIOXQXbw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0742988CC47;
	Wed,  3 Apr 2024 13:22:27 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.197])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2AB904073599;
	Wed,  3 Apr 2024 13:22:23 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: kuba@kernel.org
Cc: dave.stevenson@raspberrypi.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jtornosm@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org
Subject: [PATCH net v4] net: usb: ax88179_178a: avoid the interface always configured as random address
Date: Wed,  3 Apr 2024 15:21:58 +0200
Message-ID: <20240403132158.344838-1-jtornosm@redhat.com>
In-Reply-To: <20240402183012.119f1511@kernel.org>
References: <20240402183012.119f1511@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

After the commit d2689b6a86b9 ("net: usb: ax88179_178a: avoid two
consecutive device resets"), reset is not executed from bind operation and
mac address is not read from the device registers or the devicetree at that
moment. Since the check to configure if the assigned mac address is random
or not for the interface, happens after the bind operation from
usbnet_probe, the interface keeps configured as random address, although the
address is correctly read and set during open operation (the only reset
now).

In order to keep only one reset for the device and to avoid the interface
always configured as random address, after reset, configure correctly the
suitable field from the driver, if the mac address is read successfully from
the device registers or the devicetree. Take into account if a locally
administered address (random) was previously stored.

cc: stable@vger.kernel.org # 6.6+
Fixes: d2689b6a86b9 ("net: usb: ax88179_178a: avoid two consecutive device resets")
Reported-by: Dave Stevenson  <dave.stevenson@raspberrypi.com>
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
v4:
  - Add locally administerd address check as Jakub Kicinski suggests
v3:
  - Send the patch separately to net.
v2:
  - Split the fix and the improvement in two patches as Simon Horman
suggests.
v1: https://lore.kernel.org/netdev/20240325173155.671807-1-jtornosm@redhat.com/

 drivers/net/usb/ax88179_178a.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 88e084534853..a9c418890a1c 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1273,6 +1273,8 @@ static void ax88179_get_mac_addr(struct usbnet *dev)
 
 	if (is_valid_ether_addr(mac)) {
 		eth_hw_addr_set(dev->net, mac);
+		if (!is_local_ether_addr(mac))
+			dev->net->addr_assign_type = NET_ADDR_PERM;
 	} else {
 		netdev_info(dev->net, "invalid MAC address, using random\n");
 		eth_hw_addr_random(dev->net);
-- 
2.44.0


