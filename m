Return-Path: <linux-kernel+bounces-72836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 082B885B92B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88AD81F20CFE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0319C61683;
	Tue, 20 Feb 2024 10:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXpCXeNw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF49760276
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 10:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708425330; cv=none; b=FlEhoktSldFYdt9u9ssrsKpBIx6CTV9Cy3Eu/VC1me7JXWbncNnQ4udT56VGAKqlTr/Q4jkAAncSnoC6uCqc9Dcdf/1bzUuS2+GCBwz2LIPhFBZDNQ1NFXoFKHfbj9OLcY28MVN6iIsj16G8mlPCzLbRw+lVJPqaKjzOe3MFhoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708425330; c=relaxed/simple;
	bh=HEvXUMThvUIqnt0LiI+bBVgaUe3iN2uphGAvjHQ1fog=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=munPU3d0RK0zPpP19DOC1EyHMmZ9AG2yO5CvytD6bJwHWZ/KiZ049U2FyeheEDyLfPpqkyt76/DsihSPm+osn7ZR+eFqM/FYyDWfUeB9Hfzcm+4yFOwk/qerG4i5CvucJHSv+ANH1g9V3G4hbG1AJuCvp98mGrwOSU9UuQvpBbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cXpCXeNw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708425327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=svGjrbyynWHu4RkuCMOXvlEyLxwGmnZthB0JJWKitFw=;
	b=cXpCXeNwNBmT4/MyoIHdA7uxIZPw42T20mxRwjGlEy58KRStYfl9nEZHGUqu6Fu8KC0oOH
	gAsZDSq5XAHbuO6LKvhy/X6dzzapgBbmT4/aTx9EcsFMTmBy6aab392O91uCZkDoDXqIDK
	tppNSsiPPZKO8P3iupkR7ua/UEb1zA8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-El1YA-VmOemMflwWPxauPA-1; Tue, 20 Feb 2024 05:35:25 -0500
X-MC-Unique: El1YA-VmOemMflwWPxauPA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D93C106D020;
	Tue, 20 Feb 2024 10:35:25 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D4979492BC6;
	Tue, 20 Feb 2024 10:35:24 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 3E04540194B36; Tue, 20 Feb 2024 07:35:04 -0300 (-03)
Date: Tue, 20 Feb 2024 07:35:04 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH] net/core/dev.c: enable timestamp static key if CPU isolation
 is configured
Message-ID: <ZdSAWAwUxc5R46NH@tpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

For systems that use CPU isolation (via nohz_full), creating or destroying
a socket with  timestamping (SOF_TIMESTAMPING_OPT_TX_SWHW) might cause a
static key to be enabled/disabled. This in turn causes undesired 
IPIs to isolated CPUs.

So enable the static key unconditionally, if CPU isolation is enabled,
thus avoiding the IPIs.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

diff --git a/net/core/dev.c b/net/core/dev.c
index 0d548431f3fa..cc9a77b4aa4e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -153,6 +153,7 @@
 #include <linux/prandom.h>
 #include <linux/once_lite.h>
 #include <net/netdev_rx_queue.h>
+#include <linux/sched/isolation.h>
 
 #include "dev.h"
 #include "net-sysfs.h"
@@ -11601,3 +11602,14 @@ static int __init net_dev_init(void)
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


