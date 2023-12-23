Return-Path: <linux-kernel+bounces-10323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CD381D2BC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 07:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76D6D1C224D4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 06:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11E9D262;
	Sat, 23 Dec 2023 06:39:41 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1E46108;
	Sat, 23 Dec 2023 06:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SxvfB0YpCz4f3lVH;
	Sat, 23 Dec 2023 14:39:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 5E0EF1A0787;
	Sat, 23 Dec 2023 14:39:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXmhCjgIZlBfyaEQ--.4053S7;
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
Subject: [PATCH 3/4] badblocks: fix slab-out-of-bounds in _badblocks_check()
Date: Sat, 23 Dec 2023 14:37:27 +0800
Message-Id: <20231223063728.3229446-4-linan666@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgCXmhCjgIZlBfyaEQ--.4053S7
X-Coremail-Antispam: 1UD129KBjvdXoWrtFy8CFW7Zw13ur18uw1rJFb_yoWfuwc_Ca
	4UtF95Xrs5Jry3CrnIy3WUXrWftF1UCFnYkw1UJrn5XF48tF4DJa98Jr1UXrn5WFWUG3s0
	vrWfXrWfZr1I9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbBkFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY02
	0Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vY
	z4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
	02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
	4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4
	IIrI8v6xkF7I0E8cxan2IY04v7M4kE6xkIj40Ew7xC0wCF04k20xvY0x0EwIxGrwCFx2Iq
	xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
	106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
	xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
	Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU9Z23UUUUU=
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

prev_badblocks() will return -1 if checked range start < p[0]. Accessing
p[-1] will cause bug as below:

  BUG: KASAN: slab-out-of-bounds in badblocks_check+0x2c4

Fix it by checking 'prev' before accessing badblocks->page.

Fixes: 3ea3354cb9f0 ("badblocks: improve badblocks_check() for multiple ranges handling")
Signed-off-by: Li Nan <linan122@huawei.com>
---
 block/badblocks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index 054d05b93641..71a3e43351da 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -1316,7 +1316,7 @@ static int _badblocks_check(struct badblocks *bb, sector_t s, int sectors,
 		goto out;
 	}
 
-	if (overlap_front(bb, prev, &bad)) {
+	if (prev >= 0 && overlap_front(bb, prev, &bad)) {
 		if (set == 0) {
 			*first_bad = BB_OFFSET(p[prev]);
 			*bad_sectors = BB_LEN(p[prev]);
-- 
2.39.2


