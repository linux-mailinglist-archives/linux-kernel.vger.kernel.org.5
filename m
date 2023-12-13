Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A526881150C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442077AbjLMOnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441894AbjLMOnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:43:17 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216E4DD;
        Wed, 13 Dec 2023 06:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702478604; x=1734014604;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=+TftUUx2tLHphusHbKwAkIsPHhEjw8xGZXfDg5e4VA4=;
  b=p17WjYouU1pa/eNVZPgTrWjTBzHnz05WyWMmLwwi9giSrIxig+Tn9fiZ
   wKdAUfJDuauP8S+L6UHW5yxM0L6yaEH8bvKJeDh70McHs5Eee9dOdbH3P
   /dLnyE7W7Vj9IRSSPBPo6x+enq4mkk6l5iCS2DT/7rUItzq6dvsNczseD
   Vaa9bvFGZjBYprUORmvc8rndYlBuXUJTnkVElaYFpSsf07tytCELBCsIM
   FN3cNh5xRDG5/Saaos6hl8SvY0Yo46jic+HCCUz8om6CiisApFLnN3kGr
   K+ygMXWSHpQpz2Ehv2I7iS0uHF62TgrXO3HenB8NgtyVWddSlqu1e/vBU
   Q==;
X-CSE-ConnectionGUID: nf+DZJhFT1OtkMLl9oEkSA==
X-CSE-MsgGUID: Z1/XJVbrRsy7gnBZRYfW/Q==
X-IronPort-AV: E=Sophos;i="6.04,272,1695657600"; 
   d="scan'208";a="4580771"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2023 22:43:23 +0800
IronPort-SDR: zUSHzdLmWTnWUHuSxoV6+WxTQKZgy33EHNmSsTK70enuTJmDB0F7QOy4UcGzEI9K1sstDffQ5c
 FnRT3Ss7FF+A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2023 05:48:35 -0800
IronPort-SDR: 2i3JYJmaowjXk8a9dnNE++rmRUZIdVWsy/NP6EHrCjfPlhv3hf3ObCzWhCPWIdLAgtfL6N8nhW
 m4+7t5h9m5Zw==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Dec 2023 06:43:22 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Wed, 13 Dec 2023 06:43:08 -0800
Subject: [PATCH v2 13/13] btrfs: pass btrfs_io_geometry into
 btrfs_max_io_len
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231213-btrfs_map_block-cleanup-v2-13-cf5cfb9e2400@wdc.com>
References: <20231213-btrfs_map_block-cleanup-v2-0-cf5cfb9e2400@wdc.com>
In-Reply-To: <20231213-btrfs_map_block-cleanup-v2-0-cf5cfb9e2400@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702478586; l=3294;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=+TftUUx2tLHphusHbKwAkIsPHhEjw8xGZXfDg5e4VA4=;
 b=8Y2fUAr7KwnhLCRKmviEJLcDpFAOVutymltmuVbA1agTg8HC3E24PFd8X0JTUWyVO9qGYEPa7
 IfrGUGc+C1eAQ8pSyQn4yfpMQNTqq3ipnA6+6TvCoRKiiNBwVroRyJv
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

Instead of passing three individual members of 'struct btrfs_io_geometry'
into btrfs_max_io_len(), pass a pointer to btrfs_io_geometry.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 440ac0c1c907..af803b162d0b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6277,17 +6277,16 @@ static void handle_ops_on_dev_replace(enum btrfs_map_op op,
 	bioc->replace_nr_stripes = nr_extra_stripes;
 }
 
-static u64 btrfs_max_io_len(struct btrfs_chunk_map *map, enum btrfs_map_op op,
-			    u64 offset, u32 *stripe_nr, u64 *stripe_offset,
-			    u64 *full_stripe_start)
+static u64 btrfs_max_io_len(struct btrfs_chunk_map *map, u64 offset,
+			    struct btrfs_io_geometry *io_geom)
 {
 	/*
 	 * Stripe_nr is the stripe where this block falls.  stripe_offset is
 	 * the offset of this block in its stripe.
 	 */
-	*stripe_offset = offset & BTRFS_STRIPE_LEN_MASK;
-	*stripe_nr = offset >> BTRFS_STRIPE_LEN_SHIFT;
-	ASSERT(*stripe_offset < U32_MAX);
+	io_geom->stripe_offset = offset & BTRFS_STRIPE_LEN_MASK;
+	io_geom->stripe_nr = offset >> BTRFS_STRIPE_LEN_SHIFT;
+	ASSERT(io_geom->stripe_offset < U32_MAX);
 
 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
 		unsigned long full_stripe_len =
@@ -6302,18 +6301,19 @@ static u64 btrfs_max_io_len(struct btrfs_chunk_map *map, enum btrfs_map_op op,
 		 * to go rounddown(), not round_down(), as nr_data_stripes is
 		 * not ensured to be power of 2.
 		 */
-		*full_stripe_start =
-			btrfs_stripe_nr_to_offset(
-				rounddown(*stripe_nr, nr_data_stripes(map)));
+		io_geom->raid56_full_stripe_start = btrfs_stripe_nr_to_offset(
+			rounddown(io_geom->stripe_nr, nr_data_stripes(map)));
 
-		ASSERT(*full_stripe_start + full_stripe_len > offset);
-		ASSERT(*full_stripe_start <= offset);
+		ASSERT(io_geom->raid56_full_stripe_start + full_stripe_len >
+		       offset);
+		ASSERT(io_geom->raid56_full_stripe_start <= offset);
 		/*
 		 * For writes to RAID56, allow to write a full stripe set, but
 		 * no straddling of stripe sets.
 		 */
-		if (op == BTRFS_MAP_WRITE)
-			return full_stripe_len - (offset - *full_stripe_start);
+		if (io_geom->op == BTRFS_MAP_WRITE)
+			return full_stripe_len -
+			       (offset - io_geom->raid56_full_stripe_start);
 	}
 
 	/*
@@ -6321,7 +6321,7 @@ static u64 btrfs_max_io_len(struct btrfs_chunk_map *map, enum btrfs_map_op op,
 	 * a single disk).
 	 */
 	if (map->type & BTRFS_BLOCK_GROUP_STRIPE_MASK)
-		return BTRFS_STRIPE_LEN - *stripe_offset;
+		return BTRFS_STRIPE_LEN - io_geom->stripe_offset;
 	return U64_MAX;
 }
 
@@ -6567,9 +6567,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 
 	map_offset = logical - map->start;
 	io_geom.raid56_full_stripe_start = (u64)-1;
-	max_len = btrfs_max_io_len(map, io_geom.op, map_offset, &io_geom.stripe_nr,
-				   &io_geom.stripe_offset,
-				   &io_geom.raid56_full_stripe_start);
+	max_len = btrfs_max_io_len(map, map_offset, &io_geom);
 	*length = min_t(u64, map->chunk_len - map_offset, max_len);
 
 	down_read(&dev_replace->rwsem);

-- 
2.43.0

