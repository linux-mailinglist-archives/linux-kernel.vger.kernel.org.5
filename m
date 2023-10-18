Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0657CE8BF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjJRU1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjJRU11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:27:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B2B128;
        Wed, 18 Oct 2023 13:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697660839; x=1729196839;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CsuZBVe6nLM4gTY+G+OiL/gsz1yR77tALEMvpNtZZDw=;
  b=VwaUx04E8OcZC/68XpS8VAuLaK6BMVuusbD+6v4vsQ0Y+MDyw3clkIBM
   7O7oYW0OeS3olTSQuuAq79VXXqaP/fQ0CwJufikPYsDKJXTNqhH+Ra7EN
   2uZaapRNfuGA02Dra+v0iQPVYV1EzEF2vc0R5ACNXO2mK2wI0pbpprzJU
   KG4XvSKnHZ+25G/5TF/sq0Crrop+9nh/O1B3nc75vdJEel5RjQKs+GC9E
   NBFrIz57zg78mHsow/4ca9hXp9Sf8ca0leIUU4M9Jfb7yGHYGY21qhVMd
   rStXDcLhxQO9BqZirQBboT/RyjGX+d/b2Llyv9ZOhIcsy9tfGhIFJ0mvU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="366352903"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="366352903"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 13:27:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="4691269"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa001.fm.intel.com with ESMTP; 18 Oct 2023 13:27:16 -0700
Received: from pkitszel-desk.intel.com (unknown [10.255.194.180])
        by irvmail002.ir.intel.com (Postfix) with ESMTP id 6A763332CA;
        Wed, 18 Oct 2023 21:27:03 +0100 (IST)
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
To:     Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        George Cherian <george.cherian@marvell.com>,
        Danielle Ratson <danieller@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        Coiby Xu <coiby.xu@gmail.com>, Simon Horman <horms@kernel.org>
Cc:     Brett Creeley <brett.creeley@amd.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Eran Ben Elisha <eranbe@nvidia.com>,
        Aya Levin <ayal@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org, Benjamin Poirier <bpoirier@suse.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v3 00/11] devlink: retain error in struct devlink_fmsg
Date:   Wed, 18 Oct 2023 22:26:36 +0200
Message-Id: <20231018202647.44769-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend devlink fmsg to retain error (patch 1),
so drivers could omit error checks after devlink_fmsg_*() (patches 2-10),
and finally enforce future uses to follow this practice by change to
return void (patch 11)

Note that it was compile tested only.

bloat-o-meter for whole series:
add/remove: 8/18 grow/shrink: 23/40 up/down: 2017/-5833 (-3816)

changelog:
v3: set err to correct value, thanks to Simon and smatch
    (mlx5 patch, final patch);
v2: extend series by two more drivers (qed, qlge);
    add final cleanup patch, since now whole series should be merged in
    one part (thanks Jiri for encouragement here);

v1:
https://lore.kernel.org/netdev/20231010104318.3571791-3-przemyslaw.kitszel@intel.com
v2:
https://lore.kernel.org/netdev/20231017105341.415466-1-przemyslaw.kitszel@intel.com



Przemek Kitszel (11):
  devlink: retain error in struct devlink_fmsg
  netdevsim: devlink health: use retained error fmsg API
  pds_core: devlink health: use retained error fmsg API
  bnxt_en: devlink health: use retained error fmsg API
  hinic: devlink health: use retained error fmsg API
  octeontx2-af: devlink health: use retained error fmsg API
  mlxsw: core: devlink health: use retained error fmsg API
  net/mlx5: devlink health: use retained error fmsg API
  qed: devlink health: use retained error fmsg API
  staging: qlge: devlink health: use retained error fmsg API
  devlink: convert most of devlink_fmsg_*() to return void

 drivers/net/ethernet/amd/pds_core/devlink.c   |  29 +-
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |  93 ++--
 .../net/ethernet/huawei/hinic/hinic_devlink.c | 217 +++-----
 .../marvell/octeontx2/af/rvu_devlink.c        | 464 +++++-------------
 .../mellanox/mlx5/core/diag/fw_tracer.c       |  49 +-
 .../mellanox/mlx5/core/diag/reporter_vnic.c   | 118 ++---
 .../mellanox/mlx5/core/diag/reporter_vnic.h   |   6 +-
 .../ethernet/mellanox/mlx5/core/en/health.c   | 187 ++-----
 .../ethernet/mellanox/mlx5/core/en/health.h   |  14 +-
 .../mellanox/mlx5/core/en/reporter_rx.c       | 426 ++++------------
 .../mellanox/mlx5/core/en/reporter_tx.c       | 346 ++++---------
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |   5 +-
 .../net/ethernet/mellanox/mlx5/core/health.c  | 127 ++---
 drivers/net/ethernet/mellanox/mlxsw/core.c    | 171 ++-----
 drivers/net/ethernet/qlogic/qed/qed_devlink.c |   6 +-
 drivers/net/netdevsim/health.c                | 118 ++---
 drivers/staging/qlge/qlge_devlink.c           |  60 +--
 include/net/devlink.h                         |  60 +--
 net/devlink/health.c                          | 387 +++++----------
 19 files changed, 823 insertions(+), 2060 deletions(-)

-- 
2.38.1

