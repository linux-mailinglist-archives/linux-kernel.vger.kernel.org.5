Return-Path: <linux-kernel+bounces-47699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4433184517C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B7F29520F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773591586F2;
	Thu,  1 Feb 2024 06:38:35 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F0D634FF;
	Thu,  1 Feb 2024 06:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706769515; cv=none; b=ulVnwuiRnLmBAUaEa6SrHZyF/RAmWZfVIWEj/YXvgE6OiWx6Z/QgAdyaqNKoxnHgv94Or8t7MCXImzu0Z/5dDHnhx/irxHoAhwQ62JlA9K0AvYZB+drFAzRW2KW46qgXMu3018svMIgjHBkm3No7yvb3GFgtnIkvvosxxeg0nK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706769515; c=relaxed/simple;
	bh=yUSpzBKNKCP4F8ui7+OgWicevcqCyLmefg0O0EI89H0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OCj+XCWLiEFZYmD+LuLbiZeXvMybxOm2tyW8tEJ/0uP+MoHG82IQd6VT8pCf8v1s9Cps65Y+gXhyDZVukaxbq9I5LgfBjR6JUCK0bBRxsRRrRG7A9hkC5gVs99ih46UUWtcgLdcjI0IwQxt5eZ3kxSwXAXkiWj/lVtOyPhOyYvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TQTkT0RQ6z4f3kp8;
	Thu,  1 Feb 2024 14:38:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 42EAC1A0172;
	Thu,  1 Feb 2024 14:38:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g5iPLtllCl+Cg--.15155S6;
	Thu, 01 Feb 2024 14:38:29 +0800 (CST)
From: linan666@huaweicloud.com
To: song@kernel.org,
	neilb@suse.com,
	mariusz.tkaczyk@linux.intel.com,
	shli@fb.com
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linan666@huaweicloud.com,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	houtao1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v5 2/8] md: changed the switch of RAID_VERSION to if
Date: Thu,  1 Feb 2024 14:33:58 +0800
Message-Id: <20240201063404.772797-3-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240201063404.772797-1-linan666@huaweicloud.com>
References: <20240201063404.772797-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g5iPLtllCl+Cg--.15155S6
X-Coremail-Antispam: 1UD129KBjvdXoW7GFyfWr1ftFW8Kw17JF4Dtwb_yoWxAFc_uF
	ZagF97JrZrCF1Ikr1Fvr4Svr90vFs3Wr4xuFnrKryFv3W3XF1xWa4v9wn8Xw4rJa4UuF98
	ZFnxtrWFvr4qkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbBkFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY02
	0Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vY
	z4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
	02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
	4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4
	IIrI8v6xkF7I0E8cxan2IY04v7M4kE6xkIj40Ew7xC0wCF04k20xvY0x0EwIxGrwCFx2Iq
	xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
	106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
	xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
	Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUpyIUUUUUU=
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

There is only one case of this 'switch'. Change it to 'if'.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/md.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 1b509fb82040..3b4e0ef49675 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7636,11 +7636,9 @@ static int md_ioctl(struct block_device *bdev, blk_mode_t mode,
 	 * Commands dealing with the RAID driver but not any
 	 * particular array:
 	 */
-	switch (cmd) {
-	case RAID_VERSION:
+	if (cmd == RAID_VERSION) {
 		err = get_version(argp);
 		goto out;
-	default:;
 	}
 
 	/*
-- 
2.39.2


