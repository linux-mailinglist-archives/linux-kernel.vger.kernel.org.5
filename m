Return-Path: <linux-kernel+bounces-47698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CB9845179
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ADA329523B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8799157E89;
	Thu,  1 Feb 2024 06:38:34 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC80273FE;
	Thu,  1 Feb 2024 06:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706769514; cv=none; b=nLHUiMgvcBAxxczmBSVFSlY+wJFMPSHngLXkb5m765YnALhp6iRlc8P/mhkFZ9ty1rN+ueoP5BqJLosmVYhCLzj1R1Lc2ePaZozyuWMaDpopS6KOMuH0DPk0KJEU7KhSC7/eTBbEPbE+2su1hMLhVgP+pCJJoLpH5LZNRAZkQOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706769514; c=relaxed/simple;
	bh=6Ba++b+T2b+uqsY3Gzwucb+I4SNfKuH1Oe2V2c4TUc4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NhYFR/uB8GryqJVneoMdordAsZWCu5rSN/qIsRLv07kZYak3BqPzTIOjjQ3Flni+MHC/q1mVPd4gXd3HZZulZYdiqhMMXi0Els1afa95/bVrD3s0aO54XgRNGjpHA2LLCVgeObC4y22HU2TOcomavvJpS0qrAqyNqe3ioOm9vdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TQTkT50tpz4f3kKx;
	Thu,  1 Feb 2024 14:38:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 499241A0199;
	Thu,  1 Feb 2024 14:38:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g5iPLtllCl+Cg--.15155S4;
	Thu, 01 Feb 2024 14:38:28 +0800 (CST)
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
Subject: [PATCH v5 0/8] bugfix of MD_CLOSING and clean up md_ioctl()
Date: Thu,  1 Feb 2024 14:33:56 +0800
Message-Id: <20240201063404.772797-1-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g5iPLtllCl+Cg--.15155S4
X-Coremail-Antispam: 1UD129KBjvdXoWrurWUArWxuw4fXr1rCrW5trb_yoWfCwc_ZF
	WkXF98Wr18CF13Ka4YvF1jyrW8tr40934UJF42kr42yw1xJ3W5Zr4DXFsxXw18XayI9FsY
	9ryDAw4IyanFqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUrc_-DUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

Changes in v5:
 - add patches 1-4 to clean up md_ioct(), pathc 4 can help us clean up
   local variable 'clear_md_closing'.
 - in patches 5 and 7, clean up local variable 'clear_md_closing'.

By the way, md_ioctl() is not readable now, I wanna to re-write it later
to make it only have one 'switch' like other drivers.

Li Nan (8):
  md: merge the check of capabilities into md_ioctl_valid()
  md: changed the switch of RAID_VERSION to if
  md: clean up invalid BUG_ON in md_ioctl
  md: return directly before setting did_set_md_closing
  md: Don't clear MD_CLOSING when the raid is about to stop
  md: factor out a helper to sync mddev
  md: sync blockdev before stopping raid or setting readonly
  md: check mddev->pers before calling md_set_readonly()

 drivers/md/md.c | 149 ++++++++++++++++++++++++++----------------------
 1 file changed, 80 insertions(+), 69 deletions(-)

-- 
2.39.2


