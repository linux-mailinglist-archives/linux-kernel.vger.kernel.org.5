Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7088E75AFA6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjGTNZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjGTNZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:25:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EE610F5;
        Thu, 20 Jul 2023 06:25:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8947B61A8B;
        Thu, 20 Jul 2023 13:25:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176AFC433C8;
        Thu, 20 Jul 2023 13:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689859541;
        bh=enaNhtEJLb4KtURfM6qBYfwCJGCa/Tdqz7P+nOYyZ/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Go319qZyg13GGPs35l/yGV/4md06yQbR6TD4+X7whtGiAv6azHi2lAOtBNWctMsjG
         iZSimSvMTK5h9fTZWWhtSqm5uYxzZz8NTt57MEpjDpBp9H7iY9psVBziCVvoNEaXn4
         YlmQ1THYjEzcoMFkgx1TkMccjFQWXA6dkOKji9Y4=
Date:   Thu, 20 Jul 2023 15:25:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     =?utf-8?B?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqA==?= 
        <machel@vivo.com>, Ajay Singh <ajay.kathat@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "opensource.kernel" <opensource.kernel@vivo.com>
Subject: Re: [PATCH net v2] net: wireless: Use kfree_sensitive instead of
 kfree
Message-ID: <2023072020-epilepsy-duchess-0a80@gregkh>
References: <20230719022041.663-1-machel@vivo.com>
 <2023071950-nervous-grub-5ee3@gregkh>
 <ZLj5HPT2y8cRhWnC@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLj5HPT2y8cRhWnC@duo.ucw.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 11:06:36AM +0200, Pavel Machek wrote:
> Hi!
> 
> > > diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
> > > index b545d93c6e37..45bcadeba2da 100644
> > > --- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
> > > +++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
> > > @@ -518,7 +518,7 @@ static int wilc_wfi_cfg_allocate_wpa_igtk_entry(struct wilc_priv *priv, u8 idx)
> > >  static int wilc_wfi_cfg_copy_wpa_info(struct wilc_wfi_key *key_info,
> > >  				      struct key_params *params)
> > >  {
> > > -	kfree(key_info->key);
> > > +	kfree_sensitive(key_info->key);
> > >  
> > >  	key_info->key = kmemdup(params->key, params->key_len, GFP_KERNEL);
> > >  	if (!key_info->key)
> > > @@ -656,7 +656,7 @@ static int del_key(struct wiphy *wiphy, struct net_device *netdev, int link_id,
> > >  	if (!pairwise && (key_index == 4 || key_index == 5)) {
> > >  		key_index -= 4;
> > >  		if (priv->wilc_igtk[key_index]) {
> > > -			kfree(priv->wilc_igtk[key_index]->key);
> > > +			kfree_sensitive(priv->wilc_igtk[key_index]->key);
> > 
> > Normally "kfree_sensitive()" is used at the end of a function for when
> > kfree() of a local variable might not be called because the compiler
> > thinks it is smarter than us and optimizes it away.
> > 
> > Putting it here, in the normal operation, really doesn't do anything,
> > right?  There's always going to be odd data in the heap and normal
> 
> It does memzero.
> 
> https://elixir.bootlin.com/linux/latest/source/mm/slab_common.c#L1411

I know what it does, I'm saying "why is this required".
