Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5633A80E28D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 04:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345802AbjLLDOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 22:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjLLDOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 22:14:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41267BA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 19:14:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5684CC433C8;
        Tue, 12 Dec 2023 03:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702350889;
        bh=STg08q9IfAR0tNeI5v/tHfkB1R036nNdGe+t8ciundo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mGGI4j1KtWPXG5XGxthX++rr+bHOo5M5KapVd0sqkY+j1yldnfhLfC4aaACy1aWI2
         ud0jdHjYUeKrctIRwt2fGHY9fRzK5bwfSYJ1KmR9YncddGbA++5VzbVI2pvgtJqbAh
         yYw+fBJxNluQopj+4tE4bB2UFGzhvbfup8GwOhnz9qe/gfII8lLoJobSRIyKsnzAif
         49FFgsq4s72rZtT3vv0H+HOlgZH0Y7Sbmx9caRGP3B5Px3bbJEqSUbHf0swUY/tPJq
         kMmhT82qgp3Bm5cewmGktHqixr54eFUb27YsauJjURm38BnJUVlEUlaAqoWBTvuQSj
         JqU+tbzbPG3/Q==
Date:   Mon, 11 Dec 2023 19:14:47 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Zhipeng Lu <alexious@zju.edu.cn>
Cc:     Chris Snook <chris.snook@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Yuanjun Gong <ruc_gongyuanjun@163.com>,
        Jie Yang <jie.yang@atheros.com>,
        Jeff Garzik <jgarzik@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] ethernet: atheros: fix a memleak in
 atl1e_setup_ring_resources
Message-ID: <20231211191447.0408689d@kernel.org>
In-Reply-To: <20231208082316.3384650-1-alexious@zju.edu.cn>
References: <20231208082316.3384650-1-alexious@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Dec 2023 16:23:14 +0800 Zhipeng Lu wrote:
> v2: Setting tx_ring->tx_buffer to NULL after free.

Having closer look at this driver  - it tries to free both on close and
remove, so seems like we do indeed have to NULL-out the pointer, sigh.

> diff --git a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
> index 5935be190b9e..1bffe77439ac 100644
> --- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
> +++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
> @@ -866,6 +866,8 @@ static int atl1e_setup_ring_resources(struct atl1e_adapter *adapter)
>  		netdev_err(adapter->netdev, "offset(%d) > ring size(%d) !!\n",
>  			   offset, adapter->ring_size);
>  		err = -1;
> +		kfree(tx_ring->tx_buffer);
> +		tx_ring->tx_buffer = NULL;
>  		goto failed;

Please add a new jump target, tho, and move the freeing there.
There's a small chance someone will add more code to this function
and it will need to copy / paste this unwind.
-- 
pw-bot: cr
