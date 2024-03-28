Return-Path: <linux-kernel+bounces-122787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4F188FD41
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7371F26CE6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3067D07D;
	Thu, 28 Mar 2024 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnQC3/xR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B872B53818;
	Thu, 28 Mar 2024 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711622418; cv=none; b=TAuL2LiXoBXucvNhEyn5iQ7MBg2mP4aeHmtGP/TzsYTKd3jz3KoLWrgzyT/ZVjm+nO6QSmhLgyfkGwx56poLs1SHorWcehSBmmP2UtjxAVFe6ZETS932tyJ+rnqapvFyaaR1tqFUd9U0HrdvN2MYxypTiG08zyrTZljTN5E+vHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711622418; c=relaxed/simple;
	bh=PFuuAQ7UAQDLr/XGux3xSP9ZSukNKrAk400GL4pCeaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ly40ZBRCKkE9RqDoshebxLl+hrPQjZSclpv2/0xDuJb3pofasKUyNz0N8qzcON+sgCLfcHm8Q/1pddv06I0B2nPGowjaoFUal9aqx+uEE1hzxul4hmtTtEQ0eH7cUjTTBN3MB+uyCuTSMPfRVbG9qIAsBxqthQmsBerjENk0igI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnQC3/xR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5A1C43390;
	Thu, 28 Mar 2024 10:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711622418;
	bh=PFuuAQ7UAQDLr/XGux3xSP9ZSukNKrAk400GL4pCeaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jnQC3/xRFP0QVRTUNeZoU1I3y8WHjbeIbClQXTonCmY0HLKChE2JxhC2ZI9JRCgfA
	 NsA6JUXigjuchixlHKDNcyFGz2h3qHBDpNK9DAJH0sobRXcnBUhjHot8kJeLULLZfS
	 QTGKC2O1nCFR9+NpZOlVU20eRPehWrlyvtgpewgsZOhwTLYckAp/CXSZYnIP8ttyEf
	 N1oViVVNkjowwegTIg86IwVEnnzzNj04FUM01Vsve/wE6zDEfAZvDGaFqDBCfpi84S
	 v0xHNCGlLZAHHhPnYRS0eBiHgv9n7z30A2d7fCmNG19ev5aZMWXgXd8M2DG7V/eN2n
	 9PuxhiYvhX5lA==
Date: Thu, 28 Mar 2024 10:40:11 +0000
From: Simon Horman <horms@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v6 10/17] net: pse-pd: Add support for PSE PIs
Message-ID: <20240328104011.GY403975@kernel.org>
References: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
 <20240326-feature_poe-v6-10-c1011b6ea1cb@bootlin.com>
 <20240328103322.GX403975@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328103322.GX403975@kernel.org>

On Thu, Mar 28, 2024 at 10:33:22AM +0000, Simon Horman wrote:
> On Tue, Mar 26, 2024 at 03:04:47PM +0100, Kory Maincent wrote:
> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

..

> > diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
> 
> ...
> 
> > @@ -73,11 +103,11 @@ struct pse_control;
> >   * @pse_control_head: head of internal list of requested PSE controls
> >   * @dev: corresponding driver model device struct
> >   * @of_pse_n_cells: number of cells in PSE line specifiers
> > - * @of_xlate: translation function to translate from specifier as found in the
> > - *            device tree to id as given to the PSE control ops
> >   * @nr_lines: number of PSE controls in this controller device
> >   * @lock: Mutex for serialization access to the PSE controller
> >   * @types: types of the PSE controller
> > + * @pi: table of PSE PIs described in this controller device
> > + * @of_legacy: flag set if the pse_pis devicetree node is not used
> 
> nit: it looks line the documentation didn't keep up with the
>      structure during development: @no_of_pse_pi should be
>      documented instead of @of_legacy.

There seem to be some similar minor problems in
[PATCH net-next v6 13/17] net: pse-pd: Use regulator framework within PSE framework

/scripts/kernel-doc -none is your friend here.

> 
> >   */
> >  struct pse_controller_dev {
> >  	const struct pse_controller_ops *ops;
> > @@ -86,11 +116,11 @@ struct pse_controller_dev {
> >  	struct list_head pse_control_head;
> >  	struct device *dev;
> >  	int of_pse_n_cells;
> > -	int (*of_xlate)(struct pse_controller_dev *pcdev,
> > -			const struct of_phandle_args *pse_spec);
> >  	unsigned int nr_lines;
> >  	struct mutex lock;
> >  	enum ethtool_pse_types types;
> > +	struct pse_pi *pi;
> > +	bool no_of_pse_pi;
> >  };
> 
> ...
> 

