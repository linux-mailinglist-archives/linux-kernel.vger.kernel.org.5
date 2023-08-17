Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8962677FA72
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352942AbjHQPNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352975AbjHQPMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:12:47 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78FB3596;
        Thu, 17 Aug 2023 08:12:19 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qWefE-0002gb-2L;
        Thu, 17 Aug 2023 15:11:57 +0000
Date:   Thu, 17 Aug 2023 16:11:48 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Alexander Couzens <lynxis@fe80.eu>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next] net: pcs: lynxi: fully reconfigure if link is
 down
Message-ID: <ZN44tDZydQfFqZqo@makrotopia.org>
References: <e9831ec99acd5a8ab03c76fce87fa750c7041e60.1692273723.git.daniel@makrotopia.org>
 <ZN4arCVzdszcIBX0@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN4arCVzdszcIBX0@shell.armlinux.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Thu, Aug 17, 2023 at 02:03:40PM +0100, Russell King (Oracle) wrote:
> On Thu, Aug 17, 2023 at 01:04:06PM +0100, Daniel Golle wrote:
> > On MT7988 When switching from 10GBase-R/5GBase-R/USXGMII to one of the
> > interface modes provided by mtk-pcs-lynxi we need to make sure to
> > always perform a full configuration of the PHYA.
> > As the idea behind not doing that was mostly to prevent an existing link
> > going down without any need for it to do so. Hence we can just always
> > perform a full confinguration in case the link is down.
> 
> And this is racy - because in the case with inband signalling, the link
> can come up between reading the status and acting on it. It could even
> be already up, but the link status indicates it is not. Lastly, reading
> the BMSR has side effects: the link status bit latches low until a read.
> 
> Basically, do not read the BMSR here, it's buggy to read it any place
> other than pcs_get_state.
> 
> I think what we need to do instead are:
> 
> 1) mtk_mac_select_pcs() returns the SGMII PCS or NULL. Presumably this
>    is the driver which supports 10GBase-R/5GBase-R/USXGMII, and thus
>    this returns NULL for 10GBase-R/5GBase-R/USXGMII.
> 
>    Phylink doesn't cater for mac_select_pcs() returning non-NULL for
>    some modes and NULL for others, mainly because the presence of a PCS
>    _used_ to cause phylink to change its behaviour (see
>    https://lore.kernel.org/netdev/YZRLQqLblRurUd4V@shell.armlinux.org.uk/).
>    That has now changed (we've got rid of the legacy stuff at last!) so
>    there is no technical reason not to now allow that.
> 
>    Vladimir did have some arguments for not allowing it when we had the
>    phylink_set_pcs() interface:
>    https://lore.kernel.org/netdev/20211123181515.qqo7e4xbuu2ntwgt@skbuf/
>    I'm assuming that your requirement now provides sufficient
>    justification for allowing this.
> 
>    There is one bug that does need fixing first:
>    phylink_change_inband_advert() checks pl->pcs->neg_mode without
>    first checking whether pl->pcs is non-NULL.
> 
>    To allow this, phylink_major_config() needs:
> 
>    	pcs_changed = pcs && pl->pcs != pcs;
> 
>    to become:
> 
>    	pcs_changed = pl->pcs != pcs;
> 
> 2) with (1) solved, there are a couple of callbacks that can be used to
>    solve this - I think pcs_disable() is the one you want, which will
>    be called when we switch to a mode where _this_ PCS will no longer
>    be used (thus you can reset mpcs->interface to _NA, ready for when
>    it is next brought into use.)
> 
> Would that work for you?

Yes, and that actually even makes things much easier.
The case of mtk_mac_select_pcs() returning NULL is not even relevant:
In case of the interface being 10GBase-R, 5GBase-R or USXGMII
mtk_mac_select_pcs() will return a pointer to the USXGMII PCS instance[1].

Hence simply implementing .pcs_disabled already resolves the issue.
I will post a patch doing that instead which replaces this patch.


Thank you for reviewing!


Daniel


[1]: https://github.com/dangowrt/linux/commit/c81d14e214c8bbbab81fd6d6d49e6f7b87015e1e#diff-6f8a141b53de471a9fe00ac68f8c82b9dda3bad057c160327d6bfe1b0b9c8b23R550
