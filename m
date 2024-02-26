Return-Path: <linux-kernel+bounces-80456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2C886689C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7631C21362
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63CA14AB2;
	Mon, 26 Feb 2024 03:20:40 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773331172C;
	Mon, 26 Feb 2024 03:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708917640; cv=none; b=fJIiPNKMQ8aioxWvrgdm6VqAvO8/eMItTzDIAFFW8U0ARYHrfDuUse5Cw1xc/1zdCKFs3TdzZGHjZeW7o/7hv1Guwv2mxgFrqfWoGMajPT0fR4L6/nq7wqSR7Tow9jsJkYRYudxot7vsye9miV3/fZ7/hdW3WZzn1r6e0lOys2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708917640; c=relaxed/simple;
	bh=8uON6ExkItyMBcuClHBaUoANSnGY1opElW9eSX9yIoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TKXigYtWlWSfO1OFsujSRUyVpraPBpe8pgi3ns7y+FN4tKzrjdUeJBY9oWXrw8ZS8/WtaWXCpQfWUNK6kZqE2AlkIKifoQvxY7cI+M9E5ss+r3FdBhBJTI2WqMnxJI23LsZffC6/7PQObU9JnXJpc6H21HwcgTHzpvAiTMCYnC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tjm8W4CRGz4f3mHW;
	Mon, 26 Feb 2024 11:20:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D771A1A0A03;
	Mon, 26 Feb 2024 11:20:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g5_A9xl7gKzFA--.13921S6;
	Mon, 26 Feb 2024 11:20:34 +0800 (CST)
From: linan666@huaweicloud.com
To: song@kernel.org,
	shli@fb.com,
	neilb@suse.com
Cc: mariusz.tkaczyk@linux.intel.com,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linan666@huaweicloud.com,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	houtao1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v7 2/9] md: changed the switch of RAID_VERSION to if
Date: Mon, 26 Feb 2024 11:14:37 +0800
Message-Id: <20240226031444.3606764-3-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240226031444.3606764-1-linan666@huaweicloud.com>
References: <20240226031444.3606764-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g5_A9xl7gKzFA--.13921S6
X-Coremail-Antispam: 1UD129KBjvdXoW7GFyfWr1kJrWxAF4fGw1UGFg_yoW3GrX_ua
	1Sqas7JrW2kF1Skr10vr43ZryYyFs7Wr4xuFnFg3s5Zw13ZryfWrn5GrZ8Xw4rXa4UWF98
	AFn8trWFvr4DKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbBkFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY02
	0Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
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

There is only one case of this 'switch'. Change it to 'if'.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/md.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 332eda680aea..b783a64765a7 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7612,12 +7612,8 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
 	 * Commands dealing with the RAID driver but not any
 	 * particular array:
 	 */
-	switch (cmd) {
-	case RAID_VERSION:
-		err = get_version(argp);
-		goto out;
-	default:;
-	}
+	if (cmd == RAID_VERSION)
+		return get_version(argp);
 
 	/*
 	 * Commands creating/starting a new array:
-- 
2.39.2


