Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E7A7F0862
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 19:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjKSSxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 13:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKSSxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 13:53:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6499B9F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 10:53:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FFAC433C8;
        Sun, 19 Nov 2023 18:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700420021;
        bh=PQkiYSwgy2Ik9bE+xTktdc1gARfnvhW7W1Xi1ky8tb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OMq9Cyu1Ee7cGFPHY7IzkKTxOjkiDfQTi73UxKkAMFK2kQeDvQCU49qzo/Gp/nOFH
         ijnHjs/GWIg7OblZnmQWloN/DbrucdPjy/3uimg8UZg6UoJ1tUd6CjRj23CGfXcAXG
         psso0EhMA3Bm6x48HHE9pHnrDsVnJVRCD7OaJEKn8aTFgHn5OEXD+Km7G4R6N+qiQY
         lFZmsWGvyW4oSTZ1pXcJKlY4xcF0H4sVcY20qZ8hwNwJ5NNt+OQwHzjatglwykBNUj
         oRe7NgHdedgFMvj+Bg3edvfPBdypr0bJQPsHd85zBHxGZoR7Aq2FuKpkkoK4QKiLcq
         fxTrPhXAkL7kQ==
Date:   Sun, 19 Nov 2023 18:53:37 +0000
From:   Simon Horman <horms@kernel.org>
To:     Ryosuke Saito <ryosuke.saito@linaro.org>
Cc:     jaswinder.singh@linaro.org, ilias.apalodimas@linaro.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, masahisa.kojima@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: netsec: replace cpu_relax() with timeout handling
 for register checks
Message-ID: <20231119185337.GE186930@vergenet.net>
References: <20231117081002.60107-1-ryosuke.saito@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117081002.60107-1-ryosuke.saito@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 05:10:02PM +0900, Ryosuke Saito wrote:
> The cpu_relax() loops have the potential to hang if the specified
> register bits are not met on condition. The patch replaces it with
> usleep_range() and netsec_wait_while_busy() which includes timeout
> logic.
> 
> Additionally, if the error condition is met during interrupting DMA
> transfer, there's no recovery mechanism available. In that case, any
> frames being sent or received will be discarded, which leads to
> potential frame loss as indicated in the comments.
> 
> Signed-off-by: Ryosuke Saito <ryosuke.saito@linaro.org>
> ---
>  drivers/net/ethernet/socionext/netsec.c | 35 ++++++++++++++++---------
>  1 file changed, 23 insertions(+), 12 deletions(-)

...

> @@ -1476,9 +1483,13 @@ static int netsec_reset_hardware(struct netsec_priv *priv,
>  	netsec_write(priv, NETSEC_REG_DMA_MH_CTRL, MH_CTRL__MODE_TRANS);
>  	netsec_write(priv, NETSEC_REG_PKT_CTRL, value);
>  
> -	while ((netsec_read(priv, NETSEC_REG_MODE_TRANS_COMP_STATUS) &
> -		NETSEC_MODE_TRANS_COMP_IRQ_T2N) == 0)
> -		cpu_relax();
> +	usleep_range(100000, 120000);
> +
> +	if ((netsec_read(priv, NETSEC_REG_MODE_TRANS_COMP_STATUS) &
> +			 NETSEC_MODE_TRANS_COMP_IRQ_T2N) == 0) {
> +		dev_warn(priv->dev,
> +			 "%s: trans comp timeout.\n", __func__);
> +	}

Hi Saito-san,

could you add some colour to how the new code satisfies the
requirements of the hardware?  In particular, the use of
usleep_range(), and the values passed to it.

>  
>  	/* clear any pending EMPTY/ERR irq status */
>  	netsec_write(priv, NETSEC_REG_NRM_TX_STATUS, ~0);
> -- 
> 2.34.1
> 
