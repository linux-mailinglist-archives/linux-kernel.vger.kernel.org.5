Return-Path: <linux-kernel+bounces-48879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70ABB8462A7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2484B1F23DF8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01E13EA71;
	Thu,  1 Feb 2024 21:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XdYuMRNl"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD893CF65;
	Thu,  1 Feb 2024 21:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706823212; cv=none; b=SfI6Hsf1UMoPe+NsuMSDsKrjccSOhADq5PSaz0uUp3E2xShHCD+Rn8KG/op64UDjXIXVlyib4WR0sJ/oiEyH+HmTkfqdEitaFxZ0oyWD8tzjli6gnDo3PCpjo4MNqT71GV4gijrKfHJNUDcIuHLmjnih4ut8wd3azoxeCxMJvsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706823212; c=relaxed/simple;
	bh=siy6++GmNHscbaxkVi1s7i39+Nt2JRQuUSycj2LrjfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oT/vYBsEG75UeRiTpky+wkmwXSXhrjIaKzARZv92zHmilSM2OtxIBTYIlMhV24nO36F79jUG2OduL2U7zUYNPF8wK83SyeKAlFNUhi+3xnHId5Bo4c08WYCeQdfILOaIe8TImejHByIA1sKDLRP9QZtBBk3FeOzrOQKAriN8YDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XdYuMRNl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=B3OEY63cwbO4YybUSmVo7dQCRT2Z2Gq0tUVDWFfTub0=; b=XdYuMRNlzfxtCYfazJe+UjRaZ4
	iM9J5rNL7JiJR/FbjgoKUEuOaf5SS1gvSWBr2oIWB8eegdyGcI98KWiv/DTzwKlGHu26X3X2fhTJY
	/CzKpiALqEyBvwAoFu6bCEl0xf8N25/IMgPRHphWP8AGXHvEI8ec747SP318i9Vv15kY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rVegH-006izN-TG; Thu, 01 Feb 2024 22:33:09 +0100
Date: Thu, 1 Feb 2024 22:33:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christina Quast <contact@christina-quast.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
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
Subject: Re: [PATCH v2 0/3] Add Rust Rockchip PHY driver
Message-ID: <123204c4-9fe9-42d4-9555-bd421494c0e1@lunn.ch>
References: <20240201-rockchip-rust-phy_depend-v2-0-c5fa4faab924@christina-quast.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201-rockchip-rust-phy_depend-v2-0-c5fa4faab924@christina-quast.de>

On Thu, Feb 01, 2024 at 07:06:57PM +0100, Christina Quast wrote:
> Based on the example shown in drivers/net/phy/ax88796b_rust.rs, I ported
> the rockchip phy driver to Rust. The code in drivers/net/phy/rockchip.c
> was basically rewritten in Rust.  The patchset includes changes to
> phy.rs, adding more struct driver functions for the abstraction with
> Rust.
> 
> The driver was not tested on real hardware, because I do not have a
> board with this phy, and I would appreciate it if somebody could try
> out the driver on their board.

As a general point, please post such code RFT. Also adding RFC would
be good, and explain what sort of comments you are requesting.

    Andrew

---
pw-bot: cr



