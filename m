Return-Path: <linux-kernel+bounces-111796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A82FB887115
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2873BB219D2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA775D75F;
	Fri, 22 Mar 2024 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPA1yJx4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330655674C;
	Fri, 22 Mar 2024 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711125794; cv=none; b=Kgas2Cm9THhMG8S4d2p5Uy54u+aP88ZVzLrUBfghxI273oouLJbEFcDecsQPrKZOLPN46DjQpzsSxPIE9WGYGK++x5vtx72EFBnfga4XBEVUavdK5CunaIX29XNd6XVTNK5UxwJw6GPjbxf36j+m9xRnSnldPft5RPL2sKNNdyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711125794; c=relaxed/simple;
	bh=VuocNDwkIO/NqUPaVerRx9GiFh5vSB4EkmPbTc3m5P8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UHLj5CcnMntYzCI2XPD2ZrkKK6d8Cml7pWj68Ghra+1s45PWA0wMjM5INpuKISZ9EGUfVTClS5yHU8xTXCDM/W+gCbEE3N9nEosQeV39VTKF/lntQJlvIKEDHdsX9bLbziFuVlUUCSVopDqC7LtBTbBy7Q50AfRQAo0ZbQ3fuA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPA1yJx4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCCEC43390;
	Fri, 22 Mar 2024 16:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711125793;
	bh=VuocNDwkIO/NqUPaVerRx9GiFh5vSB4EkmPbTc3m5P8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oPA1yJx4tt7uBYrLaNo2kW7jdVdhUCJH2XoywWZL4ShvqfpfpJOEm/TmkND1Edwdm
	 OGG/Q8wXCOdBEW8Y2YpaakstbBrYAWFoX0uiltj1yRqD1qDausjseyvfWd8AJDdOIa
	 O9BlXNp1isnLtYWZ2d6fUWwEHg2wxpMyCgMhv/Jnmh2rpC0yCjZTnFj5Q3C9CmYign
	 YvD5U5lBpc4bUk2AkZd48qjsUvBZsX5v1xk8UihB+QeWg5pczBEGlQ2XqJCPKpBkVG
	 AxaUSymYuH1e2JgcvHstK0+WA7SzbrojQELz7/btdi9yVgduS0uE589Zdkp088mZAx
	 Zl+GTEMCDr3TQ==
Date: Fri, 22 Mar 2024 11:43:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Ben Chuang <benchuanggli@gmail.com>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: GL975x: Mask rootport's replay
 timer timeout during suspend
Message-ID: <20240322164311.GA1367151@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAd53p52fi_wr3Js9Rqct+i1D3rjrnVZ6tBN=uHqThM7UvzXQA@mail.gmail.com>

On Thu, Mar 21, 2024 at 06:05:33PM +0800, Kai-Heng Feng wrote:
> On Sat, Jan 20, 2024 at 6:41 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Jan 18, 2024 at 02:40:50PM +0800, Kai-Heng Feng wrote:
> > > On Sat, Jan 13, 2024 at 1:37 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Fri, Jan 12, 2024 at 01:14:42PM +0800, Kai-Heng Feng wrote:
> > > > > On Sat, Jan 6, 2024 at 5:19 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > On Thu, Dec 21, 2023 at 11:21:47AM +0800, Kai-Heng Feng wrote:
> > > > > > > Spamming `lspci -vv` can still observe the replay timer timeout error
> > > > > > > even after commit 015c9cbcf0ad ("mmc: sdhci-pci-gli: GL9750: Mask the
> > > > > > > replay timer timeout of AER"), albeit with a lower reproduce rate.
> > > > > >
> > > > > > I'm not sure what this is telling me.  By "spamming `lspci -vv`, do
> > > > > > you mean that if you run lspci continually, you still see Replay Timer
> > > > > > Timeout logged, e.g.,
> > > > > >
> > > > > >   CESta:        ... Timeout+
> > > > >
> > > > > Yes it's logged and the AER IRQ is raised.
> > > >
> > > > IIUC the AER IRQ is the important thing.
> > > >
> > > > Neither 015c9cbcf0ad nor this patch affects logging in
> > > > PCI_ERR_COR_STATUS, so the lspci output won't change and mentioning it
> > > > here doesn't add useful information.
> > >
> > > You are right. That's just a way to access config space to reproduce
> > > the issue.
> >
> > Oh, I think I completely misunderstood you!  I thought you were saying
> > that suspending the device caused the PCI_ERR_COR_REP_TIMER error, and
> > you happened to see that it was logged when you ran lspci.
> 
> Both running lspci and suspending the device can observe the error,
> because both are accessing the config space.
> 
> > But I guess you mean that running lspci actually *causes* the error?
> > I.e., lspci does a config access while we're suspending the device
> > causes the error, and the config access itself causes the error, which
> > causes the ERR_COR message and ultimately the AER interrupt, and that
> > interrupt prevents the system suspend.
> 
> My point was that any kind of PCI config access can cause the error.
> Using lspci is just make the error more easier to reproduce.
> 
> > If that's the case, I wonder if this is a generic problem that could
> > happen with *any* device, not just GL975x.
> 
> For now, it's just GL975x.
> 
> > What power state do we put the GL975x in during system suspend?
> > D3hot?  D3cold?  Is there anything that prevents config access while
> > we suspend it?
> 
> The target device state is D3hot.
> However, the issue happens when the devices is in D0, when the PCI
> core is saving the device's config space.
> 
> So I think the issue isn't related to the device state.
> 
> > We do have dev->block_cfg_access, and there's a comment that says
> > "we're required to prevent config accesses during D-state
> > transitions," but I don't see it being used during D-state
> > transitions.
> 
> Yes, there isn't any D-state change happens here.

So the timeout happens sometimes on any config accesses to the device,
no matter what the power state is?  If that's the case, why do the
masking in the suspend/resume callbacks?

If it's not related to a power state change, it sounds like something
that should be a quirk or done at probe time.

Bjorn

