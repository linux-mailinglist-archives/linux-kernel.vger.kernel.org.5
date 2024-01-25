Return-Path: <linux-kernel+bounces-38700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B51CF83C44C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44804B234AA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5BE62A04;
	Thu, 25 Jan 2024 14:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TK3+NGFQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9480262812;
	Thu, 25 Jan 2024 14:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706191573; cv=none; b=TVAZHAiA5bMOkpWoslGedbUGMsCqamwhs8KTQMLrrSqubX55skPyydNZTNjteQ7/wagg0wX6VoUwljyT6R5eD0Qzowt0W6FMXtxVloJcrshI7j1Z6HF0weCWFQbgNnJjNFCHgfPOWo68LwRBH/g2UX7hngIWV+qetCqjJRw86Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706191573; c=relaxed/simple;
	bh=G4QAP5APqsbl64s+QuDiT63+BHv2vR1X3SL4Yr7Rzns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9tiFX7u2NaJMP/GByNcE+73oQPH+wnRgi/o4gaoTLRWPU/lnpq1Snhiz++N2dtfqlZNUBjr+L3C7AZGRx795VItmwRDbJvqqIOBAEN9GP8gtQHPO/NY2e+rwwluAoqwkx+35AtJlgcECxzF/mNTux/YNDCGfVgfXYYR9XUd6s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TK3+NGFQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1408C433C7;
	Thu, 25 Jan 2024 14:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706191573;
	bh=G4QAP5APqsbl64s+QuDiT63+BHv2vR1X3SL4Yr7Rzns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TK3+NGFQMeAVRx4ymxjxQJrv8UMD0YnQzyWplwLfDTnsYbyE5nrI6SHhJOKNwwVxa
	 iSZ+0fpd4wKyayJC/QKXIWfjbLHLT271UGEx2o6LF1tgvT5geKPBS9x7rLdX+Td9rC
	 dIiK+UmqsbaczIgknBD3u6epmnZtAaHULgZwIZ3lRI66iAY16mT033Cg4asp3tLZbj
	 8NhPiwLnZ39OACOqNGsoGao4KLxgw/W2WhZYJj5z6IMfOe2GEv3z3iofAD0CuBXP+R
	 MWPSHXq503puswZytnZUI8ameL4V/NgD4AF4gLiiRi8e/1sacJEPKv5aLml47Bq6BU
	 9FOul8fPqk3qg==
Date: Thu, 25 Jan 2024 15:06:05 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Lennert Buytenhek <kernel@wantstofly.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	John Garry <john.g.garry@oracle.com>,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] ahci: add 43-bit DMA address quirk for ASMedia ASM106x
 controllers
Message-ID: <ZbJqzTD9v25SAPmd@x1-carbon>
References: <ZbEWsp4KT-V9YUaC@wantstofly.org>
 <ZbJiZotayVjtF8ti@x1-carbon>
 <ZbJlatnuTMblK9hS@wantstofly.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbJlatnuTMblK9hS@wantstofly.org>

On Thu, Jan 25, 2024 at 03:43:06PM +0200, Lennert Buytenhek wrote:
> On Thu, Jan 25, 2024 at 02:30:14PM +0100, Niklas Cassel wrote:

(snip)

> > > @@ -943,11 +951,19 @@ static int ahci_pci_device_resume(struct device *dev)
> > >  
> > >  #endif /* CONFIG_PM */
> > >  
> > > -static int ahci_configure_dma_masks(struct pci_dev *pdev, int using_dac)
> > > +static int ahci_configure_dma_masks(struct pci_dev *pdev,
> > > +				    struct ahci_host_priv *hpriv)
> > >  {
> > > -	const int dma_bits = using_dac ? 64 : 32;
> > > +	int dma_bits;
> > >  	int rc;
> > >  
> > > +	if (!(hpriv->cap & HOST_CAP_64))
> > > +		dma_bits = 32;
> > > +	else if (hpriv->flags & AHCI_HFLAG_43BIT_ONLY)
> > > +		dma_bits = 43;
> > > +	else
> > > +		dma_bits = 64;
> > > +
> > 
> > I would prefer if you write this as:
> > 
> > if (hpriv->cap & HOST_CAP_64) {
> > 	dma_bits = 64;
> > 	if (hpriv->flags & AHCI_HFLAG_43BIT_ONLY)
> > 		dma_bits = 43;
> > } else {
> > 	dma_bits = 32;
> > }
> > 
> > Such that we still require the device to advertize 64 bit support,
> > and the quirk.
> > If the device does not advertize 64, we don't want it to be possible
> > to use a mask >32, even if the quirk flag is set.
> 
> Isn't that logic exactly the same as in my version?  I.e. in both
> versions, HOST_CAP_64 has to be set and AHCI_HFLAG_43BIT_ONLY has
> to be set for dma_bits to become 43.
> 
> (I don't mind doing it your way, I just don't see a functional
> difference between the versions. :-) )

Yes, you are right.

But please change it to not use an inverted check for the flag anyway,
as such pattern has apparently proven to be too complicated for my brain
to interpret correctly already :)


Kind regards,
Niklas

