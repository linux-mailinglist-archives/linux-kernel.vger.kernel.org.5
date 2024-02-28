Return-Path: <linux-kernel+bounces-85095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6F086B060
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BD511F28255
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D7814D420;
	Wed, 28 Feb 2024 13:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZC/kXNJ5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D7B1E493
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127067; cv=none; b=DeEQ8AfsZ/7GEI/BJtezRamm0+pZcW0gy1w2QN9K8FNkpqTo5LddCW/9/3Edx2JmDmu/1UUqQJ3ervz6b1s1ICNOY98WqI+yspFDsws8qNd5QHm0PBSLCr8RSZz4J1B1txqukfbsjyddosCpsJ4b6Prydx9rZ1hLxOaHN9Evdok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127067; c=relaxed/simple;
	bh=3VQZtPFFjJ6KMik5qwmu9RFH9g6RLd3eRx0NWCx6Qko=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Fnr4P9ejRxI/VruD1cqPVE4BfkJXMluqHt9j4+4cGYQd9dQIAfJztG2TyLeOVN4/UpJQ5p0vZHb3/md/86EAVa5x8ckN4j4rPj+XIVHkC0Q8xgz6Rg1oxNk8gvXUpq0hZ4k7Lds7adrM4DA3uRiwdCRIiTpRe3Km9M1Qc6Ji6kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZC/kXNJ5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709127063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=mYhUY0xj59xhvUYFGeVBejeoiizOAuL7jH7HPYGmaLI=;
	b=ZC/kXNJ5NUV/Ec4C2J2EV0+HAV1fdM5L/N11qkgCz1Dfsa97q0MCxqHSdxWoBaCfTyN2PZ
	FY3Rv31J4gtv0w6JWY04NcTEy5N4aPKcopvINjCUkVXwI7C+/oDiXa0zemdo3933+nbOXl
	6yEtUEmR9e5H4h/JktfgEvZRKjMoS2Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-aBSN9Oe7P5W_Su_A28IPow-1; Wed, 28 Feb 2024 08:31:01 -0500
X-MC-Unique: aBSN9Oe7P5W_Su_A28IPow-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD1CF8B39A5;
	Wed, 28 Feb 2024 13:31:00 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.4])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 937901121312;
	Wed, 28 Feb 2024 13:31:00 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id EC662401E122B; Wed, 28 Feb 2024 10:30:42 -0300 (-03)
Date: Wed, 28 Feb 2024 10:30:42 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH -v2 net-next] net/core/dev.c: enable timestamp static key if
 CPU isolation is configured
Message-ID: <Zd81gp2utD9+ripX@tpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3


For systems that use CPU isolation (via nohz_full), creating or destroying
a socket with timestamping (SOCK_TIMESTAMPING_RX_SOFTWARE and 
SOF_TIMESTAMPING_OPT_TX_SWHW) might cause a
static key to be enabled/disabled. This in turn causes undesired
IPIs to isolated CPUs.

So enable the static key unconditionally, if CPU isolation is enabled,
thus avoiding the IPIs.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
v2: mention SOF_TIMESTAMPING_OPT_TX_SWHW in the commit log (Willem de Bruijn / Paolo Abeni)

diff --git a/net/core/dev.c b/net/core/dev.c
index c588808be77f..15a32f5900e6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -155,6 +155,7 @@
 #include <net/netdev_rx_queue.h>
 #include <net/page_pool/types.h>
 #include <net/page_pool/helpers.h>
+#include <linux/sched/isolation.h>
 
 #include "dev.h"
 #include "net-sysfs.h"
@@ -11851,3 +11852,14 @@ static int __init net_dev_init(void)
 }
 
 subsys_initcall(net_dev_init);
+
+static int __init net_dev_late_init(void)
+{
+	/* avoid static key IPIs to isolated CPUs */
+	if (housekeeping_enabled(HK_TYPE_MISC))
+		net_enable_timestamp();
+
+	return 0;
+}
+
+late_initcall(net_dev_late_init);


