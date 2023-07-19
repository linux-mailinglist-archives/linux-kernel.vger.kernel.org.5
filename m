Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C726B758D34
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 07:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjGSFgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 01:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGSFgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 01:36:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F28D2;
        Tue, 18 Jul 2023 22:36:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6246F60B4A;
        Wed, 19 Jul 2023 05:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3810C433C8;
        Wed, 19 Jul 2023 05:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689744968;
        bh=d3/IxNuFlljicHq27zgThypsE9G9mnM25K7t3Fk1Ydw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DiKRDBeRYX7ESq/ogBKlUjPVwSz0hBHnVgLsDhViy+CGjZ582sXbGYCbff8xsb9gj
         7PEa2XSMLvgX4C9f3/ntcW1TKTP1MMrxtjD62N9U3sfgY4SyTrHrrBn7Cxm87dfxvm
         zX5d0VoeXsX0WgfMPELO7CIppkj3hj5JIG0lginY=
Date:   Wed, 19 Jul 2023 07:36:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqA==?= 
        <machel@vivo.com>
Cc:     Ajay Singh <ajay.kathat@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "opensource.kernel" <opensource.kernel@vivo.com>
Subject: Re: [PATCH net v2] net: wireless: Use kfree_sensitive instead of
 kfree
Message-ID: <2023071950-nervous-grub-5ee3@gregkh>
References: <20230719022041.663-1-machel@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230719022041.663-1-machel@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 02:21:16AM +0000, 王明-软件底层技术部 wrote:
> key contains private part of the key, so better use
> kfree_sensitive to free it.
> 
> Fixes: 7cec84fdfd88 ("staging: wilc1000: split add_key() to avoid line over 80 chars")
> Signed-off-by: Wang Ming <machel@vivo.com>

Why not also use 王明-软件底层技术部 <machel@vivo.com> here as well?


> ---
>  drivers/net/wireless/microchip/wilc1000/cfg80211.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

No change log from what changed from version 1?



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
>  
>  	key_info->key = kmemdup(params->key, params->key_len, GFP_KERNEL);
>  	if (!key_info->key)
> @@ -656,7 +656,7 @@ static int del_key(struct wiphy *wiphy, struct net_device *netdev, int link_id,
>  	if (!pairwise && (key_index == 4 || key_index == 5)) {
>  		key_index -= 4;
>  		if (priv->wilc_igtk[key_index]) {
> -			kfree(priv->wilc_igtk[key_index]->key);
> +			kfree_sensitive(priv->wilc_igtk[key_index]->key);

Normally "kfree_sensitive()" is used at the end of a function for when
kfree() of a local variable might not be called because the compiler
thinks it is smarter than us and optimizes it away.

Putting it here, in the normal operation, really doesn't do anything,
right?  There's always going to be odd data in the heap and normal
distros/users who care about that, always wipe the heap when doing new
allocations as that's a kernel config option.

So what exactly is this "fixing" here?  What is the bug?

thanks,

greg k-h
