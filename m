Return-Path: <linux-kernel+bounces-132648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9778997BA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FFB41F22C17
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C39146A74;
	Fri,  5 Apr 2024 08:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RmGv+mTD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD0B13D53E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 08:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712305489; cv=none; b=G8hdjgETtleurTmiCuNK2YWAkZzLh+4docfbaOgOKK8C3qj0+ka3BM5s7Dv1D4QwllfPRlDGKx7f6rdLJTDxaPRpiPJsmiCqPXuLmCCmjWV599faL3JPDZWFrZLgkiPiie3QqLJ5MgjGO632TnBwHSjhFKuGDmh9+LjMe7Zaz1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712305489; c=relaxed/simple;
	bh=2L3CGX7OqkPmTsK6TECnNjWBwH73l9NqbMPNMtYIP0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYPRYnFYCYLugJyVKcMZZrezvDpujQg3kBDRwBnTHuC2PktDqZnhgc58fMdmqpmLbzhxOaOR0CACjTBk6yjXniltGZtR63eZ7OlDO97NJebXaK2ktHvHBkvk3EHxePZtJs/AxBcl3ZUszJhRzMvUrjO7STSQQyvUghclHnJ8so8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RmGv+mTD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712305486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C5I/NTVTKh0Md5yW/gn8T1xGvsFGQXYIProl8xxAsRQ=;
	b=RmGv+mTD7UoxUrlYKeVOFTqNI2dMG+dreR4iOlkoJoofkh7VpYnP9Fkh+N9YYG5cAYCpM8
	pyRQBntjfXchHgqXvJvHcI9zUI+7N3fnlw8Vft0F4A/EimigWscyHMFEYBgcv5yXGRW2OX
	tcI0GQkqVCtRVfFAMgfcDzC/CJuQpbc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-Gyk7UQUqN5SvoK_fJKmb7A-1; Fri,
 05 Apr 2024 04:24:42 -0400
X-MC-Unique: Gyk7UQUqN5SvoK_fJKmb7A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DAB481C0432F;
	Fri,  5 Apr 2024 08:24:41 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.88])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8E448111F3C6;
	Fri,  5 Apr 2024 08:24:39 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jtornosm@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v4] net: usb: ax88179_178a: non necessary second random mac address
Date: Fri,  5 Apr 2024 10:24:31 +0200
Message-ID: <20240405082431.8329-1-jtornosm@redhat.com>
In-Reply-To: <20240402183237.2eb8398a@kernel.org>
References: <20240402183237.2eb8398a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

If the mac address can not be read from the device registers or the
devicetree, a random address is generated, but this was already done from
usbnet_probe, so it is not necessary to call eth_hw_addr_random from here
again to generate another random address.

Indeed, when reset was also executed from bind, generate another random mac
address invalidated the check from usbnet_probe to configure if the assigned
mac address for the interface was random or not, because it is comparing
with the initial generated random address. Now, with only a reset from open
operation, it is just a harmless simplification.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
v4:
  - Context diff due to first patch modification.
v3:
  - Send the patch separately to net-next and remove fixes and stable tags.
v2:
  - Split the fix and the improvement in two patches and keep curly-brackets
as Simon Horman suggests.
v1: https://lore.kernel.org/netdev/20240325173155.671807-1-jtornosm@redhat.com/

 drivers/net/usb/ax88179_178a.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index a9c418890a1c..69169842fa2f 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1277,7 +1277,6 @@ static void ax88179_get_mac_addr(struct usbnet *dev)
 			dev->net->addr_assign_type = NET_ADDR_PERM;
 	} else {
 		netdev_info(dev->net, "invalid MAC address, using random\n");
-		eth_hw_addr_random(dev->net);
 	}
 
 	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_NODE_ID, ETH_ALEN, ETH_ALEN,
-- 
2.44.0


