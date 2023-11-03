Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35C87E0338
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 13:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346495AbjKCM5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 08:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjKCM5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:57:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA53E83
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 05:57:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA855C433C8;
        Fri,  3 Nov 2023 12:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699016236;
        bh=Z4GRd0KC2ISywGcPf/cNtZiFl5y4kqZBVx/tBDTs7UE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nToruN3xBPwHT7q+LbTARIMHGepo2OT9MGLynrmTvE1MVVtD4JrzpvjyZI0k2tMXU
         L8/l12OKmkFdt4SEQtmhXbbM+GSmJYkZEO4XHGAOQPwRoiY/IX6kL6Tw2YnRZf41VS
         BRGgalmr0TqJwJI7LfUoaH/1WgufMVPsljEvDXjA=
Date:   Fri, 3 Nov 2023 13:57:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yuran Pereira <yuran.pereira@hotmail.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        florian.fainelli@broadcom.com, linux-kernel@vger.kernel.org,
        justin.chen@broadcom.com, edumazet@google.com,
        bcm-kernel-feedback-list@broadcom.com, kuba@kernel.org,
        pabeni@redhat.com, linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] Prevent out-of-bounds read/write in bcmasp_netfilt_rd
 and bcmasp_netfilt_wr
Message-ID: <2023110301-purist-reputable-fab7@gregkh>
References: <DB3PR10MB6835E073F668AD24F57AE64AE8A5A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR10MB6835E073F668AD24F57AE64AE8A5A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 05:57:48PM +0530, Yuran Pereira wrote:
> The functions `bcmasp_netfilt_rd` and `bcmasp_netfilt_wr` both call
> `bcmasp_netfilt_get_reg_offset` which, when it fails, returns `-EINVAL`.
> This could lead to an out-of-bounds read or write when `rx_filter_core_rl`
> or `rx_filter_core_wl` is called.
> 
> This patch adds a check in both functions to return immediately if
> `bcmasp_netfilt_get_reg_offset` fails. This prevents potential out-of-bounds read
> or writes, and ensures that no undefined or buggy behavior would originate from
> the failure of `bcmasp_netfilt_get_reg_offset`.
> 
> Addresses-Coverity-IDs: 1544536 ("Out-of-bounds access")
> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
> ---
>  drivers/net/ethernet/broadcom/asp2/bcmasp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> index 29b04a274d07..8b90b761bdec 100644
> --- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> @@ -227,6 +227,8 @@ static void bcmasp_netfilt_wr(struct bcmasp_priv *priv,
>  
>  	reg_offset = bcmasp_netfilt_get_reg_offset(priv, nfilt, reg_type,
>  						   offset);
> +	if (reg_offset < 0)
> +		return;
>  
>  	rx_filter_core_wl(priv, val, reg_offset);
>  }
> @@ -244,6 +246,8 @@ static u32 bcmasp_netfilt_rd(struct bcmasp_priv *priv,
>  
>  	reg_offset = bcmasp_netfilt_get_reg_offset(priv, nfilt, reg_type,
>  						   offset);
> +	if (reg_offset < 0)
> +		return 0;

Shouldn't you return an error here?

thanks

greg k-h
