Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8357878B884
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjH1TjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbjH1Ti4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:38:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB96123
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:38:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42557639A9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 19:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49159C433C7;
        Mon, 28 Aug 2023 19:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693251531;
        bh=L5/usRoTQkY0NoAqxhYEBU7YzcbiHRwN9h1q1YuPI1s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uRgmWe/4dw2beWc7pVFw+c0KIFlChQsMUW35wruhyGQV9RuOdaP4I0p2mU8f32xUs
         s5Jn586gfW8hgaxlFyQfbCrYxuBKLJNCCb6Nf/7bGEqNZtyfUBeR3l6sa/zfH0bUoi
         A1XafmFpvV86FksFScJqp63/tL/4OGBNEu5j0+m/9pQYxAyn0DeRF5qUZ9NkXBnw3r
         mkZc99nSlPdIh0lTih1NV5o0GSO3epl8KgwQ6OaxRxileksbOrrsxaUsK5d+pDdaOV
         TNjp+8Z6qS6e9Ev/xHfzcRuQuKcP3nICPAIVvy+doX1Cnn2DbbMbGwd3UPWVQwMVno
         8iSS5pKYfHpmg==
Date:   Mon, 28 Aug 2023 12:38:49 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexandra Diupina <adiupina@astralinux.ru>,
        Zhao Qiang <qiang.zhao@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH v3] fsl_ucc_hdlc: process the result of hold_open()
Message-ID: <20230828123849.69466f0a@kernel.org>
In-Reply-To: <20230828121235.13953-1-adiupina@astralinux.ru>
References: <896acfac-fadb-016b-20ff-a06e18edb4d9@csgroup.eu>
        <20230828121235.13953-1-adiupina@astralinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 15:12:35 +0300 Alexandra Diupina wrote:
> Process the result of hold_open() and return it from
> uhdlc_open() in case of an error
> It is necessary to pass the error code up the control flow,
> similar to a possible error in request_irq()
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
> ---
> v3: Fix the commits tree
> v2: Remove the 'rc' variable (stores the return value of the 
> hdlc_open()) as Christophe Leroy <christophe.leroy@csgroup.eu> suggested
>  drivers/net/wan/fsl_ucc_hdlc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
> index 47c2ad7a3e42..4164abea7725 100644
> --- a/drivers/net/wan/fsl_ucc_hdlc.c
> +++ b/drivers/net/wan/fsl_ucc_hdlc.c
> @@ -731,7 +731,7 @@ static int uhdlc_open(struct net_device *dev)
>  		napi_enable(&priv->napi);
>  		netdev_reset_queue(dev);
>  		netif_start_queue(dev);
> -		hdlc_open(dev);
> +		return hdlc_open(dev);

Don't you have to undo all the things done prior to hdlc_open()?

Before you post v4 please make sure that you've read:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#resending-after-review

Zhao, please review the next version.
-- 
pw-bot: cr
