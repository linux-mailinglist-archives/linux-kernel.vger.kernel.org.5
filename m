Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39ACE751F99
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbjGMLLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 07:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjGMLLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:11:50 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284361FF1;
        Thu, 13 Jul 2023 04:11:49 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qJuEa-00082a-0L;
        Thu, 13 Jul 2023 11:11:44 +0000
Date:   Thu, 13 Jul 2023 12:11:30 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Ungerer <gerg@kernel.org>
Subject: Re: [PATCH v2 net-next 4/9] net: ethernet: mtk_eth_soc: increase
 MAX_DEVS to 3
Message-ID: <ZK_b4s6cQd-lhz1Y@makrotopia.org>
References: <cover.1689012506.git.daniel@makrotopia.org>
 <2cc8012ec538106c6bcf22a40b647ec342e687a8.1689012506.git.daniel@makrotopia.org>
 <ZK+izTulIcse2aG5@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK+izTulIcse2aG5@shell.armlinux.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 08:07:57AM +0100, Russell King (Oracle) wrote:
> On Thu, Jul 13, 2023 at 03:18:52AM +0100, Daniel Golle wrote:
> > From: Lorenzo Bianconi <lorenzo@kernel.org>
> > 
> > This is a preliminary patch to add MT7988 SoC support since it runs 3
> > macs instead of 2.
> > 
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 6 +++++-
> >  drivers/net/ethernet/mediatek/mtk_eth_soc.h | 4 ++--
> >  2 files changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > index 7014e0d108b27..7f191e4337dd8 100644
> > --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > @@ -4030,8 +4030,12 @@ static void mtk_sgmii_destroy(struct mtk_eth *eth)
> >  {
> >  	int i;
> >  
> > -	for (i = 0; i < MTK_MAX_DEVS; i++)
> > +	for (i = 0; i < MTK_MAX_DEVS; i++) {
> > +		if (!eth->sgmii_pcs[i])
> > +			continue;
> > +
> >  		mtk_pcs_lynxi_destroy(eth->sgmii_pcs[i]);
> > +	}
> 
> Please instead arrange for mtk_pcs_lynxi_destroy() to be a no-op if it's
> passed a NULL pointer, which makes it easier to use in error paths (it
> means mtk_pcs_lynxi_destroy() can be called without checks - like
> kfree() etc.)
> 
> Since error paths don't get often tested, we need to do as much as
> possible to make error paths trivial.

This is the case already, so the above if-clause can be dropped.
I will do so in v3.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/pcs/pcs-mtk-lynxi.c#n291
