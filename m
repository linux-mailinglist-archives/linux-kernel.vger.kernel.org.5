Return-Path: <linux-kernel+bounces-48684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B64E845FC2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373BB1F27C7E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C866A7C6D0;
	Thu,  1 Feb 2024 18:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P5bm9aHJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A7412FB38;
	Thu,  1 Feb 2024 18:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706811785; cv=none; b=o4sX7H/74J3uRebePWeRCcxHQFaEAgfVa4b00GFzZL4TvONMvVxw7tkV5105Lt2J19DZ55eb7S9acJvWH+PGisarKoAny2nO6bD87Q+BIHavPgs/p6WbOZg8B6PIBS5eCsI4DCzfZw3efaYT7s6Wa9sIfimHs1goSvqHUuHGX5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706811785; c=relaxed/simple;
	bh=g30JJF6c2p9BNtqLzB7XLKvKHMAUsAjHRtAPmzxpNec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdIPPelvhcN8UPBNWmDzPbi6oQIZdwJHWHUB4bLv79s5nUc3WNqzpT0+rSUw8ETdcjXIjTKqMeXjI9AH8cDWPUN82tVElItwuzPxY60+DHPvYoX4kGS3+UqF0CIFsIIZfHS5zxGuiTUGEzs37R9IEmM0tj8KH6BwtzBuDNGQMoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P5bm9aHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625A1C43394;
	Thu,  1 Feb 2024 18:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706811784;
	bh=g30JJF6c2p9BNtqLzB7XLKvKHMAUsAjHRtAPmzxpNec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P5bm9aHJFe5C09SLrv5P8D7FyWqccaceRdwXWPzs31IigkUX5cR3+dS4usDCl7sMp
	 BSu+SPA0C5NO1P0FRs+6K2+SF3/WBNxlMr9TKBy0ngmLOAmvNt4IlVj2pkwUw2r90J
	 Y7nDNsYw4jfFEBIeImdlpHUOZyWbJcIHrJXZw/ek=
Date: Thu, 1 Feb 2024 10:23:03 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Christina Quast <contact@christina-quast.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Trevor Gross <tmgross@umich.edu>, Andrew Lunn <andrew@lunn.ch>,
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
Message-ID: <2024020105-bankroll-opium-a6e5@gregkh>
References: <20240201-rockchip-rust-phy_depend-v2-0-c5fa4faab924@christina-quast.de>
 <20240201-rockchip-rust-phy_depend-v2-3-c5fa4faab924@christina-quast.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201-rockchip-rust-phy_depend-v2-3-c5fa4faab924@christina-quast.de>

On Thu, Feb 01, 2024 at 07:07:00PM +0100, Christina Quast wrote:
> This is the Rust implementation of drivers/net/phy/rockchip.c. The
> features are equivalent. You can choose C or Rust version kernel
> configuration.
> 
> Signed-off-by: Christina Quast <contact@christina-quast.de>
Cool, but why?  Is this going to happen for all phy drivers going
forward?  What's the end-game here, dropping all .c phy drivers that are
in rust?  Or having duplicates for all of them?

thanks,

greg k-h

