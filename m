Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B6080EC16
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346764AbjLLMix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346542AbjLLMig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:38:36 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD2518A;
        Tue, 12 Dec 2023 04:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702384710; x=1733920710;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=13sSKOdPGCtJkfDz7HQPJxztkCHKHtWtxlS4sYRz4H4=;
  b=E0mtm3ODGYYYMV8YUegryncaZoWzS4o6t4v9LxRadScZkpdqSjm9x6cg
   vA1Ek6wO6BCYWJaMRdj3zw2zUeOAo5yUNoSM9ViHXZxrZp0TV0MgG6SrU
   S3vH4NUVqs0MGgnjC72v3suCpa333uqDt10FpYD1eaSODZl69OliJ7Ca3
   b6wyN1a3zkDfb8jXsPpdWZ1U4OKoL/da69PV8E/4GOlpcSK7DlezAsORT
   7/RCgbAAShhVdYLT6xVKCMeZt0jfh+bUEM3ry7xUrQFNoPrpzL1Tz6S9Z
   sBVKZB24NFoEH2y94qaxTXl+t2Ehbn3LIStRgE2SNSxU+xmqT0HLZVLgj
   g==;
X-CSE-ConnectionGUID: va5vw7GKTH2FBlFviEvl2g==
X-CSE-MsgGUID: 7MRTnW96QaS6F8qfMtdagA==
X-IronPort-AV: E=Sophos;i="6.04,270,1695657600"; 
   d="scan'208";a="4629800"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2023 20:38:24 +0800
IronPort-SDR: j0J/dG2cgKpx4DcpuqCRoR9U3+qv9Iyxt69e4py1qaKKfCOEgTOOhEErPFzooqtcZVCEgU/gs9
 xt3mSFH/xcyQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2023 03:43:37 -0800
IronPort-SDR: 5scbsRwiXUxhNm5LGPAxCPN18+mYWq7ksdwM55JYQOAmA9fXPdGQOgKwRqgDip5/vxloYNCMhF
 ETdj34Q+m/kw==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2023 04:38:23 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Tue, 12 Dec 2023 04:38:06 -0800
Subject: [PATCH 08/13] btrfs: factor out block mapping for RAID5/6
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-btrfs_map_block-cleanup-v1-8-b2d954d9a55b@wdc.com>
References: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
In-Reply-To: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702384691; l=4237;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=13sSKOdPGCtJkfDz7HQPJxztkCHKHtWtxlS4sYRz4H4=;
 b=TDOS5Lt38tJFregGC9nNL23Jv/PCsz8I1IJK3qjSuXJmjp4sHbxkXD8Qf6U/zluSNhuTSShXE
 g170bvYfm06B9G05ZhEWK0oilO0BXLCZROYDmNQO0fnNI4awFm6dmCK
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a container for the I/O geometry that has all the needed
information for the block mappings of RAID5 and RAID6, factor out a helper
calculating this information.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 91 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 49 insertions(+), 42 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index bc0988d8bd56..fd213bb7d619 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6437,6 +6437,54 @@ static void map_blocks_for_raid10(struct btrfs_fs_info *fs_info,
 	io_geom->mirror_num = io_geom->stripe_index - old_stripe_index + 1;
 }
 
+static void map_blocks_for_raid56(struct btrfs_chunk_map *map,
+				  enum btrfs_map_op op,
+				  struct btrfs_io_geometry *io_geom,
+				  u64 logical, u64 *length)
+{
+	int data_stripes = nr_data_stripes(map);
+
+	if (op != BTRFS_MAP_READ || io_geom->mirror_num > 1) {
+		/*
+		 * Needs full stripe mapping.
+		 *
+		 * Push stripe_nr back to the start of the full stripe
+		 * For those cases needing a full stripe, @stripe_nr
+		 * is the full stripe number.
+		 *
+		 * Originally we go raid56_full_stripe_start / full_stripe_len,
+		 * but that can be expensive.  Here we just divide
+		 * @stripe_nr with @data_stripes.
+		 */
+		io_geom->stripe_nr /= data_stripes;
+
+		/* RAID[56] write or recovery. Return all stripes */
+		io_geom->num_stripes = map->num_stripes;
+		io_geom->max_errors = btrfs_chunk_max_errors(map);
+
+		/* Return the length to the full stripe end */
+		*length = min(logical + *length,
+			      io_geom->raid56_full_stripe_start + map->start +
+				      btrfs_stripe_nr_to_offset(data_stripes)) -
+			  logical;
+		io_geom->stripe_index = 0;
+		io_geom->stripe_offset = 0;
+		return;
+	}
+
+	ASSERT(io_geom->mirror_num <= 1);
+	/* Just grab the data stripe directly. */
+	io_geom->stripe_index = io_geom->stripe_nr % data_stripes;
+	io_geom->stripe_nr /= data_stripes;
+
+	/* We distribute the parity blocks across stripes */
+	io_geom->stripe_index =
+		(io_geom->stripe_nr + io_geom->stripe_index) % map->num_stripes;
+
+	if (op == BTRFS_MAP_READ && io_geom->mirror_num < 1)
+		io_geom->mirror_num = 1;
+}
+
 /*
  * Map one logical range to one or more physical ranges.
  *
@@ -6529,48 +6577,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		map_blocks_for_raid10(fs_info, map, op, &io_geom,
 				      dev_replace_is_ongoing);
 	} else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-		int data_stripes = nr_data_stripes(map);
-
-		if (op != BTRFS_MAP_READ || io_geom.mirror_num > 1) {
-			/*
-			 * Needs full stripe mapping.
-			 *
-			 * Push stripe_nr back to the start of the full stripe
-			 * For those cases needing a full stripe, @stripe_nr
-			 * is the full stripe number.
-			 *
-			 * Originally we go raid56_full_stripe_start / full_stripe_len,
-			 * but that can be expensive.  Here we just divide
-			 * @stripe_nr with @data_stripes.
-			 */
-			io_geom.stripe_nr /= data_stripes;
-
-			/* RAID[56] write or recovery. Return all stripes */
-			io_geom.num_stripes = map->num_stripes;
-			io_geom.max_errors = btrfs_chunk_max_errors(map);
-
-			/* Return the length to the full stripe end */
-			*length = min(logical + *length,
-				      io_geom.raid56_full_stripe_start +
-					      map->start +
-					      btrfs_stripe_nr_to_offset(
-						      data_stripes)) -
-				  logical;
-			io_geom.stripe_index = 0;
-			io_geom.stripe_offset = 0;
-		} else {
-			ASSERT(io_geom.mirror_num <= 1);
-			/* Just grab the data stripe directly. */
-			io_geom.stripe_index = io_geom.stripe_nr % data_stripes;
-			io_geom.stripe_nr /= data_stripes;
-
-			/* We distribute the parity blocks across stripes */
-			io_geom.stripe_index =
-				(io_geom.stripe_nr + io_geom.stripe_index) %
-					map->num_stripes;
-			if (op == BTRFS_MAP_READ && io_geom.mirror_num < 1)
-				io_geom.mirror_num = 1;
-		}
+		map_blocks_for_raid56(map, op, &io_geom, logical, length);
 	} else {
 		/*
 		 * After this, stripe_nr is the number of stripes on this

-- 
2.43.0

