Return-Path: <linux-kernel+bounces-34813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 441B78387CE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 803DA1C23851
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A320E524D0;
	Tue, 23 Jan 2024 07:10:20 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C5651C2A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705993820; cv=none; b=Mc4I08+yB8hzdNHpD/lJfXCrG8i5II9SkP9nzxTUQbCYVpmGem938NIkw6ndbatRvFdfnhFAI2Jf/bRxFTRbsGeZJUD5ypOUID6afJJ0XLctjqZt0A1E02iTvHB2UcqSP4kAauZDTqnfKnkDvEB6sLtaj/MU4QzHh01OqpEkU1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705993820; c=relaxed/simple;
	bh=32ZqCuQ4/QKleRINyVHRGBKT/W3OXQ6ZsS8lsWSJXP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sau/driIhg4rxOlsYRGj02QPeSHb5Oi1a1EaM7YWMCFo0pwpDj1+V4C554x7mcS665X8k5B/IVLX1H/O/lf2bqxEc4sqCTC6lcBcum8YQUaYIRcsq3qFPr+X0XCapX/AJuknkmdU7Sxodt/qAkgAl6eUB970GgfMXN1w4OSQUwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1rSAuv-0001zL-2o; Tue, 23 Jan 2024 08:09:53 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1rSAut-001mCz-VU; Tue, 23 Jan 2024 08:09:51 +0100
Received: from sha by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1rSAut-001KLj-SN; Tue, 23 Jan 2024 08:09:51 +0100
Date: Tue, 23 Jan 2024 08:09:51 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aisheng Dong <aisheng.dong@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/3] mailbox: imx: get RR/TR registers num from
 Parameter register
Message-ID: <20240123070951.GA93665@pengutronix.de>
References: <20240122-imx-mailbox-v2-0-7b3c80333b92@nxp.com>
 <20240122-imx-mailbox-v2-2-7b3c80333b92@nxp.com>
 <20240122090330.GR4700@pengutronix.de>
 <DU0PR04MB9417852AC47FA4BCFB38560F88742@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417852AC47FA4BCFB38560F88742@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Tue, Jan 23, 2024 at 01:42:03AM +0000, Peng Fan wrote:
> Hi Sascha,
> 
> > Subject: Re: [PATCH v2 2/3] mailbox: imx: get RR/TR registers num from
> > Parameter register
> >
> > Hi Peng,
> 
> [snip]
> >
> > >  };
> > >
> > >  enum imx_mu_type {
> > > @@ -264,18 +267,17 @@ static int imx_mu_generic_rxdb(struct
> > > imx_mu_priv *priv,  static int imx_mu_specific_tx(struct imx_mu_priv
> > > *priv, struct imx_mu_con_priv *cp, void *data)  {
> > >     u32 *arg = data;
> > > +   u32 num_tr = priv->num_tr;
> > >     int i, ret;
> > >     u32 xsr;
> > > -   u32 size, max_size, num_tr;
> > > +   u32 size, max_size;
> > >
> > >     if (priv->dcfg->type & IMX_MU_V2_S4) {
> > >             size = ((struct imx_s4_rpc_msg_max *)data)->hdr.size;
> > >             max_size = sizeof(struct imx_s4_rpc_msg_max);
> > > -           num_tr = 8;
> >
> > This change looks unexpected here. num_tr used to be 8 here and now
> > becomes 4 at maximum. Was this a bug? If yes, this deserves a separate
> > patch with an explanation what was wrong here.
> 
> Sorry, I could not follow you here.
> The num_tr is switch to use priv->num_tr now. It is not changed to 4 at
> maximum, it is just use priv->num_tr to avoid hardcoding it to 8.
> As of now, all platforms has IMX_MU_V2_S4 are using 8, and
> the hardware register num is 8, except i.MX95 V2X MU using 4.

I was confused by the warning you introduced:

> > > +   if (priv->num_rr > 4 || priv->num_tr > 4) {
> > > +           WARN_ONCE(true, "%s not support TR/RR larger than 4\n",
> > __func__);
> > > +           return;
> > > +   }

It will trigger when priv->num_tr is read as 8, so I assumed it is 4 at
maximum. Indeed just the check is wrong and you might haven't notice the
warning during testing.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

