Return-Path: <linux-kernel+bounces-138290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 263DB89EF50
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAA601F2176F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9945F159201;
	Wed, 10 Apr 2024 09:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NLZqv/oX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778F01591E0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 09:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712742993; cv=none; b=HfxG8V1cs+LHjrPPAOAglbslAdeOQVamTxnfSz7+mohICtnlZ8Pxoe78rwZ3FUnIBK0MmR+7PSbsrJNGhHLOMX33Ci+zq5bltGZPq9/sqzsgFcKKbnWtc6UoxpJrWHwqEQGMoBDpdDE9O8KqD+37+1Fx9LVv/UJ+5dlUM8Ve+fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712742993; c=relaxed/simple;
	bh=6RyjuDcWsZO20Mdq+RG05EtCrq1VHou3GzobE5FL86k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tasjaK0UlGlgHVuGR4SvW1hxzJP2Ou9wGHDqdT1Do2bWwbbTmFzai6IwpIBLFEiy98ELYZeuQMVjfgKmuuY7Nwcx8ujVOq744egjj8V5DZVnuQ1TLk1qjkwg/EvUzocbSt4hyi463/kWfjZ/gy0Gh1UbSpIodLynaOF6Kdok4Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NLZqv/oX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712742990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GpBfMhS04qgT23TOMbDyVoHFEuB0U5xK3Cly3cM2U5g=;
	b=NLZqv/oXUNTYHKvmcGuXfhGk3KATpfAQ+uAdgkXtuFMMe9Z3lXlWAww8eB8bsoICS5N59R
	crJM0KLGIDDWMltuZOXYwqZf1Aqen4sqJdyEHAs5EaHxpUgxBsgdk6W1xA4KKa2XQYqJpp
	aDDxTr4mWrjFhcDlWySUP3FAq9pglHY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-LXAg-BT_NdmBkTKRCBGFEg-1; Wed,
 10 Apr 2024 05:56:24 -0400
X-MC-Unique: LXAg-BT_NdmBkTKRCBGFEg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80ECC1C4C381;
	Wed, 10 Apr 2024 09:56:23 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.244])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 170DA2166B34;
	Wed, 10 Apr 2024 09:56:19 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	stable@vger.kernel.org,
	Jarkko Palviainen <jarkko.palviainen@gmail.com>
Subject: [PATCH] net: usb: ax88179_178a: avoid writing the mac address before first reading
Date: Wed, 10 Apr 2024 11:55:49 +0200
Message-ID: <20240410095603.502566-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

After the commit d2689b6a86b9 ("net: usb: ax88179_178a: avoid two
consecutive device resets"), reset operation, in which the default mac
address from the device is read, is not executed from bind operation and
the random address, that is pregenerated just in case, is direclty written
the first time in the device, so the default one from the device is not
even read. This writing is not dangerous because is volatile and the
default mac address is not missed.

In order to avoid this, do not allow writing a mac address directly into
the device, if the default mac address from the device has not been read
yet.

cc: stable@vger.kernel.org # 6.6+
Fixes: d2689b6a86b9 ("net: usb: ax88179_178a: avoid two consecutive device resets")
Reported-by: Jarkko Palviainen <jarkko.palviainen@gmail.com>
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
 drivers/net/usb/ax88179_178a.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 69169842fa2f..650bb7b6badf 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -174,6 +174,7 @@ struct ax88179_data {
 	u32 wol_supported;
 	u32 wolopts;
 	u8 disconnecting;
+	u8 mac_address_read;
 };
 
 struct ax88179_int_data {
@@ -969,9 +970,12 @@ static int ax88179_change_mtu(struct net_device *net, int new_mtu)
 static int ax88179_set_mac_addr(struct net_device *net, void *p)
 {
 	struct usbnet *dev = netdev_priv(net);
+	struct ax88179_data *ax179_data = dev->driver_priv;
 	struct sockaddr *addr = p;
 	int ret;
 
+	if (!ax179_data->mac_address_read)
+		return -EAGAIN;
 	if (netif_running(net))
 		return -EBUSY;
 	if (!is_valid_ether_addr(addr->sa_data))
@@ -1256,6 +1260,7 @@ static int ax88179_led_setting(struct usbnet *dev)
 
 static void ax88179_get_mac_addr(struct usbnet *dev)
 {
+	struct ax88179_data *ax179_data = dev->driver_priv;
 	u8 mac[ETH_ALEN];
 
 	memset(mac, 0, sizeof(mac));
@@ -1281,6 +1286,9 @@ static void ax88179_get_mac_addr(struct usbnet *dev)
 
 	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_NODE_ID, ETH_ALEN, ETH_ALEN,
 			  dev->net->dev_addr);
+
+	ax179_data->mac_address_read = 1;
+	netdev_info(dev->net, "MAC address: %pM\n", dev->net->dev_addr);
 }
 
 static int ax88179_bind(struct usbnet *dev, struct usb_interface *intf)
-- 
2.44.0


