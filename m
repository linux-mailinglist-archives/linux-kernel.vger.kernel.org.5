Return-Path: <linux-kernel+bounces-373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C73814028
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E080F28826E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 02:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CD11A5B6;
	Fri, 15 Dec 2023 02:40:37 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF621107A4;
	Fri, 15 Dec 2023 02:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Srtk51rG3z4f3k5n;
	Fri, 15 Dec 2023 10:40:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 846ED1A0188;
	Fri, 15 Dec 2023 10:40:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDn6hCbvHtlSqe4Dg--.24310S6;
	Fri, 15 Dec 2023 10:40:30 +0800 (CST)
From: linan666@huaweicloud.com
To: song@kernel.org
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linan666@huaweicloud.com,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	houtao1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 2/2] md/raid1: support read error check
Date: Fri, 15 Dec 2023 10:38:52 +0800
Message-Id: <20231215023852.3478228-3-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231215023852.3478228-1-linan666@huaweicloud.com>
References: <20231215023852.3478228-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDn6hCbvHtlSqe4Dg--.24310S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1kZF13uF17JryxGF17Wrg_yoW8Aw4kpa
	15AF9YyrW5Jry5Zw4DJFWDu3WFk34fKay0yr93Jws2g3saqrZ8KFWUWa4agrn8GFn5Gr13
	Z398GwsrCFs7tFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	AKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
	xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
	1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY
	6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuY
	vjfU1xhLUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

After commit 1e50915fe0bb ("raid: improve MD/raid10 handling of correctable
read errors."), rdev will be set to faulty if it reads data error to many
times in raid10. Add this mechanism to raid1 now.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/raid1.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 156b81de49fc..42236ed91226 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2273,16 +2273,24 @@ static void sync_request_write(struct mddev *mddev, struct r1bio *r1_bio)
  *	3.	Performs writes following reads for array synchronising.
  */
 
-static void fix_read_error(struct r1conf *conf, int read_disk,
-			   sector_t sect, int sectors)
+static void fix_read_error(struct r1conf *conf, struct r1bio *r1_bio)
 {
+	sector_t sect = r1_bio->sector;
+	int sectors = r1_bio->sectors;
+	int read_disk = r1_bio->read_disk;
 	struct mddev *mddev = conf->mddev;
+	struct md_rdev *rdev = rcu_dereference(conf->mirrors[read_disk].rdev);
+
+	if (exceed_read_errors(mddev, rdev)) {
+		r1_bio->bios[r1_bio->read_disk] = IO_BLOCKED;
+		return;
+	}
+
 	while(sectors) {
 		int s = sectors;
 		int d = read_disk;
 		int success = 0;
 		int start;
-		struct md_rdev *rdev;
 
 		if (s > (PAGE_SIZE>>9))
 			s = PAGE_SIZE >> 9;
@@ -2531,8 +2539,7 @@ static void handle_read_error(struct r1conf *conf, struct r1bio *r1_bio)
 	if (mddev->ro == 0
 	    && !test_bit(FailFast, &rdev->flags)) {
 		freeze_array(conf, 1);
-		fix_read_error(conf, r1_bio->read_disk,
-			       r1_bio->sector, r1_bio->sectors);
+		fix_read_error(conf, r1_bio);
 		unfreeze_array(conf);
 	} else if (mddev->ro == 0 && test_bit(FailFast, &rdev->flags)) {
 		md_error(mddev, rdev);
-- 
2.39.2


