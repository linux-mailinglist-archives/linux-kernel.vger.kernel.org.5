Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0978876853B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 14:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjG3MMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 08:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjG3MMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 08:12:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24157CA
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 05:12:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FD106068F
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 12:12:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05168C433C8;
        Sun, 30 Jul 2023 12:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690719160;
        bh=30hP26QIotzwpSrm1s0WESZxVcArCm7cZz8z8kTCgsM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jtjso80udY7BZgbMKRBGwNkxqO2/AQLLDjt+SVh650vaMV7rMPHCD8JRWUbvlKyR0
         kW2hrjDumtgZdW5haxo9Of7rf5uyuoE390Kpdy6MnkXPqtFWvtDDPtNTFOgpgfw37s
         GOv36yjlMk4GcNKrT2ptCSlM+59w1Ub4fS9Cb7yArb9yxj0eWrYYUbkH+ZxVc/Ji4N
         5G5jrxME9gWxUN3QA1aPontPGQPz9awEHdT8LP7GH4zG7blfcj2ykjmw26vfzZYqlZ
         Y82jGdbJjagYSDK6sI3i02gBK4fUfz9u9pUhF0dg2D58zpFwQ1zEbzNoAE+TCX+uvC
         tGDEBx6vxDqTw==
Date:   Sun, 30 Jul 2023 15:12:36 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Ratheesh Kannoth <rkannoth@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        vladimir.oltean@nxp.com, claudiu.manoil@nxp.com,
        alexandre.belloni@bootlin.com, andrew@lunn.ch,
        f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com,
        michael.chan@broadcom.com, rajur@chelsio.com,
        yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, taras.chornyi@plvision.eu, saeedm@nvidia.com,
        idosch@nvidia.com, petrm@nvidia.com, horatiu.vultur@microchip.com,
        lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
        daniel.machon@microchip.com, simon.horman@corigine.com,
        aelior@marvell.com, manishc@marvell.com, ecree.xilinx@gmail.com,
        habetsm.xilinx@gmail.com, peppe.cavallaro@st.com,
        alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        mcoquelin.stm32@gmail.com, pablo@netfilter.org,
        kadlec@netfilter.org, fw@strlen.de
Subject: Re: [PATCH v1 net-next] dissector: Use 64bits for used_keys
Message-ID: <20230730121236.GC94048@unreal>
References: <20230727062814.2054345-1-rkannoth@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727062814.2054345-1-rkannoth@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 11:58:14AM +0530, Ratheesh Kannoth wrote:
> As 32bit of dissectory->used_keys are exhausted,
> increase the size to 64bits.
> 
> This is base changes for ESP/AH flow dissector patch.
> 
> Please find patch and discussions at
> https://lore.kernel.org/netdev/ZMDNjD46BvZ5zp5I@corigine.com/T/#t
> 
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> --
> ChangeLog
> 
> v0 -> v1: Fix errors reported by kernel test robot
> ---
>  drivers/net/dsa/ocelot/felix_vsc9959.c        |  8 +--
>  drivers/net/dsa/sja1105/sja1105_flower.c      |  8 +--
>  drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c  |  6 +-
>  .../ethernet/chelsio/cxgb4/cxgb4_tc_flower.c  | 18 ++---
>  .../freescale/dpaa2/dpaa2-switch-flower.c     | 22 +++---
>  .../net/ethernet/freescale/enetc/enetc_qos.c  |  8 +--
>  .../hisilicon/hns3/hns3pf/hclge_main.c        | 16 ++---
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 18 ++---
>  drivers/net/ethernet/intel/iavf/iavf_main.c   | 18 ++---
>  drivers/net/ethernet/intel/ice/ice_tc_lib.c   | 44 ++++++------
>  drivers/net/ethernet/intel/igb/igb_main.c     |  8 +--
>  .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 18 ++---
>  .../marvell/prestera/prestera_flower.c        | 20 +++---
>  .../mellanox/mlx5/core/en/tc/ct_fs_smfs.c     | 25 ++++---
>  .../net/ethernet/mellanox/mlx5/core/en_tc.c   | 44 ++++++------
>  .../ethernet/mellanox/mlxsw/spectrum_flower.c | 22 +++---
>  .../microchip/lan966x/lan966x_tc_flower.c     |  4 +-
>  .../microchip/sparx5/sparx5_tc_flower.c       |  4 +-
>  drivers/net/ethernet/microchip/vcap/vcap_tc.c | 18 ++---
>  drivers/net/ethernet/microchip/vcap/vcap_tc.h |  2 +-
>  drivers/net/ethernet/mscc/ocelot_flower.c     | 28 ++++----
>  .../ethernet/netronome/nfp/flower/conntrack.c | 43 ++++++------
>  .../ethernet/netronome/nfp/flower/offload.c   | 64 +++++++++---------
>  .../net/ethernet/qlogic/qede/qede_filter.c    | 12 ++--
>  drivers/net/ethernet/sfc/tc.c                 | 67 ++++++++++---------
>  .../stmicro/stmmac/stmmac_selftests.c         |  6 +-
>  drivers/net/ethernet/ti/am65-cpsw-qos.c       |  6 +-
>  drivers/net/ethernet/ti/cpsw_priv.c           |  6 +-
>  include/net/flow_dissector.h                  |  5 +-
>  net/core/flow_dissector.c                     |  2 +-
>  net/ethtool/ioctl.c                           | 16 ++---
>  net/netfilter/nf_flow_table_offload.c         | 22 +++---
>  net/netfilter/nf_tables_offload.c             | 13 ++--
>  net/netfilter/nft_cmp.c                       |  2 +-
>  34 files changed, 317 insertions(+), 306 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
