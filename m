Return-Path: <linux-kernel+bounces-90008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BBB86F8DD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 04:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0930D1F21483
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135084696;
	Mon,  4 Mar 2024 03:22:44 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F583211C;
	Mon,  4 Mar 2024 03:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709522563; cv=none; b=f2hna1515vWoGVh0XBoNN43VsliJ0rEhPPW/biBEaVMvpQ7uavCZbOA4mf7/97hGy1kVzXP8Q+Ru4SLf8oTmq8VHndfQNysTvt5ZifYz8FwfLP2OUKQwkPcPgvt7srXzjjDInFF4ip/AaCrExticNpfLaW+AgPQYfy/t9nno9n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709522563; c=relaxed/simple;
	bh=veLqZ5GaMtlPnNbR+KmO08huNmMlZ5vta4bUNMiDihc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I4hfPovIpD792U5GIo8GYGfMVhOiIT5vmWTMDTTUSL8Df69gHCnMETIBPS2RXT86yZoGEnWmA1uTh07he6UkD1LBL4w/89MIl3wGXGlLpatD6oJT9+CxaYtYwnOoayaMVt5chOQtnzgEK8nmmdQXQa1Ky+RNbiXv0hh0baeQ7Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Tp3sZ4GfTz1FLcr;
	Mon,  4 Mar 2024 11:22:26 +0800 (CST)
Received: from kwepemd500004.china.huawei.com (unknown [7.221.188.173])
	by mail.maildlp.com (Postfix) with ESMTPS id 34A571A016B;
	Mon,  4 Mar 2024 11:22:32 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (7.221.188.25) by
 kwepemd500004.china.huawei.com (7.221.188.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 4 Mar 2024 11:22:31 +0800
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Mon, 4 Mar
 2024 11:22:31 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <kent.overstreet@linux.dev>, <bfoster@redhat.com>
CC: <lizetao1@huawei.com>, <linux-bcachefs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] bcachefs: Fix null-ptr-deref in bch2_fs_alloc()
Date: Mon, 4 Mar 2024 11:22:03 +0800
Message-ID: <20240304032203.3480001-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd500012.china.huawei.com (7.221.188.25)

There is a null-ptr-deref issue reported by kasan:

  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
  Call Trace:
    <TASK>
    bch2_fs_alloc+0x1092/0x2170 [bcachefs]
    bch2_fs_open+0x683/0xe10 [bcachefs]
    ...

When initializing the name of bch_fs, it needs to dynamically alloc memory
to meet the length of the name. However, when name allocation failed, it
will cause a null-ptr-deref access exception in subsequent string copy.

Fix this issue by checking if name allocation is successful.

Fixes: 401ec4db6308 ("bcachefs: Printbuf rework")
Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/bcachefs/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
index 6b23e11825e6..24fa41bbe7e3 100644
--- a/fs/bcachefs/super.c
+++ b/fs/bcachefs/super.c
@@ -818,13 +818,13 @@ static struct bch_fs *bch2_fs_alloc(struct bch_sb *sb, struct bch_opts opts)
 		goto err;
 
 	pr_uuid(&name, c->sb.user_uuid.b);
-	strscpy(c->name, name.buf, sizeof(c->name));
-	printbuf_exit(&name);
-
 	ret = name.allocation_failure ? -BCH_ERR_ENOMEM_fs_name_alloc : 0;
 	if (ret)
 		goto err;
 
+	strscpy(c->name, name.buf, sizeof(c->name));
+	printbuf_exit(&name);
+
 	/* Compat: */
 	if (le16_to_cpu(sb->version) <= bcachefs_metadata_version_inode_v2 &&
 	    !BCH_SB_JOURNAL_FLUSH_DELAY(sb))
-- 
2.34.1


