Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A107B1B0D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 13:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjI1Lf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 07:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjI1LfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:35:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DA7126
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 04:35:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C042EC43391;
        Thu, 28 Sep 2023 11:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695900920;
        bh=eCdzVXY1VW+2ruFXsRtXnBv1KXcCjRb+xOzc64++GNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hiE+tKDmxeDv1cLRdfZl6ITFhCHm+TZYouLVEIOC2CT7DvBdJ9XZrHGREw/3/YV7B
         Jn0VXSBK3QGgeE3nzWfiqctPqUd0jIVGcVKEVvcAEYSkDUbxc64EuH7JOjUmX0Bwk1
         OTBB9W1X02y+NSblhN1h+nDD4+OBBlCgUb+s4k4jeFRfAawApyStDh7YQisNnZvgLv
         wHCQWsiL7mHJBoehWhs9/iJvtNeBfITcs1UuOoz0m6Ku+qYcEpZViHZOShOrRocz7S
         t3Qx+v8Gasbc8Z4XVe3lydAjQkXCMyaBXSk3uVwYneF3sn2dmFCDA/ReJc1uibbAaJ
         dsWNuiTeJrtZw==
Date:   Thu, 28 Sep 2023 13:35:09 +0200
From:   Simon Horman <horms@kernel.org>
To:     Sieng-Piaw Liew <liew.s.piaw@gmail.com>
Cc:     chris.snook@gmail.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: atl1c: switch to napi_consume_skb()
Message-ID: <20230928113509.GF24230@kernel.org>
References: <20230921005623.3768-1-liew.s.piaw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921005623.3768-1-liew.s.piaw@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Eric Dumazet

On Thu, Sep 21, 2023 at 08:56:23AM +0800, Sieng-Piaw Liew wrote:
> Switch to napi_consume_skb() to take advantage of bulk free, and skb
> reuse through skb cache in conjunction with napi_build_skb().
> 
> When parameter 'budget' = 0, indicating non-NAPI context,
> dev_consume_skb_any() is called internally.
> 
> Signed-off-by: Sieng-Piaw Liew <liew.s.piaw@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/atheros/atl1c/atl1c_main.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> index 74b78164cf74..46cdc32b4e31 100644
> --- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> +++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> @@ -842,7 +842,8 @@ static int atl1c_sw_init(struct atl1c_adapter *adapter)
>  }
>  
>  static inline void atl1c_clean_buffer(struct pci_dev *pdev,
> -				struct atl1c_buffer *buffer_info)
> +				      struct atl1c_buffer *buffer_info,
> +				      int budget)
>  {
>  	u16 pci_driection;
>  	if (buffer_info->flags & ATL1C_BUFFER_FREE)
> @@ -861,7 +862,7 @@ static inline void atl1c_clean_buffer(struct pci_dev *pdev,
>  				       buffer_info->length, pci_driection);
>  	}
>  	if (buffer_info->skb)
> -		dev_consume_skb_any(buffer_info->skb);
> +		napi_consume_skb(buffer_info->skb, budget);
>  	buffer_info->dma = 0;
>  	buffer_info->skb = NULL;
>  	ATL1C_SET_BUFFER_STATE(buffer_info, ATL1C_BUFFER_FREE);
> @@ -882,7 +883,7 @@ static void atl1c_clean_tx_ring(struct atl1c_adapter *adapter,
>  	ring_count = tpd_ring->count;
>  	for (index = 0; index < ring_count; index++) {
>  		buffer_info = &tpd_ring->buffer_info[index];
> -		atl1c_clean_buffer(pdev, buffer_info);
> +		atl1c_clean_buffer(pdev, buffer_info, 0);
>  	}
>  
>  	netdev_tx_reset_queue(netdev_get_tx_queue(adapter->netdev, queue));
> @@ -909,7 +910,7 @@ static void atl1c_clean_rx_ring(struct atl1c_adapter *adapter, u32 queue)
>  
>  	for (j = 0; j < rfd_ring->count; j++) {
>  		buffer_info = &rfd_ring->buffer_info[j];
> -		atl1c_clean_buffer(pdev, buffer_info);
> +		atl1c_clean_buffer(pdev, buffer_info, 0);
>  	}
>  	/* zero out the descriptor ring */
>  	memset(rfd_ring->desc, 0, rfd_ring->size);
> @@ -1607,7 +1608,7 @@ static int atl1c_clean_tx(struct napi_struct *napi, int budget)
>  			total_bytes += buffer_info->skb->len;
>  			total_packets++;
>  		}
> -		atl1c_clean_buffer(pdev, buffer_info);
> +		atl1c_clean_buffer(pdev, buffer_info, budget);
>  		if (++next_to_clean == tpd_ring->count)
>  			next_to_clean = 0;
>  		atomic_set(&tpd_ring->next_to_clean, next_to_clean);
> @@ -2151,7 +2152,7 @@ static void atl1c_tx_rollback(struct atl1c_adapter *adpt,
>  	while (index != tpd_ring->next_to_use) {
>  		tpd = ATL1C_TPD_DESC(tpd_ring, index);
>  		buffer_info = &tpd_ring->buffer_info[index];
> -		atl1c_clean_buffer(adpt->pdev, buffer_info);
> +		atl1c_clean_buffer(adpt->pdev, buffer_info, 0);
>  		memset(tpd, 0, sizeof(struct atl1c_tpd_desc));
>  		if (++index == tpd_ring->count)
>  			index = 0;
> -- 
> 2.34.1
> 
> 
