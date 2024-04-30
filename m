Return-Path: <linux-kernel+bounces-163615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3190A8B6DAD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DD201C21F35
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237B8127B5C;
	Tue, 30 Apr 2024 09:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tEU8D+8n"
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD07205E2E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714467740; cv=none; b=ESoNNJFqZgYcx0LKqu7hTWai0cMWJPscGuZ8kYToYsqI0XqmZ/0qrcWm4vOE/t3WEosWlpfeX61vdRCU6QpfZv2lTpwu3dpo2tsBTuV28kg4klKYepepd0MWprLwhcXum2UCeCovDbaGEpJe/cako3Sgzc8TLdNvkq1uuYX2sAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714467740; c=relaxed/simple;
	bh=jNu2cGfuxXih8LuWKi4Vsz55ZAVbUVK0a6cK0rdyZcc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Deary3nsl2kVV6w0ODOE0Mtc384U0RFPlk6MbvHAyysGn6SHAYldt9OFcJ5RGctWVvzySLD1CWXuhdD01mjz6YSzLZhvRpzhZDvMMPTpCd86DhWHM6adiBHPF+klerQeP5Bn02SUBirWAwLiIXLl2Phmb+p/b24HbHhh2JdjzyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=tEU8D+8n; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714467739; x=1746003739;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+jjK4IdZ7xyzxhwRxgUpp+voHGGl/e2Af8iojen5Qi0=;
  b=tEU8D+8n32WRVXGQcKxsPO2pT6ZVXrrADm3dwtIlqHKpf8LVmmOHJqHA
   oDM9/CQ/Cj0CKrz1u17LNtrgBRMLVB7CIu16WvRZs9ud8pzjJlj6sphMY
   +gyATlZSNOW9lVOlhXtTukbeGlWydvBjclxiyFAAqk4yjrFWl8zeA3Ifh
   0=;
X-IronPort-AV: E=Sophos;i="6.07,241,1708387200"; 
   d="scan'208";a="722464492"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:01:57 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.17.79:43855]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.2.6:2525] with esmtp (Farcaster)
 id fa49cf44-efb0-424d-b2b0-3a9c7d543a8e; Tue, 30 Apr 2024 09:01:55 +0000 (UTC)
X-Farcaster-Flow-ID: fa49cf44-efb0-424d-b2b0-3a9c7d543a8e
Received: from EX19D008EUA001.ant.amazon.com (10.252.50.34) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 30 Apr 2024 09:01:55 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D008EUA001.ant.amazon.com (10.252.50.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 30 Apr 2024 09:01:55 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com
 (10.253.65.58) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Tue, 30 Apr 2024 09:01:54
 +0000
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id 65E5F20C24; Tue, 30 Apr 2024 09:01:54 +0000 (UTC)
From: Hagar Hemdan <hagarhem@amazon.com>
To:
CC: Maximilian Heyne <mheyne@amazon.de>, Norbert Manthey <nmanthey@amazon.de>,
	Hagar Gamal Halim Hemdan <hagarhem@amazon.com>, Bryan Tan
	<bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Arnd
 Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Torokhov <dtor@vmware.com>, George Zhang <georgezhang@vmware.com>,
	Andy king <acking@vmware.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] vmci: prevent speculation leaks by sanitizing event in event_deliver()
Date: Tue, 30 Apr 2024 08:59:16 +0000
Message-ID: <20240430085916.4753-1-hagarhem@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Hagar Gamal Halim Hemdan <hagarhem@amazon.com>

Coverity spotted that event_msg is controlled by user-space,
event_msg->event_data.event is passed to event_deliver() and used
as an index without sanitization.

This change ensures that the event index is sanitized to mitigate any
possibility of speculative information leaks.

This bug was discovered and resolved using Coverity Static Analysis
Security Testing (SAST) by Synopsys, Inc.

Only compile tested, no access to HW.

Fixes: 1d990201f9bb ("VMCI: event handling implementation.")
Signed-off-by: Hagar Gamal Halim Hemdan <hagarhem@amazon.com>
---
v4: Added the testing state in the commit message and rebased on top of
latest mainline
---
 drivers/misc/vmw_vmci/vmci_event.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_vmci/vmci_event.c b/drivers/misc/vmw_vmci/vmci_event.c
index 5d7ac07623c2..9a41ab65378d 100644
--- a/drivers/misc/vmw_vmci/vmci_event.c
+++ b/drivers/misc/vmw_vmci/vmci_event.c
@@ -9,6 +9,7 @@
 #include <linux/vmw_vmci_api.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/nospec.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/rculist.h>
@@ -86,9 +87,12 @@ static void event_deliver(struct vmci_event_msg *event_msg)
 {
 	struct vmci_subscription *cur;
 	struct list_head *subscriber_list;
+	u32 sanitized_event, max_vmci_event;
 
 	rcu_read_lock();
-	subscriber_list = &subscriber_array[event_msg->event_data.event];
+	max_vmci_event = ARRAY_SIZE(subscriber_array);
+	sanitized_event = array_index_nospec(event_msg->event_data.event, max_vmci_event);
+	subscriber_list = &subscriber_array[sanitized_event];
 	list_for_each_entry_rcu(cur, subscriber_list, node) {
 		cur->callback(cur->id, &event_msg->event_data,
 			      cur->callback_data);
-- 
2.40.1


