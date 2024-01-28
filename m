Return-Path: <linux-kernel+bounces-42023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5157183FB18
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 00:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83E9A1C212DA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 23:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6225845972;
	Sun, 28 Jan 2024 23:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="g+plIkOH"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F84844375;
	Sun, 28 Jan 2024 23:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706485940; cv=none; b=Cp/2FFUdJ5sinVf9thXw7VzI6bhdVCYvbZKAUL/Y22yYDs6dLuCPHa1fHovZYm4cR6er0HjqO0YPkSvCWcGLcYjhtDpnL0Uerqv4OUgxloUq0hsGLm4fg+Nbpu7sBr1+TRh6HQZCqWbNWxvFnMDPHBhD76lIjzVwPpI5b/ZTD6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706485940; c=relaxed/simple;
	bh=SHqmM3uu0EufouKxED5u9CkeQtajdNFY1EgMtL8k/Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOMnXIfjuci/wWUysgqTkKTsBFaebuRRwPfi7ayypzlJBEzM7Z/nBd7rTJsUm6k+0Ctd15VzZE1IUCMuxQEZNrAXRFnHyFOMuLK9/oacwqvJBHFP0FvcWBG7M2iSLkWkOUTEwfNZvt11m8AhE98vuK1iNTYV8xr3e3L9h9MRDCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=g+plIkOH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=g9+FPcUGtHUPTu+7RnkMJkCX5s0s8bZFoyllSulMMCU=; b=g+plIkOHBwfFBwOAvpjtWn+Ag/
	+4euHrCao+cFGm1zCEmNeH1Y7oSy/IXdVBjtJ7s7d+1/KADd0CfOpMGYj7uYprqds4CQCKGnuXcnJ
	k4wYaxvbkME6S6VeZnX8lo9PjVo2xo0AgXaNbt9QDQ/yEoSxB8ODBpQU9O0r66axS99k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rUEwd-006Kj0-FT; Mon, 29 Jan 2024 00:52:11 +0100
Date: Mon, 29 Jan 2024 00:52:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH v3 5/5] net: phy: qcom: detach qca808x PHY
 driver from at803x
Message-ID: <0e6dd47d-3dd2-4c8f-99f7-1c3d105ddc82@lunn.ch>
References: <20240128120451.31219-1-ansuelsmth@gmail.com>
 <20240128120451.31219-6-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240128120451.31219-6-ansuelsmth@gmail.com>

On Sun, Jan 28, 2024 at 01:04:26PM +0100, Christian Marangi wrote:
> Almost all the QCA8081 PHY driver OPs are specific and only some of them
> use the generic at803x.
> 
> To make the at803x code slimmer, move all the specific qca808x regs and
> functions to a dedicated PHY driver.
> 
> Probe function and priv struct is reworked to allocate and use only the
> qca808x specific data. Unused data from at803x PHY driver are dropped
> from at803x priv struct.
> 
> Also a new Kconfig is introduced QCA808X_PHY, to compile the newly
> introduced PHY driver for QCA8081 PHY.
> 
> As the Kconfig name starts with Qualcomm the same order is kept.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

