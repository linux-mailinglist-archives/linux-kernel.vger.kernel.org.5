Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB3C7FC853
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376404AbjK1VN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376472AbjK1VNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:13:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F27C2111
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:09:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B223FC43397;
        Tue, 28 Nov 2023 21:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205787;
        bh=OQG5pExFCrizfxS4lhZazsQx4RqNvZXSW3hWT1Vz/Xg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pu5o12nGOsbFA8T0M8v1PyABCeT1iuxkGtTW24V/4BKRN+HfRgJVdikqfgBVq4A/C
         7fUe2LyitM5PtnJulifnznP8QJ+lUyqN5fcmU1/YaV9rPp/96F+tdYI6Kwt44ERm7o
         Mke5XM1p4uDfdAqhnqiMLyhuorAMOjD5EhRinx5e9jaFGkQ80pjAold+TyyrnzxYRI
         NpUF/QqSszrEGp5eyFomnE6n7SVy8fI0F9bkPHIW3R2iggfhdbungPF9FvDzGA3rW2
         ViKRATrPSNmFAh+yjnjTVM/tQeFfFbxX1033EgcgA2mX6sgAD1X4sRgwilJgAdyx15
         6pDF8C/3VKsTA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Coly Li <colyli@suse.de>,
        Andrea Tomassetti <andrea.tomassetti-opensource@devo.com>,
        Eric Wheeler <bcache@lists.ewheeler.net>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        kent.overstreet@gmail.com, linux-bcache@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 03/11] bcache: avoid oversize memory allocation by small stripe_size
Date:   Tue, 28 Nov 2023 16:09:27 -0500
Message-ID: <20231128210941.877094-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210941.877094-1-sashal@kernel.org>
References: <20231128210941.877094-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.262
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Coly Li <colyli@suse.de>

[ Upstream commit baf8fb7e0e5ec54ea0839f0c534f2cdcd79bea9c ]

Arraies bcache->stripe_sectors_dirty and bcache->full_dirty_stripes are
used for dirty data writeback, their sizes are decided by backing device
capacity and stripe size. Larger backing device capacity or smaller
stripe size make these two arraies occupies more dynamic memory space.

Currently bcache->stripe_size is directly inherited from
queue->limits.io_opt of underlying storage device. For normal hard
drives, its limits.io_opt is 0, and bcache sets the corresponding
stripe_size to 1TB (1<<31 sectors), it works fine 10+ years. But for
devices do declare value for queue->limits.io_opt, small stripe_size
(comparing to 1TB) becomes an issue for oversize memory allocations of
bcache->stripe_sectors_dirty and bcache->full_dirty_stripes, while the
capacity of hard drives gets much larger in recent decade.

For example a raid5 array assembled by three 20TB hardrives, the raid
device capacity is 40TB with typical 512KB limits.io_opt. After the math
calculation in bcache code, these two arraies will occupy 400MB dynamic
memory. Even worse Andrea Tomassetti reports that a 4KB limits.io_opt is
declared on a new 2TB hard drive, then these two arraies request 2GB and
512MB dynamic memory from kzalloc(). The result is that bcache device
always fails to initialize on his system.

To avoid the oversize memory allocation, bcache->stripe_size should not
directly inherited by queue->limits.io_opt from the underlying device.
This patch defines BCH_MIN_STRIPE_SZ (4MB) as minimal bcache stripe size
and set bcache device's stripe size against the declared limits.io_opt
value from the underlying storage device,
- If the declared limits.io_opt > BCH_MIN_STRIPE_SZ, bcache device will
  set its stripe size directly by this limits.io_opt value.
- If the declared limits.io_opt < BCH_MIN_STRIPE_SZ, bcache device will
  set its stripe size by a value multiplying limits.io_opt and euqal or
  large than BCH_MIN_STRIPE_SZ.

Then the minimal stripe size of a bcache device will always be >= 4MB.
For a 40TB raid5 device with 512KB limits.io_opt, memory occupied by
bcache->stripe_sectors_dirty and bcache->full_dirty_stripes will be 50MB
in total. For a 2TB hard drive with 4KB limits.io_opt, memory occupied
by these two arraies will be 2.5MB in total.

Such mount of memory allocated for bcache->stripe_sectors_dirty and
bcache->full_dirty_stripes is reasonable for most of storage devices.

Reported-by: Andrea Tomassetti <andrea.tomassetti-opensource@devo.com>
Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-by: Eric Wheeler <bcache@lists.ewheeler.net>
Link: https://lore.kernel.org/r/20231120052503.6122-2-colyli@suse.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/bcache/bcache.h | 1 +
 drivers/md/bcache/super.c  | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 1dd9298cb0e02..7bce582788458 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -265,6 +265,7 @@ struct bcache_device {
 #define BCACHE_DEV_WB_RUNNING		3
 #define BCACHE_DEV_RATE_DW_RUNNING	4
 	int			nr_stripes;
+#define BCH_MIN_STRIPE_SZ		((4 << 20) >> SECTOR_SHIFT)
 	unsigned int		stripe_size;
 	atomic_t		*stripe_sectors_dirty;
 	unsigned long		*full_dirty_stripes;
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 6afaa5e852837..d5f57a9551dda 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -822,6 +822,8 @@ static int bcache_device_init(struct bcache_device *d, unsigned int block_size,
 
 	if (!d->stripe_size)
 		d->stripe_size = 1 << 31;
+	else if (d->stripe_size < BCH_MIN_STRIPE_SZ)
+		d->stripe_size = roundup(BCH_MIN_STRIPE_SZ, d->stripe_size);
 
 	n = DIV_ROUND_UP_ULL(sectors, d->stripe_size);
 	if (!n || n > max_stripes) {
-- 
2.42.0

