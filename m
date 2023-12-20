Return-Path: <linux-kernel+bounces-7473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DCC81A853
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CFD5284E79
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 21:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3875495D6;
	Wed, 20 Dec 2023 21:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="uYCZ3KNG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E896D495EC;
	Wed, 20 Dec 2023 21:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=wIWDMjkfub9nTTJ5JI74/K00hMgRE/kdEk8xa9Y7LW0=; b=uYCZ3KNG9utyPrLOQFCRgBF6Nl
	/vkLFPPGzZu4iOSDQKwsx9kGJD7FMpBWrI9XxlegwaUE3iaeSlBGPPAxzAV51jnMqIvo0I201/wtR
	1aL5j4WX9noqJjeATTXuVYICtmfyutP384rd9vxKV5lI9eI4rPXAgxpi/h54/vjCWj4U=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:57326 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rG4Gk-0002Rp-RU; Wed, 20 Dec 2023 16:38:23 -0500
Date: Wed, 20 Dec 2023 16:38:22 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, jringle@gridpoint.com,
 kubakici@wp.pl, phil@raspberrypi.org, bo.svangard@embeddedart.se,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>
Message-Id: <20231220163822.ce1d3893735d3334ae2d04e2@hugovil.com>
In-Reply-To: <ZYMQRv1Td7FjH5Mh@smile.fi.intel.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
	<20231219171903.3530985-18-hugo@hugovil.com>
	<ZYMQRv1Td7FjH5Mh@smile.fi.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	* -1.4 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH 17/18] serial: sc16is7xx: refactor EFR lock
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Wed, 20 Dec 2023 18:03:18 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Dec 19, 2023 at 12:19:01PM -0500, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Move common code for EFR lock/unlock of mutex into functions for code reuse
> > and clarity.
> 
> ...
> 
> > @@ -333,6 +333,7 @@ struct sc16is7xx_one {
> >  	struct sc16is7xx_one_config	config;
> >  	bool				irda_mode;
> >  	unsigned int			old_mctrl;
> > +	u8				old_lcr; /* Value before EFR access. */
> >  };
> 
> Have you run `pahole`?
> I believe with
> 
> 	unsigned int			old_mctrl;
> 	u8				old_lcr; /* Value before EFR access. */
> 	bool				irda_mode;
> 
> layout it will take less memory.

Hi,
I did not know about this tool, nice.

$ pahole -C sc16is7xx_one drivers/tty/serial/sc16is7xx.o

Before:
    /* size: 752, cachelines: 12, members: 10 */

With your proposed change:
    /* size: 744, cachelines: 12, members: 10 */

Will add this modification for V2, as well as other issues
noted below.

Thank you,
Hugo


> > +/* In an amazing feat of design, the Enhanced Features Register (EFR)
> 
> /*
>  * This is NOT the style we use for multi-line
>  * comments in the serial subsystem. On contrary
>  * this comment can be used as a proper example.
>  * (Yes, I noticed it's an old comment, but take
>  *  a chance to fix it.)
>  */
> 
> > + * shares the address of the Interrupt Identification Register (IIR).
> > + * Access to EFR is switched on by writing a magic value (0xbf) to the
> > + * Line Control Register (LCR). Any interrupt firing during this time will
> > + * see the EFR where it expects the IIR to be, leading to
> > + * "Unexpected interrupt" messages.
> > + *
> > + * Prevent this possibility by claiming a mutex while accessing the EFR,
> > + * and claiming the same mutex from within the interrupt handler. This is
> > + * similar to disabling the interrupt, but that doesn't work because the
> > + * bulk of the interrupt processing is run as a workqueue job in thread
> > + * context.
> > + */
> 
> ...
> 
> > +	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG,
> > +			     SC16IS7XX_LCR_CONF_MODE_B);
> 
> One line. (Yes, 81 character, but readability is as good as before.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
> 
> 

