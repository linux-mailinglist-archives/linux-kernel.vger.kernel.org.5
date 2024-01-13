Return-Path: <linux-kernel+bounces-25288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5854B82CCC1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 14:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A1F1F21D83
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 13:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C1221116;
	Sat, 13 Jan 2024 13:06:13 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7359D210E3
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 13:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TBzCm6myXz1xmCm;
	Sat, 13 Jan 2024 21:05:24 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id A074C1404F7;
	Sat, 13 Jan 2024 21:06:05 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemd200001.china.huawei.com
 (7.185.36.224) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Sat, 13 Jan
 2024 21:06:05 +0800
From: ZhaoLong Wang <wangzhaolong1@huawei.com>
To: <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<wangzhaolong1@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v3 2/2] ubi: Correct the number of PEBs after a volume resize failure
Date: Sat, 13 Jan 2024 21:06:01 +0800
Message-ID: <20240113130601.2502095-2-wangzhaolong1@huawei.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20240113130601.2502095-1-wangzhaolong1@huawei.com>
References: <20240113130601.2502095-1-wangzhaolong1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemd200001.china.huawei.com (7.185.36.224)

In the error handling path `out_acc` of `ubi_resize_volume()`,
when `pebs < 0`, it indicates that the volume table record failed to
update when the volume was shrunk. In this case, the number of `ubi->avail_pebs`
and `ubi->rsvd_pebs` should be restored to their previous values to prevent
the UBI layer from reporting an incorrect number of available PEBs.

Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/mtd/ubi/vmt.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
index 97294def01eb..990571287e84 100644
--- a/drivers/mtd/ubi/vmt.c
+++ b/drivers/mtd/ubi/vmt.c
@@ -515,13 +515,12 @@ int ubi_resize_volume(struct ubi_volume_desc *desc, int reserved_pebs)
 out_acc:
 	spin_lock(&ubi->volumes_lock);
 	vol->reserved_pebs = reserved_pebs - pebs;
-	if (pebs > 0) {
-		ubi->rsvd_pebs -= pebs;
-		ubi->avail_pebs += pebs;
+	ubi->rsvd_pebs -= pebs;
+	ubi->avail_pebs += pebs;
+	if (pebs > 0)
 		ubi_eba_copy_table(vol, old_eba_tbl, vol->reserved_pebs);
-	} else {
+	else
 		ubi_eba_copy_table(vol, old_eba_tbl, reserved_pebs);
-	}
 	vol->eba_tbl = old_eba_tbl;
 	spin_unlock(&ubi->volumes_lock);
 out_free:
-- 
2.34.3


