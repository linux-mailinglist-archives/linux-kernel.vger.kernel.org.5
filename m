Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EC280EECA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376579AbjLLO3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376605AbjLLO3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:29:43 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB4CF2;
        Tue, 12 Dec 2023 06:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702391388; x=1733927388;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xv2qt7/sAoWAEZQgV2h0LqG0rMAj+aEH2dHkRRXSC5I=;
  b=oIsr77O5j0zkwxlUXfDleZ0ccRz9XLOqxGfnqREsWGHMMg4/LbmZVOIs
   fx284UHlddnwenHpMAdGh4xUFSoUZMWuDHM6G3hcoX4B/EDVrSv4xR84I
   S62VDRsyamvIddYj8EsbvNLJ5q6MTmv48AX3FFrG7JK/NHFm7g/8oWeXb
   kRwTW0UweVcZtVG4kCsHi1cUrYUyaPmtF/qbm1cxl5MJeLrfTOtvKqhiZ
   xoWFEXvfIcFsl4Wrw2f2QknZ0d6zqUA2fkeNy2qT/VNflQvEMvdexuLHm
   ABbipL2jpSqOwxYBsE/4ULVVrS/sfCpBAAAUjsol3hLqQNqNZAtumehEV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1887329"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="1887329"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 06:29:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1104923742"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="1104923742"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga005.fm.intel.com with ESMTP; 12 Dec 2023 06:29:44 -0800
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michal Kubecek <mkubecek@suse.cz>,
        Jiri Pirko <jiri@resnulli.us>,
        Paul Greenwalt <paul.greenwalt@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] idpf: add get/set for Ethtool's header split ringparam
Date:   Tue, 12 Dec 2023 15:27:50 +0100
Message-ID: <20231212142752.935000-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the header split feature (putting headers in one smaller
buffer and then the data in a separate bigger one) is always enabled
in idpf when supported.
One may want to not have fragmented frames per each packet, for example,
to avoid XDP frags. To better optimize setups for particular workloads,
add ability to switch the header split state on and off via Ethtool's
ringparams, as well as to query the current status.
There's currently only GET in the Ethtool Netlink interface for now,
so add SET first. I suspect idpf is not the only one supporting this.

Alexander Lobakin (1):
  ethtool: add SET for TCP_DATA_SPLIT ringparam

Michal Kubiak (1):
  idpf: add get/set for Ethtool's header split ringparam

 drivers/net/ethernet/intel/idpf/idpf.h        |  7 +-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 11 ++++
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 65 +++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 12 ++--
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  2 +
 include/linux/ethtool.h                       |  2 +
 net/ethtool/rings.c                           | 12 ++++
 7 files changed, 104 insertions(+), 7 deletions(-)

-- 
2.43.0

