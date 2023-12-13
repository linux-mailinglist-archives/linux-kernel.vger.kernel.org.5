Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB098811504
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441989AbjLMOni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378944AbjLMOnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:43:13 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D95DD;
        Wed, 13 Dec 2023 06:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702478599; x=1734014599;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=qN9uFU57GBna2r1afgLudejpCt6oeNpZ8RYEEAbqQXg=;
  b=rsq3ow2eWmjEgFeyR0jpq8WGVr3aVBbipVvjQfs8g+QM/jxxDkmNYsun
   dchscET/rroFcnDmjXZ3CnM4PpCkoGtbe/zc327lsmXszDShDt0F+NY87
   rUMQWE75TNobHNp5N3R+O9jnCvOkBk7EiMM2/zDOesmFFhtr57vqPnvbY
   Saz6MPtaL5uEAsMAsH3Sap6UTrsBjpOBAP1PMPzCewoVsNXPDIur8u4jU
   aN+2JEmbXxoy2fQRU5iaIQx4+PhacXxIIK74rqZf4oGzmvgB/EiYvdFYS
   wH9hLOQulVExhrQuKs53KDKuYaofX7ADa2iZBFXYrbbyBNgNo4sN9aBbD
   w==;
X-CSE-ConnectionGUID: FSnTn6JcTaaJEa7Na8rxyg==
X-CSE-MsgGUID: LInRM9QtT9iKNuNtPYzxhQ==
X-IronPort-AV: E=Sophos;i="6.04,272,1695657600"; 
   d="scan'208";a="4580759"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2023 22:43:18 +0800
IronPort-SDR: lyt6xR+vykByqf1jWQA8GMQ/ft12tNXRgi7Z25mb2GJxiDgjA8doJhOOYCg+DgKQaPcQEHb3Ub
 TmQl6n7JXF2w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2023 05:48:30 -0800
IronPort-SDR: J2ayBnMfsZEDf/vIc07aK+WYzQeCZ/WpAJqHvaNHjQ2NotY1+NOxfWGl/LoOA44EUhCMHF8yW/
 EwbcbU+id01g==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Dec 2023 06:43:17 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Wed, 13 Dec 2023 06:43:04 -0800
Subject: [PATCH v2 09/13] btrfs: factor out block mapping for single
 profiles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231213-btrfs_map_block-cleanup-v2-9-cf5cfb9e2400@wdc.com>
References: <20231213-btrfs_map_block-cleanup-v2-0-cf5cfb9e2400@wdc.com>
In-Reply-To: <20231213-btrfs_map_block-cleanup-v2-0-cf5cfb9e2400@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702478586; l=1479;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=qN9uFU57GBna2r1afgLudejpCt6oeNpZ8RYEEAbqQXg=;
 b=GNdQPNmiHfgl1oXaJa/IVRS0l3ajkT51NLCGozaz/MHqjMXwZZ1CW6t4MH4Jx3fi4CkpD97Ym
 g4JV3WNQke0Ce8JBP4/pBhcFu5cxQp3j3hu7Trc+B1uQk/QkogCGigQ
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
information for the block mappings of SINGLE profiles, factor out a helper
calculating this information.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 55614a9eb8a5..e23c7d2842a6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6487,6 +6487,14 @@ static void map_blocks_raid56_read(struct btrfs_chunk_map *map,
 		io_geom->mirror_num = 1;
 }
 
+static void map_blocks_single(struct btrfs_chunk_map *map,
+			      struct btrfs_io_geometry *io_geom)
+{
+	io_geom->stripe_index = io_geom->stripe_nr % map->num_stripes;
+	io_geom->stripe_nr /= map->num_stripes;
+	io_geom->mirror_num = io_geom->stripe_index + 1;
+}
+
 /*
  * Map one logical range to one or more physical ranges.
  *
@@ -6591,9 +6599,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		 * device we have to walk to find the data, and stripe_index is
 		 * the number of our device in the stripe array
 		 */
-		io_geom.stripe_index = io_geom.stripe_nr % map->num_stripes;
-		io_geom.stripe_nr /= map->num_stripes;
-		io_geom.mirror_num = io_geom.stripe_index + 1;
+		map_blocks_single(map, &io_geom);
 	}
 	if (io_geom.stripe_index >= map->num_stripes) {
 		btrfs_crit(fs_info,

-- 
2.43.0

