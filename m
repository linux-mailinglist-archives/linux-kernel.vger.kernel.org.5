Return-Path: <linux-kernel+bounces-70243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 451B185952A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02190282083
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 06:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0057492;
	Sun, 18 Feb 2024 06:58:00 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABF263A9
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 06:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708239480; cv=none; b=rI58b+pTFOUB4Sd56wLhN7PQRq/Sm/x4MSZBuz4kgFxZwm3DAoAljrzA68V7wG7BUkAmmDrGALnM0WCal3Q9/bhO1YbAAM921fsFb2LZKHqEXx8D198HeSBdSpS0GHkpS6SSEdDvdsOly0ESST2HUVHAlsGdYkn8P4Q3bNIVKao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708239480; c=relaxed/simple;
	bh=qaK6lIdOACF7viPlmdosZqtssntW53AXGWTeB7TYcVk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gSNg5FeuQGxM/yKuHw4DvY9UZC2iuEDK95xmO7VfaAYs+miHn6Jl7n1OD1D0/EYMDoA32IOSCZjzdy+pp/vQ+B+e1X57oZzXFBWqc2sfS6AKYzFY74/TGiY988FEph8+x25JHekD23CUsOzvQPCnueKzb2TBOdROn1c7yjjuYcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TcxLS0x62z1vtXx;
	Sun, 18 Feb 2024 14:57:20 +0800 (CST)
Received: from kwepemi500023.china.huawei.com (unknown [7.221.188.76])
	by mail.maildlp.com (Postfix) with ESMTPS id E1D521404DB;
	Sun, 18 Feb 2024 14:57:52 +0800 (CST)
Received: from huawei.com (10.110.54.32) by kwepemi500023.china.huawei.com
 (7.221.188.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 18 Feb
 2024 14:57:52 +0800
From: liqiang <liqiang64@huawei.com>
To: <akpm@linux-foundation.org>, <ying.huang@intel.com>,
	<paulmck@linux.vnet.ibm.com>, <neilb@suse.de>, <chuck.lever@oracle.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH] llist: Make llist_del_first return only the first node
Date: Sun, 18 Feb 2024 14:57:50 +0800
Message-ID: <20240218065750.1241-1-liqiang64@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500023.china.huawei.com (7.221.188.76)

Set the next of the returned node of llist_del_first
to NULL, which can prevent subsequent nodes in llist
from being exposed, and is more consistent with the
logic of this interface.

Signed-off-by: liqiang <liqiang64@huawei.com>
---
 lib/llist.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/llist.c b/lib/llist.c
index f21d0cf..c33fff5 100644
--- a/lib/llist.c
+++ b/lib/llist.c
@@ -61,6 +61,7 @@ struct llist_node *llist_del_first(struct llist_head *head)
 		next = READ_ONCE(entry->next);
 	} while (!try_cmpxchg(&head->first, &entry, next));
 
+	entry->next = NULL;
 	return entry;
 }
 EXPORT_SYMBOL_GPL(llist_del_first);
-- 
2.23.0.windows.1


