Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A087A159C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 07:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjIOFpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 01:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjIOFpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 01:45:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07EA1FC7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 22:45:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C79CC433C7;
        Fri, 15 Sep 2023 05:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694756746;
        bh=RkQ+VQK/LtyZI9gl6pg1mDINFpvds0mAdYYBVjSe2Do=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AFmeNfCmf0UoU2TDXz1Q08pNza4cMwv4wVxKRKe9UD+B+ZRsXpTFSVLgpalZJp562
         lxz2ddDGm3iwA9uamSzYoUyClxUMGDmnCFkhU3ZPzgcOYSRhxAzTxFuDLNBHztl9hc
         6qwACV+O4ac+Ec/vlysxEeDvCvoKMBcBE79uTIWfbHK1bC1wv9GuF8CuCBvC0bDMeJ
         Iqz74JV9xRnnA4qFRN9lQEdyqVTfWL8jwv8mriXX+1IKbid9loMRY9J8XWIfJdATEh
         6amQveAa5iTUdzxteuxFLbRxYZhRLOEaGKF4zBYIVJwZU2VpBV2QhhyHkThy33rqPT
         ryaHOif+TQ82g==
Date:   Fri, 15 Sep 2023 07:45:41 +0200
From:   Simon Horman <horms@kernel.org>
To:     Ma Ke <make_ruc2021@163.com>
Cc:     shshaikh@marvell.com, manishc@marvell.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        GR-Linux-NIC-Dev@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/qlcnic: fix possible use-after-free bugs in
 qlcnic_alloc_rx_skb()
Message-ID: <20230915054541.GB758782@kernel.org>
References: <20230913104119.3344592-1-make_ruc2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913104119.3344592-1-make_ruc2021@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 06:41:19PM +0800, Ma Ke wrote:
> In qlcnic_alloc_rx_skb(), when dma_map_single() fails, skb is freed
> immediately. And skb could be freed again. This issue could allow a
> local attacker to crash the system due to a use-after-free flaw.
> 
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
> index 41894d154013..6501aaf2b5ce 100644
> --- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
> +++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
> @@ -832,6 +832,7 @@ static int qlcnic_alloc_rx_skb(struct qlcnic_adapter *adapter,
>  	if (dma_mapping_error(&pdev->dev, dma)) {
>  		adapter->stats.rx_dma_map_error++;
>  		dev_kfree_skb_any(skb);
> +		skb = NULL;
>  		return -ENOMEM;

Hi Ma Ke,

I am a unclear on how skb could be freed a second time.
skb is a local variable which goes out of scope when
the function returns.
