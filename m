Return-Path: <linux-kernel+bounces-50355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC478477EF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0F821C2587A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87178062A;
	Fri,  2 Feb 2024 18:39:44 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E34315D5CD;
	Fri,  2 Feb 2024 18:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899184; cv=none; b=r/yNrOBKJD2sFEapMgyEFH0whbZMTxeBqwFEENgYTso/h+N3jWSa/mlaBXyd6CRaEV9igWN5CXjkAGV29Ho9Ev5pRRHNTcH4HibKkRE5FxAb/NBPW2ygeIDPwLoawcLLIwfcXpaGafzfE9i4zNHR4BcgpwuqRcN9OFMGGBmw8AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899184; c=relaxed/simple;
	bh=9f6vU82EFNxs5qQJiBXinPYuAuGon2VB1Gw/+HpYECs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVcwJP4K2fx0qHAJk58OBfaPEp/i8P8ggqb3YA8siPC8BhCjwHKVvMJJvbQDnHiIBEPFo4cCdjw9KUlTEGdvUmJIoNJ3K5j55YOG6SemSjjEfTNFEtLlo73cOJBnUKr3/QM2e2YcstBGHf5A5eL8FpOfYUivPgDqmmuJoM9iSCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rVyRe-0002Ew-3A;
	Fri, 02 Feb 2024 18:39:23 +0000
Date: Fri, 2 Feb 2024 18:39:18 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v3 4/7] net: dsa: mt7530: move XTAL check to
 mt7530_setup()
Message-ID: <Zb021ozEQSbU-gPd@makrotopia.org>
References: <20240202-for-netnext-mt7530-improvements-2-v3-0-63d5adae99ca@arinc9.com>
 <20240202-for-netnext-mt7530-improvements-2-v3-4-63d5adae99ca@arinc9.com>
 <ZbzWpmZrukknMsYf@shell.armlinux.org.uk>
 <5b744f7f-2f63-4219-a0e9-8f08267b1fdd@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b744f7f-2f63-4219-a0e9-8f08267b1fdd@arinc9.com>

On Fri, Feb 02, 2024 at 09:16:02PM +0300, Arınç ÜNAL wrote:
> On 2.02.2024 14:48, Russell King (Oracle) wrote:
> > On Fri, Feb 02, 2024 at 12:19:10PM +0300, Arınç ÜNAL via B4 Relay wrote:
> > > From: Arınç ÜNAL <arinc.unal@arinc9.com>
> > > 
> > > The crystal frequency concerns the switch core. The frequency should be
> > > checked when the switch is being set up so the driver can reject the
> > > unsupported hardware earlier and without requiring port 6 to be used.
> > > 
> > > Move it to mt7530_setup(). Drop the unnecessary function printing.
> > > 
> > > Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> > > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > > Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> > 
> > I would prefer this to be earlier in the series, before patch 2 which
> > moves mt7530_setup_port6() to be called from mac_config(). mac_config()
> > is supposed to be configuration error-free - in other words, all state
> > should have been checked before hand.
> 
> I agree but mt7530_mac_config() is not a void function yet. The
> mac_port_config member of the mt753x_info structure points to this
> function. My next patch series gets rid of all useless error returns on the
> phylink path and change mac_port_config to void. So I don't think working
> on this patch series further will worth the effort. I'd rather have this
> version applied as is.

I agree regarding not changing the patch itself, but I also agree
with Russell regarding the patch ordering. I know it's a 10-minute
git headache to rebase the patches on top of each other in a different
order, but you can easily compare the end result being identical to
what you had before and hence don't need to retest.

