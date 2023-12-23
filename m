Return-Path: <linux-kernel+bounces-10320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EAD81D2B7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 07:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E5981F22F95
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 06:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965158BF2;
	Sat, 23 Dec 2023 06:39:40 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBDD15BD;
	Sat, 23 Dec 2023 06:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SxvfD0Bzkz4f3kFm;
	Sat, 23 Dec 2023 14:39:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DEC731A0997;
	Sat, 23 Dec 2023 14:39:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXmhCjgIZlBfyaEQ--.4053S6;
	Sat, 23 Dec 2023 14:39:34 +0800 (CST)
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
Subject: [PATCH 2/4] badblocks: optimize _badblocks_check()
Date: Sat, 23 Dec 2023 14:37:26 +0800
Message-Id: <20231223063728.3229446-3-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231223063728.3229446-1-linan666@huaweicloud.com>
References: <20231223063728.3229446-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXmhCjgIZlBfyaEQ--.4053S6
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWktw1UtrWDCFy7trWrXwb_yoW8WrWDpr
	nxX34SgryqgF1UX3W8Z3ZrJr1ruw13tF4UKay7Jrn8KryIyw1xK3W0qryYyFyj9FyfJrnI
	qa15uryrZFyxGa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmC14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vY
	z4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
	02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
	4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4
	IIrI8v6xkF7I0E8cxan2IY04v7M4kE6xkIj40Ew7xC0wCF04k20xvY0x0EwIxGrwCFx2Iq
	xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
	106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
	xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
	Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUvAp5UUUUU=
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

Check badblocks_empty earlier, and goto out if check range starts after
all badblocks or badblocks is empty since no badblocks intersect with
check range.

Clean up redundant check '(prev + 1) < bb->count'. If it is true, it
will enter the earlier branch.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 block/badblocks.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index ebf17a54851a..054d05b93641 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -1296,6 +1296,11 @@ static int _badblocks_check(struct badblocks *bb, sector_t s, int sectors,
 retry:
 	seq = read_seqbegin(&bb->lock);
 
+	if (badblocks_empty(bb)) {
+		len = sectors;
+		goto out;
+	}
+
 	p = bb->page;
 	acked_badblocks = 0;
 
@@ -1303,17 +1308,12 @@ static int _badblocks_check(struct badblocks *bb, sector_t s, int sectors,
 	bad.start = s;
 	bad.len = sectors;
 
-	if (badblocks_empty(bb)) {
-		len = sectors;
-		goto update_sectors;
-	}
-
 	prev = prev_badblocks(bb, &bad, hint);
 
 	/* start after all badblocks */
 	if ((prev + 1) >= bb->count && !overlap_front(bb, prev, &bad)) {
 		len = sectors;
-		goto update_sectors;
+		goto out;
 	}
 
 	if (overlap_front(bb, prev, &bad)) {
@@ -1339,7 +1339,7 @@ static int _badblocks_check(struct badblocks *bb, sector_t s, int sectors,
 	}
 
 	/* Not front overlap, but behind overlap */
-	if ((prev + 1) < bb->count && overlap_behind(bb, &bad, prev + 1)) {
+	if (overlap_behind(bb, &bad, prev + 1)) {
 		len = BB_OFFSET(p[prev + 1]) - bad.start;
 		hint = prev + 1;
 		goto update_sectors;
-- 
2.39.2


