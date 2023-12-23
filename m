Return-Path: <linux-kernel+bounces-10321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3396681D2B8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 07:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65DA41C2235A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 06:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59328F70;
	Sat, 23 Dec 2023 06:39:40 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D0D4437;
	Sat, 23 Dec 2023 06:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Sxvf90z6kz4f3lDH;
	Sat, 23 Dec 2023 14:39:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6B8081A0787;
	Sat, 23 Dec 2023 14:39:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXmhCjgIZlBfyaEQ--.4053S5;
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
Subject: [PATCH 1/4] badblocks: goto out if find any unacked badblocks in _badblocks_check()
Date: Sat, 23 Dec 2023 14:37:25 +0800
Message-Id: <20231223063728.3229446-2-linan666@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgCXmhCjgIZlBfyaEQ--.4053S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr18Aw4fur18tFy5ZFyrZwb_yoW8ur45pr
	sxGwnxtryjgF13W3ZrZFsFyr1ru34fJF4UGay7Ga48Kry8Kw1xtF4rWr1avryj9rW3GrsY
	v3W3uryruayDKwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmC14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
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
	Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUwFxUUUUUU=
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

In _badblocks_check(), after finding any unacked badblocks, the return
value, 'first_bad' and 'bad_sectors' will not be changed anymore, and
there is no need to check other ranges. So goto out directly after
finding unacked badblocks.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 block/badblocks.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index fc92d4e18aa3..ebf17a54851a 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -1274,7 +1274,7 @@ static int _badblocks_clear(struct badblocks *bb, sector_t s, int sectors)
 static int _badblocks_check(struct badblocks *bb, sector_t s, int sectors,
 			    sector_t *first_bad, int *bad_sectors)
 {
-	int unacked_badblocks, acked_badblocks;
+	int acked_badblocks;
 	int prev = -1, hint = -1, set = 0;
 	struct badblocks_context bad;
 	unsigned int seq;
@@ -1297,7 +1297,6 @@ static int _badblocks_check(struct badblocks *bb, sector_t s, int sectors,
 	seq = read_seqbegin(&bb->lock);
 
 	p = bb->page;
-	unacked_badblocks = 0;
 	acked_badblocks = 0;
 
 re_check:
@@ -1318,21 +1317,24 @@ static int _badblocks_check(struct badblocks *bb, sector_t s, int sectors,
 	}
 
 	if (overlap_front(bb, prev, &bad)) {
-		if (BB_ACK(p[prev]))
+		if (set == 0) {
+			*first_bad = BB_OFFSET(p[prev]);
+			*bad_sectors = BB_LEN(p[prev]);
+			set = 1;
+		}
+
+		if (BB_ACK(p[prev])) {
 			acked_badblocks++;
-		else
-			unacked_badblocks++;
+		} else {
+			rv = -1;
+			goto out;
+		}
 
 		if (BB_END(p[prev]) >= (s + sectors))
 			len = sectors;
 		else
 			len = BB_END(p[prev]) - s;
 
-		if (set == 0) {
-			*first_bad = BB_OFFSET(p[prev]);
-			*bad_sectors = BB_LEN(p[prev]);
-			set = 1;
-		}
 		goto update_sectors;
 	}
 
@@ -1355,13 +1357,12 @@ static int _badblocks_check(struct badblocks *bb, sector_t s, int sectors,
 
 	WARN_ON(sectors < 0);
 
-	if (unacked_badblocks > 0)
-		rv = -1;
-	else if (acked_badblocks > 0)
+	if (acked_badblocks > 0)
 		rv = 1;
 	else
 		rv = 0;
 
+out:
 	if (read_seqretry(&bb->lock, seq))
 		goto retry;
 
-- 
2.39.2


