Return-Path: <linux-kernel+bounces-92625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0D9872307
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95D5A1F22512
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E06E127B46;
	Tue,  5 Mar 2024 15:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QIKYzkd1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F9485944
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709653284; cv=none; b=jIgrGo8BTZF2f+6FMTu6RAaiZ5SK0rw/k8vvYdDprGgfUQ6Vl07mCsjj5LHmy6C/hQNaN9pZx81wP3gHcJ+arkuDVQJXA4x9q2/IE9OHTn1QArVllM7iat23ivGULnE4KdNkA/k/p9WvdX1CbFn2PAe/CAi9WCRciqlS6bGd348=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709653284; c=relaxed/simple;
	bh=luhECAtvT7QNAppxYpVvGiqCYhbBdUPQ8m2Erv7UbZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=p00oyuftcPhM0gh+K5nnphR7il7VmRxdlcU7wYqi+auvP+3ORHfBOkRZKo+BQWD1vjFmbfzWNqAlPWqi2u80NAN7hM0Kr64v+yfNFY7hRIVSWp/GJiCGKledh5isgH8X0jANlqCEjb/lirpEQJD83e4jWeypdmahxDQ9fcqds+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QIKYzkd1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709653274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=pWUBbxy7MElKnb2mfhbQTl4McdZyvi6kMMuQwNYbO5A=;
	b=QIKYzkd1y0Gt8Fl/ejvG7KL/wLkfGywxj0n/54PBSAevXol5/Vk6rCj+RtUzuSd5dc7kMy
	ChoUgO7/U8Lz262l16oDddEs03SzHx5xDYumMuiAR7QI0VkcoJJmjYNu43rUliRS688PCF
	4vIcRWlrUmRZ6YYlku/fpZFp0IA5wsU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-jFYYEzwVPH2BH2Bms7fgBg-1; Tue, 05 Mar 2024 10:41:11 -0500
X-MC-Unique: jFYYEzwVPH2BH2Bms7fgBg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2826E10189BB;
	Tue,  5 Mar 2024 15:41:08 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E9CA7492BE8;
	Tue,  5 Mar 2024 15:41:07 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 6472A4021787F; Mon,  4 Mar 2024 10:46:34 -0300 (-03)
Date: Mon, 4 Mar 2024 10:46:34 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next -v3] net/core/dev.c: enable timestamp static key if
 CPU isolation is configured
Message-ID: <ZeXQup48+X6U9TQ/@tpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10


For systems that use CPU isolation (via nohz_full), creating or destroying
a socket with timestamping (SOCK_TIMESTAMPING_RX_SOFTWARE) might cause a
static key to be enabled/disabled. This in turn causes undesired
IPIs to isolated CPUs.

So enable the static key unconditionally, if CPU isolation is enabled,
thus avoiding the IPIs.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---                                                                                                                                         
v2: mention SOF_TIMESTAMPING_OPT_TX_SWHW in the commit log (Willem de Bruijn / Paolo Abeni)
v3: SOF_TIMESTAMPING_OPT_TX_SWHW is irrelevant (Willem de Bruijn)

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


