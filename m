Return-Path: <linux-kernel+bounces-116463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62454889F24
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DC3E1C2CD5F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6C56774E;
	Mon, 25 Mar 2024 07:31:48 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C442187655
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711338271; cv=none; b=ShE6vL3z0ev5QpvsYL4gB3i8zAd3NHBXHnyFxyV/OroehoLuECooTbWqAfEGZbN4wYukmMIxnbGVknGgCPdozF4f0BZN+N2Gp6oI5G23A/Shfno1+2zp7iGV1Z8pvl+TGsoDxCy+0iVcCHWVJr30RLEV3XAUav8sr0F+K25rgt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711338271; c=relaxed/simple;
	bh=sgje5sEOE8XBsmqgTdTVqNM6zkfECGgBmoRAE8rZUYM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gpbiVyQ/fPMfWj/W+0Bt0XT/8Dlp2pvsPNcwaAC+nAFiDEYJ9lW21oXyxn5cZSIdhsKwe6WsTD7kSPIZs3Nr2hb3etqPxmqJRJJUPL1r3Akd0rSkt1gDbMH/F9hDcbY9OAyrbV1bK0qZgJDz0bpyXPpUscr2YZN4dPn0O3a6I90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4V2zJv5Z4QzNmJC;
	Mon, 25 Mar 2024 11:42:23 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 33006140F7B;
	Mon, 25 Mar 2024 11:44:22 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 11:44:21 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Jan Kara <jack@suse.com>, Dennis Zhou <dennis@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] fs: quota: use group allocation of per-cpu counters API
Date: Mon, 25 Mar 2024 12:12:40 +0800
Message-ID: <20240325041240.53537-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100001.china.huawei.com (7.185.36.93)

Use group allocation of per-cpu counters api to accelerate
dquot_init() and simplify code.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 fs/quota/dquot.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index dacbee455c03..808544f74e5e 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -3016,11 +3016,10 @@ static int __init dquot_init(void)
 	if (!dquot_hash)
 		panic("Cannot create dquot hash table");
 
-	for (i = 0; i < _DQST_DQSTAT_LAST; i++) {
-		ret = percpu_counter_init(&dqstats.counter[i], 0, GFP_KERNEL);
-		if (ret)
-			panic("Cannot create dquot stat counters");
-	}
+	ret = percpu_counter_init_many(dqstats.counter, 0, GFP_KERNEL,
+				       _DQST_DQSTAT_LAST);
+	if (ret)
+		panic("Cannot create dquot stat counters");
 
 	/* Find power-of-two hlist_heads which can fit into allocation */
 	nr_hash = (1UL << order) * PAGE_SIZE / sizeof(struct hlist_head);
-- 
2.41.0


