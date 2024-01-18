Return-Path: <linux-kernel+bounces-30388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F9D831E12
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D7921F22488
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D462C842;
	Thu, 18 Jan 2024 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Pmo5tso8"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363952D02B;
	Thu, 18 Jan 2024 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705597220; cv=none; b=n9tnq8PZ1WDteWui05kpE6bNizW+Vm+EovOYy1Wj5wIW/IEuRA5SMJvpuYzuLyLZegXh+XOEqm0F1KYn1ZwVaPYlj8zgoegS1FtF8sgaQVava2vl23Z04gZ1oXidmwBSP0uHqd444rkz8SXBqmlQA6fMYHPlDW+URz6hS+JXcGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705597220; c=relaxed/simple;
	bh=ZQkTj7v3P3b8slVfFVO0LEhYN51N22sIpr/cgL8WBSg=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=Z1OIKdNHih8W9WEPFM2aRQodQXOih/IUuN/O1yLZk/EBm6gwB+gEtKUeWKPDukCSQO8qZe8EVGDBNlVgBY7Nn/Ae0dyeKt3KsmePNXQ0qb01W4IeEFLpU97Qvdhg8fGyLo7ETLrb5I3tvf4pDnxLIXXqRX46tTwAegURxn0SUwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Pmo5tso8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0tuU5//Jtkk4REo0lwHCqrHwmxJPEkKkKcI8xTrY0ts=; b=Pmo5tso8M37VzKsnub2PaUM2i/
	KTG/bCFboCVTfbvP87Gk6zFJwzphCJsWVihUJuzNDyho9s5F5Nh/F5Xfqrctk2FV8G36iDvat+T2A
	tbzyFHV5I6+ih8DTPTMQJxoL9QQnWf1lhcnCQBLfNeaJ29XANT9Ity7oIvbebs34Nw5s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rQVkP-005UmY-SR; Thu, 18 Jan 2024 18:00:09 +0100
Date: Thu, 18 Jan 2024 18:00:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, Divya.Koppera@microchip.com,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net v2 2/2] net: micrel: Fix set/get PHC time for lan8814
Message-ID: <139fe4c1-6a3e-4ef3-a178-ebbe09652966@lunn.ch>
References: <20240118085916.1204354-1-horatiu.vultur@microchip.com>
 <20240118085916.1204354-3-horatiu.vultur@microchip.com>
 <6fa37dfd-3c92-4842-9785-1b17bbbedc9d@lunn.ch>
 <20240118152353.syk3v7kgf3mutqpp@DEN-DL-M31836.microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118152353.syk3v7kgf3mutqpp@DEN-DL-M31836.microchip.com>

> > Maybe submit this for net-next?
> 
> Anyway, I don't have strong feelings about this, if it goes to net or
> net-next, I just want to fix this at some point :)

Please submit to net-next. I think the ML bot which picks out patches
to backport is likely to see the work Fix in the subject and decided
to backport it anyway. But its not our problem if the bot breaks the
stable rules.

Is there any danger of regressions? Could the higher word actually
have a value for some reason today, which is being ignored. Would this
change then jump the time forward?

       Andrew

