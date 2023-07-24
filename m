Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF4D75EA5D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 06:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjGXEI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 00:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjGXEIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 00:08:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B6110C8;
        Sun, 23 Jul 2023 21:08:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71EB860F21;
        Mon, 24 Jul 2023 04:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8498CC433C7;
        Mon, 24 Jul 2023 04:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690171717;
        bh=8c2zav60atZ7w/JV19Iq5+QqEuSTHxx9gxQ1aqSwTrM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fkJU9mCvFRXnA8NyDj/QWtJsqvGuti6sfyP5PLjjN4Ya+Tc7Ho3wSxsR2jXn9Eyoy
         qyUykWtqXd8yxj1kxb58hVqCxnxxQ26O8n7bQ0WTT9rC7rjF61+Ppkr5y3M3bJtJfH
         lE18UClDAO2d9Y5RdhFhBWi0keCbu+VswLRItn8s=
Date:   Mon, 24 Jul 2023 06:08:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        mathias.nyman@intel.com, linux-usb@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 3/9] xhci: Don't require a valid
 get_quirks() function pointer during xhci setup
Message-ID: <2023072426-impart-neatness-d0e0@gregkh>
References: <20230724013554.2334965-1-sashal@kernel.org>
 <20230724013554.2334965-3-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724013554.2334965-3-sashal@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 09:35:45PM -0400, Sasha Levin wrote:
> From: Mathias Nyman <mathias.nyman@linux.intel.com>
> 
> [ Upstream commit 9b907c91aa94522ae14bf155ce7b9ccb10a0903c ]
> 
> Not all platforms drivers need to set up custom quirks during the xhci
> generic setup. Allow them to pass NULL as the function pointer when
> calling xhci_gen_setup()
> 
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> Message-ID: <20230602144009.1225632-4-mathias.nyman@linux.intel.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/usb/host/xhci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 0f2b67f38d2ea..3feee0419fdd9 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -4975,7 +4975,8 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
>  
>  	xhci->quirks |= quirks;
>  
> -	get_quirks(dev, xhci);
> +	if (get_quirks)
> +		get_quirks(dev, xhci);

Not needed in 4.14.y, thanks.

greg k-h
