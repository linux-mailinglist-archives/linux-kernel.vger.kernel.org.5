Return-Path: <linux-kernel+bounces-94495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E42AE8740A8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8448A1F21869
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E58E140E25;
	Wed,  6 Mar 2024 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a0CcI12l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E155C14036A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 19:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709754133; cv=none; b=fRia6DhuvZ5iyvO9ZJBxH9xfHcgaVxitbgLReRoEQSLejJm5deCCkHXtvc/yydHhMiaOQeWjiRNy+0ZnF6gBNT+8IEzYV7XO4gp4uy80yZ67Lktg/Ycvlv5UezcWfn0tVZR16C9OQ22QIWoDOQwUuP5xSyCZ5WSCXm5ENqwc+7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709754133; c=relaxed/simple;
	bh=fz8sVULSokUEtg1apAJP0N1kFWc3PTDlmYeHhou+7FM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QhwMXA1FwSWEPcZ5CF/3f4/P23JVOyiRNFDTF/q9GPLHX/6h2th9T6UrOyuIA8b1+ysBQZP0XJ136XI3j8M+viv8oNA/IzOz4DIOzrb3DlNUjniik7vHGZQLvJt0Tj6DMvhQZyQM+UyNBFof0ogZwOrt4xOrcGfDYWtVQhKBiOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a0CcI12l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709754130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=7NzAkrFfDtAG1W4IZ9k3+0Y5QZ/B1qwXKO/PPRafIn0=;
	b=a0CcI12lmEMeC0/t28O87lqFYlN+bRKmfE+r90OiMs+rtWsIDZmQjZaPxa1TwmrjWsctSi
	d5AR04fRVxtUnrpJPcC7NhYydZbP7bLJRmS1wZ66PidXMMqAaAHO6+YVLPfYonA4TwTmWt
	ojQxfgvw7p+BhmrkwaLVbMUWJ8cBbyk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-lhnnuKE-NN-TQ7tU0BGcmw-1; Wed, 06 Mar 2024 14:42:08 -0500
X-MC-Unique: lhnnuKE-NN-TQ7tU0BGcmw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1825185A58C;
	Wed,  6 Mar 2024 19:42:08 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D5B1BC041EF;
	Wed,  6 Mar 2024 19:42:07 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 3A5B04014ABF9; Wed,  6 Mar 2024 16:41:47 -0300 (-03)
Date: Wed, 6 Mar 2024 16:41:47 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next -v4] net/core/dev.c: enable timestamp static key if
 CPU isolation is configured
Message-ID: <ZejG+1YF4Rk89Gc9@tpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8


For systems that use CPU isolation (via nohz_full), creating or destroying
a socket with SO_TIMESTAMP, SO_TIMESTAMPNS or SO_TIMESTAMPING with flag
SOF_TIMESTAMPING_RX_SOFTWARE will cause a static key to be enabled/disabled.
This in turn causes undesired IPIs to isolated CPUs.

So enable the static key unconditionally, if CPU isolation is enabled,
thus avoiding the IPIs.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
v2: mention SOF_TIMESTAMPING_OPT_TX_SWHW in the commit log (Willem de Bruijn / Paolo Abeni)
v3: SOF_TIMESTAMPING_OPT_TX_SWHW is irrelevant (Willem de Bruijn)
v4: additional changelog improvements (Willem de Bruijn)

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


