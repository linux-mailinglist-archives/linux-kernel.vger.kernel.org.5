Return-Path: <linux-kernel+bounces-114487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15A488901B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54E4A291265
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9372017EB8C;
	Sun, 24 Mar 2024 23:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCyMtPYs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A971224A3A;
	Sun, 24 Mar 2024 23:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321933; cv=none; b=dMj2vd8ulXvXjoEnXSOV/qN+R7iYP+pXE3/kMbsojaJ+i0L4FYhYoAZkLhZKf2nyyGteXI026FtEPS7XyB7HCpUvuUl3HO7mn5oCkpBghLcGduJcWTIKd+USWLSZ67MK9x2JnDeefQBt+1R+C/VrLkZPCCPGAkOy+YbK2hY1mTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321933; c=relaxed/simple;
	bh=YDc8E3KzalxDjkSCtlxxcLyzt/KQurU33A4ccpgqgYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t7Thv+aOyWnCRtklrNtndkZI8f54F4GT0s56KuU6DuuBcXuiVlQeE5GGMoRLbEXO2vn0vHb/X7V14E6IgC2sxPIXSwD4DiCULuh8+dHzNbb4Mu1hLu6Evx+fEIcLOZDZ1pD91E4XK65Vxue34LqrtvwhCQqP2LjN4TVY6QYAPWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCyMtPYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A7FC433C7;
	Sun, 24 Mar 2024 23:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321932;
	bh=YDc8E3KzalxDjkSCtlxxcLyzt/KQurU33A4ccpgqgYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qCyMtPYs962fV+cmIrPnLbxbXqbR2tIXrcqax9mlIA5KOAnuX0VMdfDRPqEZ+RDTo
	 OtC3qIv7tZ0tX2dy8in2ozYc/jX5lGTtfc2RxM4bodAik4+qkOjduJHm6THLm7x6AJ
	 9EYatV2utxkicbHQnzUz1g1CiB+HzbYxDveOHlekB9Uaa6BttRA3iOHpzVDpYp2O/c
	 N96txkEnplxV59LQMqZLlIqlcVtQ5MluibDZVkojvZRgmhyg2voG85YoAz7NoC3JuI
	 AMbbsZyWnT5Y2gX+ffGBPBzbiCnNBW5SEkNOPS5OIF7N/f5L592mRxxsbfmoILN1ml
	 MqhrSYizZKkrA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>,
	Song Liu <song@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 002/451] md/raid10: prevent soft lockup while flush writes
Date: Sun, 24 Mar 2024 19:04:38 -0400
Message-ID: <20240324231207.1351418-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 010444623e7f4da6b4a4dd603a7da7469981e293 ]

Currently, there is no limit for raid1/raid10 plugged bio. While flushing
writes, raid1 has cond_resched() while raid10 doesn't, and too many
writes can cause soft lockup.

Follow up soft lockup can be triggered easily with writeback test for
raid10 with ramdisks:

watchdog: BUG: soft lockup - CPU#10 stuck for 27s! [md0_raid10:1293]
Call Trace:
 <TASK>
 call_rcu+0x16/0x20
 put_object+0x41/0x80
 __delete_object+0x50/0x90
 delete_object_full+0x2b/0x40
 kmemleak_free+0x46/0xa0
 slab_free_freelist_hook.constprop.0+0xed/0x1a0
 kmem_cache_free+0xfd/0x300
 mempool_free_slab+0x1f/0x30
 mempool_free+0x3a/0x100
 bio_free+0x59/0x80
 bio_put+0xcf/0x2c0
 free_r10bio+0xbf/0xf0
 raid_end_bio_io+0x78/0xb0
 one_write_done+0x8a/0xa0
 raid10_end_write_request+0x1b4/0x430
 bio_endio+0x175/0x320
 brd_submit_bio+0x3b9/0x9b7 [brd]
 __submit_bio+0x69/0xe0
 submit_bio_noacct_nocheck+0x1e6/0x5a0
 submit_bio_noacct+0x38c/0x7e0
 flush_pending_writes+0xf0/0x240
 raid10d+0xac/0x1ed0

Fix the problem by adding cond_resched() to raid10 like what raid1 did.

Note that unlimited plugged bio still need to be optimized, for example,
in the case of lots of dirty pages writeback, this will take lots of
memory and io will spend a long time in plug, hence io latency is bad.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20230529131106.2123367-2-yukuai1@huaweicloud.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid10.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 7b318e7e8d459..009f7ffe4e10c 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -920,6 +920,7 @@ static void flush_pending_writes(struct r10conf *conf)
 
 			raid1_submit_write(bio);
 			bio = next;
+			cond_resched();
 		}
 		blk_finish_plug(&plug);
 	} else
@@ -1130,6 +1131,7 @@ static void raid10_unplug(struct blk_plug_cb *cb, bool from_schedule)
 
 		raid1_submit_write(bio);
 		bio = next;
+		cond_resched();
 	}
 	kfree(plug);
 }
-- 
2.43.0


