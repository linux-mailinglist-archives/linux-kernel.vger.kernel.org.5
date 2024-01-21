Return-Path: <linux-kernel+bounces-32177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5288357B3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 21:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7251C214D7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 20:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F28383B2;
	Sun, 21 Jan 2024 20:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="S8SHx6hP"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C8B37713;
	Sun, 21 Jan 2024 20:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705868624; cv=none; b=SROCfzbm1RxhiIgC78WnJR7xk8EldelTXeRY+MklvNEiFu+xQ1JB4akeDYJJeYSfA9x7mBsNgGIPW4WwaXNnXc84wXEaehH87HBdi2mvJMu0J6TOe8uqJxDgQPVmad+mfV/klkvNDU26nGLPKwMsrcIpYK0w9fDXkmO3WmQUbCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705868624; c=relaxed/simple;
	bh=b1pZyK7FsCUmhPlvju8roc6IUuWpgZNleb3xFjmFVeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyBOzSi5w9Cuvfl+AqHKx6A2lrpeQFf9PHWTuyPxwcwI+4T/fpucrvGlQ8iS4deOt0w3EGh3jOfAWKloazv9UETdXF7Ax07jx6sPZugGFf/bZzbn50bmTzS5Wq1Lz58m1y7jxlTZiR6IqsCKG79g8c/5CO2rEw/DVt5d2fBJOww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=S8SHx6hP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BK3kTu4rO51T+6hQ0GXL+VPtTV0TrbToYj9UeX6NjHI=; b=S8SHx6hP8PBi2zrMN88BCDT3ma
	dbfiNVqGFMe40xW7EkpU8oIc39ujKK+0joAWNuDXA6N7eAN624FWu9nclqZ0AQDfwb3vdKPsbVqSd
	0/Z2jS5L0mTHBoCynuaZ/VyBgcN/1AJzP8te62cA0Fjr0mhgpcBpj6rdVFF12NQUd+9w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rReLe-005fbq-75; Sun, 21 Jan 2024 21:23:18 +0100
Date: Sun, 21 Jan 2024 21:23:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Andre Werner <andre.werner@systec-electronic.com>
Cc: hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v4 1/2] net: phy: phy_device: Prevent nullptr
 exceptions on ISR
Message-ID: <645d928b-cd8b-42d0-9f68-fb9b05769cfa@lunn.ch>
References: <20240121201511.8997-1-andre.werner@systec-electronic.com>
 <20240121201511.8997-2-andre.werner@systec-electronic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240121201511.8997-2-andre.werner@systec-electronic.com>

On Sun, Jan 21, 2024 at 08:54:48PM +0100, Andre Werner wrote:
> If phydev->irq is set unconditionally, check
> for valid interrupt handler or fall back to polling mode to prevent
> nullptr exceptions in interrupt service routine.
> 
> Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

