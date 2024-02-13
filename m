Return-Path: <linux-kernel+bounces-63846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C34D585356C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AD7C2885EF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633925F845;
	Tue, 13 Feb 2024 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SsIPWU6J"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0DF5F54F;
	Tue, 13 Feb 2024 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839847; cv=none; b=gOEqrOyrMUgF5IqMPbj2yWM2irr8hpcAn0Xt8q8HOUozxbnKgdr+WSmKHmKH4vUi9oKwu65XTwXgEXm9mB5DzNgcBEr7IJMwLWMscBr6JT+cN7YhvYXKCftULOPkl5LZpkme7HxSV6zcb9juawQ3zg6Rky/7IF+yONz9/jP/9RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839847; c=relaxed/simple;
	bh=L5HFUuCbgdypUHaFrX7NoMN/dywBS26HbXH/mWMDEAE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ovkInI81FjbDeNd5RJ6igGDJDDb5rZKBYSYxccUjzT20BuqT/vYh66FJDvtBo1ERM0P8wFdz/qMv89DRNt84o3RgqxfjpGkkIvMo1KM6cL85r0cqwVGqeBJqQHiTIOI/ft3KIC8WWYP42ojpeg1+r+pruqGlCr6e0jdr5PFFdrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SsIPWU6J; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 840E2E000F;
	Tue, 13 Feb 2024 15:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707839836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xLKrcUWgSnxDEmML8cy4ZQrlK1+oKtedl7yJAvMVDT8=;
	b=SsIPWU6Jqssq5dl7/9GfrkUzaqLNd6eF8iA+CPIlTZScJjDBNxoIrN7AI9CwOm9WNbmkNv
	NqkPZbN7Ch1SsE29IVokl/WydXoJC1DmUcN5yKwJZyT/GQtH5xDQZiWFX7lH3NgBCnO+BM
	1oj5LuzMHiTrzHlvWnzLnU2l+Uz8Q1TgLx53qTxmOkNtgCeQggPu1xmYIACmUVVNansOM9
	Bmq4ffcmc0z/v3xRCkOqx/zmqA1LKiZ8AqfNLj1dshh5OJLZuQZ6ttLScMHPScZWP6kny2
	d6xT8s7ApSVVPxb2SS4jJo/L9khL/YSpjF+/VBYHGLGhxwQ1CR6wBq/Rp45K2A==
Date: Tue, 13 Feb 2024 16:57:12 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Richard Cochran
 <richardcochran@gmail.com>, <UNGLinuxDriver@microchip.com>,
 <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <thomas.petazzoni@bootlin.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Subject: Re: [PATCH net-next 2/3] net: lan966x: Allow using PCH extension
 for PTP
Message-ID: <20240213165712.27e0443a@device-28.home>
In-Reply-To: <20240213103156.rl4kzwpmxn3haz7y@DEN-DL-M31836.microchip.com>
References: <20240212173307.1124120-1-maxime.chevallier@bootlin.com>
	<20240212173307.1124120-3-maxime.chevallier@bootlin.com>
	<20240213103156.rl4kzwpmxn3haz7y@DEN-DL-M31836.microchip.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Horatiu,

On Tue, 13 Feb 2024 11:31:56 +0100
Horatiu Vultur <horatiu.vultur@microchip.com> wrote:

