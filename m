Return-Path: <linux-kernel+bounces-42905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0DF840852
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C44F1F26990
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0B512C53B;
	Mon, 29 Jan 2024 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lEotKr4T"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BD412DDB8;
	Mon, 29 Jan 2024 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706538569; cv=none; b=ACurfjrD8Eh8HJBMuVvpJCXeNjrhTV4S7rpUgOtrf6On0w2L3tJS+XeZ2l+oIjIZTwidDGQy4oeS83PN4gZBzlfx0mGoOWjqbkP1KgCMIMVjfdfsJXLuX8lO7EMXszQJoM9r3stjEqcsNbBQbcBJWatfaVt2leyuXMTaMnp5Ip0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706538569; c=relaxed/simple;
	bh=klGW4JOU0ClALuDIqAMnJ+Upbz3StGj/hOFT5SNXbgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stFpGjpu3Zx03w8g48q58bwYZdaiVZmSFzpZ4tI7zKvpUvNw13U3Bay/iSJwPBAKgbIdjCO4YLINRFg/cX9oYXzz5kTTPiBvZMxWeO65HpdL92VME2tmlPBkGHjCf7u9vR7Vkk5/qQKRTqhCmUM/NKec7A7tiwsqe9K7+5aNZ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lEotKr4T; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eEk2jH9LZt5ObdKA94XJk1IMNwEaHrVFcULWWP+KBAI=; b=lEotKr4T0fkUQPW3qw7TD1yeTn
	CJa48VP/EhsWS+dKqsgkKE3mEyvX/eK55hToX/B0C6wwq4g4X+JnASUxW6GSwIE0uxkzyCRYOgs1R
	AvU5uPSievCvVtiRpot9DHjF69MUZqxC+uT3TDcTljuOCqDxdpiR9TLfn84xF07MudlE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rUSdR-006O6T-Sh; Mon, 29 Jan 2024 15:29:17 +0100
Date: Mon, 29 Jan 2024 15:29:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Andre Werner <andre.werner@systec-electronic.com>
Cc: hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next v5 1/2] net: phy: phy_device: Prevent nullptr
 exceptions on ISR
Message-ID: <b507e17b-da8b-4616-b0d0-af9995bf8fc7@lunn.ch>
References: <20240129135734.18975-1-andre.werner@systec-electronic.com>
 <20240129135734.18975-2-andre.werner@systec-electronic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129135734.18975-2-andre.werner@systec-electronic.com>

On Mon, Jan 29, 2024 at 02:55:04PM +0100, Andre Werner wrote:
> If phydev->irq is set unconditionally, check
> for valid interrupt handler or fall back to polling mode to prevent
> nullptr exceptions in interrupt service routine.
> 
> Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Nitpick:

Your Signed-off-by: should go last.

Its not enough to need a respin, but please keep this in mind for
future patches.

       Andrew

