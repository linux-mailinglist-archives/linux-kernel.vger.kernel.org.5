Return-Path: <linux-kernel+bounces-68776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 538E1858003
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D371F21507
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C0C12F373;
	Fri, 16 Feb 2024 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+i/G1OA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE77A12C7FB
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708095777; cv=none; b=Km6koc1UUq0I6cpzPdKBchO1uDb5MqYTPwDQYTN7bb+JxZ2lf2dX+KkAoC3l38083R/TQ/7UmOAHpPHEbyl3nqZ7HpNthz3vSvW7BqIiwnwvUbagaNj6U8qpk3GQgdGGkZrmThJNiv/2zrO5dfaF9omIBlEBJ+X4FSeID7Wgreo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708095777; c=relaxed/simple;
	bh=GqVjIc3Y9GJCrVy/nye5izgJbw3sIDygaE+0C7huDFg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kA20wpgxmszgwj3IbS1hNtO7AHufvJo9QrR0u1qBBw8ABNw7f6p9clrswY1CUP0lp5Ly5OweCKnWbcAil56qdmU3oja53OpsI+zqRo3IRDd0seqYgwCqb05loULvyauMGXnZUBP5donCMFtc3EhAdRfxAzB73t2wUHjoUgR0YUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y+i/G1OA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708095773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=aZ1RnOnTSLBiglbkhX1NHskWW94OsYikvhSwmo5Uu90=;
	b=Y+i/G1OAhEhbfjjwzvvNOl/sHLxJfT+AtT3zfVECWlDpHoBeEjeZ0LsD2XsxS+batTiLHw
	OowJj+qZRPXBDWHqLqiIEiiqMX1kub07CGUCuoeOZfejL0UtWjWIAtV/fFan9WMrEjF0C7
	qS1LLY7+iYmD2R19V8Wd8PevVklB/OY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-W3BTSf1FMa6m6Uev6EHpOg-1; Fri, 16 Feb 2024 10:02:51 -0500
X-MC-Unique: W3BTSf1FMa6m6Uev6EHpOg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F014684AE4A;
	Fri, 16 Feb 2024 15:02:50 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.4])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BDB1240C9444;
	Fri, 16 Feb 2024 15:02:50 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id B80BE4086D5AC; Fri, 16 Feb 2024 12:02:15 -0300 (-03)
Date: Fri, 16 Feb 2024 12:02:15 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH] net/core/dev.c: enable timestamp static key if CPU isolation
 is configured
Message-ID: <Zc9493j46rZMRIDv@tpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2


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


