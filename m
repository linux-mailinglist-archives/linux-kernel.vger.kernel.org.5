Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5607F7A16
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 18:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjKXRIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 12:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjKXRIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 12:08:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F53D4E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 09:08:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACDAEC433CA;
        Fri, 24 Nov 2023 17:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700845691;
        bh=N6eKa6WfMK+P6QxFOZlfSTYYVqTpDOay3TuZvDz49n0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sHxMm9u1mMdx4N1F/JdO5WDKNIARNwK+oEk/f5MTc2gwWWXdnb4XOhlos6fZv0ckr
         1py3975fia0mRXMPlQMdjVjKxL53JpgTwcG3rvnHQpCr8BcrM7H6w+zU9dB77D/D5z
         83YrmiGMtVn855hQ1ZmWM+NjyvOV6dQVgH+bmtjfwSWXd7FTC9DuqpBVan5Z+TJ44Q
         R1HDPglOvv1jfIcHG3Tn7/h/iwhhgXLQvr6Sn3KAE9qLHCGzUkimLx/KpzvilSIitM
         PC3BT4wrUiLNAkwnulC5I6OOvqMQiSBXdYaU7qBSDI4r9mygQeqrTHn45pxrxMIH9V
         MODQ2dzif3ppw==
Date:   Fri, 24 Nov 2023 17:08:04 +0000
From:   Simon Horman <horms@kernel.org>
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        hgani@marvell.com, vimleshk@marvell.com, egallen@redhat.com,
        mschmidt@redhat.com, pabeni@redhat.com, kuba@kernel.org,
        davem@davemloft.net, wizhao@redhat.com, konguyen@redhat.com,
        jesse.brandeburg@intel.com, sumang@marvell.com,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 2/2] octeon_ep: get max rx packet length from
 firmware
Message-ID: <20231124170804.GU50352@kernel.org>
References: <20231122183435.2510656-1-srasheed@marvell.com>
 <20231122183435.2510656-3-srasheed@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122183435.2510656-3-srasheed@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 10:34:35AM -0800, Shinas Rasheed wrote:
> Max receive packet length can vary across SoCs, so
> this needs to be queried from respective firmware and
> filled by driver. A control net get mtu api should be
> implemented to do the same.
> 
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>

...

> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> index 2da00a701df2..423eec5ff3ad 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> @@ -1307,6 +1307,7 @@ static int octep_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  {
>  	struct octep_device *octep_dev = NULL;
>  	struct net_device *netdev;
> +	int max_rx_pktlen;
>  	int err;
>  
>  	err = pci_enable_device(pdev);
> @@ -1377,8 +1378,15 @@ static int octep_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	netdev->hw_features = NETIF_F_SG;
>  	netdev->features |= netdev->hw_features;
> +
> +	max_rx_pktlen = octep_ctrl_net_get_mtu(octep_dev, OCTEP_CTRL_NET_INVALID_VFID);
> +	if (max_rx_pktlen < 0) {
> +		dev_err(&octep_dev->pdev->dev,
> +			"Failed to get max receive packet size; err = %d\n", max_rx_pktlen);
> +		goto register_dev_err;

Hi Shinas,

This jump will cause this function to return err.  But err is 0 here.
Perhaps it should be set to a negative error value instead?

> +	}
>  	netdev->min_mtu = OCTEP_MIN_MTU;
> -	netdev->max_mtu = OCTEP_MAX_MTU;
> +	netdev->max_mtu = max_rx_pktlen - (ETH_HLEN + ETH_FCS_LEN);
>  	netdev->mtu = OCTEP_DEFAULT_MTU;
>  
>  	err = octep_ctrl_net_get_mac_addr(octep_dev, OCTEP_CTRL_NET_INVALID_VFID,
> -- 
> 2.25.1
> 
