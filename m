Return-Path: <linux-kernel+bounces-54547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3178684B090
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B92AAB21832
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AEB12E1ED;
	Tue,  6 Feb 2024 09:00:00 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C7C12D161;
	Tue,  6 Feb 2024 08:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707209999; cv=none; b=fencTMNi6vaTFb5KFKLmeccDDYpwF4rfBSE52xAOtAWDCcpraeWhp/ouM3XuwIGvz5IRBIcDDLLXlRdiMJ8YJ7gNdrEYQmcNpklo6PCfk1ruAQm52o/tk2tCQuKGtKfOctHD2evWo2pxsQnVyecAGviYLU1d8hdfsKreYtuSsPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707209999; c=relaxed/simple;
	bh=0eM9a+BLPyshHZ+cYhbvhP0NmcRRNc1MK5/f4P8xSn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DqjVpUNGb/ev2Fe4kmrG7wiLck1p/5FkTHpKnjUMlqCohy+MIWaCTAiZLNzxWkkgTvK1zgztkaw5x3rYj8nVNqNVyVlKgJuvH1dcoI4nlRS7SSLCxNYmasQSYcxE5Sd9NjpkKQp/9JIyhnY3F7KNNlT/gVTHL90djhq7JwUJAhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TTcdK3PXJz4f3kj3;
	Tue,  6 Feb 2024 16:59:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DE3A71A0C59;
	Tue,  6 Feb 2024 16:59:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBEG9cFldA+QDA--.34552S7;
	Tue, 06 Feb 2024 16:59:53 +0800 (CST)
From: linan666@huaweicloud.com
To: song@kernel.org,
	mariusz.tkaczyk@linux.intel.com,
	shli@fb.com,
	neilb@suse.com
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linan666@huaweicloud.com,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	houtao1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v6 3/9] md: clean up invalid BUG_ON in md_ioctl
Date: Tue,  6 Feb 2024 16:55:05 +0800
Message-Id: <20240206085511.2841555-4-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240206085511.2841555-1-linan666@huaweicloud.com>
References: <20240206085511.2841555-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBEG9cFldA+QDA--.34552S7
X-Coremail-Antispam: 1UD129KBjvdXoWrKry5WFy5tFykWw43Kr4UJwb_yoW3tFc_ua
	yrZF9rXryxZFyIkr15tr13ZFy0yFn7Wrn7ZF1a9ry5ZFy7XryrGFZYgws8Xan5WFW7uryq
	yr4ayrsYyrsrKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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

'disk->private_data' is set to mddev in md_alloc() and never set to NULL,
and users need to open mddev before submitting ioctl. So mddev must not
have been freed during ioctl, and there is no need to check mddev here.
Clean up it.

Signed-off-by: Li Nan <linan122@huawei.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index ea147348bd24..fb4e80a0aa9a 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7645,11 +7645,6 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
 
 	mddev = bdev->bd_disk->private_data;
 
-	if (!mddev) {
-		BUG();
-		goto out;
-	}
-
 	/* Some actions do not requires the mutex */
 	switch (cmd) {
 	case GET_ARRAY_INFO:
-- 
2.39.2


