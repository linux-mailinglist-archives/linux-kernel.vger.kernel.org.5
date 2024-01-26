Return-Path: <linux-kernel+bounces-39916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA6283D75E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C460F1C21840
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426641D52B;
	Fri, 26 Jan 2024 09:27:03 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C497C1759E;
	Fri, 26 Jan 2024 09:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706261222; cv=none; b=cy1LoA6qdoVoGfbmmeleu40mC4K66byqtxccg3IzI9vIJOxt6/U5SFNgWjGMXFeJlDraxaH2DJIZsUGjyCRfwnfKGUO+LdUBD1zME8CWlsh+dvJ1SBW5kRmiaQojVzwmLvYb+qngFPUgESkTTmUBDBltO9Leey8uoPWtE+arkpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706261222; c=relaxed/simple;
	bh=FIx1uLPId8BHIh6NPhhScj8PP6AhDmIDrtP/uDFs44k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PW5ay9/9Y5ul/XMT310OFO9OMrVzOeK9eZKKn887toAoo+6MPfZDINgHc8Ur9/TxOGaCkuyYkEeT9h867oXpHAV8qiKcEpfTH8lRKBVWh5tSfyo2MwXulITEuu2jKwMVIQNXdQ5cPgmzgAup4Q0KTVLYCe4IQJMe25/4mXEUIzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TLsld4SR5z4f3l72;
	Fri, 26 Jan 2024 17:26:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 95ECD1A0272;
	Fri, 26 Jan 2024 17:26:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBHferNlLsUdCA--.25360S4;
	Fri, 26 Jan 2024 17:26:57 +0800 (CST)
From: linan666@huaweicloud.com
To: song@kernel.org,
	neilb@suse.com,
	shli@fb.com,
	mariusz.tkaczyk@linux.intel.com
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linan666@huaweicloud.com,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	houtao1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v4 0/4]  md: Don't clear MD_CLOSING when the raid is about to stop
Date: Fri, 26 Jan 2024 17:22:50 +0800
Message-Id: <20240126092254.1314908-1-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBHferNlLsUdCA--.25360S4
X-Coremail-Antispam: 1UD129KBjvdXoWrurW8KFWfZr1xJF1fWF15Jwb_yoW3urc_Jr
	WkAa4rGrn7GFWSka45Kr4DArW0yrWjgw4UXF4xtrWfXr1aqa4UWa1DJrs7Xwn7XFWrAF4F
	kw1UAFWfZF4qqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUBSoJUUUUU=
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

Changes in v4:
 - insert 'break;' to avoid fall-through in patch 3.

Changes in v3:
 - rename vaires 'did_set_md_closing' in patch 1.
 - rename function mddev_set_closing_and_sync_blockdev() in patch 2.
 - reorganize conditions in patch 3.
 - add a new patch to clean up md_set_readonly().

Changes in v2:
 - don't clear MD_CLOSING in md_clean().
 - set MD_CLOSING and sync blockdev in array_state_store().

Li Nan (4):
  md: Don't clear MD_CLOSING when the raid is about to stop
  md: factor out a helper to sync mddev
  md: sync blockdev before stopping raid or setting readonly
  md: check mddev->pers before calling md_set_readonly()

 drivers/md/md.c | 98 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 69 insertions(+), 29 deletions(-)

-- 
2.39.2


