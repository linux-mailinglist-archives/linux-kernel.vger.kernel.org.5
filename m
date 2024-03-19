Return-Path: <linux-kernel+bounces-108070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9604688058B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40021C22D02
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299163A1D4;
	Tue, 19 Mar 2024 19:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bVWvnIiq"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D458B1CAB2;
	Tue, 19 Mar 2024 19:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710877110; cv=none; b=JaaLDVeheBAkq6mwTBxsdEO+3qf7QwjfBUS7Blv0vbRSPO73lKtWQdhUT58uffWQJTUg/9mVVS3BA7OqLMC1I80d92GwxL1s98ZEQYHUjHkuwWEXLynyJrgTkpvNMj09ne5NMQMa3QZSneoVDAOieddDWKEW01/AP5VjAVV27Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710877110; c=relaxed/simple;
	bh=kO1YJJtx2987pVea+qT8uhv2VHxBqnR51SKI5+CEBUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5njgH+NA8cm5fvpgP2r2FLMt7ZoDzqgmKUPkykFwZGXQ/i+maR1h6g/b0p1DRECiTm67EqT1O+vwVrURZNL82vGC2x4nixyBPw4pycBPSDbTfGe+QfXHXWEghG4BEBF/M6JurIKcQccmw69aZK7kH5c7QipRNh97vg5XlXXNrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bVWvnIiq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KuJ46ov0M1WFwhfgzmspEFR4JVVYgLT88C9rn2uIR34=; b=bVWvnIiqzDGPrE99+90DS3V/0c
	FfzZ4Xx1Lkoij6a3fsPRHLBdnADgUk5RsDNbLcxQ2NbscnZBGNiTXVTGbJ2Ja7iCXcjY6XnIIWHaG
	IK4j2hgYiCnKYhMdZixQthGh23EC/SNWFf1icFUQv9MDVpt6mve9ZKTeoQvc26nVaRlA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rmfHf-00Ajib-Vv; Tue, 19 Mar 2024 20:38:03 +0100
Date: Tue, 19 Mar 2024 20:38:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?iso-8859-1?Q?Ren=E9?= van Dorst <opensource@vdorst.com>,
	Russell King <linux@armlinux.org.uk>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/3] Fix EEE support for MT7531 and MT7988 SoC switch
Message-ID: <6cb585f6-6da8-45a2-a28b-2fb556f95672@lunn.ch>
References: <20240318-for-net-mt7530-fix-eee-for-mt7531-mt7988-v>
 <ZfnYkuzuvwLepIfC@makrotopia.org>
 <00ec9779-19ce-4005-83f0-f4abf37350fc@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ec9779-19ce-4005-83f0-f4abf37350fc@arinc9.com>

> I would argue that EEE advertisement on the PHY should be enabled by
> default.

That is an open question at the moment. For some use cases, it can add
extra delay and jitter which can cause problems. I've heard people
doing PTP don't like EEE for example.

The current phylib core code leaves the PHY advertisement whatever its
reset default is. So we leave it to the manufacture to decide if it
should be enabled or disabled by default. It is policy, so it should
really be down to user space to configure EEE how it wants it.

       Andrew

