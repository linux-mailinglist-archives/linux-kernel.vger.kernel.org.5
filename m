Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2AE7842A7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236241AbjHVN7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbjHVN7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:59:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191421B2;
        Tue, 22 Aug 2023 06:59:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D6BD65759;
        Tue, 22 Aug 2023 13:59:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B64C433BC;
        Tue, 22 Aug 2023 13:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692712750;
        bh=BpLZy5EXAYnsyB2n/GZOh4fvSjwt5JJEL0l4Y1NMxR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jyfbcryffwrkCTjhH1ie23wS5GLG4GhWBDMmr2puY/U6hzFrQvee9af1Qsk+rThEs
         H1COZN9O1LFhT5j+xgQAQLO+HzBCvfPQIGdKV0NGQLm0eXtfuxkKRXrhGM69F+8OHE
         7JgrP2wFc74Cc3OJeXqfdXa4xa/mvXfO/ZZTxeMtZVXejmAUY6nADPJHDJrf52KEEN
         enylxcbKWsSLW14NSu9IH5HtD+iTJvU3J8asYNj5G2JXBNPv5GBSfIUqtADKnZhuAP
         G3BVXON61ncnFLJND5VQJN8Vl41gxSyaUczPlpTuqW226H4jX6QU1HHc5KEYi17b4c
         VWuoIE+GvDRLA==
Date:   Tue, 22 Aug 2023 19:29:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the dmaengine tree with Linus' tree
Message-ID: <ZOS/Kfmw3uvi1XMx@matsya>
References: <20230822151319.2cf59635@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822151319.2cf59635@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-08-23, 15:13, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the dmaengine tree got a conflict in:
> 
>   drivers/dma/mcf-edma.c
> 
> between commit:
> 
>   0a46781c89de ("dmaengine: mcf-edma: Fix a potential un-allocated memory access")
> 
> from Linus' tree and commit:
> 
>   923b13838892 ("dmaengine: mcf-edma: Use struct_size()")
> 
> from the dmaengine tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks for the merge, it lgtm


> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/dma/mcf-edma.c
> index 9413fad08a60,28304dd8763a..000000000000
> --- a/drivers/dma/mcf-edma.c
> +++ b/drivers/dma/mcf-edma.c
> @@@ -190,15 -189,9 +189,15 @@@ static int mcf_edma_probe(struct platfo
>   		return -EINVAL;
>   	}
>   
>  -	chans = pdata->dma_channels;
>  +	if (!pdata->dma_channels) {
>  +		dev_info(&pdev->dev, "setting default channel number to 64");
>  +		chans = 64;
>  +	} else {
>  +		chans = pdata->dma_channels;
>  +	}
>  +
> - 	len = sizeof(*mcf_edma) + sizeof(*mcf_chan) * chans;
> - 	mcf_edma = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
> + 	mcf_edma = devm_kzalloc(&pdev->dev, struct_size(mcf_edma, chans, chans),
> + 				GFP_KERNEL);
>   	if (!mcf_edma)
>   		return -ENOMEM;
>   



-- 
~Vinod
