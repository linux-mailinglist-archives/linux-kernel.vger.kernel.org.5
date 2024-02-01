Return-Path: <linux-kernel+bounces-48876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE5684629A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C18328D643
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFA83E491;
	Thu,  1 Feb 2024 21:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zxmqXiyX"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB77F20DF1;
	Thu,  1 Feb 2024 21:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706823018; cv=none; b=nhPZQP/hEtTz632fQV/n8GhR3YeBllGjfNmbIMCBZ7FhFm5yVI+a90GuBXXCQlBE6ZrqBGO8GxaJ5xtNBuFuhOIs0Cw12bvj7rFhb6H92PklvPh6WabSq3/eWcBVd7CebA1YGqROnH0GPS+23dh9YLdCt/r4jpLzcbWKmfg8CLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706823018; c=relaxed/simple;
	bh=WO1pSGffK2BlsotNwVmh8l81KNixmgAA6UL4gmhM/sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPQ8SqA9F4w3oHXx2JOrbUL8RkB5ElXJ1CwCvFgFrX1ErxX9LOibdsuKrqUFloL+j03RR/jVvCSVXUXcYGbxH3mWLg21qoUh3aJUFhTxE7gFTfgtlhGqeN6NS8Fp63P0+lF3va+iw5KyWmlQqDrs0KLutxqqTvKDgIY537Jt++Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zxmqXiyX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=n9vCqnQ6kLBE0f/I+0hHoajVVyErt59ig2/HWfGH0AA=; b=zxmqXiyXFy7SLUTKfKDL3w89pd
	oZb7jeslnq2ro4bmDEpZb9hGEa2BgVxzuEcILzPX7uMaWphgfNsfqBja0UV+QqPgO0z0esv1Zcg8A
	ovckSI8Sp6N5+RWLIx52C5a28/YKrK5qgGV0N3S8MTLrih4qMkWmWvpGcPy/jWy3US9w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rVecz-006ixF-4T; Thu, 01 Feb 2024 22:29:45 +0100
Date: Thu, 1 Feb 2024 22:29:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Christina Quast <contact@christina-quast.de>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
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
Message-ID: <6725eeac-45ee-4f3f-a612-0ef5725b9fd9@lunn.ch>
References: <20240201-rockchip-rust-phy_depend-v2-0-c5fa4faab924@christina-quast.de>
 <20240201-rockchip-rust-phy_depend-v2-3-c5fa4faab924@christina-quast.de>
 <2024020105-bankroll-opium-a6e5@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024020105-bankroll-opium-a6e5@gregkh>

On Thu, Feb 01, 2024 at 10:23:03AM -0800, Greg KH wrote:
> On Thu, Feb 01, 2024 at 07:07:00PM +0100, Christina Quast wrote:
> > This is the Rust implementation of drivers/net/phy/rockchip.c. The
> > features are equivalent. You can choose C or Rust version kernel
> > configuration.
> > 
> > Signed-off-by: Christina Quast <contact@christina-quast.de>
> Cool, but why?  Is this going to happen for all phy drivers going
> forward?  What's the end-game here, dropping all .c phy drivers that are
> in rust?  Or having duplicates for all of them?

As one of the PHY Maintainers, i would say no.

Now we have an example, i think we should be a lot more strict about
what we actually merge. It should be a driver for hardware which does
not have a C driver.

We cannot drop C drivers since Rust at the moment does not support all
architectures GCC/Clang does. PHY drivers are architecture
independent, and in real life used on multiple architectures. When
Rust eventually catches up, we could consider dropping C drivers when
there is an equivalent Rust driver, but from what i hear, that is a
few years away. I don't want to be supporting a C and Rust driver for
the same hardware.

     Andrew

