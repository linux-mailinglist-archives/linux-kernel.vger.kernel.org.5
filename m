Return-Path: <linux-kernel+bounces-49791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F11846F6F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9278128885D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A84A13E232;
	Fri,  2 Feb 2024 11:50:49 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5C113DBB9
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 11:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874649; cv=none; b=DO+POp9u2QmO+wdVEgkmPeMte3KsricWAXW199PTcvELg+GbeJQKTkc9pqT0TK9ANgduoQkcNuMVq+zytx3I4DpyYbCdmytV7XaXIQFto16j5zB6Kee9OeCoXNQDDx7AN8UMIdQ+/sbc19y5lV6W8q70ae54kLxc1DnoJZxXi1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874649; c=relaxed/simple;
	bh=qaK6lIdOACF7viPlmdosZqtssntW53AXGWTeB7TYcVk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bg+2DO4trygE11UEA86MsWB3Knyf46NWCAODoN1svAyp5RvsdoNOHe3lugElYAaC5HaFOV2YqCdA7WtVcI7DFScMFW6ZnVx4L/+b3n53eSgrfFZvGK2q7hTu+teSMfIBkU+rYHz/mOVcqBdR1hkfznlMIPs3/+ELSKWIUEGfaN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TRDZB5m2yz29l0k;
	Fri,  2 Feb 2024 19:48:50 +0800 (CST)
Received: from kwepemi500023.china.huawei.com (unknown [7.221.188.76])
	by mail.maildlp.com (Postfix) with ESMTPS id 0DDED14011A;
	Fri,  2 Feb 2024 19:50:43 +0800 (CST)
Received: from huawei.com (10.110.54.32) by kwepemi500023.china.huawei.com
 (7.221.188.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 2 Feb
 2024 19:50:42 +0800
From: liqiang <liqiang64@huawei.com>
To: <akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH] llist: Make llist_del_first return only the first node
Date: Fri, 2 Feb 2024 19:50:40 +0800
Message-ID: <20240202115040.537-1-liqiang64@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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


