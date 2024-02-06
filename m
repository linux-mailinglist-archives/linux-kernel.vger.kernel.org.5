Return-Path: <linux-kernel+bounces-54543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C214E84B088
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30BAAB229DE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5571912C541;
	Tue,  6 Feb 2024 08:59:58 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C0B12D14B;
	Tue,  6 Feb 2024 08:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707209997; cv=none; b=TRepieV/Wwe1WDf1MklNKokMzapl6Qg+V7Srp5F1KwH2nLqcQGJXGnUT3oXGz8OT0zFCHGl0LzsuDJHE1gNFZbD7/DXVhQGq+c14losiO9CKpedS0D7J9+6xAlb+7+Piz8LXr2c10y4iKKfXMjjVUptff0XZmZYNXLjiqKJNJoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707209997; c=relaxed/simple;
	bh=LSJURmfYmqv5RFHR10D+DrFUTJ9KA2W9tOGt9KbH8NI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tk9FbxSN9Se0nUN41EhlbKbf3lGhHwy5dNnuwAZB4/5LvOcrmkdJO4qQP4rKZ0LKr0hEGzCVI7kyOF/ug2rRAEd4ZgxsV7LnBvjEWbB4s5JJHy3d80YZyvB5Mw18MrdIWymvP6MOyMoOgz6IJg6WRZf8HYI7JlQAjrcFoBWdH0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TTcdJ18N3z4f3khn;
	Tue,  6 Feb 2024 16:59:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 90DC61A027B;
	Tue,  6 Feb 2024 16:59:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBEG9cFldA+QDA--.34552S4;
	Tue, 06 Feb 2024 16:59:52 +0800 (CST)
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
Subject: [PATCH v6 0/9] bugfix of MD_CLOSING and clean up md_ioctl()
Date: Tue,  6 Feb 2024 16:55:02 +0800
Message-Id: <20240206085511.2841555-1-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBEG9cFldA+QDA--.34552S4
X-Coremail-Antispam: 1UD129KBjvdXoWrurW8KF4fAFy3tryUWFyfWFg_yoWkuFc_WF
	Z5Aas8Wr18CF43Ka45ZF15ArWUtrW09ryUJF47Cr4ayw1xtw15ZFWDJFZxXw1xXayI9FnY
	9r4DAa1Iyan7XjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbf8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7M4kE6xkIj40Ew7xC0wCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
	x2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSApUUUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

Changes in v6:
 - in patch 2, return directly.
 - in patch 4, return directly in case GET_DISK_INFO and GET_ARRAY_INFO.
 - in patch 7, rewrite commit message.
 - add patch 8, clean up openers check.

Changes in v5:
 - add patches 1-4 to clean up md_ioct(), pathc 4 can help us clean up
   local variable 'clear_md_closing'.
 - in patches 5 and 7, clean up local variable 'clear_md_closing'.

By the way, md_ioctl() is not readable now, I wanna to re-write it later
to make it only have one 'switch' like other drivers.

Li Nan (9):
  md: merge the check of capabilities into md_ioctl_valid()
  md: changed the switch of RAID_VERSION to if
  md: clean up invalid BUG_ON in md_ioctl
  md: return directly before setting did_set_md_closing
  md: Don't clear MD_CLOSING when the raid is about to stop
  md: factor out a helper to sync mddev
  md: sync blockdev before stopping raid or setting readonly
  md: clean up openers check in do_md_stop() and md_set_readonly()
  md: check mddev->pers before calling md_set_readonly()

 drivers/md/md.c | 190 ++++++++++++++++++++++++------------------------
 1 file changed, 94 insertions(+), 96 deletions(-)

-- 
2.39.2


