Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A3880EC14
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376257AbjLLMiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346673AbjLLMif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:38:35 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F18D18C;
        Tue, 12 Dec 2023 04:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702384710; x=1733920710;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=7IitFGc7/IJjyGbmbRVykpWQDNZ+Fz3j+hjcbSopc1E=;
  b=K/Yb0BNOsoES05ZFwy5REND1r1cIX9RQdVEIG9LTijrgsXON2l04Z1lQ
   TfNtO5+L7h5KB6bd7H65ckdAO5mzwuoAzZaFPpIkhLwEwyxTwPaok1Ork
   Urmh9V86MlwWFkK4kxGG5jusJWn4WYBx1s3d0cOnkmjFhVjQ43QzVxPTn
   1AZJ/rnkW0hP2K85p3lrjl9W+GDdomTJQIBweWLZFuTrWAe9dnn1SuZMT
   2PFcxQi9RDICzAI2D+pZbY0sXZUbFVmdJK9UIB+E3bFF6kbPEVv8zkCE/
   qKzs6MZvuhpv8y1I4lTb7Y9hX9pP4VJt9xDSj9SSE/mwt/lAdKhrfK/LM
   Q==;
X-CSE-ConnectionGUID: pD/fV8xhRcexNxFDJ//omg==
X-CSE-MsgGUID: kRCA0+rwTeq+zgKt6hj8XA==
X-IronPort-AV: E=Sophos;i="6.04,270,1695657600"; 
   d="scan'208";a="4629799"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2023 20:38:22 +0800
IronPort-SDR: R4NX11529yF01cq9XPPIhIyS2B7QsnjTifd/BKHds/GrkRATpWcmFwY/hURfE8oYNZiO6jb++j
 kD/zgcJI1pdg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2023 03:43:36 -0800
IronPort-SDR: 8J6ZDf1DDploJw+gY5lkK5JekK+E157uSfQee0KdypWrWGmB74LaZBDHO0y6h4YPSaEP7JcZ5L
 4oUfsuBCHBZg==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2023 04:38:21 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Tue, 12 Dec 2023 04:38:05 -0800
Subject: [PATCH 07/13] btrfs: reduce scope of data_stripes in
 btrfs_map_block
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-btrfs_map_block-cleanup-v1-7-b2d954d9a55b@wdc.com>
References: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
In-Reply-To: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702384691; l=1989;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=7IitFGc7/IJjyGbmbRVykpWQDNZ+Fz3j+hjcbSopc1E=;
 b=m4KZIBJGlht6nE4zqHrrx7BstIG8G4cLN/crwdkYixYRslsvpO2Vc38LmvGL3ofu+E3yGlXJQ
 06Jf6iwdjM6C2PklkZji0KGEd7Oih8sPYImBrGyVe0epBCfvmyAOGPr
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

Reduce the scope of 'data_stripes' in btrfs_map_block(). While the change
allone doesn't make too much sense, it helps us factoring out a helper
function for the block mapping of RAID56 I/O.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9090bfc4fe38..bc0988d8bd56 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6480,7 +6480,6 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	struct btrfs_chunk_map *map;
 	struct btrfs_io_geometry io_geom = { };
 	u64 map_offset;
-	int data_stripes;
 	int i;
 	int ret = 0;
 	int num_copies;
@@ -6500,8 +6499,6 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	if (IS_ERR(map))
 		return PTR_ERR(map);
 
-	data_stripes = nr_data_stripes(map);
-
 	map_offset = logical - map->start;
 	io_geom.raid56_full_stripe_start = (u64)-1;
 	max_len = btrfs_max_io_len(map, op, map_offset, &io_geom.stripe_nr,
@@ -6532,6 +6529,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		map_blocks_for_raid10(fs_info, map, op, &io_geom,
 				      dev_replace_is_ongoing);
 	} else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
+		int data_stripes = nr_data_stripes(map);
+
 		if (op != BTRFS_MAP_READ || io_geom.mirror_num > 1) {
 			/*
 			 * Needs full stripe mapping.
@@ -6643,7 +6642,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		 * modulo, to reduce one modulo call.
 		 */
 		bioc->full_stripe_logical = map->start +
-			btrfs_stripe_nr_to_offset(io_geom.stripe_nr * data_stripes);
+			btrfs_stripe_nr_to_offset(io_geom.stripe_nr *
+							nr_data_stripes(map));
 		for (int i = 0; i < io_geom.num_stripes; i++) {
 			ret = set_io_stripe(fs_info, op, logical, length,
 					    &bioc->stripes[i], map,

-- 
2.43.0

