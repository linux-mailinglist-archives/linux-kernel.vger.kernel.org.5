Return-Path: <linux-kernel+bounces-130620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02976897A9E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2E01C21680
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3637C156673;
	Wed,  3 Apr 2024 21:24:59 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22008156672
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 21:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712179498; cv=none; b=B/9nVPE/ClS4prywDuFO4PBzVlk2pAlGW5vtYR5uOhwZMUhy45uAWQ/c2ccByWydfG69ZxEMcB2kv0PZDXvt9l2lvY53xmgQTESPW+S4hRvuo7VHaUTSAMOytF6xtL86NRYA1rwDKSjTvqLV/lWVLVZOATPjyu2g6iv7Krscp1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712179498; c=relaxed/simple;
	bh=q8ZLeioSh1fVWNbn/pZ4xPwtR1LdQr2B/PlfUqk7Uww=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JuE0C7PAocaBBurGJHQrC0NIb1uGqIlQyYYckyFwgIn0R2jnWwi/hlXoXLznUIbj4sbRGJlNWIGtcnrEpAAXYvxyb7EmAWD7jOazKdwTTGVFC815ER1qI55f1wTHn0KrFKarsCS1/iAq/+xKEcpLkXkAHpjYX8NXQ1AqWCIDiBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 9d2bc742-f200-11ee-abf4-005056bdd08f;
	Thu, 04 Apr 2024 00:24:54 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 4 Apr 2024 00:24:54 +0300
To: Colin Foster <colin.foster@in-advantage.com>
Cc: Mark Brown <broonie@kernel.org>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 6.8 SPI Chip Select Regression
Message-ID: <Zg3JJtzdB5Q3aGsl@surfacebook.localdomain>
References: <Zgx5glZznSCheksj@euler>
 <467644bf-85d0-429a-bd11-7155b1cb5fbc@sirena.org.uk>
 <Zgy7llSklu7iU2Om@euler>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zgy7llSklu7iU2Om@euler>

Tue, Apr 02, 2024 at 09:14:46PM -0500, Colin Foster kirjoitti:
> Hi Mark,
> 
> Thanks for the quick response.
> 
> On Wed, Apr 03, 2024 at 12:52:44AM +0100, Mark Brown wrote:
> > On Tue, Apr 02, 2024 at 04:32:50PM -0500, Colin Foster wrote:
> > > Hi Amit,
> > 
> > Amit, please respond to these issues - you never replied to the mails
> > about the other regressions this introduced either...
> > 
> > > [    3.459990] omap2_mcspi 48030000.spi: chipselect 0 already in use
> > > [    3.466135] spi_master spi0: spi_device register error /ocp/interconnect@48000000/segment@0/target-module@30000/spi@0/soc@0
> > > [    3.477495] spi_master spi0: Failed to create SPI device for /ocp/interconnect@48000000/segment@0/target-module@30000/spi@0/soc@0
> > 
> > > Is this a known issue? Is there anything I either might need to do to a
> > > device tree, or something you might suggest to help troubleshoot this?
> > 
> > This is not known, and given that you say there's only one chip select
> > in use on the system seems clearly bogus.  There were some regressions
> > with trying to use more than the hard coded maximum number of chip
> > selects but they have a different error pattern.  It's late so I'll not
> > look properly right now but...
> > 
> > Do you know what chip select 0 is - if you add a WARN_ON() to
> > spi_set_chipselect() it should show a prior call to the function,
> 
> Log is below. There aren't any other SPI devices, so I'm not really sure
> what is the issue just yet. It is also using the built-in chip select,
> not a GPIO.
> 
> > or is
> > it some logic bug that somehow is not manifesting on other systems that
> > use chip select 0?  Though looking quickly there has been some factoring
> > out since that commit was merged...  just to confirm, did you bisect to
> > find the problematic commit? 
> 
> I bisected, and just confirmed again that the previous commit,
> f05e2f61fe88: ("ALSA: hda/cs35l56: Use set/get APIs to access spi->chip_select")
> does boot as expected.
> 
> I noticed the issue on 6.9-rc2, then jumped back to 6.8, then 6.7.
> Bisected between 6.7 and 6.8.
> 
> > If you could show the DT for your setup
> > that'd help, especially if this is a GPIO chip select.
> 
> It should be attached. It is really nothing more than the beaglebone
> black with this SPI addition. The only things out-of-tree are some VLAN
> and MTU tweaks I had to make for my DSA networking setup to work.

You have
addr cell = 1
sz cell = 0

At the same time you have 
reg <0 0>

AFAICT the SPI core behaves correctly. Am I wrong?

I.o.w. you either want to have reg = <0>, or <0 1> or something which has
different values.

-- 
With Best Regards,
Andy Shevchenko



