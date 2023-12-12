Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458C180EC02
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346619AbjLLMiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346615AbjLLMiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:38:10 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444DB110;
        Tue, 12 Dec 2023 04:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702384695; x=1733920695;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=HxLnsy+1wzJFDbdBgEWHFKFPXH75LHkJH8uVaiHdWO0=;
  b=fuh3S6cznHcmN0xl/8jz9/9DUQDWiGPV+EN8qb6RRVk356qSfZwAccfW
   bWqmKur7LZIAYoUV+tp0gRZh8VaPwP8Zw79vAqo93gV2UzCA3eq+9iQtG
   Et/f+z54200iCT+BbAHRVQn1+hjolXb0zuFOhitMieha9mZhMA3/sgkJl
   Vc7iIGV+1QhEDlKNteIdCcK55i6JuTniwUX4+XcsLacG94qvu9S33OkVa
   +V84U64utzSwCPPzFNkCbFiPSzgiiptAlfzawa7vaJgfs5vOdFepsK0xy
   +j4hLgbiaCpEdCIDBB5zyyY9eNzLFxJkjpOBfj+lf33ponx5c/0GbYTDH
   Q==;
X-CSE-ConnectionGUID: xCwpIT7FSHaErwldKyunDg==
X-CSE-MsgGUID: UdtOej1lRbKvuC80Tl2gXQ==
X-IronPort-AV: E=Sophos;i="6.04,270,1695657600"; 
   d="scan'208";a="4629785"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2023 20:38:13 +0800
IronPort-SDR: 5Fhmkq7VxQSiyP2WOKOmkC97fn6L5aMvXcdglI8a0KvblJDJ/Yt56eNDh2bWmqIG5gjC1gWHkt
 vz+OcEYEGPqw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2023 03:43:26 -0800
IronPort-SDR: WzDIvKQqA3LLyuNHm+UkZVLffG9NuRobe5ag3IJc77mUmdGQv/ZThDS0U338FLmLswjLsOAfWe
 R9teZsu2MpUw==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2023 04:38:12 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 00/13] btrfs: clean up RAID I/O geometry calculation
Date:   Tue, 12 Dec 2023 04:37:58 -0800
Message-Id: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACZUeGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDIwNz3aSSorTi+NzEgviknPzkbN3knNTEvNICXWMTszRT48S0NEuDFCW
 g7oKi1LTMCrDJ0bG1tQCdbVldaQAAAA==
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702384691; l=1540;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=HxLnsy+1wzJFDbdBgEWHFKFPXH75LHkJH8uVaiHdWO0=;
 b=s0YTYTdmfza6AEe2dcweU8WfdAEb56Vd6rQELH/ft5wMIDIdr8u7D8NPLSKllTdu6Wn2fHsRE
 Dg/6r7NPbA+BWojqQDifnWwlMwyFN5b6IB2XbUlDuMbqISpXTbgTXPD
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

The calculation of the RAID I/O geometry in btrfs_map_block has been a maze of
if-else statements for a very long time and the advent of the
raid-stripe-tree made the situation even worse.

This patchset refactors btrfs_map_block() to untagle the maze and make I/O
geometry setting easier to follow, but does not introduce any functional
changes.

I've also run it through Josef's CI and there have been test failures, but
none of them introduced by these patches.

---
Johannes Thumshirn (13):
      btrfs: factor out helper for single device IO check
      btrfs: re-introduce struct btrfs_io_geometry
      btrfs: factor out block-mapping for RAID0
      btrfs: factor out RAID1 block mapping
      btrfs: factor out block mapping for DUP profiles
      btrfs: factor out block mapping for RAID10
      btrfs: reduce scope of data_stripes in btrfs_map_block
      btrfs: factor out block mapping for RAID5/6
      btrfs: factor out block mapping for single profiles
      btrfs: untagle if else maze in btrfs_map_block
      btrfs: open code set_io_stripe for RAID56
      btrfs: pass struct btrfs_io_geometry to set_io_stripe
      btrfs: pass btrfs_io_geometry into btrfs_max_io_len

 fs/btrfs/volumes.c | 388 +++++++++++++++++++++++++++++++++--------------------
 1 file changed, 245 insertions(+), 143 deletions(-)
---
base-commit: 14d1d39586246ca9d4ce97049c98be849e3bbcd9
change-id: 20231207-btrfs_map_block-cleanup-346f53aff90d

Best regards,
-- 
Johannes Thumshirn <johannes.thumshirn@wdc.com>

