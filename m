Return-Path: <linux-kernel+bounces-14159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8560A82188F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A6561F21FE6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F705695;
	Tue,  2 Jan 2024 08:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMf5qLQh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1BC53A5;
	Tue,  2 Jan 2024 08:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86FDC433C7;
	Tue,  2 Jan 2024 08:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704185466;
	bh=2pamsJzOfalMkhVWaBDNI7cGzCZwKULHf8AWyrgT91Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XMf5qLQhtU+xCzPEB8vHAJ4PLS21u8Lk2WorG7ghLytZFEtEt6O9Rd81G0qrGzGQQ
	 Tm/3b+TEgzCdZY1bJ031fSlK/m4kt17kHv0l4kVDDFCl0pQ9AKYLmgp3XYyh2sgpmV
	 2anVjFKRyob0KB4npTntHDLoEiGI+KtW9PLIjbGhQ0GOm8g63nqWF0MYIdaQIiHZRH
	 oxJq0ANqooG2CN5xKM0If16YD0wqunZ19osOO3zT1H+S4wjfs6OPxb7jGX2fZL1gT3
	 7NJhAbZ1SG55GDtIv37lNQ542Ss7VKiY/mAKIMKs5JBht4xukcNXSFs5USyIjF5oNC
	 ARYwbuJlJDttg==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rKaUE-0004wn-04;
	Tue, 02 Jan 2024 09:50:58 +0100
Date: Tue, 2 Jan 2024 09:50:58 +0100
From: Johan Hovold <johan@kernel.org>
To: Stan Bertrand <stanislasbertrand@gmail.com>
Cc: linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: ftdi_sio: add ftdi serial to gpiochip label
Message-ID: <ZZPOcpN5Th3wEh2W@hovoldconsulting.com>
References: <20231003001135.2713961-1-sbertrand@witekio.com>
 <ZXwmBxvQlxca8aNv@hovoldconsulting.com>
 <4193075.XuvPJYOev2@dl3541lx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4193075.XuvPJYOev2@dl3541lx>

On Mon, Jan 01, 2024 at 06:00:22PM -0800, Stan Bertrand wrote:
> On Friday, December 15, 2023 2:10:15 AM PST Johan Hovold wrote:
> > On Mon, Oct 02, 2023 at 05:11:35PM -0700, Stan Bertrand wrote:
> > > From: Stanislas Bertrand <stanislasbertrand@gmail.com>
> > > 
> > > Use ftdi serial number on gpiochip label.
> > > Allows to interface with gpiod utils using the serial number:
> > > 
> > > $ gpiodetect
> > > gpiochip5 [ftdi-cbus-FTRelay2] (4 lines)
> > > gpiochip6 [ftdi-cbus] (4 lines)
> > > gpiochip7 [ftdi-cbus-A106TPEC] (4 lines)
> > > 
> > > $ gpioget ftdi-cbus-FTRelay2 2
> > > 0
> > 
> > I don't think this is a good idea, for example, as not all devices have
> > a unique serial string.
> 
> The goal is to identify the gpiochip corresponding to a known FTDI device.
> If serials are not unique, it can still differentiate others.
> A device serial can be set (FT Prog, Python lib, ...) for direct of access.

I understand why you want this, I just don't think it's a good interface
and this something that will become ABI.

Also note that all gpiochips on a multiport FTDI device will all end up
with the same label with the current proposal.

> > Looks like the naming of gpiochips are all over the place, and ideally
> > this should not have been something that was left up to individual
> > driver to decide.
> > 
> > I see several drivers using the name of the corresponding platform
> > device as label, which works in most cases, but not always either. The
> > only unique and always available identifier is the gpiochip's place in
> > the device tree itself.
> > 
> > For USB, we already encode the bus topology in the USB device names
> > (e.g. 1-11.5.1) and we could possibly consider using that. But we
> > already have USB serial devices with multiple GPIO chips so also that
> > would require some further thought (e.g. using the interface name
> > instead).
> 
> The aim is identification while being platform agnostic, device tree or x86.
> The FTDI serial allows device identification regardless of the system topology.

The USB bus topology will be the same regardless whether you use
devicetree or ACPI. Granted, the USB bus numbers are not stable on Linux
but that is a generic problem.

Johan

