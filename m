Return-Path: <linux-kernel+bounces-124357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E88989162F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2014D2858B0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E507745971;
	Fri, 29 Mar 2024 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gHj38MRq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E16922093;
	Fri, 29 Mar 2024 09:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711705170; cv=none; b=CrybszGNuGB8nbSMBDVQ5RCMj0SDBRWiiXe89AnPYuvMY2ife+jSpkjcMFT9J5Xo09Lw0x6MrM2ByoBs1qWrey6Fb2HyvFt0lqy4HtKbY3SAMF7uMESl7iL78w+3EPNnNa+PpO/KBfr3OAtzvAFiZcn20Aa58jxqo4WcvdT1KYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711705170; c=relaxed/simple;
	bh=Mm4Dxsw/XnK0vryR0/b2qb6rSQjEXbXIgtBX3y9Pv8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmQAW5QYmXT3DG9vBFytNXlqrr04muUr2W930oGuk9cKVKxQ/VMYAQHtthAYI8VT8efK6NZJN4rN0HJ7uDKF7vp0HXuquP2iCE4qJtyHNwseDMnBMioJeN/TUG5xHuWfnIpjCFPcU6g4LerL0aUWFpPEhiy60ppQDSdUy3xA1gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gHj38MRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E6CC433F1;
	Fri, 29 Mar 2024 09:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711705169;
	bh=Mm4Dxsw/XnK0vryR0/b2qb6rSQjEXbXIgtBX3y9Pv8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gHj38MRqOFrlrs/UQEVC1HqBIFcQZRYGOVE+Pn8dnmkAHeNzuUIN05iVFRqaxqsEs
	 l9gKszHqzlim1EGWBE8MQM5PIEOK4Fc7ha12O5Iz3ltYTbWAE6gc/8DB2j+1oRGE+Z
	 k//RKUPiaAix+xzEN7+mN1+4Z6j9xK4sWhXLYg8I=
Date: Fri, 29 Mar 2024 10:39:21 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gong Ruiqi <gongruiqi1@huawei.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Jon Ringle <jringle@gridpoint.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wang Weiyang <wangweiyang2@huawei.com>, stable@vger.kernel.org
Subject: Re: [PATCH stable 5.10] serial: sc16is7xx: convert from _raw_ to
 _noinc_ regmap functions for FIFO
Message-ID: <2024032926-wielder-recreate-be4a@gregkh>
References: <20240318025259.1412353-1-gongruiqi1@huawei.com>
 <07a3c30d-5a81-4b99-8090-38753b650432@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07a3c30d-5a81-4b99-8090-38753b650432@huawei.com>

On Mon, Mar 18, 2024 at 11:14:13AM +0800, Gong Ruiqi wrote:
> Oops. + Cc stable@vger.kernel.org
> 
> On 2024/03/18 10:52, GONG, Ruiqi wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > commit dbf4ab821804df071c8b566d9813083125e6d97b upstream.
> > 
> > The SC16IS7XX IC supports a burst mode to access the FIFOs where the
> > initial register address is sent ($00), followed by all the FIFO data
> > without having to resend the register address each time. In this mode, the
> > IC doesn't increment the register address for each R/W byte.
> > 
> > The regmap_raw_read() and regmap_raw_write() are functions which can
> > perform IO over multiple registers. They are currently used to read/write
> > from/to the FIFO, and although they operate correctly in this burst mode on
> > the SPI bus, they would corrupt the regmap cache if it was not disabled
> > manually. The reason is that when the R/W size is more than 1 byte, these
> > functions assume that the register address is incremented and handle the
> > cache accordingly.
> > 
> > Convert FIFO R/W functions to use the regmap _noinc_ versions in order to
> > remove the manual cache control which was a workaround when using the
> > _raw_ versions. FIFO registers are properly declared as volatile so
> > cache will not be used/updated for FIFO accesses.
> > 
> > Fixes: dfeae619d781 ("serial: sc16is7xx")
> > Cc:  <stable@vger.kernel.org>
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > Link: https://lore.kernel.org/r/20231211171353.2901416-6-hugo@hugovil.com
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
> > ---
> > 
> > The mainline commit dbf4ab821804 ("serial: sc16is7xx: convert from _raw_
> > to _noinc_ regmap functions for FIFO") by Hugo has been assigned to be
> > CVE-2023-52488, but for stable branches lower than 6.1 there's no
> > official backport.
> > 
> > I made up this backport patch for 5.10, and its correctness has been
> > confirmed in previous communication with Hugo. Let's publicize it and
> > merge it into upstream.

I can not take this only in 5.10, it needs to also go into 5.15.y first,
right?

Please resend a 5.15.y and this 5.10.y version when you have both of
them (the 5.10.y version wasn't sent to stable@k.o so it's hard to track
down), and we will be glad to take them both.

thanks,

greg k-h

