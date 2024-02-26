Return-Path: <linux-kernel+bounces-80462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F408668AB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77F521C21686
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0301C696;
	Mon, 26 Feb 2024 03:20:44 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C57A1B94E;
	Mon, 26 Feb 2024 03:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708917644; cv=none; b=XKs+AFJ/rnfb+iN9CB00YeNMgMUIm9NuEJGq6KIYzZ5J4/CLaGuYpy+zssr4GtvHsDBEVu00QsSUlqgKJFLyakss9II5udkP08KM2swbBhvTkuvEEIuzN9QDZMms+L+NBDAV+hz+lF1dYiar1SmIzg+0E4qI3O/dmJhu3K/0AHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708917644; c=relaxed/simple;
	bh=Pb+nukCNoYTydGMlkfyH1QI3j74Xn9liscDHiVH61EI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Po0+yGEsQV/ZC8zU5jYgaRW55p6SWF6igulwVH7CnEKP8HACiJja3+HyKYO2Bch+8Wh58pXEKKQYY1n0rE9YVbSjNbxaCYfZLbbbKawR6itmVtNOM0FvIwu430GceAWEjBcbEi9cgWPniThdsujb+gSaNyTJ2u5RuzlX4xmyWW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Tjm8X5Sgbz4f3jXP;
	Mon, 26 Feb 2024 11:20:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E8DB61A0ECC;
	Mon, 26 Feb 2024 11:20:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g5_A9xl7gKzFA--.13921S4;
	Mon, 26 Feb 2024 11:20:33 +0800 (CST)
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
Subject: [PATCH v7 0/9] bugfix of MD_CLOSING and clean up md_ioctl()
Date: Mon, 26 Feb 2024 11:14:35 +0800
Message-Id: <20240226031444.3606764-1-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g5_A9xl7gKzFA--.13921S4
X-Coremail-Antispam: 1UD129KBjvdXoWrurWUKw4rXrW8ArWxWr45ZFb_yoWkJFc_XF
	Z5Aa45Wr1xCF42ka45ZF1UArWjyr48GryUJFs2kr42yw17tw1UXFWDJF43Xw17WFWIkF1r
	Cr4DAa1Iyan7XjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
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

Changes in v7:
 - adapt to md-6.9 branch.

Changes in v6:
 - in patch 2, return directly.
 - in patch 4, return directly in case GET_DISK_INFO and GET_ARRAY_INFO.
 - in patch 7, rewrite commit message.
 - add patch 8, clean up openers check.

Changes in v5:
 - add patches 1-4 to clean up md_ioct(), pathc 4 can help us clean up
   local variable 'clear_md_closing'.
 - in patches 5 and 7, clean up local variable 'clear_md_closing'.


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

 drivers/md/md.c | 183 ++++++++++++++++++++++++------------------------
 1 file changed, 91 insertions(+), 92 deletions(-)

-- 
2.39.2


