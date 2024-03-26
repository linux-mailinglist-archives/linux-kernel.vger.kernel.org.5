Return-Path: <linux-kernel+bounces-119970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F6788CF8C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34737B290CE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDA413D29F;
	Tue, 26 Mar 2024 21:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxZF3iPU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C025312B156
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711486869; cv=none; b=eiuDKUulsRFCRvNfvmqjVgm3VvMl2RUKmzlh7JhEHfniG309kzt7mXur++Qkp3y9Yl+FWNbpDtsU9qbhqNdc62yq1la33Ql105a8PFShTEdChiBrTKJ8QEaRxQiw0tZH14/X21YHfykLuWA4A1VDziWYjxTgjG2ruur1veki04o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711486869; c=relaxed/simple;
	bh=WHBxGwZ6H9/KGmihUFGz6zO8MQ9Qe0+HygqEebKz9UY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=etShdn5UCHNYiWE/oI/3mJOUzW75sIho+7zRGdqMyj9xRqas0EIVxKtPgpSRuq/SJFFucnR6d6cDgsYhEMr/RxlV6ppo0elsb6+Zr9PqpYFqXKipNQzId/8y52B+N/FxPem8/l9r/de/vq7NYpMgl5qFWbabVs5sw8H013HvMUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxZF3iPU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF81C433F1;
	Tue, 26 Mar 2024 21:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711486869;
	bh=WHBxGwZ6H9/KGmihUFGz6zO8MQ9Qe0+HygqEebKz9UY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UxZF3iPU7vc7c0gktZugJwIqnCOB1xko2JEIG1o74uIWDQu5e8D3L72/jwUWysnQd
	 r1PDg2iwIPSbxfPh8mSPax/iVaIf1eFHrMWroMU4Zl93Q1emXboZmZ6Rx9AjrjU1A8
	 NNHBeQ0ixYsvZhaP0cjKiyvPG+UjpxgEt75qlLPEb6v/nVWRgz0kBljZ8HntW6gn2r
	 Ch6fQH5Dx+6AeatmYbLsGWPZ1/FwYN33u6momSw4aEmo/As2et5hbX/ZGKn2jKgkLs
	 3LTMsAiAs6fhxuba+RMq9dOPMTjxoEdjSmYqqA4esEdIlQKgxBbTtoBguS3cH7Sb4I
	 7c1/wxkoZOrCw==
Date: Tue, 26 Mar 2024 16:01:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Switch over to MSI interrupts
Message-ID: <20240326210107.GA1496865@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgL2G4ItkFlQ7cqS@smile.fi.intel.com>

On Tue, Mar 26, 2024 at 06:21:47PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 25, 2024 at 04:19:15PM -0500, Bjorn Helgaas wrote:
> > On Tue, Mar 12, 2024 at 06:59:05PM +0200, Andy Shevchenko wrote:
> 
> ...
> 
> > > -	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_LEGACY);
> > > +	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
> > >  	if (ret < 0)
> > >  		return ret;
> > 
> > I guess at least some of these devices do support INTx, since we
> > always used INTx previously, right?
> > 
> > There are a bunch of bug reports complaining about a lack of _PRT
> > entries for them, e.g., these from
> > https://bugzilla.kernel.org/show_bug.cgi?id=212261#c24:
> 
> But this is not related to my patch, and the mentioned bug report seems about
> all AMD and Intel platforms.
> 
> Can you, please, elaborate what the relation to my patch?

Right, sorry I didn't make that clear; I didn't mean that it was
related to your patch.  I was just looking at this old bug report
about not being able to figure out INTx routing.

Your patch had to do with interrupts, so I just wondered whether you
had insight into whether these devices actually used INTx.  My guess
is that at least some of them *do* use INTx, because prior to your
patch, the driver *only* tried to use INTx.

If it happend that they never use INTx, but advertise INTA via
Interrupt Pin, I think that would be a device defect that we might
consider a quirk for.

If they *do* use INTx, and the _PRT doesn't tell us how it's routed, I
think that would be a firmware defect, and ... I dunno what we would
do.  I guess just avoid using INTx because we don't know where the
interupt goes.

Bjorn

