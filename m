Return-Path: <linux-kernel+bounces-23671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DED82AFDD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A331C23D8E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D2432C7A;
	Thu, 11 Jan 2024 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Mi/7EUkk"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF62B1802D;
	Thu, 11 Jan 2024 13:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=il+w8FtfhJHoKZMk6/3PRsXBylrA/EgWONxoBacvEFk=; b=Mi/7EUkk+96Fu+e4grIj30OKjw
	s9UyrmWftnrF5wN6Wzm7wk3Z+2ni4VbciRb89fFHNdz7XOhm6n6z8y4JbQdPiM695s0KR7w/ilFeA
	XRWAAsLwqU88g7nnIBgdyaaEn9mfjf3/lxxelTjQKnISiOWvECOfxFpBj0eCdTv5gTDI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rNuvm-00506I-0z; Thu, 11 Jan 2024 14:17:10 +0100
Date: Thu, 11 Jan 2024 14:17:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Gan, Yi Fang" <yi.fang.gan@intel.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Looi, Hong Aun" <hong.aun.looi@intel.com>,
	"Voon, Weifeng" <weifeng.voon@intel.com>,
	"Song, Yoong Siang" <yoong.siang.song@intel.com>,
	"Choong, Yong Liang" <yong.liang.choong@intel.com>
Subject: Re: [PATCH net v3 1/1] net: phylink: Add module_exit()
Message-ID: <3e87a5f7-e637-401c-8fe1-9b0c5e6d8289@lunn.ch>
References: <20240104101255.3056090-1-yi.fang.gan@intel.com>
 <fb1cc3a4-8615-4cee-8fe7-29966c4cb7c7@lunn.ch>
 <MW6PR11MB8310698247DD950C5EBF5F2CB9682@MW6PR11MB8310.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW6PR11MB8310698247DD950C5EBF5F2CB9682@MW6PR11MB8310.namprd11.prod.outlook.com>

> Hi Andrew,
> 
> Regarding the justification on why it is safe to remove phylink, 
> we had done some memory leak check when unloading the phylink module.
>  
> root@localhost:~# lsmod | grep "phylink"
> phylink               73728  0
> root@localhost:~# rmmod phylink
> root@localhost:~# echo scan > /sys/kernel/debug/kmemleak
> root@localhost:~# cat /sys/kernel/debug/kmemleak
> root@localhost:~#
>  
> So far, we didn't observe any memory leaking happened when unloading
> phylink module. Is it sufficient or do you have any other suggestions to check 
> on whether the module is safe to remove?

In general, leaked memory is safe. Being leaked, nothing is using
it. If nothing is using it, how can it cause an opps, corrupt a file
system, etc.

What you need to do is review all users of phylink, and determine if
any of them retains a pointer to anything which phylink manages and
will not be freed or uninitialized when it is unloaded. Is all polling
of GPIOs cleanly stopped? Are interrupt handlers disabled and
removed. Are PCS and MAC drivers cleanly unloaded first? Are hwmon
entries cleanly removed, taking into account that user space might
have them open? All ethtool ioctl/netlink calls are out of the code
before it is removed, etc.

     Andrew

