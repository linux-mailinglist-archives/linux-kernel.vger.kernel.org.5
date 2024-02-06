Return-Path: <linux-kernel+bounces-55116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9BB84B7F3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC55528C422
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AF21E89C;
	Tue,  6 Feb 2024 14:32:09 +0000 (UTC)
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132391E538;
	Tue,  6 Feb 2024 14:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229928; cv=none; b=prG8n2I2Q08p7idbDVNr4kVEERux9VL8kTUhJ2mYg9PKNP5HDET8ZO/KOGLczbO4Sl6NPPm2mVhQNyryz9SJt0YPxdTvVf2IG5/mNPEPmAIwlIQYAH/anSl1lavrRMBjSZusCnBlSw5+KfsWlxr4Bpmk6B0rfWQqMg7Gk+nB5+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229928; c=relaxed/simple;
	bh=FXlLwj57nAJFGF/Vub+i5XUXQg7kTxUUzmFuRuy0jiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rldLpcChIvJ0L7P4TxEUYVxFX1aIsyRm7MHHQYmhBZraZ55m9fltrCgblCW5VzyYBoPJgKF+NvwQ/WYfieKzDGANmL77/OcMPELTVvktjW8dGuvtwunHGakgzgSeE4/KP0xhZS85ayStEkrVQmavMy7FUxsJ4+TDzzrDiOaorz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from martin by akranes.kaiser.cx with local (Exim 4.96)
	(envelope-from <martin@akranes.kaiser.cx>)
	id 1rXM4h-000AXd-1k;
	Tue, 06 Feb 2024 15:05:23 +0100
Date: Tue, 6 Feb 2024 15:05:23 +0100
From: Martin Kaiser <martin@kaiser.cx>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Shawn Guo <shawnguo@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Peng Fan <peng.fan@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] gpio: vf610: allow disabling the vf610 driver
Message-ID: <ZcI8oyHzaktJcfNV@v2202401214221251712.nicesrv.de>
References: <20240124205900.14791-1-martin@kaiser.cx>
 <20240124205900.14791-2-martin@kaiser.cx>
 <20240126122719.GA13659@francesco-nb>
 <ZbgX-HGjM5fdftCG@v2202401214221251712.nicesrv.de>
 <ZbibA9QbOn19AXcn@gaggiata.pivistrello.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbibA9QbOn19AXcn@gaggiata.pivistrello.it>
Sender: "Martin Kaiser,,," <martin@akranes.kaiser.cx>

Thus wrote Francesco Dolcini (francesco@dolcini.it):

> On Mon, Jan 29, 2024 at 10:26:16PM +0100, Martin Kaiser wrote:
> > Thus wrote Francesco Dolcini (francesco@dolcini.it):

> > > On Wed, Jan 24, 2024 at 09:58:57PM +0100, Martin Kaiser wrote:
> > > > The vf610 gpio driver is enabled by default for all i.MX machines,
> > > > without any option to disable it in a board-specific config file.

> > > > Most i.MX chipsets have no hardware for this driver. Change the default
> > > > to enable GPIO_VF610 for SOC_VF610 and disable it otherwise.

> > > > Add a text description after the bool type, this makes the driver
> > > > selectable by make config etc.

> > > > Fixes: 30a35c07d9e9 ("gpio: vf610: drop the SOC_VF610 dependency for GPIO_VF610")
> > > > Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> > > > ---

> > > >  config GPIO_VF610
> > > > -	def_bool y
> > > > +	bool "VF610 GPIO support"
> > > > +	default y if SOC_VF610

> > > any reason for having this default y for SOC_VF610, but not for the
> > > other SOC that uses the same variant (i.MX7ULP, ... ?).

> > Ok, it's probably not as consistent as it could be.

> ...

> > Does this make sense?
> sounds fair to me.

Sorry for the delay, other tasks got in the way.

The maintainers have meanwhile merged v4.

Basically, the conclusion of my last mail was that imx7ulp and soc_vf610 could
be configured in the same way to make things a bit clearer. This wouldn't be
much of an improvement compared to the v4 set, I'd suggest keeping the current
state.

Thanks,
Martin

