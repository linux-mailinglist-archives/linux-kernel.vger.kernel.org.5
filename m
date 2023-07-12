Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5243F750EEF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjGLQsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjGLQs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:48:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A60911B;
        Wed, 12 Jul 2023 09:48:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCFF261840;
        Wed, 12 Jul 2023 16:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B313C433C7;
        Wed, 12 Jul 2023 16:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689180508;
        bh=o6U7TLywD6o6bw0C8hco3IaGeUAK/X3uTG4BfimyOw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hKPjgVgPEt4Z0UuY32DiQo5EZZsQewZg0ex5V++8LjiLQqAv7nnItXU3bP9xHhXyB
         BmIGahJTCSRJIu33d6hBfPnmNHA9qc+gxll+2eCYX8ZlEo6K7ASKUgCbXRQBI5NHHG
         hPmdIRwgIlMkt3TXEqf6c4I1la8QuwqnyI42Ztrjd/qgveLlUU8zEFjBe6Xug7cMrZ
         shplwewsHWF6yONfHv2DJe+AqrM52oehtHOpSX2E+58Wk5e5y4RwhmBgDh17dNJTHf
         ZG6UVic7HXF5Yg6junDUCzoynXjmBr799qoVKf1aNjCSHWLJD2DR7H9Xi5vn0n4zw3
         ImIcrNSoI/qfQ==
Date:   Wed, 12 Jul 2023 22:18:15 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org, keescook@chromium.org,
        christophe.jaillet@wanadoo.fr, kuba@kernel.org,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/24] bus: mhi: host: use vmalloc_array and vcalloc
Message-ID: <20230712164815.GI102757@thinkpad>
References: <20230627144339.144478-1-Julia.Lawall@inria.fr>
 <20230627144339.144478-11-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230627144339.144478-11-Julia.Lawall@inria.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 04:43:25PM +0200, Julia Lawall wrote:
> Use vmalloc_array and vcalloc to protect against
> multiplication overflows.
> 
> The changes were done using the following Coccinelle
> semantic patch:
> 
> // <smpl>
> @initialize:ocaml@
> @@
> 
> let rename alloc =
>   match alloc with
>     "vmalloc" -> "vmalloc_array"
>   | "vzalloc" -> "vcalloc"
>   | _ -> failwith "unknown"
> 
> @@
>     size_t e1,e2;
>     constant C1, C2;
>     expression E1, E2, COUNT, x1, x2, x3;
>     typedef u8;
>     typedef __u8;
>     type t = {u8,__u8,char,unsigned char};
>     identifier alloc = {vmalloc,vzalloc};
>     fresh identifier realloc = script:ocaml(alloc) { rename alloc };
> @@
> 
> (
>       alloc(x1*x2*x3)
> |
>       alloc(C1 * C2)
> |
>       alloc((sizeof(t)) * (COUNT), ...)
> |
> -     alloc((e1) * (e2))
> +     realloc(e1, e2)
> |
> -     alloc((e1) * (COUNT))
> +     realloc(COUNT, e1)
> |
> -     alloc((E1) * (E2))
> +     realloc(E1, E2)
> )
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Applied to mhi-next!

- Mani

> 
> ---
> v2: Use vmalloc_array and vcalloc instead of array_size.
> This also leaves a multiplication of a constant by a sizeof
> as is.  Two patches are thus dropped from the series.
> 
>  drivers/bus/mhi/host/init.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -u -p a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> --- a/drivers/bus/mhi/host/init.c
> +++ b/drivers/bus/mhi/host/init.c
> @@ -759,7 +759,7 @@ static int parse_ch_cfg(struct mhi_contr
>  	 * so to avoid any memory possible allocation failures, vzalloc is
>  	 * used here
>  	 */
> -	mhi_cntrl->mhi_chan = vzalloc(mhi_cntrl->max_chan *
> +	mhi_cntrl->mhi_chan = vcalloc(mhi_cntrl->max_chan,
>  				      sizeof(*mhi_cntrl->mhi_chan));
>  	if (!mhi_cntrl->mhi_chan)
>  		return -ENOMEM;
> 

-- 
மணிவண்ணன் சதாசிவம்
