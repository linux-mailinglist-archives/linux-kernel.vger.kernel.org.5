Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1296378A048
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 18:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjH0QwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 12:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjH0Qvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 12:51:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045A0FA;
        Sun, 27 Aug 2023 09:51:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C8C3611FE;
        Sun, 27 Aug 2023 16:51:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37361C433C7;
        Sun, 27 Aug 2023 16:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693155110;
        bh=TlQdo29IZv7MrO/bYku2qIiSdo/EQP4nkB2CM7ZXBQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EXHgQx9lmZ305uzl/tg0XGP5Q41kScb0RgwI4R6c6QE56Ova9jwAdfGthEm3HE0d1
         cR2EAUC6G5lfE6YwmJ+O+DBBM2X5+62rFDauvvCp9mlQy7Dpvcat+phlxVX9V1UFPq
         3e70CB9NB8FY6tLy4LmWTd2epqtCR5BN0OiOUVr3tPOL2nkFnNS9qh1npJEZ7Te1+c
         Ocau9RXriup9XmticG7AbKFhr9GU1npSkvmn/WyNA2ypq9eLP9w4sZ8MsX5CZNWnT9
         6XCz1fti2h1XFTySGimNQaNmKwbxpF4rmbaQUm7BkOhfhdzZ3nqxO/FY7fpYeivJXQ
         8WzZGORmTM0Sg==
Date:   Sun, 27 Aug 2023 18:51:30 +0200
From:   Simon Horman <horms@kernel.org>
To:     Mikhail Kobuk <m.kobuk@ispras.ru>
Cc:     Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        lvc-project@linuxtesting.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Matt Carlson <mcarlson@broadcom.com>
Subject: Re: [PATCH] ethernet: tg3: remove unreachable code
Message-ID: <20230827165130.GV3523530@kernel.org>
References: <20230825190443.48375-1-m.kobuk@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825190443.48375-1-m.kobuk@ispras.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 10:04:41PM +0300, Mikhail Kobuk wrote:

+ Matt Carlson <mcarlson@broadcom.com>

> 'tp->irq_max' value is either 1 [L16336] or 5 [L16354], as indicated in
> tg3_get_invariants(). Therefore, 'i' can't exceed 4 in tg3_init_one()
> that makes (i <= 4) always true. Moreover, 'intmbx' value set at the
> last iteration is not used later in it's scope.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 78f90dcf184b ("tg3: Move napi_add calls below tg3_get_invariants")
> Signed-off-by: Mikhail Kobuk <m.kobuk@ispras.ru>
> Reviewed-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> ---
>  drivers/net/ethernet/broadcom/tg3.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
> index 5ef073a79ce9..6b6da2484dfe 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -17792,10 +17792,7 @@ static int tg3_init_one(struct pci_dev *pdev,
>  		tnapi->tx_pending = TG3_DEF_TX_RING_PENDING;
>  
>  		tnapi->int_mbox = intmbx;
> -		if (i <= 4)
> -			intmbx += 0x8;
> -		else
> -			intmbx += 0x4;
> +		intmbx += 0x8;
>  
>  		tnapi->consmbox = rcvmbx;
>  		tnapi->prodmbox = sndmbx;
> -- 
> 2.42.0
> 
> 
