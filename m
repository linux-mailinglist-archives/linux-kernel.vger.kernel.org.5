Return-Path: <linux-kernel+bounces-29749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DDD8312EC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21ED71C21FE9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C242F944D;
	Thu, 18 Jan 2024 07:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WG6wM0cG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9D853A4;
	Thu, 18 Jan 2024 07:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705561321; cv=none; b=bm41aikjG6roeyXyyiY3E0y0SlL5y1ATu6ftzOY+zTjSHAU42Ls+3voDFdGfs2VMlw5JTzXsrzHZkueA4gmxhgNRHZZSsfTM0m1M0m6ekd54+Y7QtFJCXpfy/jx1BEApSJtDR0h5ch+Ys3NUXP2MZ/bVyIh+TOUltlZgR8bEvqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705561321; c=relaxed/simple;
	bh=Szngl9KR9trVcJI9mDPXjLVcKtiXPzUtSgGBv4tGig8=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=NsDysniUGOcQ5/TtQqzFnd90ayL6gaLfAOZxSRbOCA6VDT3AAnFaqfnZkQj9wHhq1Tl4Wh35fIU25okceHCzy70BXn1Hu1nlJ4Z9tqA1fZDIR4PXwAUe4Sj1hUoADnLmcSIzZBLn+ZHvw7NliHOkr+9yJmpTKeFB1u1inemEwzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WG6wM0cG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF183C433F1;
	Thu, 18 Jan 2024 07:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705561321;
	bh=Szngl9KR9trVcJI9mDPXjLVcKtiXPzUtSgGBv4tGig8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WG6wM0cGznp/rgxljmjbdb3RIL05aKNtBumUdVDErcJe2smWjRbiYDxFaoPs78BwM
	 7XEAA7LMTybpv1Mlqb2CX+qFdzM1ivWy61CNuJCvJE9GMPLnWDusTuGEm5cSMioNtO
	 HnLXDhUddXdsHQLZ8kPRCmYeKvBsFl+byWatSTTY=
Date: Thu, 18 Jan 2024 08:01:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: crescentcy.hsieh@moxa.com, jirislaby@kernel.org, LinoSanfilippo@gmx.de,
	lukas@wunner.de, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 1/2] tty: serial: Cleanup the bit shift with macro
Message-ID: <2024011836-glimmer-seventh-f2a7@gregkh>
References: <20231201071554.258607-2-crescentcy.hsieh@moxa.com>
 <20240117145623.3556-1-cniedermaier@dh-electronics.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117145623.3556-1-cniedermaier@dh-electronics.com>

On Wed, Jan 17, 2024 at 03:56:23PM +0100, Christoph Niedermaier wrote:
> Hi everyone,
> 
> > This patch replaces the bit shift code with "_BITUL()" macro inside
> > "serial_rs485" struct.
> > 
> > Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
> > ---
> >  include/uapi/linux/serial.h | 17 +++++++++--------
> >  1 file changed, 9 insertions(+), 8 deletions(-)
> > 
> > diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
> > index 53bc1af67..6c75ebdd7 100644
> > --- a/include/uapi/linux/serial.h
> > +++ b/include/uapi/linux/serial.h
> > @@ -11,6 +11,7 @@
> >  #ifndef _UAPI_LINUX_SERIAL_H
> >  #define _UAPI_LINUX_SERIAL_H
> >  
> > +#include <linux/const.h>
> >  #include <linux/types.h>
> >  
> >  #include <linux/tty_flags.h>
> > @@ -140,14 +141,14 @@ struct serial_icounter_struct {
> >   */
> >  struct serial_rs485 {
> >  	__u32	flags;
> > -#define SER_RS485_ENABLED		(1 << 0)
> > -#define SER_RS485_RTS_ON_SEND		(1 << 1)
> > -#define SER_RS485_RTS_AFTER_SEND	(1 << 2)
> 
> In the old definition (1 << 3) wasn't used.
> 
> > -#define SER_RS485_RX_DURING_TX		(1 << 4)
> > -#define SER_RS485_TERMINATE_BUS		(1 << 5)
> > -#define SER_RS485_ADDRB			(1 << 6)
> > -#define SER_RS485_ADDR_RECV		(1 << 7)
> > -#define SER_RS485_ADDR_DEST		(1 << 8)
> > +#define SER_RS485_ENABLED		_BITUL(0)
> > +#define SER_RS485_RTS_ON_SEND		_BITUL(1)
> > +#define SER_RS485_RTS_AFTER_SEND	_BITUL(2)
> > +#define SER_RS485_RX_DURING_TX		_BITUL(3)
> 
> Isn't it a break if number 3 isn't skipped here as well?

Ugh, yes it is, good catch!

Care to send a patch to fix this up?

thanks,

greg k-h

