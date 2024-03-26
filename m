Return-Path: <linux-kernel+bounces-120032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E584F88D088
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68858B214D9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C6713D8B8;
	Tue, 26 Mar 2024 22:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYQKtt7T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E716413D89D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 22:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711490996; cv=none; b=ZZn0dSbLPDEc0okj+dkaZR8FuA42FBFsYSaOdIUKD+zj5sMNcraHSCKnMrKcO2Wd+rvwzGsuTxKPizALC1dl5gpRonepeGsGXNRwxf3OXYLDvigzfjbClPiztrCuR4gvyp+xLFjw1WMJ+wN3Je2IA8135uNXyI246W3qKM6/WLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711490996; c=relaxed/simple;
	bh=yzHu8ghuLWE+CXOVCoEHpNcdeDSwqlCbVd1uifSUizM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rM15OJKtaWxw7pH3i26rAuc+gzIexjx4vXHP27CzB2wppzxPItTsA+9v+8uPVGtOurQdJ9vS4PbREAMDhk09LFIUM5pnYTotv2Ik22VXUKiSALSIF5H8kNSJbna9H8hvMMtJothtYpELpNAeL8BZ87VMYDqDiJ6Ryi8JdYuK/u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYQKtt7T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2B8C433F1;
	Tue, 26 Mar 2024 22:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711490995;
	bh=yzHu8ghuLWE+CXOVCoEHpNcdeDSwqlCbVd1uifSUizM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oYQKtt7TtatP2dv/lSizCKc3d2eDQP92T5+yHdnWuq+6BgU3qiLbA2gHITVbLnQAk
	 TPDTco5hvM8nhnhWMIBOCYAAx60xElDYXGUMgOW44yZ+s98qbFO9m0xRZjrVEg4tEn
	 tDec/QGI3NeK5fB+F20zro2NaPm89/sObyPylqKttgNFvCCRkdoKkJODciZ2FI9+Th
	 S8DmPHCBYtWPZOkyms+BQeoV2qkxsshCX+F1daK8Lw8J1vMfWiFArPUJPgL2A4So07
	 5m9HxTyq31b74MBxm8OFRPKpw/3XD1KHriHNL2O0WqoynGWZCTrGktn3AohZHobWsV
	 xMzB4riKeLi/w==
Date: Tue, 26 Mar 2024 17:09:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Switch over to MSI interrupts
Message-ID: <20240326220953.GA1498942@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgM8iExkz5S6reeq@smile.fi.intel.com>

On Tue, Mar 26, 2024 at 11:22:16PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 26, 2024 at 04:01:07PM -0500, Bjorn Helgaas wrote:
> > On Tue, Mar 26, 2024 at 06:21:47PM +0200, Andy Shevchenko wrote:
> > > On Mon, Mar 25, 2024 at 04:19:15PM -0500, Bjorn Helgaas wrote:
> > > > On Tue, Mar 12, 2024 at 06:59:05PM +0200, Andy Shevchenko wrote:
> 
> ...
> 
> > > > > -	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_LEGACY);
> > > > > +	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
> > > > >  	if (ret < 0)
> > > > >  		return ret;
> > > > 
> > > > I guess at least some of these devices do support INTx, since we
> > > > always used INTx previously, right?
> > > > 
> > > > There are a bunch of bug reports complaining about a lack of _PRT
> > > > entries for them, e.g., these from
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=212261#c24:
> > > 
> > > But this is not related to my patch, and the mentioned bug report seems about
> > > all AMD and Intel platforms.
> > > 
> > > Can you, please, elaborate what the relation to my patch?
> > 
> > Right, sorry I didn't make that clear; I didn't mean that it was
> > related to your patch.  I was just looking at this old bug report
> > about not being able to figure out INTx routing.
> > 
> > Your patch had to do with interrupts, so I just wondered whether you
> > had insight into whether these devices actually used INTx.  My guess
> > is that at least some of them *do* use INTx, because prior to your
> > patch, the driver *only* tried to use INTx.
> > 
> > If it happend that they never use INTx, but advertise INTA via
> > Interrupt Pin, I think that would be a device defect that we might
> > consider a quirk for.
> > 
> > If they *do* use INTx, and the _PRT doesn't tell us how it's routed, I
> > think that would be a firmware defect, and ... I dunno what we would
> > do.  I guess just avoid using INTx because we don't know where the
> > interupt goes.
> 
> Okay, so the revert after all is not required, do you agree?

Yes, I agree!  No indication of problems with your patch, AFAICS.

If you have any opinions or ideas on the "can't derive routing for PCI
INT A" stuff, I'd still be interested, because it really annoys users.

Bjorn

