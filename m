Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D03E80EC18
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346766AbjLLMi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346676AbjLLMih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:38:37 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B9B197;
        Tue, 12 Dec 2023 04:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702384711; x=1733920711;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=3JBwlPmlVxcc4Hbr5ovZi090xqLbOi7L4Oq6IXpdP+c=;
  b=QLs0QV679G5N/ymlyyps5HWJs45hxlJc+R6+akAIHN4bEM4Bi/PoG+DO
   Z+mrN3rj6u74m8L54wOP/oJhohVdWIijXtKmB1unfSUk8Rl2QmFfSgX7G
   jMi1u/X/EVY2Y07OSFBcSfBOKjtFcoZg0336R1GeSI3BwlH6fVHg474HG
   AA0XySnO6hfMu+a/xx7f9N8/c9iaV3nP6TK9phAe9fgbzOecQmVpqX2cn
   CoEpTzCKxHJs2efz880SoyqCgpbLuqFjxA7XO+i0H5XLu8ErfHCA619EY
   Ukajrbuo2NhQ7N5q4pvzXlFOYsRtZ0Ctwc+ol6BedE05bMRbhfS0SWYsw
   A==;
X-CSE-ConnectionGUID: WeyuH8m4SLe4nDnwUH0XBA==
X-CSE-MsgGUID: skh67uFoSICKLfzJJ3cuzw==
X-IronPort-AV: E=Sophos;i="6.04,270,1695657600"; 
   d="scan'208";a="4629801"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2023 20:38:25 +0800
IronPort-SDR: hkw1xN8eTru++8Dqoc6P4XNCkZjZrbsdui5kbs3MjMeMkB7v2jqKuvgl4/Ayv+B/ysfQw1y/S2
 R+MCymewRzlQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2023 03:43:38 -0800
IronPort-SDR: yKSyTL4RqjgBc7SWF2fYJaRUNDzPRK+sZWGPoy8X41nvAdlplDIhTKBhy5y5ItabOFKvZyVo9t
 6QI2j683Vtrw==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2023 04:38:24 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Tue, 12 Dec 2023 04:38:07 -0800
Subject: [PATCH 09/13] btrfs: factor out block mapping for single profiles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-btrfs_map_block-cleanup-v1-9-b2d954d9a55b@wdc.com>
References: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
In-Reply-To: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702384691; l=1483;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=3JBwlPmlVxcc4Hbr5ovZi090xqLbOi7L4Oq6IXpdP+c=;
 b=r7nRTt3NiVSw2tCG7+pUuEg/CKxGw337avuRqCY47dHeFu/f1OGQZYTu51UFeCF7ybE5cxiJj
 SacfI6e1ut9AIn6wOV7xbl86esli7DGok75vH3UVFmSj7beg62mv5fx
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
index fd213bb7d619..e7bd3a25c516 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6485,6 +6485,14 @@ static void map_blocks_for_raid56(struct btrfs_chunk_map *map,
 		io_geom->mirror_num = 1;
 }
 
+static void map_blocks_for_single(struct btrfs_chunk_map *map,
+				  struct btrfs_io_geometry *io_geom)
+{
+	io_geom->stripe_index = io_geom->stripe_nr % map->num_stripes;
+	io_geom->stripe_nr /= map->num_stripes;
+	io_geom->mirror_num = io_geom->stripe_index + 1;
+}
+
 /*
  * Map one logical range to one or more physical ranges.
  *
@@ -6584,9 +6592,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		 * device we have to walk to find the data, and stripe_index is
 		 * the number of our device in the stripe array
 		 */
-		io_geom.stripe_index = io_geom.stripe_nr % map->num_stripes;
-		io_geom.stripe_nr /= map->num_stripes;
-		io_geom.mirror_num = io_geom.stripe_index + 1;
+		map_blocks_for_single(map, &io_geom);
 	}
 	if (io_geom.stripe_index >= map->num_stripes) {
 		btrfs_crit(fs_info,

-- 
2.43.0

