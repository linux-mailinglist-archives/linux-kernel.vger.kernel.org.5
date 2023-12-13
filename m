Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75D8811502
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbjLMOn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbjLMOnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:43:11 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4594E91;
        Wed, 13 Dec 2023 06:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702478598; x=1734014598;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=sLjwrenKmqHBOSqsM1KRhm85HG8IZyehA4bXrtvn4bM=;
  b=ZQLgZOZC275uLopqeMKgSMzkrMY8CtaqDrt3RU1a9H5cio0PV4VMXVrL
   H+D8ulphFAWtdoyQ29FON/YxeY2BD9jIKW6MkqdLUwxuts82KOiQSbFv2
   KDL2Y4eFuvgXrRZCq5Hw9+f8IPZElgOvD8THCjxVOQ3WS3TpyY8cSySkE
   vm+UqBtLVvKI3E04m2xN0DEk9jEf9yRgr49y5GwxPmAfCAkq4adpvOpOf
   SKT8TZap/7uPtN4aYiDpaEtdeIFLv2ezwqbC0L1DvEYEKyFbx5jUCpVYY
   XL1VqxJpcSbgpLtrJjOyZ7in/Lh65Koq4l3zKmtfDEB1HBTDYkiQd/GGK
   g==;
X-CSE-ConnectionGUID: EkFSIohuSm+ooJQ9K/Wkgw==
X-CSE-MsgGUID: jPewL/rvQvi5Xyl14Xds4Q==
X-IronPort-AV: E=Sophos;i="6.04,272,1695657600"; 
   d="scan'208";a="4802972"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2023 22:43:17 +0800
IronPort-SDR: yIkfoK9NMfQ5amNWjB7XCr1Y8+sZR0QjjSpLWtWKGqqujb6rc7nsn96UO5sSk+eg/aXk0q3iTQ
 c9wfDbRYckTQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2023 05:48:29 -0800
IronPort-SDR: jPwWC4S6kGyM8dieutpeuowuWyiIVgIWCh6TWacQP2GwV9yx/q44p3bdBdHoxkLOd8Fc1bUdHW
 jdCeE/DcoJsw==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Dec 2023 06:43:15 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Wed, 13 Dec 2023 06:43:02 -0800
Subject: [PATCH v2 07/13] btrfs: reduce scope of data_stripes in
 btrfs_map_block
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231213-btrfs_map_block-cleanup-v2-7-cf5cfb9e2400@wdc.com>
References: <20231213-btrfs_map_block-cleanup-v2-0-cf5cfb9e2400@wdc.com>
In-Reply-To: <20231213-btrfs_map_block-cleanup-v2-0-cf5cfb9e2400@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702478586; l=1985;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=sLjwrenKmqHBOSqsM1KRhm85HG8IZyehA4bXrtvn4bM=;
 b=QCzPri8RzAPG0gQUjoB9ReI3jAolOkhuz/CxGWfC4Z32Nu4ABb2QM8e69FhqOPars7B46FJ2F
 0S1GI3+M2PSD6ncphJIeR8ono5Xs/VBqXt7ixv/kwKsS2xRsAZC2ESr
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
index 4c9c130cdfd0..3a6a2f71d364 100644
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
@@ -6505,8 +6504,6 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	if (IS_ERR(map))
 		return PTR_ERR(map);
 
-	data_stripes = nr_data_stripes(map);
-
 	map_offset = logical - map->start;
 	io_geom.raid56_full_stripe_start = (u64)-1;
 	max_len = btrfs_max_io_len(map, io_geom.op, map_offset, &io_geom.stripe_nr,
@@ -6534,6 +6531,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		map_blocks_raid10(fs_info, map, &io_geom,
 				  dev_replace_is_ongoing);
 	} else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
+		int data_stripes = nr_data_stripes(map);
+
 		if (op != BTRFS_MAP_READ || io_geom.mirror_num > 1) {
 			/*
 			 * Needs full stripe mapping.
@@ -6645,7 +6644,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
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

