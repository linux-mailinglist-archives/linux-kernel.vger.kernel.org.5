Return-Path: <linux-kernel+bounces-62873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0340685271F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAFF01F25F50
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B3F539E;
	Tue, 13 Feb 2024 01:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CZ5kAB/H"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC32CA47;
	Tue, 13 Feb 2024 01:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707789172; cv=none; b=OKfMs6FDi3g1EROU9CBfl1+O2XUkpcNy6kYwPKqM/dACjZDH6Tkxd+5iSa8foSNrBx9LaQCIMcsWmFbkwbEu3jbv2H3ainT82BtgKJ95nNb2FbZYN8dnntQkrUdKkqj6ri1sjlH+fIdYgIGW+rQ0L41hGIHHAeKHxkIMfkWbfk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707789172; c=relaxed/simple;
	bh=U6doxvDnuIY90hBori+eEiej6JWNkEdPedf5UFcbCP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeGT2o9RDZ7betrJIjaDERsZmEQwC4a3tzodWf7FCGvUOk8ikHDY8+FbLEkznhkzQ5t7LPFbo2AkRMZFT5Gk+kmIXXz4gBJyBE3E99YyU1NW3dc1wV+9rDtopWGFfGlH9O1u50uiuzJ2ZJX1Hlgewhlw1GIOY8VSDs1Mf9zdOZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CZ5kAB/H; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1SdYRn3CWEK3dxlZPaRQcNWKE6YBcI2fKjJGdbWOJRk=; b=CZ5kAB/Hf4UtFoX61xHTUDT0fJ
	B9BqJ9om1X6C2Wq+KOHa/IsARGsafaYupQviQ+T6GZ0PvBg332qYLgT7SkL3yqGg+pNkzIA/MJRGY
	bXhTHhBb1w0zNfMq1RMbb42QU7vdS6kX3z63JhttSAuMbclxMRNidgYFAZNGsssiQW+I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rZhyc-007ckQ-DI; Tue, 13 Feb 2024 02:52:50 +0100
Date: Tue, 13 Feb 2024 02:52:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Robert Marko <robimarko@gmail.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	ansuelsmth@gmail.com, rmk+kernel@armlinux.org.uk,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: aquantia: clear PMD Global Transmit
 Disable bit during init
Message-ID: <bcccaab4-fffd-43ee-ac49-8fe8a92d65a1@lunn.ch>
References: <20240211181732.646311-1-robimarko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211181732.646311-1-robimarko@gmail.com>

On Sun, Feb 11, 2024 at 07:16:41PM +0100, Robert Marko wrote:
> PMD Global Transmit Disable bit should be cleared for normal operation.
> This should be HW default, however I found that on Asus RT-AX89X that uses
> AQR113C PHY and firmware 5.4 this bit is set by default.
> 
> With this bit set the AQR cannot achieve a link with its link-partner and
> it took me multiple hours of digging through the vendor GPL source to find
> this out, so lets always clear this bit during .config_init() to avoid a
> situation like this in the future.

This all look sensible. My only question is, should we have core c45
code doing this?

[Goes and looks at 802.3]

O.K, so the Marvell PHY firmware appears to be broken. The standard
says it should have a default value of 0, i.e. the transmitter should
be enabled by default. So this is just a workaround for broken
behaviour.

> Signed-off-by: Robert Marko <robimarko@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

