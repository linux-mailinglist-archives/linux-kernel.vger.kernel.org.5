Return-Path: <linux-kernel+bounces-40124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BF883DA9C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C802B25A65
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD711B810;
	Fri, 26 Jan 2024 13:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NN5fv+lT"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9C41B7ED;
	Fri, 26 Jan 2024 13:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706275060; cv=none; b=SQJKKbPVu1k1ASq5838wVwNHf68osZm1nCXTrAc04PAntCSDwvzejzqMKN9PMOKLH/vOMWO0sKlwvj+qqQpTHwz5QxY+fYImWKQX9jVAL/qNmI5xgzG+NJjA7+RnNOgrwZNz6HSDqTRBgAHeeHeF9e+A69khglgWO59xy1n3qnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706275060; c=relaxed/simple;
	bh=NlQuNlflVT/LmukzQGVyl9V41C+YgjahNb0jnYT9yrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sa1rQ9QEEkUcdphbrFbf3hKfYyT0pmHIrrbrTq0OND/KGc6o8QiqbwCjLHF1pZ4JMLqjkjPxRHtuay/rlxX438WAIIY7zfLaqY9LZHrLzuUl3Vjv219MAQ6R3ci7me4d+5A/TcXIjsOT9hTeRPrkbu+bH4f6U/ZsBNJMdT+r5KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NN5fv+lT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=dBeM8KjZ3a0EMDvqT9tXv1BytxLZNqA83/cMmPhrQCw=; b=NN
	5fv+lTjbEXcXQKrRSLN0bAVAH8MBxuR5SeUM4YqvIt+kW/Zq7KPBPjZAtpXM3yZJBEsCTLMKdfPPe
	iPJYz+3SpYQ4mtWEGbTrnZn54Dg4Q82F0U1Uey7bC3B5LCN+nMVsVfb4a/EOVP+qcxof4KKJ9U+/7
	6Swl7FGffzQhbbg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rTM5L-006Anh-QP; Fri, 26 Jan 2024 14:17:31 +0100
Date: Fri, 26 Jan 2024 14:17:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Christian Lamparter <chunkeey@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, petr.benes@ysoft.com
Subject: Re: [PATCH net v3] net: dsa: qca8k: fix illegal usage of GPIO
Message-ID: <22d3d3fd-223b-4b33-9911-1dc4d6809075@lunn.ch>
References: <1706266175-3408-1-git-send-email-michal.vokac@ysoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1706266175-3408-1-git-send-email-michal.vokac@ysoft.com>

On Fri, Jan 26, 2024 at 11:49:35AM +0100, Michal Vokáč wrote:
> When working with GPIO, its direction must be set either when the GPIO is
> requested by gpiod_get*() or later on by one of the gpiod_direction_*()
> functions. Neither of this is done here which results in undefined
> behavior on some systems.
> 
> As the reset GPIO is used right after it is requested here, it makes sense
> to configure it as GPIOD_OUT_HIGH right away. With that, the following
> gpiod_set_value_cansleep(1) becomes redundant and can be safely
> removed.
> 
> Fixes: a653f2f538f9 ("net: dsa: qca8k: introduce reset via gpio feature")
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

