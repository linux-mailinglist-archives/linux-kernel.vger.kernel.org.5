Return-Path: <linux-kernel+bounces-29909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C85831503
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 594B8284452
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B280125A4;
	Thu, 18 Jan 2024 08:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qDOVfwNX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F93011C89;
	Thu, 18 Jan 2024 08:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705567462; cv=none; b=UPtGDkJiqtnMFrQd4r1mLlF/pfXYkJa1auDkKwKJpG2hvqp3dFOAPpmNpqHSZglJneWkjJcP9qjlDNE+57BsiT058OUuCm7kwhovPNcEEJIMauRmFIvYY5XT86GBDJREXKWbZeGpg69zVZyVnC9WpJ7Qv2r5qmScBueYTd1gnBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705567462; c=relaxed/simple;
	bh=QATaYohPU+L5T8X2rlTM5GZ2caeXAoEQ/uZIIr7aU1U=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=F2C3Wr2PiTtcaFKYqyBskoiPW9gE9jiBul+jsxb+7Pxb7MMjofXIeO5lWQ6gQG8QUfU8MtFZ11sECZOYHPnSY0qKH+K/veBziZCc+Or7Hwn/qCvmyoPTKRtTdt4sGOTWRKMe/mOxpjg7JHlpTXjfsRliCzBRlQx71BLKFydqMBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qDOVfwNX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98676C433F1;
	Thu, 18 Jan 2024 08:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705567462;
	bh=QATaYohPU+L5T8X2rlTM5GZ2caeXAoEQ/uZIIr7aU1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qDOVfwNXPTBRCJJg2DsnbrWD+GBWjItEjJYLihQ4vm5Ea9tjsJfj9afAR9e4SFLrj
	 a0jpkuK9PGdPOh7QduSQDGLZcx5J+D9OWSCq2C7CXWlDsEP1fVMWCpaFk9uOfSLpx6
	 0ut6xaJFBERvT6tqZ+GdP+8E6aSn1du1yPv/93Cw=
Date: Thu, 18 Jan 2024 09:44:19 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
	jirislaby@kernel.org, LinoSanfilippo@gmx.de, lukas@wunner.de,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 1/2] tty: serial: Cleanup the bit shift with macro
Message-ID: <2024011824-squiggle-foil-8db4@gregkh>
References: <20231201071554.258607-2-crescentcy.hsieh@moxa.com>
 <20240117145623.3556-1-cniedermaier@dh-electronics.com>
 <2024011836-glimmer-seventh-f2a7@gregkh>
 <Zajd8fd/U3foRyLB@moxa-ThinkCentre-M90t>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zajd8fd/U3foRyLB@moxa-ThinkCentre-M90t>

On Thu, Jan 18, 2024 at 04:14:41PM +0800, Crescent CY Hsieh wrote:
> On Thu, Jan 18, 2024 at 08:01:58AM +0100, Greg KH wrote:
> > On Wed, Jan 17, 2024 at 03:56:23PM +0100, Christoph Niedermaier wrote:
> > > >  struct serial_rs485 {
> > > >  	__u32	flags;
> > > > -#define SER_RS485_ENABLED		(1 << 0)
> > > > -#define SER_RS485_RTS_ON_SEND		(1 << 1)
> > > > -#define SER_RS485_RTS_AFTER_SEND	(1 << 2)
> > > 
> > > In the old definition (1 << 3) wasn't used.
> > > 
> > > > -#define SER_RS485_RX_DURING_TX		(1 << 4)
> > > > -#define SER_RS485_TERMINATE_BUS		(1 << 5)
> > > > -#define SER_RS485_ADDRB			(1 << 6)
> > > > -#define SER_RS485_ADDR_RECV		(1 << 7)
> > > > -#define SER_RS485_ADDR_DEST		(1 << 8)
> > > > +#define SER_RS485_ENABLED		_BITUL(0)
> > > > +#define SER_RS485_RTS_ON_SEND		_BITUL(1)
> > > > +#define SER_RS485_RTS_AFTER_SEND	_BITUL(2)
> > > > +#define SER_RS485_RX_DURING_TX		_BITUL(3)
> > > 
> > > Isn't it a break if number 3 isn't skipped here as well?
> 
> Sorry I might have misunderstood the meaning of "broke userspace".
> 
> In this case, does it imply splitting the "cleanup" patch and the "add
> feature" patch, or leaving the third bit unused? Or perhaps both?

You can not redefine existing defines to different values, like you did
here, that changes the user/kernel api of the system.

Luckily this isn't in any released kernel, I'll either revert this after
-rc1 is out, or take a patch from anyone else to do so if they want to
send it now.

thanks,

greg k-h

