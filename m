Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D241077D1CC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 20:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239117AbjHOS0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 14:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239100AbjHOS0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:26:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5E91BE6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 11:26:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2937763CA8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 18:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FABC433C7;
        Tue, 15 Aug 2023 18:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692123991;
        bh=YJ0/8zdnMDRXvPB3UfHtL9v7XyB4zHHumRxB3bDf6fc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ffs/R70x4VZ5W0eaFayjpGXQgeGGl3eHPoaM13QfOUscjLW86mkgTzKWJC6DqkAmJ
         bmYXXhiOXdnUHXiT/xDs/8h64qMRj5pEV4kL+XMcFE8zofd11C1ZuZF/+P2zeS0vdw
         jNt7MEmsDwI/CQ5dpUfdkQnDXBbzSVNRAuXpDMsW5mKNwNjg2SSsoS63hbJg/uiA+k
         ggxr2OimfFiEnpI5PRRQVCLpdlcKx+6DAT7YqeA6OTvCuHZqu1T1rhMhxijYOQk3Om
         FhT3QoK+pPy2gEELS4w5BK0zWMXwotBDd9LF9PPllAHX3P0w2KudZHuWKmPU8ONSre
         xoVGhM1AAY/hA==
Date:   Tue, 15 Aug 2023 21:26:27 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jijie Shao <shaojijie@huawei.com>
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shenjian15@huawei.com, wangjie125@huawei.com,
        liuyonglong@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] net: hns3: fix wrong rpu tln reg issue
Message-ID: <20230815182627.GS22185@unreal>
References: <20230815060641.3551665-1-shaojijie@huawei.com>
 <20230815060641.3551665-5-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815060641.3551665-5-shaojijie@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 02:06:41PM +0800, Jijie Shao wrote:
> In the original RPU query command, the status register values of
> multiple RPU tunnels are accumulated by default, which is unreasonable.
> This patch Fix it by querying the specified tunnel ID.
> The tunnel number of the device can be obtained from firmware
> during initialization.
> 
> Fixes: ddb54554fa51 ("net: hns3: add DFX registers information for ethtool -d")
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  1 +
>  .../hisilicon/hns3/hns3pf/hclge_cmd.h         |  4 +-
>  .../hisilicon/hns3/hns3pf/hclge_main.c        |  2 +
>  .../hisilicon/hns3/hns3pf/hclge_regs.c        | 66 ++++++++++++++++++-
>  4 files changed, 71 insertions(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
