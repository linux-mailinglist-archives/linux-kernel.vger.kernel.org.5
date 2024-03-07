Return-Path: <linux-kernel+bounces-95922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C408754FE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ADA8283A63
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15141EB40;
	Thu,  7 Mar 2024 17:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KegBqN45"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A7212FF8F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709831678; cv=none; b=Q7A0eDQ1wH8JFkVUUwWHucHN53HVDymDawooGNwsLYb0FZ8WXTP0kYVppg87tAGjxEfKMgDjY6HGVVyAzpEQSpMPGZmRCflYCbFhFFykpd9GsiTOJFvULeNQw2UtYQ1kOWb0++GbFDPKkiP0ZOwsvBxmTh00+gw6r7ifJrF0/R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709831678; c=relaxed/simple;
	bh=RHYXIvGJo8q/LIBWiLq20XUcVqSjEGZKfomR2XrwR+c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WdqC+SDOFr/jIjU+aV3gGNpk+88+gYFiJD2XZIuskR/hNp5yRf2LsaJCeaxnZx8uxI2iLamoQeo6kxnRBXhrs1xDgHItVlV4ahUX4w9Dy03t++p9E4KYhVkDL8aqDBJhzEe5HsaMltYN1Ly4JiArQJCOF2zNtD7I8EN170ZbfYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KegBqN45; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709831675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=NG816kiSDpgCjmlRtzxBd0pgqG2tGupf4H8p5jd/PSY=;
	b=KegBqN45l4TOQEe1++2C2xr2w84vUtRlWATMPB5S8zr1joPdpSw+SyNWjTrYaVIgsVUQqs
	JARm3b3orn42+KLIMZBYkRklvTBci1DKuP56i+y4cCnsdiuiHn+2NOn0Ydj+kaAw5X2P+h
	82k3Zep1HCXJs2yCF+LYSPgFQUNk9Eg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-AO8X13KGOb2-QP-mwOuRKA-1; Thu,
 07 Mar 2024 12:14:30 -0500
X-MC-Unique: AO8X13KGOb2-QP-mwOuRKA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BDBF3C0BE2D;
	Thu,  7 Mar 2024 17:14:30 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C931F17AA6;
	Thu,  7 Mar 2024 17:14:29 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 8CEA840AD6D54; Thu,  7 Mar 2024 14:14:03 -0300 (-03)
Date: Thu, 7 Mar 2024 14:14:03 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next -v5] net/core/dev.c: enable timestamp static key if
 CPU isolation is configured
Message-ID: <Zen126EYArNCxIYz@tpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5


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
v5: late initcall not necessary, can use subsys initcall (Willem de Bruijn)

diff --git a/net/core/dev.c b/net/core/dev.c
index 0d548431f3fa..7832793b2980 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -153,6 +153,7 @@
 #include <linux/prandom.h>
 #include <linux/once_lite.h>
 #include <net/netdev_rx_queue.h>
+#include <linux/sched/isolation.h>
 
 #include "dev.h"
 #include "net-sysfs.h"
@@ -11596,6 +11597,10 @@ static int __init net_dev_init(void)
 				       NULL, dev_cpu_dead);
 	WARN_ON(rc < 0);
 	rc = 0;
+
+	/* avoid static key IPIs to isolated CPUs */
+	if (housekeeping_enabled(HK_TYPE_MISC))
+		net_enable_timestamp();
 out:
 	return rc;
 }


