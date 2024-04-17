Return-Path: <linux-kernel+bounces-148587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B41608A84C5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69D641F237CC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94C813F432;
	Wed, 17 Apr 2024 13:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f8WHvl68"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1233813173A;
	Wed, 17 Apr 2024 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713360782; cv=none; b=df2f+C/SA6jczvugJbLXYwndyM6U2IcpyXlr2r5ozP/zslAtWMQptpJSqaFSAdO5xJWRSrHDUIBfWAk5cfX2pInFHQ1OPFgAZGMUgZH5D48XIuWb9t6T5IIx7p509sUwpjAaQVX2wL3+XvpMaWMuGKlN/kyQPtHzs6id0RpEObA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713360782; c=relaxed/simple;
	bh=0FAQr3+1ZyvZLqysSDdApJFQe0+RgfkEZ/Lh4fI1GnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgQNwJsgL+40lY9H1X+lG0w/zDw0XBDnDDDit+D3M55eiv/ei38gsNlCukfx9H4Q1aUTav+E1F4Xr15sd3Rjy8PlBnuqztnqjATxjLJRtl5rZgoYqx7qKfPFNOPn4wr8wjl46OvagZ9mGSDQcxC5H9YecgKyjejoFVE78SNrcWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f8WHvl68; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E66C072AA;
	Wed, 17 Apr 2024 13:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713360781;
	bh=0FAQr3+1ZyvZLqysSDdApJFQe0+RgfkEZ/Lh4fI1GnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f8WHvl68uFX4nxlyi0wiRaglG8F8qQhn71IzAOpEEnlmDOTsivZmG9z89kl2BHYaj
	 JxFdfrFmaYBTalfPEaGu6CiC+JYRcAgubU4ByKQdSdTmM+QPGH2xtk/iwQpE7UQrcH
	 xl6UpOD24d87Pc2xxrsvl23yhIcmyT+Dn7B8z2/0=
Date: Wed, 17 Apr 2024 15:32:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Parker Newman <parker@finest.io>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v3 7/8] serial: exar: add CTI specific setup code
Message-ID: <2024041700-engraved-bootie-aca5@gregkh>
References: <cover.1713270624.git.pnewman@connecttech.com>
 <354ff4aa9d8bdea1a21c503e685e81ac3df48eb8.1713270624.git.pnewman@connecttech.com>
 <2024041726-fall-debunk-6cc5@gregkh>
 <20240417091735.17686470@SWDEV2.connecttech.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417091735.17686470@SWDEV2.connecttech.local>

On Wed, Apr 17, 2024 at 09:17:35AM -0400, Parker Newman wrote:
> On Wed, 17 Apr 2024 13:24:20 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Tue, Apr 16, 2024 at 08:55:34AM -0400, Parker Newman wrote:
> > >  struct exar8250 {
> > >  	unsigned int		nr;
> > > +	unsigned int		osc_freq;
> > > +	struct pci_dev		*pcidev;
> > > +	struct device		*dev;
> >
> > Why do you need both a pci_dev and a device?  Aren't they the same thing
> > here?
> >
> 
> I added dev to make the prints cleaner. I personally prefer:
> 
> 	dev_err(priv->dev, ...);
> to
> 	dev_err(&priv->pcidev->dev, ...);
> 
> or to adding a:
> 	struct device *dev = &priv->pcidev->dev;
> 
> to every function just for printing.
> 
> However, I do understand your point. I can drop dev if you prefer.

Pick one and stick with it, no need for both.  I too like your first
option, and if you never need the pci device pointer, just stick with
"struct dev".  Note, properly reference count it in case you think it
could go away from underneath you (some paths it could, so be careful.)

> > > +static int cti_tristate_disable(struct exar8250 *priv, unsigned int port_num)
> > > +{
> > > +	return _cti_set_tristate(priv, port_num, false);
> > > +}
> >
> > Do you ever call _cti_set_tristate() with "true"?
> >
> 
> Currently no. However, re-enabling tristate via a custom ioctl was a feature in
> our old out-of-tree driver (which was created prior to linux RS485 support).
> 
> I am not sure how it would be activated now, but I left enabling tristate as an
> option in to make it easier down the line when we need it.
> 
> I can add a note to the patch or remove it if you would prefer.

Just remove it for now, no need to ever add code you "might need in the
future", just add that then, when you need it.  Code for what you need
to do now, that makes things simpler and removes extra stuff that you
would have to force others to review :)

thanks,

greg k-h

