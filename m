Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9010D7FB5BE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjK1J0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjK1J0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:26:37 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE405D0;
        Tue, 28 Nov 2023 01:26:42 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 14305E000C;
        Tue, 28 Nov 2023 09:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701163601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7SWqqO2Y/xiO+TRt8YQW+yLQIPdt2LTdZoHMxmm1Ics=;
        b=Sjtn6l7zR30mQxJLlA3aYzk9WnLTcPBVw0DYsqorv2X4Go8xgOK4V3aCzIINxp+nkLGQK5
        Ayse/f/Mse7tHbDjEPE+MPdWmz3bMf42OLOslD8lN5W9elEuudOQOBJjNrD+tiwAbEWIAr
        SCTRi+QfaZVk0WJipImlHqNLPfi9dC88hjVDTFMScwVwr1vaJ5aeZQD3WVaCxQPTF2Ikz1
        dlK4suG6cJLtk01cHyNVpoT0H7VlPB0VGUwvyIScf/5+mKM+5Bfq0T+bA2rNwRtCJDAFRP
        Jp/kVUBaLItB12epGtBbbim4dhUuRLuNfhMK3eet1bJq29qppvLkNdVT6MzFIA==
Date:   Tue, 28 Nov 2023 11:20:37 +0100
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Simon Horman <horms@kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        alexis.lothore@bootlin.com
Subject: Re: [PATCH net] net: stmmac: dwmac-socfpga: Don't access SGMII
 adapter when not available
Message-ID: <20231128112037.21e2d5aa@device.home>
In-Reply-To: <20231128101841.627fc97e@windsurf>
References: <20231128094538.228039-1-maxime.chevallier@bootlin.com>
        <20231128101841.627fc97e@windsurf>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On Tue, 28 Nov 2023 10:18:41 +0100
Thomas Petazzoni <thomas.petazzoni@bootlin.com> wrote:

> On Tue, 28 Nov 2023 10:45:37 +0100
> Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:
> 
> > The SGMII adapter isn't present on all dwmac-socfpga implementations.
> > Make sure we don't try to configure it if we don't have this adapter.
> > 
> > Fixes: 5d1f3fe7d2d5 ("net: stmmac: dwmac-sogfpga: use the lynx pcs driver")
> > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> > index ba2ce776bd4d..ae120792e1b6 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> > @@ -243,7 +243,8 @@ static void socfpga_sgmii_config(struct socfpga_dwmac *dwmac, bool enable)
> >  {
> >  	u16 val = enable ? SGMII_ADAPTER_ENABLE : SGMII_ADAPTER_DISABLE;
> >  
> > -	writew(val, dwmac->sgmii_adapter_base + SGMII_ADAPTER_CTRL_REG);
> > +	if (dwmac->sgmii_adapter_base)
> > +		writew(val, dwmac->sgmii_adapter_base + SGMII_ADAPTER_CTRL_REG);
> >  }
> >  
> >  static int socfpga_set_phy_mode_common(int phymode, u32 *val)  
> 
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> 
> As a follow-up improvement, there's an open-coded version of
> socfpga_sgmii_config() in socfpga_dwmac_fix_mac_speed(), which could be
> rewritten as such:
> 
> 	socfpga_sgmii_config(dwmac, false);
>
> 	if (splitter_base) {
> 		val = readl(splitter_base + EMAC_SPLITTER_CTRL_REG);
> 		val &= ~EMAC_SPLITTER_CTRL_SPEED_MASK;
 [...]

I did saw this, but as this is merely a non-functional rework, I'd
like to target this to net-next, so I'll wait for the fix to land and
follow-up with this rework indeed.

Thanks for the review,

Maxime
