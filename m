Return-Path: <linux-kernel+bounces-148585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 103428A84C1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE10328323C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1271813E8A5;
	Wed, 17 Apr 2024 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YcUBcPyh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524EA13BAFB;
	Wed, 17 Apr 2024 13:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713360660; cv=none; b=qXHId1gUK8u3kW3k5isRNH6w6CEgCUcEuHJPZ2f/5otM77tKmMX3upzcES4KJDHhcl1GHrjh/Rj6x+VptnjgSjbzG+X/UgfXEYWzMAZ7CXY+aM/WqDs4L55ztnn+MiKr4RMqqkuLMr+wa0zsU3FHnjLaotbRchbDuWjW+7bC6xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713360660; c=relaxed/simple;
	bh=WiX3CxJvr+ydE+u5l5Y9ymhgWQ140YrTzOQJMdduWF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1asVjBFNmJt4g7r1mRnoAriOF+TJ6m9e20f1sYu4kcjxx3x02FZH7ps1iJ5YITSavvCBuYU1IS0Aye4pi2AB66miXfauzKR4iD23EW1egci0cyMk15ZgrBFRI31qUJbfoAebAHxKzFIiN7e01N8FrUIeYi3IR/iipRZVW+Yinw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YcUBcPyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F094C3277B;
	Wed, 17 Apr 2024 13:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713360659;
	bh=WiX3CxJvr+ydE+u5l5Y9ymhgWQ140YrTzOQJMdduWF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YcUBcPyhI4Q5bgipJU27blJaZaL+Tj03m1UM0mrdMcEtndQ5cT6a6OrAqe7vZQhAB
	 E8ZH0w6wvWCkLhcUpDV7WM4ymn1edQrPKuZ+p5Jc5JGYkWXaI89xchjJsANpVBaU+f
	 PDCZS//twwiKmTlXnCYPNiiehyCd0pM1doVMIVZM=
Date: Wed, 17 Apr 2024 15:30:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Parker Newman <parker@finest.io>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v3 8/8] serial: exar: fix: fix crash during shutdown if
 setup fails
Message-ID: <2024041730-abstain-dynamite-054a@gregkh>
References: <cover.1713270624.git.pnewman@connecttech.com>
 <1a21fffe403d7181e0404db1ed92140c306f97b7.1713270624.git.pnewman@connecttech.com>
 <2024041746-galvanize-satchel-09a4@gregkh>
 <20240417082413.70397ccf@SWDEV2.connecttech.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417082413.70397ccf@SWDEV2.connecttech.local>

On Wed, Apr 17, 2024 at 08:24:13AM -0400, Parker Newman wrote:
> On Wed, 17 Apr 2024 13:19:07 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Tue, Apr 16, 2024 at 08:55:35AM -0400, Parker Newman wrote:
> > > From: Parker Newman <pnewman@connecttech.com>
> > >
> > > If a port fails to register with serial8250_register_8250_port() the
> > > kernel can crash when shutting down or module removal.
> > >
> > > This is because "priv->line[i]" will be set to a negative error code
> > > and in the exar_pci_remove() function serial8250_unregister_port() is
> > > called without checking if the "priv->line[i]" value is valid.
> > >
> > > Signed-off-by: Parker Newman <pnewman@connecttech.com>
> > > ---
> > >  drivers/tty/serial/8250/8250_exar.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> > > index 501b9f3e9c89..f5a395ed69d1 100644
> > > --- a/drivers/tty/serial/8250/8250_exar.c
> > > +++ b/drivers/tty/serial/8250/8250_exar.c
> > > @@ -1671,7 +1671,8 @@ static void exar_pci_remove(struct pci_dev *pcidev)
> > >  	unsigned int i;
> > >
> > >  	for (i = 0; i < priv->nr; i++)
> > > -		serial8250_unregister_port(priv->line[i]);
> > > +		if (priv->line[i] >= 0)
> > > +			serial8250_unregister_port(priv->line[i]);
> >
> > Is this a bug in the current driver?  If so, can you resend it on its
> > own so we can get it merged now?
> >
> 
> Yes it is, I can split this one out and send it on its own.

Great!  Bonus points if you can find the commit id it fixes and add a
"Fixes:" tag to the signed-off-by area.  If not, I can guess :)

thanks,

greg k-h

