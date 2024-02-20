Return-Path: <linux-kernel+bounces-72253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2423F85B131
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C943C1F23DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E528A45009;
	Tue, 20 Feb 2024 03:12:21 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B585C3EA88;
	Tue, 20 Feb 2024 03:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708398741; cv=none; b=AB9fV1Yl2oxhU5ksixNTj53V6Ilpi4TqURQYsXmVYI+vng8jbgZ6R6p87mijbZLJEHF4qe0HLJ9liUGCl4AV4mx5yY+hwzPRoPeQqC7t+U63kud13JMrp4kA95cZw4szXoer4sFl2vP4ARjCwAY7UaqZWDA5Wid589wD82aOzs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708398741; c=relaxed/simple;
	bh=3OAtWuvcmCOMGC2E9OtxyY61y74Y41DgRrdqhZY4dxU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NA1m97FyNg9zgeoHF0M4sVT9JhoOXISGcKn3MufXhN+4wPadwi4cpTJO5bx8l/JhMgw3M3Oi6pJKFUPuzUgEiO4zp1daGZQCHy2Q3/AXqHZoh+MnNJoz0DLb54a/tAMa0ITOCfrUyMjBFQnd+NposagG2EhTFntEeo005b3pB8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Tf4Cq6mhsz1Q8pv;
	Tue, 20 Feb 2024 11:10:31 +0800 (CST)
Received: from dggpemm500008.china.huawei.com (unknown [7.185.36.136])
	by mail.maildlp.com (Postfix) with ESMTPS id 9CE771402E2;
	Tue, 20 Feb 2024 11:12:09 +0800 (CST)
Received: from localhost (10.174.242.157) by dggpemm500008.china.huawei.com
 (7.185.36.136) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 11:12:09 +0800
From: Yunjian Wang <wangyunjian@huawei.com>
To: <willemdebruijn.kernel@gmail.com>, <jasowang@redhat.com>,
	<kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<brouer@redhat.com>, <xudingke@huawei.com>, Yunjian Wang
	<wangyunjian@huawei.com>
Subject: [PATCH net] tun: Fix xdp_rxq_info's queue_index when detaching
Date: Tue, 20 Feb 2024 11:12:07 +0800
Message-ID: <1708398727-46308-1-git-send-email-wangyunjian@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500008.china.huawei.com (7.185.36.136)

When a queue(tfile) is detached, we only update tfile's queue_index,
but do not update xdp_rxq_info's queue_index. This patch fixes it.

Fixes: 8bf5c4ee1889 ("tun: setup xdp_rxq_info")
Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
---
 drivers/net/tun.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index bc80fc1d576e..be37235af55d 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -652,6 +652,7 @@ static void __tun_detach(struct tun_file *tfile, bool clean)
 				   tun->tfiles[tun->numqueues - 1]);
 		ntfile = rtnl_dereference(tun->tfiles[index]);
 		ntfile->queue_index = index;
+		ntfile->xdp_rxq.queue_index = index;
 		rcu_assign_pointer(tun->tfiles[tun->numqueues - 1],
 				   NULL);
 
-- 
2.33.0


