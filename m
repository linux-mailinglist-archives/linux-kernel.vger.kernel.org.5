Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7643D79777D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239513AbjIGQ0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239850AbjIGQ0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:26:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DBD7A8B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:23:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9199CC433CA;
        Thu,  7 Sep 2023 16:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694103696;
        bh=LPGi9Fu144GxPJSIGqNXekKcUHxzLfYXOlpXxINy/Pg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mv0HlTXEVpZzU8M4w0BK/j5CLaqBwvdIO2NqtmjnQ4SPuITIxYSnVFc88H7R1SZsG
         PEkC13ricPNtd/sjnXwFdRJSg58HKd3RJNKdjDCtGjr53TVFcXvurmtX7oEbEunOnU
         kqZzadCG+iRPM3GX/Xo8kC6x5iefiOWTxon2EN5T5ZGomBctN59MBAxKRFb3pm+UT4
         UfIyeDItfZat6nbYpZVYl39qR8XCKMc3R1tLZVYoOiD+uQ+Hu6W2eRw7PA+tpA3aBj
         Z2Bs5/yCb738Lv5/qpuD11ZIlkdyw/6rvVdn+3ss4BAuGkcr77B5QFZgj0M8pOPYCN
         TdTm4UUateZmQ==
Date:   Thu, 7 Sep 2023 18:21:31 +0200
From:   Simon Horman <horms@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: fix uninitialized
 variable
Message-ID: <20230907162131.GK434333@kernel.org>
References: <9918f1ae-5604-4bdc-a654-e0566ca77ad6@moroto.mountain>
 <51d1ae238aecde07b2b4fe02cdab0dc87287cd96.1694099183.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51d1ae238aecde07b2b4fe02cdab0dc87287cd96.1694099183.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 04:14:20PM +0100, Daniel Golle wrote:
> Variable dma_addr in function mtk_poll_rx can be uninitialized on
> some of the error paths. In practise this doesn't matter, even random
> data present in uninitialized stack memory can safely be used in the
> way it happens in the error path.
> 
> However, in order to make Smatch happy make sure the variable is
> always initialized.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index 31090490d47ce..6342eac90793e 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -2119,11 +2119,11 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
>  	u8 *data, *new_data;
>  	struct mtk_rx_dma_v2 *rxd, trxd;
>  	int done = 0, bytes = 0;
> +	dma_addr_t dma_addr = NULL;

Hi Daniel,

I'm not sure that NULL is a valid value for a variable of type dma_addr_t.
Is DMA_MAPPING_ERROR more appropriate here?

Flagged by Sparse and, W=1 builds with gcc-13 and clang-16.

>  
>  	while (done < budget) {
>  		unsigned int pktlen, *rxdcsum;
>  		struct net_device *netdev;
> -		dma_addr_t dma_addr;
>  		u32 hash, reason;
>  		int mac = 0;
>  
> -- 
> 2.42.0
> 
