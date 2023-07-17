Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840FE756682
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjGQOfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGQOft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:35:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6371BE;
        Mon, 17 Jul 2023 07:35:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4848C61070;
        Mon, 17 Jul 2023 14:35:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF66C433C7;
        Mon, 17 Jul 2023 14:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689604547;
        bh=wkWyQH5Rw+uI//ie9kDz9PJG5ccJnGGiK/ksrVALN6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hi7bxdt9naGox+8fFiNdaQJGdo30qUe2u1C+0LkKsRVePOP7YXW+bBNBJwhq/3mqm
         O+LtoGZYjvSozZ0xkkV76ua2xCQxPJs8A18aO8BJ8C5UpsfvNhpvh9iG8Y6yd2ruKi
         CucdNDZeyVcD6qoGNlYhxt/+2Pm1YHdHuKT+eFGE=
Date:   Mon, 17 Jul 2023 16:35:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wang Ming <machel@vivo.com>
Cc:     Ajay Singh <ajay.kathat@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH net v1] net: wireless: Use kfree_sensitive instead of
 kfree
Message-ID: <2023071715-marsupial-matron-c743@gregkh>
References: <20230717093456.17474-1-machel@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717093456.17474-1-machel@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 05:34:43PM +0800, Wang Ming wrote:
> key might contain private part of the key, so better use
> kfree_sensitive to free it.

"might"?  What determines if it does, or does not, contain the private
part of the key?

Shouldn't this always be known?

> Fixes: 7cec84fdfd88 ("staging: wilc1000: split add_key() to avoid line over 80 chars")
> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>  drivers/net/wireless/microchip/wilc1000/cfg80211.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
> index b545d93c6e37..45bcadeba2da 100644
> --- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
> +++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
> @@ -518,7 +518,7 @@ static int wilc_wfi_cfg_allocate_wpa_igtk_entry(struct wilc_priv *priv, u8 idx)
>  static int wilc_wfi_cfg_copy_wpa_info(struct wilc_wfi_key *key_info,
>  				      struct key_params *params)
>  {
> -	kfree(key_info->key);
> +	kfree_sensitive(key_info->key);

For most systems, this would have been wiped when kfree() was called due
to allocation being zeroed out, right?

But, if you want to be safe, and you know this was a private key, that's
fine to do as well, but please figure out if this really is, or is not,
a private key.

thanks,

greg k-h
