Return-Path: <linux-kernel+bounces-724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A351B81452F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57FF21F23CB9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E81318E2B;
	Fri, 15 Dec 2023 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+9D8p19"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C9618C19;
	Fri, 15 Dec 2023 10:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B13EC433C8;
	Fri, 15 Dec 2023 10:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702635020;
	bh=+IMN7z6g0qShOLd7JcJytNXZiHwmS0VJRsZHt710esw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m+9D8p19mbxf3P4K+cVu7TGd58XZW4cSBfa0UMFmNj0ZbLfzDFvbz7YJmhWovgD1v
	 iVuLvZo9uJ/7K1Ie75G6FKXP3CW5kEpWLhrnRppmukD9l8fA9Qa1WyKmrxR+cReG83
	 EhY5DdE1Gg/Xl3lQgxOT4rYqEamS6daiSkVydzfx0vaML5olCe2/dbr5prX767MHCg
	 VM9Y3FPxhedwr7gKTjGSK2kUR4AckQ0VKpb+BcFsnMPsiPehVD/YOPmmx9+KJqMsxc
	 wKnVOzp4qTPQU5PBxQ5/MHpDer92ucS1MczoX/LiJusTKU8w+M3Bh8BnCHoxfJgp34
	 bVsypLfswEIxg==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rE595-0007cv-02;
	Fri, 15 Dec 2023 11:10:15 +0100
Date: Fri, 15 Dec 2023 11:10:15 +0100
From: Johan Hovold <johan@kernel.org>
To: Stan Bertrand <stanislasbertrand@gmail.com>
Cc: linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: ftdi_sio: add ftdi serial to gpiochip label
Message-ID: <ZXwmBxvQlxca8aNv@hovoldconsulting.com>
References: <20231003001135.2713961-1-sbertrand@witekio.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003001135.2713961-1-sbertrand@witekio.com>

On Mon, Oct 02, 2023 at 05:11:35PM -0700, Stan Bertrand wrote:
> From: Stanislas Bertrand <stanislasbertrand@gmail.com>
> 
> Use ftdi serial number on gpiochip label.
> Allows to interface with gpiod utils using the serial number:
> 
> $ gpiodetect
> gpiochip5 [ftdi-cbus-FTRelay2] (4 lines)
> gpiochip6 [ftdi-cbus] (4 lines)
> gpiochip7 [ftdi-cbus-A106TPEC] (4 lines)
> 
> $ gpioget ftdi-cbus-FTRelay2 2
> 0

I don't think this is a good idea, for example, as not all devices have
a unique serial string.

Looks like the naming of gpiochips are all over the place, and ideally
this should not have been something that was left up to individual
driver to decide.

I see several drivers using the name of the corresponding platform
device as label, which works in most cases, but not always either. The
only unique and always available identifier is the gpiochip's place in
the device tree itself.

For USB, we already encode the bus topology in the USB device names
(e.g. 1-11.5.1) and we could possibly consider using that. But we
already have USB serial devices with multiple GPIO chips so also that
would require some further thought (e.g. using the interface name
instead).

Johan

