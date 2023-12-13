Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A108114FE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441930AbjLMOnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379214AbjLMOnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:43:07 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF29710D;
        Wed, 13 Dec 2023 06:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702478593; x=1734014593;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=OGBopphelKNfH3fDb7Sryq8+Z3p2RDE/ywfM09UR7p4=;
  b=bi1hDzPpuKz0//o8Oxmm8HLJnQ4g4W7TxEOywbRKxhyjgisp64xgXCzS
   jJxSduvcv4Dksf+F+5eQ14HX8sPSnQlchYJUD3OCJHH6UueAo6m2BIV++
   9WPCIPFj1qoZFjNV4PqIsTuhVyimqY9/cdol0eAgV97YZs22S7K3a/B+a
   f/G8yp+z8XJ4pYoSr+tlvy7GEgUUWq5S8wDCxAF3bFiE2FwR1iLOJqsAR
   08UmLScHaJj2fxbfN5CYhyDSdsUvjVmKvodgcVl1Ncq6iwBoNlXjcCbEn
   eUfhoPvmP61UAYqhVA7pb8Upz41M8edVAubjDhJasIfSxPwVgTq9fQY8P
   Q==;
X-CSE-ConnectionGUID: 1f+F10bjSYigoi42PdxRig==
X-CSE-MsgGUID: FEuCJKl3SemXdBePbuYRSA==
X-IronPort-AV: E=Sophos;i="6.04,272,1695657600"; 
   d="scan'208";a="4802960"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2023 22:43:13 +0800
IronPort-SDR: FLJAOc0lbqerwDZ4MToxlU4c9G7Ttz9yqNEZuHaraCPJrIOnuibTmOeMu9t9Q9cB+cWd8Al1ij
 Znz4+PAH1mEQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2023 05:48:25 -0800
IronPort-SDR: rnTZSX//iZgybjgnnAkzZqoPezDuWIFemcqbCoxFEr5w+jxQ2TeSNvkH0WraZ1ksD8KfbGE2Xf
 NxEebyD4s/Bg==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Dec 2023 06:43:12 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Wed, 13 Dec 2023 06:43:00 -0800
Subject: [PATCH v2 05/13] btrfs: factor out block mapping for DUP profiles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231213-btrfs_map_block-cleanup-v2-5-cf5cfb9e2400@wdc.com>
References: <20231213-btrfs_map_block-cleanup-v2-0-cf5cfb9e2400@wdc.com>
In-Reply-To: <20231213-btrfs_map_block-cleanup-v2-0-cf5cfb9e2400@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702478586; l=1656;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=OGBopphelKNfH3fDb7Sryq8+Z3p2RDE/ywfM09UR7p4=;
 b=RoUSRB0NVfcBYTvIOqxOOxqc+hkutI1em/Twwdx6l0bDKETDThATmODhCll6UwYpaFA8rq/uH
 0Tzc8n5u/9FA6kNzuXkI3dhPx+QfoO14JiDspxKP41PCdWZTtwvmoDQ
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
information for the block mappings of DUP, factor out a helper calculating
this information.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c11fb6db4679..fe2807bb0935 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6392,6 +6392,22 @@ static void map_blocks_raid1(struct btrfs_fs_info *fs_info,
 	io_geom->mirror_num = io_geom->stripe_index + 1;
 }
 
+static void map_blocks_dup(struct btrfs_chunk_map *map,
+			   struct btrfs_io_geometry *io_geom)
+{
+	if (io_geom->op != BTRFS_MAP_READ) {
+		io_geom->num_stripes = map->num_stripes;
+		return;
+	}
+
+	if (io_geom->mirror_num) {
+		io_geom->stripe_index = io_geom->mirror_num - 1;
+		return;
+	}
+
+	io_geom->mirror_num = 1;
+}
+
 /*
  * Map one logical range to one or more physical ranges.
  *
@@ -6484,14 +6500,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		map_blocks_raid1(fs_info, map, &io_geom,
 				 dev_replace_is_ongoing);
 	} else if (map->type & BTRFS_BLOCK_GROUP_DUP) {
-		if (op != BTRFS_MAP_READ) {
-			io_geom.num_stripes = map->num_stripes;
-		} else if (io_geom.mirror_num) {
-			io_geom.stripe_index = io_geom.mirror_num - 1;
-		} else {
-			io_geom.mirror_num = 1;
-		}
-
+		map_blocks_dup(map, &io_geom);
 	} else if (map->type & BTRFS_BLOCK_GROUP_RAID10) {
 		u32 factor = map->num_stripes / map->sub_stripes;
 

-- 
2.43.0

