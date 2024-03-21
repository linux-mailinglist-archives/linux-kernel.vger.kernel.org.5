Return-Path: <linux-kernel+bounces-109512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A263E881A65
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668C12838A6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9995D1396;
	Thu, 21 Mar 2024 00:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fOYpeqKe"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D44D181;
	Thu, 21 Mar 2024 00:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710980004; cv=none; b=AgV+T7Ih9Gm71trdAvQ0g6ebyw6KQvNU8Xka+XfyhIOBVGInKJwOmYsILqzTRQsUxjY+m9Ptd8tEiLTA6z+VgIvsxgXHCJ/ohzJ+tofv54V5Lsckl4vJalf4BudtGSDS59HkVJ05md3wiOkeq0DoVMPSKVtwqPPCqsoYsZqgsBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710980004; c=relaxed/simple;
	bh=idt34RCsmjQa9sg1HF413GfcyPC/eDnTis7MJWPyj5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PycABMlEW1zZCkBZowjviwuN44y37MQNsl7x5TIAxjh/wPcUVNpPto6Cg5jyVOokJMJpS0Mbo6sC64scfOijGz8CcFzLXqGFhSXp9SK1S06tcPwz/R8v7uOzP6X0i4ZKgyg1uzVKaARhjbO1aknnLrdtb/LoDyHPnXZaTffH4qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fOYpeqKe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gv/K5XLmRYXt/pW1HUc3KeLmTK/ySVp7kwxWVc+y47c=; b=fOYpeqKetM3L0Xo5Efv6ZGCPO/
	mfkTT387NHowiUY3ZFCMinZYn8lf1Wq0AN6ghtcZYekBTkJ7GKyhXC6s8U0on1Z30IxwKtuOtZz6L
	4D5APpuj/IR0xP2YRY0CZcWFwq98rjbvt9QGoBQqqk0wp0QBV0UYF7tRi2MZDW2eDwOw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rn63R-00ApGM-4B; Thu, 21 Mar 2024 01:13:09 +0100
Date: Thu, 21 Mar 2024 01:13:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Elad Nachman <enachman@marvell.com>
Cc: taras.chornyi@plvision.eu, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, kory.maincent@bootlin.com,
	thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
	przemyslaw.kitszel@intel.com, dkirjanov@suse.de,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] net: marvell: prestera: force good base mac
Message-ID: <d58e8059-66b7-4545-896a-6194b98000ef@lunn.ch>
References: <20240320172008.2989693-1-enachman@marvell.com>
 <20240320172008.2989693-5-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320172008.2989693-5-enachman@marvell.com>

On Wed, Mar 20, 2024 at 07:20:07PM +0200, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> The switching ASIC router HW unit MAC Source Address is configured with
> 40-bits of MAC base address in its registers (done in the firmware code),
> requiring all ports doing L3 routing in HW to have the same upper 40-bit
> MAC address.
> 
> Since each switchport MAC address uses the switch base mac address and
> then adds the physical port number to it, Force the last byte of the
> switch base mac address to be at most 127, so when adding to it, we
> will not wrap around the previous (more significant) mac address byte,
> resulting in a warning message.
> 
> Fixes: 501ef3066c89 ("net: marvell: prestera: Add driver for Prestera family ASIC devices")
> Signed-off-by: Elad Nachman <enachman@marvell.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

