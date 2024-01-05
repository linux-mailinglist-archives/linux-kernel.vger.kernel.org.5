Return-Path: <linux-kernel+bounces-18014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C958282571E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63B1A284A45
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE7A2E84A;
	Fri,  5 Jan 2024 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OftuXIap"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6B62E844;
	Fri,  5 Jan 2024 15:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE37C433C8;
	Fri,  5 Jan 2024 15:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704469867;
	bh=Lh0uReuG9LM3mNy7nFZnSgLZko7guYuJt+uwH4YOYl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OftuXIapFuJoHGsh9wKaBv7QZtbR3dcnJNeZ7XJ1r8MZ8P4ShFE4za1n580MH6Tly
	 5FiPD+F2W8z/Y9dMrS4CZQ865i4jER4FFrBnVbPC9YslmkM/gDhSwUYOsk1jZJMroD
	 MrKlO2A9xFx51L+LSQ5vwPzmaiwu11BiXG//7iEE=
Date: Fri, 5 Jan 2024 16:51:04 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: make spi_bus_type const
Message-ID: <2024010511-wrongness-ashes-f540@gregkh>
References: <2024010549-erasure-swoop-1cc6@gregkh>
 <0fcee73a-bdcb-41d5-b6e5-21947ae9e3d7@sirena.org.uk>
 <2024010554-unreached-colony-96dd@gregkh>
 <50ecc7bb-50ac-4846-8a6e-fad9148c948f@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50ecc7bb-50ac-4846-8a6e-fad9148c948f@sirena.org.uk>

On Fri, Jan 05, 2024 at 03:45:37PM +0000, Mark Brown wrote:
> On Fri, Jan 05, 2024 at 04:05:18PM +0100, Greg Kroah-Hartman wrote:
> > On Fri, Jan 05, 2024 at 02:55:01PM +0000, Mark Brown wrote:
> 
> > > Whatever makes the driver core able to handle this doesn't seem to be in
> > > mainline yet - what's the story there?
> 
> > Odd, what errors are you seeing when you build?  I have had to fix up a
> > few subsys_* calls for this type of thing, but I don't see spi_bus_type
> > being used in those that I saw in my local tree.  Did I miss something
> > else?
> 
> > Maybe just wait for after 6.8-rc1, it builds properly here locally :)
> 
> It's this on an x86 allmodconfig:
> 
> /build/stage/linux/sound/soc/rockchip/rk3399_gru_sound.c:471:29: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
>   471 |                 .bus_type = &spi_bus_type,
>       |                             ^
> cc1: all warnings being treated as errors
> 
> so not actually a core thing, I have to confess I didn't notice where
> the assignment was when I glanced at the errors.

Ah, missed that, as it was handled by this commit for the i2c tree:
	https://lore.kernel.org/all/2023121942-jumble-unethical-3163@gregkh/

So just hold off on this until after 6.8-rc1 is out, or I can wait until
then as well if you ack it and take it through my tree.

thanks,

greg k-h

