Return-Path: <linux-kernel+bounces-126520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E2B893904
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F7D1F21771
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC318D30B;
	Mon,  1 Apr 2024 08:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WF5Hy5Rd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B7BB671
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 08:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711960084; cv=none; b=QN3r8oUbUUVMvXKSyWzEQvktu0pGTePsMgLaSjryXDYvk6TlSA1vNyJMFUXjyeNYKXlehTLE2YnADmJliZo6IJLJSeioFdsnqahayT1BSYLMMoPYNa1/yNAnbNSFkcjxOP/PgAXLGVvrXwInLZLX8rWRYeS7J9lQdqQZ4oCynkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711960084; c=relaxed/simple;
	bh=agXxZwKpjsRdYdSSi+1mbrytFe5+985cFwiZHMvbFRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VytWjD5jU6JczaYlw6zK9DqQh/DiyLtUhLO3sMm8An3VhOMdrLPZJcz6to5w7t2awQDYiKo0aVWejuWBQ7s1gXiWm4UCpeEOuXkcZSTx8XudXYNL/TDXDC2bzVIly9dRL2zOQFauC4hmltlsEZLw3akEGN/oixICG6nI+ZFS0J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WF5Hy5Rd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711960081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tSr/lVIfIGvT1+aJOWWnrxhQC1YOeeTlOj48kgZP5e0=;
	b=WF5Hy5Rdvz5YP5j+O3rzGS5krBrMWEh7Pse4E+Zs/8Vt2/kGJYGcN+eopoDjvf0Uas+Ymp
	ciaLca7cKVm32lLiiJth4Ztu0yoxKuqga9fVMIa2FdyXCtzRLC38Dwl1j4PHN1Tvmh5WlT
	jGamoUIM9Jie4QfvOPJKaeWYN5b4VrU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-3vQyGHplM3Gu5U3S2v6uwg-1; Mon,
 01 Apr 2024 04:28:00 -0400
X-MC-Unique: 3vQyGHplM3Gu5U3S2v6uwg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C26F3802124;
	Mon,  1 Apr 2024 08:27:59 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.124])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1B11C112C5;
	Mon,  1 Apr 2024 08:27:56 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: horms@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH net-next v3] net: usb: ax88179_178a: non necessary second random mac address
Date: Mon,  1 Apr 2024 10:27:25 +0200
Message-ID: <20240401082746.7654-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

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
v3:
  - Send the patch separately to net-next and remove fixes and stable tags.
v2:
  - Split the fix and the improvement in two patches and keep curly-brackets
as Simon Horman suggests.
v1: https://lore.kernel.org/netdev/20240325173155.671807-1-jtornosm@redhat.com/

 drivers/net/usb/ax88179_178a.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 8ca8ace93d9c..08c9b2ab9711 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1276,7 +1276,6 @@ static void ax88179_get_mac_addr(struct usbnet *dev)
 		dev->net->addr_assign_type = NET_ADDR_PERM;
 	} else {
 		netdev_info(dev->net, "invalid MAC address, using random\n");
-		eth_hw_addr_random(dev->net);
 	}
 
 	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_NODE_ID, ETH_ALEN, ETH_ALEN,
-- 
2.44.0


