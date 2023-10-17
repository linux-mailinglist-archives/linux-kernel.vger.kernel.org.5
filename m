Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A5F7CC11B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343728AbjJQKyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbjJQKyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:54:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A481AA2;
        Tue, 17 Oct 2023 03:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697540058; x=1729076058;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZQE6BpiayELUC26ur600Gzn7596iC7PaPo/DK0fqnrY=;
  b=bklKBs9LDsMMYdl4AqTDACLdjOn+hSS8OZzVeVPIeeKlsv/Q0pS9kY4G
   QNBsfwarQYEVkDsPW5swFJiTgKo6gX9SjnRwat0JF+zv3ctYLyPjlr0Gc
   luXcUlHWJmPK+FnvW7TBW8/NjUw9LgFhqKW9GhDfofX5rZqpwfVCcxO9y
   kYDf9TVznvdXRjYhLEuNjJhxpZvLFLmUVLkX6TAzDgfIYnXagwtZ2h+9j
   3fL01WYPTM+B29emRRu44H6nyPyFZrP+ndHN/ypOAi2ivnvulEefbEkGj
   XR5IViM5kFdVKTIPvaAP0t2fmTcG2wKaRe/7VkGxrhOIS+7TOCzeUd/ly
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="366012584"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="366012584"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 03:54:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="785445243"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="785445243"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga008.jf.intel.com with ESMTP; 17 Oct 2023 03:54:09 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
        by irvmail002.ir.intel.com (Postfix) with ESMTP id 26BB3312C0;
        Tue, 17 Oct 2023 11:54:07 +0100 (IST)
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
        Coiby Xu <coiby.xu@gmail.com>
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
        linux-kernel@vger.kernel.org,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v2 00/11] devlink: retain error in struct devlink_fmsg
Date:   Tue, 17 Oct 2023 12:53:30 +0200
Message-Id: <20231017105341.415466-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
v2: extend series by two more drivers (qed, qlge);
    add final cleanup patch, since now whole series should be merged in
    one part (thanks Jiri for encouragement here);

v1:
https://lore.kernel.org/netdev/20231010104318.3571791-3-przemyslaw.kitszel@intel.com

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
 .../ethernet/mellanox/mlx5/core/en/health.c   | 185 ++-----
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
 net/devlink/health.c                          | 388 +++++----------
 19 files changed, 822 insertions(+), 2060 deletions(-)

-- 
2.40.1

