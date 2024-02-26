Return-Path: <linux-kernel+bounces-81499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DCC8676C2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041331C24B4C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27045128839;
	Mon, 26 Feb 2024 13:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EZTFU3f/"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92761AACC
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954774; cv=none; b=IpzSnQRXMC6dGLWOhKku/NOlsCTZ2OtmGFLiXzvj8SWyiuyoVy/FKyGjcV5bToYqTxX4Y2wU9c33EGJTX2LCZ0tDL0kD3f++sAnb6tAoD5dXUIg3f1D7Tve9iz7ENliPa1B06wey5QDAHQ0WMduPh0O1cluSTvpzhGPQoq2+kRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954774; c=relaxed/simple;
	bh=MWmAbB8K5MLgMEvoZoZEs0OnXomLIkT8UJsdf2JB0zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrQGxiO3DMxaC9gcEWrF3IteFBbKkQnvP1Co6QjxtHGxZ/Z2L5MuIIpUFvH80f2R1CvMgaRuXDIvp7yjQ5JmDuyJ+Uy6DVl8T3Aq5Ix7+nQbYt+ZNBHt0bQihP2vsaiHPaCWnBNzzxEeYv2Fp2KPitDptwg/E3eA7r066PXHMq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EZTFU3f/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=t8m8HYOpU/lqomilwTOtXcWOBIIrR/NPUPE8VHST/Ko=; b=EZTFU3f/2QzTSCqHScnAwR3o5s
	6WESfBCmc5g6hxfZ9bznelLm8wW61U3xcbbk7niVEWtpEkONX4uh0XQKh7oTMA698ppCx/ZirLlvi
	/Wi4AiMw+xJ/dgpdemnlhllBJ8WeteAoHraZuXP8HZ4JtkYaeWt1DEqCPf0GjbX9ieR8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rebCj-008j3N-JL; Mon, 26 Feb 2024 14:39:37 +0100
Date: Mon, 26 Feb 2024 14:39:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
	linux@armlinux.org.uk
Subject: Re: [PATCH] ARM: mvebu: Add check in coherency.c to prevent null
 pointer dereference
Message-ID: <eb036663-2109-4d75-8386-451fa5c34889@lunn.ch>
References: <20240225060450.53044-1-duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225060450.53044-1-duoming@zju.edu.cn>

On Sun, Feb 25, 2024 at 02:04:50PM +0800, Duoming Zhou wrote:
> The kzalloc() in armada_375_380_coherency_init() will return
> null if the physical memory has run out. As a result, if we
> dereference the property pointer, the null pointer dereference
> bug will happen.
> 
> This patch adds a check to avoid null pointer dereference.
> 
> Fixes: 497a92308af8 ("ARM: mvebu: implement L2/PCIe deadlock workaround")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>

I have to wounder how we can run out of memory here. This code is
being called from:

postcore_initcall(coherency_late_init);

If you look at:

https://elixir.bootlin.com/linux/latest/source/include/linux/init.h#L299

You can see that only true kernel core stuff has been called before
that. If that has consumed all the available memory, something is very
seriously wrong, and the machine is not going to last another couple
of milliseconds before it crashes no matter what checking you do.

So i do wounder if your time could be better spent in other places?

	Andrew

