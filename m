Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF477E8321
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbjKJTrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346419AbjKJTrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:47:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B648A7E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 11:44:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C95C433C8;
        Fri, 10 Nov 2023 19:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699645451;
        bh=gMTNMcFdUq6GUBvKFbLUH+ZN2QErP8+dG8hYixvB3TA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o3I8vKDiIJbvJIlfTxeM04d6iidiBy5EncXrF1n5tTzEf70QY2Mg6nol/AzqQIPCs
         XhKpKpuC15SU0q44aaz/keJvpj4yO+s7wburNS1Xk0IWYFMQiE5QcXGRvSVNpDQ/8O
         OGD1qaqKNZnjwdca6yFY3rE44LR1CrzuqLcROCO1Rjb53jmjgWowfTbyhFy1y9sIDQ
         VAZ/nwzggdy6J1n5dJax4v7zbTiBV2Oz+VxsMC64+6JE9g7UIhRDE3UwcN7ZJf0RcB
         yPWG1rznN3awtPrArA3r/gdm5FNalYwN6rv4bfjoThxcRppUN76b7pieDExFQimcaD
         0W6J0IlSLHW5g==
Date:   Fri, 10 Nov 2023 11:44:10 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Dae R. Jeong" <threeearcat@gmail.com>
Cc:     borisp@nvidia.com, john.fastabend@gmail.com, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ywchoi@casys.kaist.ac.kr
Subject: Re: [PATCH] tls: fix missing memory barrier in tls_init
Message-ID: <20231110114410.01cd3eb3@kernel.org>
In-Reply-To: <ZU4Mk_RfzvRpwkmX@dragonet>
References: <ZU4Mk_RfzvRpwkmX@dragonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2023 19:57:23 +0900 Dae R. Jeong wrote:
> +	mutex_init(&ctx->tx_lock);
> +	ctx->sk_proto = READ_ONCE(sk->sk_prot);
> +	ctx->sk = sk;
>  	ctx->tx_conf = TLS_BASE;
>  	ctx->rx_conf = TLS_BASE;

TLS_BASE is 0, so there's no strong reason to move the rcu assign
after *x_conf init. It's already 0. You can replace the assignment
with WARN_ON(ctx->tx_conf != TLS_BASE) to make sure, and move that 
into tls_ctx_create() instead of removing that function.

FWIW make sure you read this before posting v2:

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
