Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F0B7749FF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbjHHUJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjHHUJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:09:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D6225EE3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 11:41:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD19462A47
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 18:41:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05EC0C433C7;
        Tue,  8 Aug 2023 18:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691520087;
        bh=Lc7JVkNFcw65RIJUGUc7Ey8+fVjd9Ixy2Gj31K040wA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IQYu/FVKgUAdSrDKuV0MH2RIjnSFK7i83eSY6On0P6crpWYl7Mo9uARai5o5vRgyD
         dionhFqRqEafk/TxbbDk6Y7dwqmGUguFR12+zgjlbXWJiTxcliWUNLhOfumdSFTQEc
         EhOkx/aati3Pv62QLBWauYMGKwYQm/unl15rnEXbAvW6E9FRsKc7iqcQ1nuSozi+QB
         lyp4dQ4K6U0iD6WMyLEPdA4nTPI3WOa3S2I0bTuGNXnIzoKifGoYFoqfb3pk5o42Kz
         0xWVikaBSA/mP0h8d1kWVNi8aQYiP56E+uWRn1hVBLNYL8QIa68k2SmocFhpA2DpaB
         erW8A3s/9tE0w==
Date:   Tue, 8 Aug 2023 21:41:16 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jijie Shao <shaojijie@huawei.com>
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shenjian15@huawei.com, wangjie125@huawei.com,
        liuyonglong@huawei.com, wangpeiyang1@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 net 4/4] net: hns3: fix deadlock issue when
 externel_lb and reset are executed together
Message-ID: <20230808184116.GF94631@unreal>
References: <20230807113452.474224-1-shaojijie@huawei.com>
 <20230807113452.474224-5-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807113452.474224-5-shaojijie@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 07:34:52PM +0800, Jijie Shao wrote:
> From: Yonglong Liu <liuyonglong@huawei.com>
> 
> When externel_lb and reset are executed together, a deadlock may
> occur:
> [ 3147.217009] INFO: task kworker/u321:0:7 blocked for more than 120 seconds.
> [ 3147.230483] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 3147.238999] task:kworker/u321:0  state:D stack:    0 pid:    7 ppid:     2 flags:0x00000008
> [ 3147.248045] Workqueue: hclge hclge_service_task [hclge]
> [ 3147.253957] Call trace:
> [ 3147.257093]  __switch_to+0x7c/0xbc
> [ 3147.261183]  __schedule+0x338/0x6f0
> [ 3147.265357]  schedule+0x50/0xe0
> [ 3147.269185]  schedule_preempt_disabled+0x18/0x24
> [ 3147.274488]  __mutex_lock.constprop.0+0x1d4/0x5dc
> [ 3147.279880]  __mutex_lock_slowpath+0x1c/0x30
> [ 3147.284839]  mutex_lock+0x50/0x60
> [ 3147.288841]  rtnl_lock+0x20/0x2c
> [ 3147.292759]  hclge_reset_prepare+0x68/0x90 [hclge]
> [ 3147.298239]  hclge_reset_subtask+0x88/0xe0 [hclge]
> [ 3147.303718]  hclge_reset_service_task+0x84/0x120 [hclge]
> [ 3147.309718]  hclge_service_task+0x2c/0x70 [hclge]
> [ 3147.315109]  process_one_work+0x1d0/0x490
> [ 3147.319805]  worker_thread+0x158/0x3d0
> [ 3147.324240]  kthread+0x108/0x13c
> [ 3147.328154]  ret_from_fork+0x10/0x18
> 
> In externel_lb process, the hns3 driver call napi_disable()
> first, then the reset happen, then the restore process of the
> externel_lb will fail, and will not call napi_enable(). When
> doing externel_lb again, napi_disable() will be double call,
> cause a deadlock of rtnl_lock().
> 
> This patch use the HNS3_NIC_STATE_DOWN state to protect the
> calling of napi_disable() and napi_enable() in externel_lb
> process, just as the usage in ndo_stop() and ndo_start().
> 
> Fixes: 04b6ba143521 ("net: hns3: add support for external loopback test")
> Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
