Return-Path: <linux-kernel+bounces-55705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 436A484C091
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 310281C24566
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63791C69E;
	Tue,  6 Feb 2024 23:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fQrdi6qP"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBF51C2B3;
	Tue,  6 Feb 2024 23:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707260473; cv=none; b=mIVT+rn8NkeNRSPiBEjgFrDYDUqsm4iL8OtUWBr8ZB2Q4XRVUAn8NtlFLuI5JUtRtdXgpXCEgNFhJCQEY14KqEHYwA9PA+Q6d/baA9/4Uk2mX4YacME5Z0upwVSsY7liFIQ/r9DL5GiAeXnb/cAz99847Cf7CATjTSqyf+sgXCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707260473; c=relaxed/simple;
	bh=whJJHCSgv9wS0iFIrlNtciLwFTUFvmaPY7s1Vz49+DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W19zphLING9ckFYP/6rK0pTEIBs/I2YmaAEl4s95dU2TPi3r0+pbVYrkuWIVonioCUDIg+KVfW7yrKUHq9Bvg8oAbRz2kIICFWUMGG3pHBl0RezRUh5yt8ehj6x60QRkUfWR5YsEfUyMtzz0cU1aqcBthj4dEJT/9sBdy62msSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fQrdi6qP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SPTt7oR80AXopIqc8+4lr98M7p1eXFt9rIgm1PC5o50=; b=fQrdi6qPz/zge9lAr3PYPcDhWX
	wgsdjTy6Y9dfZKxU31mz5TfYs83AxSbxnZsNk7jea/wFJC0w1dwy577REAke3LBptq8c4PGLkP/Yi
	vQiUhZim6exUJ1Fb83XryCA1YOXZE3oEIOC+N942NdhvoXg5bkw3z6xFFXVbKUrrNPbc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rXUQj-007Axh-DB; Wed, 07 Feb 2024 00:00:41 +0100
Date: Wed, 7 Feb 2024 00:00:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Trevor Gross <tmgross@umich.edu>
Cc: Christina Quast <chrysh@christina-quast.de>,
	Shashwat Kishore <kshashwat13@gmail.com>,
	Christina Quast <contact@christina-quast.de>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiko Stuebner <heiko@sntech.de>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 3/3] net: phy: add Rust Rockchip PHY driver
Message-ID: <8a95a80f-55da-4606-a55c-59b63a249178@lunn.ch>
References: <20240201-rockchip-rust-phy_depend-v2-0-c5fa4faab924@christina-quast.de>
 <20240201-rockchip-rust-phy_depend-v2-3-c5fa4faab924@christina-quast.de>
 <CALNs47tnwCgyvM2jBo=bTt1=2AJFt3b6W+JsTHM3Np2tbNJYCA@mail.gmail.com>
 <eb229460-0efc-448a-863f-ac0634a72f2c@christina-quast.de>
 <CALNs47tfmcayLdbLbArPS=AHwETiaQKZ09h69_Q4HmfrMPk4-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALNs47tfmcayLdbLbArPS=AHwETiaQKZ09h69_Q4HmfrMPk4-A@mail.gmail.com>

> Andrew might have some ideas too. There are a lot of new phys coming
> out since MACsec is getting more popular, also some newer specs like
> 10GBase-T1 and 10Base-T1S.

Those can also be hard to get hold of, unless a vendor is interested.

Another source to look at might be OpenWRT and DD-WRT. These projects
are not always good at upstreaming. They sometimes just use the vendor
crap drivers. See if they have any PHY drivers for devices not in
mainline. Any they do have should be for COTS hardware you probably
can buy off the shelf.

    Andrew

