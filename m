Return-Path: <linux-kernel+bounces-42834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F2B84076F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93FEF2828C5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37674657C3;
	Mon, 29 Jan 2024 13:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aO8TH4yS"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945B1657AF;
	Mon, 29 Jan 2024 13:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706536302; cv=none; b=ZW3GMOiubCDr7w4bmRv5/6NXUJXppoiRDTQnyG0uPr4wSDjaZyR0qM1MXM7ahb+PIUw7O2Ek0lGSJdHVlDvTSCWMohlCn5aKif/+Bc7jZHkJiNFr3fk3R+FqwCE2gjqQ4bgGG/MIbQka967hHyELXGy3YGG7M+fF1667nRL6lec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706536302; c=relaxed/simple;
	bh=jPBzSDJorMXrEmr1VgABmaFqEILts+b/SHP6BEDaQeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHLeWSENxGoqatqqCfXE8OiOsCWlX+lq4l821ETXBcp39EzhXYGg/1YvJpu1k/5/kuNzo7QMTjDHxnuBxx8CuPurgmyZc3Hu0GHmyHdhiIOYi7Q0yfTjq/N527TRmkZC0BNmSkC0c+b1oDtrdH3i4ZVNR5vXAfMo2Xosa42cQ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aO8TH4yS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Z98X2Dv/gFHdwMZq84R2/WmZ935wMrTZ5Sxl3bVWePg=; b=aO8TH4ySmVxbUrRdjSZ0f0FdgQ
	pEXvay/NZkuMzYUZavwBXpyGeUiJ5/N2MTudAeouPgZUWOcecoT3PbxsiF1vmLb5d4etqBCOMwKeD
	hCeyOQWs0cS8LW2Xmt1S/V3WH3mWmjOf10iZbDwgMiODZ81LqZIa8ZBvq9d85lnNgYVQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rUS2o-006NrQ-EG; Mon, 29 Jan 2024 14:51:26 +0100
Date: Mon, 29 Jan 2024 14:51:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Clark Wang <xiaoning.wang@nxp.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-imx@nxp.com, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: dwmac-imx: add clock input support in RMII
 mode
Message-ID: <f11b9162-2b77-413b-8158-ee46c1602bd3@lunn.ch>
References: <20240126024433.2928223-1-xiaoning.wang@nxp.com>
 <20240126024433.2928223-2-xiaoning.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126024433.2928223-2-xiaoning.wang@nxp.com>

On Fri, Jan 26, 2024 at 10:44:33AM +0800, Clark Wang wrote:
> In RMII mode, the default setting is using the 50MHz reference clock
> from SoC. The ref_clk pin is output.
> If users want to use external or PHY to provide the 50MHz ref clock,
> it needs to config the GPR register.
> So, add the code to config GPR register to support the clock input.

Hi Clark

You have this threaded to the previous email. That previous email is a
fix, where are this is development of a new feature. So please don't
thread them. Please take a read of:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

You need different Subject lines to indicate which tree these patches
should be applied to.

> 
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Reviewed-by: Wei Fang <wei.fang@nxp.com>

Signed-of-by comes last.


    Andrew

---
pw-bot: cr

