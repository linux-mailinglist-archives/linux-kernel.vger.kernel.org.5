Return-Path: <linux-kernel+bounces-16763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3408824379
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60985287AC2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7063C225A8;
	Thu,  4 Jan 2024 14:17:46 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A4622F12;
	Thu,  4 Jan 2024 14:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4T5TF23VGBzZgFt;
	Thu,  4 Jan 2024 22:17:26 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 8048B18001C;
	Thu,  4 Jan 2024 22:17:40 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Jan
 2024 22:17:39 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <yukuai3@huawei.com>,
	<libaokun1@huawei.com>
Subject: [PATCH v3 0/8] ext4: fix divide error in mb_update_avg_fragment_size()
Date: Thu, 4 Jan 2024 22:20:32 +0800
Message-ID: <20240104142040.2835097-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500021.china.huawei.com (7.185.36.21)

V2->V3:
  Replace patch 3's changelog with the one suggested by Jan Kara.
  Refactor the code in patch 4 to make it more readable, as suggested by Jan Kara.
  Patch 8 is adapted based on patch 4 after modification.
  Add Reviewed-by tag.

V1->V2:
  Fixed some things pointed out by Jan Kara.
  Fixed more cases where blocks could be allocated from corrupted groups.

[V1]: https://lore.kernel.org/all/20231218141814.1477338-1-libaokun1@huawei.com/
[V2]: https://lore.kernel.org/all/20231221150558.2740823-1-libaokun1@huawei.com/

Baokun Li (8):
  ext4: fix double-free of blocks due to wrong extents moved_len
  ext4: do not trim the group with corrupted block bitmap
  ext4: regenerate buddy after block freeing failed if under fc replay
  ext4: avoid bb_free and bb_fragments inconsistency in mb_free_blocks()
  ext4: avoid dividing by 0 in mb_update_avg_fragment_size() when block
    bitmap corrupt
  ext4: avoid allocating blocks from corrupted group in
    ext4_mb_try_best_found()
  ext4: avoid allocating blocks from corrupted group in
    ext4_mb_find_by_goal()
  ext4: mark the group block bitmap as corrupted before reporting an
    error

 fs/ext4/mballoc.c     | 91 ++++++++++++++++++++++++++++---------------
 fs/ext4/move_extent.c |  6 +--
 2 files changed, 62 insertions(+), 35 deletions(-)

-- 
2.31.1


