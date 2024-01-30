Return-Path: <linux-kernel+bounces-44716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2842842669
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73215289C7E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CCD6D1D0;
	Tue, 30 Jan 2024 13:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0EyaNAy3"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37376D1B5;
	Tue, 30 Jan 2024 13:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706622523; cv=none; b=O6BNzHKvnPKm5ffaXIWSHgl2tmd3cWujsPqK4pIfhtqF69W9C8sDFu8BDzJgVbwolNILylywzCgrADwC+nwAPgMQ96vG9p5uxU746nJwCX4Tf4i6FsNpIJeSMhQeIDww9IJ3pJxF0indGyG6HyhA1TLCeMOdmPmEsd4RukkdF+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706622523; c=relaxed/simple;
	bh=LX2Fic2UMf7KjX8p2W2+sSCjFDYmcP3OxJ1aZl3nnnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0rAoKME5hVKoCoJirZswaCkp01Ozw8hfJxZQcqUxIcA20jIEmg30BchSq4qRMuJhP+j7I0drH8qa/0jz+rx60rYNgQRKkyL5k2cg2wpyX7Ahei8bqA262dBsWzJatpL3tPWdPPE9IuejT/S0qhxAQ6AJXX+lLIXpLjpX13AgSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0EyaNAy3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vd//V4XYtNdO2bVzPimQHhpuzy1TW7+TDVfUFwizcWs=; b=0EyaNAy3PN3WNXOZkObkKOnf7m
	l+LjuYFxeSmhk3U5RzxxGCO0Ob/JJ5phV2UidjoFY6TDp/w1VAOw5GU0j/6w7dWlLI65z+naIqFmw
	nV0n25zGIlwSGH0LXks3/JplBRPXEwI4GX7pzoZ7e+w37JMlEZfKniz/sYw3x4tI8BxM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rUoTM-006UoM-Ti; Tue, 30 Jan 2024 14:48:20 +0100
Date: Tue, 30 Jan 2024 14:48:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Petr Tesarik <petr@tesarici.cz>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	"open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>,
	Marc Haber <mh+netdev@zugschlus.de>,
	Florian Fainelli <f.fainelli@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: stmmac: protect updates of 64-bit statistics
 counters
Message-ID: <cd9ce78c-2761-4b87-af87-ed6ccb1206bb@lunn.ch>
References: <20240128193529.24677-1-petr@tesarici.cz>
 <ZbiCWtY8ODrroHIq@xhacker>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbiCWtY8ODrroHIq@xhacker>

> PS: when I sent the above "net: stmmac: use per-queue 64 bit statistics
> where necessary", I had an impression: there are too much statistics in
> stmmac driver, I didn't see so many statistics in other eth drivers, is
> it possible to remove some useless or not that useful statistic members?

These counters might be considered ABI. We don't want to cause
regressions in somebodies testing, or even billing scripts because we
remove a counter which somebody is using.

       Andrew

