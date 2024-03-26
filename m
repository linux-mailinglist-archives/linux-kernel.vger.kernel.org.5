Return-Path: <linux-kernel+bounces-119464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A37F688C953
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596141F67BA0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE7D80C1F;
	Tue, 26 Mar 2024 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LIeAnMnK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB14613CF8B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470605; cv=none; b=tKRb5skIOa/8uK3p+6b+8hX+CSFqeRgX06+Sv4V01UNDtuLsTFhSNCUbor+KtB6vSWR6yr9VYstq4BfzKIRAgonoL882TpVMNsV+WeXYJwcHyhxy/4NTG8onaD65s52KkkREisu4yJA1ZQcAmcXpzK43yWVXQxWDdAD86dydmCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470605; c=relaxed/simple;
	bh=rjSUXjjrKiWdU5sbS7+AjRgyC6HxieupC43ocaHS1/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOqNyWQVUN+AdcQfBVUB0Z/NUmnPz8ijul/QQb9tbhkRLQEu65nOv3dTA0TEU/JRHKn7CkxDHQxiNQPoN0xDRVydHGFlrvkb8h31lw5by4XAGIO6E1+c46cdxsg4AM9pr2GA3mkfVnMT1nRghxGKkuCiBb/tQxsxanDVPqHmw5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LIeAnMnK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711470602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7eFdufef3zYONep2oCLblhXQDLYYjXipt4Q1WaXEK5M=;
	b=LIeAnMnKMqVjUKY3cRwREryKPuGByqtfgVVr0nGDaQd4VKZGcsxzrMmZjDBH/fCTQHaWpZ
	NAWPPzXy7ZQew3C4TdBxQ1ZKtgLXwYOHzFLI3+vwHMy0CbYuO73jn5GtqHC87dDab3htkd
	BDphcfXoz8ajOKbXs4eAN/1MjeBoj38=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-okaYP1U4PZu-9kpR-wRCZA-1; Tue, 26 Mar 2024 12:29:57 -0400
X-MC-Unique: okaYP1U4PZu-9kpR-wRCZA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B465380F7E3;
	Tue, 26 Mar 2024 16:29:56 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.147])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D056A1C060D4;
	Tue, 26 Mar 2024 16:29:53 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: horms@kernel.org
Cc: dave.stevenson@raspberrypi.com,
	davem@davemloft.net,
	edumazet@google.com,
	jtornosm@redhat.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] net: usb: ax88179_178a: avoid the interface always configured as random address
Date: Tue, 26 Mar 2024 17:29:43 +0100
Message-ID: <20240326162943.306577-1-jtornosm@redhat.com>
In-Reply-To: <20240326092459.GG403975@kernel.org>
References: <20240326092459.GG403975@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

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
the device registers or the devicetree.

cc: stable@vger.kernel.org # 6.6+
Fixes: d2689b6a86b9 ("net: usb: ax88179_178a: avoid two consecutive device resets")
Reported-by: Dave Stevenson  <dave.stevenson@raspberrypi.com>
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
V1 -> V2:
- Split the fix and the improvement in two patches as Simon Horman
suggests.

 drivers/net/usb/ax88179_178a.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 88e084534853..8ca8ace93d9c 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1273,6 +1273,7 @@ static void ax88179_get_mac_addr(struct usbnet *dev)
 
 	if (is_valid_ether_addr(mac)) {
 		eth_hw_addr_set(dev->net, mac);
+		dev->net->addr_assign_type = NET_ADDR_PERM;
 	} else {
 		netdev_info(dev->net, "invalid MAC address, using random\n");
 		eth_hw_addr_random(dev->net);
-- 
2.44.0