> The 02/12/2024 18:33, Maxime Chevallier wrote:
> > [Some people who received this message don't often get email from maxime.chevallier@bootlin.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]  
> 
> Hi Maxime,
> 
> I have tried your patches on pcb8291, which is a lan966x without PHYs
> that support timestamping. And on this platform this patch breaks up the
> things. Because it should just do the timestamping the MAC in that case,
> but with this patch it doesn't get any time.
> The same issue can be reproduced on pcb8280 and then disable PHY
> timestamping, or change the lan8814 not to support HW timestamping.
> 
> Please see bellow the reason why.

You are entirely correct and I apparently messed-up my series as these
changes were implemented locally and somehow lost in the rebase. Indeed
this codes doesn't work at all... I'll resend that, thanks a lot for
the test and sorry !

> 
> > 
> > +/* Enable or disable PCH timestamp transmission. This uses the USGMII PCH
> > + * extensions to transmit the timestamps in the frame preamble.
> > + */
> > +static void lan966x_ptp_pch_configure(struct lan966x_port *port, bool *enable)
> > +{
> > +       struct phy_device *phydev = port->dev->phydev;
> > +       int ret;
> > +
> > +       if (!phydev)
> > +               *enable = false;
> > +
> > +       if (*enable) {
> > +               /* If we cannot enable inband PCH mode, we fallback to classic
> > +                * timestamping
> > +                */
> > +               if (phy_inband_ext_available(phydev, PHY_INBAND_EXT_PCH_TIMESTAMP)) {
> > +                       ret = phy_inband_ext_enable(phydev, PHY_INBAND_EXT_PCH_TIMESTAMP);
> > +                       if (ret)
> > +                               *enable = false;
> > +               } else {
> > +                       *enable = false;
> > +               }
> > +       } else {
> > +               phy_inband_ext_disable(phydev, PHY_INBAND_EXT_PCH_TIMESTAMP);
> > +       }
> > +
> > +       lan_rmw(SYS_PCH_CFG_PCH_SUB_PORT_ID_SET(port->chip_port % 4) |
> > +               SYS_PCH_CFG_PCH_TX_MODE_SET(*enable) |
> > +               SYS_PCH_CFG_PCH_RX_MODE_SET(*enable),
> > +               SYS_PCH_CFG_PCH_SUB_PORT_ID |
> > +               SYS_PCH_CFG_PCH_TX_MODE |
> > +               SYS_PCH_CFG_PCH_RX_MODE,
> > +               port->lan966x, SYS_PCH_CFG(port->chip_port));
> > +}
> > +
> >  int lan966x_ptp_hwtstamp_set(struct lan966x_port *port,
> >                              struct kernel_hwtstamp_config *cfg,
> >                              struct netlink_ext_ack *extack)
> >  {
> >         struct lan966x *lan966x = port->lan966x;
> > +       bool timestamp_in_pch = false;
> >         struct lan966x_phc *phc;
> > 
> >         switch (cfg->tx_type) {
> > @@ -303,10 +339,18 @@ int lan966x_ptp_hwtstamp_set(struct lan966x_port *port,
> >                 return -ERANGE;
> >         }
> > 
> > +       if (cfg->source == HWTSTAMP_SOURCE_PHYLIB &&
> > +           cfg->tx_type == HWTSTAMP_TX_ON &&
> > +           port->config.portmode == PHY_INTERFACE_MODE_QUSGMII)
> > +               timestamp_in_pch = true;
> > +
> > +       lan966x_ptp_pch_configure(port, &timestamp_in_pch);
> > +
> >         /* Commit back the result & save it */
> >         mutex_lock(&lan966x->ptp_lock);
> >         phc = &lan966x->phc[LAN966X_PHC_PORT];
> >         phc->hwtstamp_config = *cfg;
> > +       phc->pch = timestamp_in_pch;  
> 
> Here we figure out if pch is enabled or not. If the cfg->source is not
> PHYLIB or the interface is not QUSGMII then timestamp_in_pch will stay
> false.
> 
> >         mutex_unlock(&lan966x->ptp_lock);
> > 
> >         return 0;
> > @@ -397,6 +441,7 @@ int lan966x_ptp_txtstamp_request(struct lan966x_port *port,
> >         LAN966X_SKB_CB(skb)->jiffies = jiffies;
> > 
> >         lan966x->ptp_skbs++;
> > +  
> 
> I think this is just a small style change. So maybe it shouldn't be in
> here.
> 
> >         port->ts_id++;
> >         if (port->ts_id == LAN966X_MAX_PTP_ID)
> >                 port->ts_id = 0;
> > @@ -500,6 +545,27 @@ irqreturn_t lan966x_ptp_irq_handler(int irq, void *args)
> >                 /* Read RX timestamping to get the ID */
> >                 id = lan_rd(lan966x, PTP_TWOSTEP_STAMP);
> > 
> > +               /* If PCH is enabled, there is a "feature" that also the MAC
> > +                * will generate an interrupt for transmitted frames. This
> > +                * interrupt should be ignored, so clear the allocated resources
> > +                * and try to get the next timestamp. Maybe should clean the
> > +                * resources on the TX side?
> > +                */
> > +               if (phy_inband_ext_enabled(port->dev->phydev,
> > +                                          PHY_INBAND_EXT_PCH_TIMESTAMP)) {
> > +                       spin_lock(&lan966x->ptp_ts_id_lock);
> > +                       lan966x->ptp_skbs--;
> > +                       spin_unlock(&lan966x->ptp_ts_id_lock);
> > +
> > +                       dev_kfree_skb_any(skb_match);
> > +
> > +                       lan_rmw(PTP_TWOSTEP_CTRL_NXT_SET(1),
> > +                               PTP_TWOSTEP_CTRL_NXT,
> > +                               lan966x, PTP_TWOSTEP_CTRL);
> > +
> > +                       continue;
> > +               }
> > +
> >                 spin_lock_irqsave(&port->tx_skbs.lock, flags);
> >                 skb_queue_walk_safe(&port->tx_skbs, skb, skb_tmp) {
> >                         if (LAN966X_SKB_CB(skb)->ts_id != id)
> > @@ -1088,19 +1154,27 @@ void lan966x_ptp_rxtstamp(struct lan966x *lan966x, struct sk_buff *skb,
> >         struct timespec64 ts;
> >         u64 full_ts_in_ns;
> > 
> > +       phc = &lan966x->phc[LAN966X_PHC_PORT];
> > +
> >         if (!lan966x->ptp ||
> > -           !lan966x->ports[src_port]->ptp_rx_cmd)
> > +           !lan966x->ports[src_port]->ptp_rx_cmd ||
> > +           !phc->pch)  
> 
> And here because phc->pch is false, it would just return.
> Meaning that it would never be able to get the time.
> I presume that this check should not be modified.

Dammit you are right and I had these modifications locally, but
apparently I messed my rebase and lost that... 

> 
> >                 return;
> > 
> > -       phc = &lan966x->phc[LAN966X_PHC_PORT];
> > -       lan966x_ptp_gettime64(&phc->info, &ts);
> > -
> > -       /* Drop the sub-ns precision */
> > -       timestamp = timestamp >> 2;
> > -       if (ts.tv_nsec < timestamp)
> > -               ts.tv_sec--;
> > -       ts.tv_nsec = timestamp;
> > -       full_ts_in_ns = ktime_set(ts.tv_sec, ts.tv_nsec);
> > +       if (phc->pch) {
> > +               /* Drop the sub-ns precision */
> > +               timestamp = timestamp >> 2;
> > +               full_ts_in_ns = lower_32_bits(timestamp);
> > +       } else {
> > +               lan966x_ptp_gettime64(&phc->info, &ts);
> > +
> > +               /* Drop the sub-ns precision */
> > +               timestamp = timestamp >> 2;
> > +               if (ts.tv_nsec < timestamp)
> > +                       ts.tv_sec--;
> > +               ts.tv_nsec = timestamp;
> > +               full_ts_in_ns = ktime_set(ts.tv_sec, ts.tv_nsec);
> > +       }  
>  
> 


Thanks for the review and analysis Horatiu, and sorry for this hiccup !

Maxime

