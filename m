Return-Path: <linux-kernel+bounces-10322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593A581D2BB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 07:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1687B2859DE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 06:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D51D260;
	Sat, 23 Dec 2023 06:39:41 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7A86116;
	Sat, 23 Dec 2023 06:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SxvfB3tyVz4f3lVV;
	Sat, 23 Dec 2023 14:39:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D1E2E1A09A0;
	Sat, 23 Dec 2023 14:39:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXmhCjgIZlBfyaEQ--.4053S8;
	Sat, 23 Dec 2023 14:39:35 +0800 (CST)
From: linan666@huaweicloud.com
To: axboe@kernel.dk,
	geliang.tang@suse.com,
	xni@redhat.com,
	colyli@suse.de
Cc: ira.weiny@intel.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linan666@huaweicloud.com,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	houtao1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 4/4] badblocks: clean up prev_badblocks()
Date: Sat, 23 Dec 2023 14:37:28 +0800
Message-Id: <20231223063728.3229446-5-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231223063728.3229446-1-linan666@huaweicloud.com>
References: <20231223063728.3229446-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXmhCjgIZlBfyaEQ--.4053S8
X-Coremail-Antispam: 1UD129KBjvdXoWrur1kWF18Kr13CrWUKrW8Xrb_yoWfJrX_J3
	4UtrWkJrn3AFsxCr1ay3WUtrWrtF1UCrn2kryjyrykZF47tFWkJa15JryDXrs8WF4UWanx
	ur93ZrW3ZF4IqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbPkFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
	IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
	F7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
	1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
	kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYx
	C7M4IIrI8v6xkF7I0E8cxan2IY04v7M4kE6xkIj40Ew7xC0wCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUY4EEUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

The offset of 'lo' must <= ‘s' after biset. clean up redundant check.
And replace the check of badblocks->count with badblocks_empty().

Signed-off-by: Li Nan <linan122@huawei.com>
---
 block/badblocks.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index 71a3e43351da..88ed13897443 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -486,7 +486,7 @@ static int prev_badblocks(struct badblocks *bb, struct badblocks_context *bad,
 	int lo, hi;
 	u64 *p;
 
-	if (!bb->count)
+	if (badblocks_empty(bb))
 		goto out;
 
 	if (hint >= 0) {
@@ -521,8 +521,7 @@ static int prev_badblocks(struct badblocks *bb, struct badblocks_context *bad,
 			hi = mid;
 	}
 
-	if (BB_OFFSET(p[lo]) <= s)
-		ret = lo;
+	ret = lo;
 out:
 	return ret;
 }
-- 
2.39.2


