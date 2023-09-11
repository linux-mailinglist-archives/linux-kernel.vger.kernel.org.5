Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79CEA79B823
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbjIKUtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243848AbjIKSBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 14:01:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20250E4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 11:01:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C23CC433C8;
        Mon, 11 Sep 2023 18:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694455279;
        bh=8PwPQLkF7TkKQS3xRoKZEnUx2R/Klq1fUqa0PqLQnJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a1n+jtqVeuNa2OJm2/P4mopJw5qfVAjut5J44v8yKsCBrnAl137zJn5IjJs/pNeId
         eXh4EhZB21g9IurKh6ltrm2GZYfTmFPVKUz0qvGrjj+vMSb6FOsIXKaTIOzGnVlpfw
         QxKDNFpiHFfDVb8CZJhYn6B7AofbsIgFc4GpI/w8lwDcsOKfVScEdKz133NIYtcEkM
         MT2Rawroq+aCN6eBKPMxi4FA11POxTB9eIkSV/tBFN47B6jgnc3yM7QX+uslK4bBRh
         ZiMiV0g/YzUywjTv2hSsvUn50/VVUemZTbSp4nu3UJSbHjyBeidEbwTXh+acIglMe4
         ffCXrIjdkx+RQ==
Date:   Mon, 11 Sep 2023 20:01:13 +0200
From:   Simon Horman <horms@kernel.org>
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        hgani@marvell.com, vimleshk@marvell.com, mschmidt@redhat.com,
        egallen@redhat.com, Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Satananda Burla <sburla@marvell.com>,
        Abhijit Ayarekar <aayarekar@marvell.com>
Subject: Re: [net PATCH] octeon_ep: fix tx dma unmap len values in SG
Message-ID: <20230911180113.GA113013@kernel.org>
References: <20230911092306.2132794-1-srasheed@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911092306.2132794-1-srasheed@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 02:23:06AM -0700, Shinas Rasheed wrote:
> Lengths of SG pointers are in big-endian
> 
> Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt support")
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeon_ep/octep_tx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c
> index 5a520d37bea0..7e99486c274b 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c
> @@ -69,12 +69,12 @@ int octep_iq_process_completions(struct octep_iq *iq, u16 budget)
>  		compl_sg++;
>  
>  		dma_unmap_single(iq->dev, tx_buffer->sglist[0].dma_ptr[0],
> -				 tx_buffer->sglist[0].len[0], DMA_TO_DEVICE);
> +				 tx_buffer->sglist[0].len[3], DMA_TO_DEVICE);
>  
>  		i = 1; /* entry 0 is main skb, unmapped above */
>  		while (frags--) {
>  			dma_unmap_page(iq->dev, tx_buffer->sglist[i >> 2].dma_ptr[i & 3],
> -				       tx_buffer->sglist[i >> 2].len[i & 3], DMA_TO_DEVICE);
> +				       tx_buffer->sglist[i >> 2].len[3 - (i & 3)], DMA_TO_DEVICE);
>  			i++;
>  		}

Hi Shinas,

is this change also needed in octep_iq_process_completions() ?
The code there looks rather similar.
