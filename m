Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045F180EC1A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376267AbjLLMjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346710AbjLLMih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:38:37 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB3B1AA;
        Tue, 12 Dec 2023 04:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702384716; x=1733920716;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=5N+ew4xV5T7Bg5xRXq4tOKGJ+cFKuS/hdyWQo9PfRK4=;
  b=kzVTsrVVVOLBT6ujfGKRWLb04CHbFyjyrAhuXjr6D4VQywpuIZUJmXMu
   OuzAKPEbCGB32iKy/sXP3ec3hm+LwQLrEt6P3Akc7Xu3DfSVZs4pJBzAE
   1UHdZ/gFdEkhcyKBmWK0K9ebz9ESr4bTpCpuI9DVW9Z2WjgwWTsOWKYaT
   AmV7jDtbsXJN8vuuk5ig3j/V63bjKOMKyyvIb5ylt7GoNaAekbA8xYnBl
   8bIORoYdzPS76tNvBYA9JF9n1k0JPct7yK9YEnKZtDHRpD9YPsE/JS2iP
   iL10A+KowFJmP6fzWouBH8XvK1q9RnFfVeGTcfGR/Vd8c3ruOpGsqUuO+
   Q==;
X-CSE-ConnectionGUID: uVLj9uwRRq2AUSArnRqE7Q==
X-CSE-MsgGUID: Kw0t9OlYQUaISAH1jqUHgA==
X-IronPort-AV: E=Sophos;i="6.04,270,1695657600"; 
   d="scan'208";a="4629803"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2023 20:38:26 +0800
IronPort-SDR: vKkvRlQYyDxiFmPXH4dqCmG/4MPVnkwrK5fSUR/1TpDtDXTRpOuF3C1F4muK2CCgzDTmMBzm7u
 A8lZs6UINL3Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2023 03:43:40 -0800
IronPort-SDR: 437019ZkLS5lVX+ILTYrOyq/+MvQ1iB1fXqdv7sacM5yvroTKC9tetv5GjVreidiR/1ZJNVY8B
 TeusU574/icA==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2023 04:38:26 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Tue, 12 Dec 2023 04:38:08 -0800
Subject: [PATCH 10/13] btrfs: untagle if else maze in btrfs_map_block
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-btrfs_map_block-cleanup-v1-10-b2d954d9a55b@wdc.com>
References: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
In-Reply-To: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702384691; l=1978;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=5N+ew4xV5T7Bg5xRXq4tOKGJ+cFKuS/hdyWQo9PfRK4=;
 b=2kMp398nU9E3QkdK1U8I9QCQXm14Ml+zCql16ykYKhLoWPS+u2gLznbChrXeRk1aLFZxP4NCc
 aCqY/yRLCYRDOrga34Pjc3zOZYRBhwtjHvtfF4KMjTjUbu2yf3xA+EY
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

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e7bd3a25c516..946333c8c331 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6574,26 +6574,38 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	io_geom.num_stripes = 1;
 	io_geom.stripe_index = 0;
 	io_geom.mirror_num = (mirror_num_ret ? *mirror_num_ret : 0);
-	if (map->type & BTRFS_BLOCK_GROUP_RAID0) {
+
+	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
+	case BTRFS_BLOCK_GROUP_RAID0:
 		map_blocks_for_raid0(map, op, &io_geom);
-	} else if (map->type & BTRFS_BLOCK_GROUP_RAID1_MASK) {
+		break;
+	case BTRFS_BLOCK_GROUP_RAID1:
+	case BTRFS_BLOCK_GROUP_RAID1C3:
+	case BTRFS_BLOCK_GROUP_RAID1C4:
 		map_blocks_for_raid1(fs_info, map, op, &io_geom,
 				     dev_replace_is_ongoing);
-	} else if (map->type & BTRFS_BLOCK_GROUP_DUP) {
+		break;
+	case BTRFS_BLOCK_GROUP_DUP:
 		map_blocks_for_dup(map, op, &io_geom);
-	} else if (map->type & BTRFS_BLOCK_GROUP_RAID10) {
+		break;
+	case BTRFS_BLOCK_GROUP_RAID10:
 		map_blocks_for_raid10(fs_info, map, op, &io_geom,
 				      dev_replace_is_ongoing);
-	} else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
+		break;
+	case BTRFS_BLOCK_GROUP_RAID5:
+	case BTRFS_BLOCK_GROUP_RAID6:
 		map_blocks_for_raid56(map, op, &io_geom, logical, length);
-	} else {
+		break;
+	default:
 		/*
 		 * After this, stripe_nr is the number of stripes on this
 		 * device we have to walk to find the data, and stripe_index is
 		 * the number of our device in the stripe array
 		 */
 		map_blocks_for_single(map, &io_geom);
+		break;
 	}
+
 	if (io_geom.stripe_index >= map->num_stripes) {
 		btrfs_crit(fs_info,
 			   "stripe index math went horribly wrong, got stripe_index=%u, num_stripes=%u",

-- 
2.43.0

