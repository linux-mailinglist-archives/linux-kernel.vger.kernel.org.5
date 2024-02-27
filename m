Return-Path: <linux-kernel+bounces-84012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4C986A14E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9371E284A13
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8F714F9F2;
	Tue, 27 Feb 2024 21:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+JynnRf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8084C14F991;
	Tue, 27 Feb 2024 21:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709067705; cv=none; b=VjJC0Mr3RzA8XZsoX/2H+Dll2kB521ewsZn494RpNC//ztb04oQHGwBjtE5VnC6RaOWb0zrlYvYEsVbLtKHg2KTrc+l+OK/GKjvBp8dyd58FVNMd3nTtZjvSNagzLhPUouY2P9BX03lGayE6Cx3PvzyFMRSm3u15IRQHyYfzBtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709067705; c=relaxed/simple;
	bh=9RZq2R9Frymd/w3S8HzXoEU6qYzChWirDv0zqoRbLTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/vewCHhg2aWpa/t8AhPxQCayPqMMzXIHQ4yHowm/QkUCWu80M8/atUdC+iTN78NLkVpwlSepOWU1GM3Qt5LEmoYO/om8ZTWYaHpCMmKYgCnHAIdrIgZnF6EgDdijDvTLcyG//hwrDvjaLAj+pI5ioz5WQV0XFigykywfap2ejo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+JynnRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FD3C433C7;
	Tue, 27 Feb 2024 21:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709067705;
	bh=9RZq2R9Frymd/w3S8HzXoEU6qYzChWirDv0zqoRbLTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u+JynnRfHU57qm/IfI2DmAMzW+Z+HURn/wRIswI2yK8NtC0raFRdTiOy4qlbPax3w
	 JiI6oLi82m4D1BQ7uuvvvouZa77iboiNlYx7dHAA7iAu6uBn9DQlZtepRQTo6mIIuw
	 3bu9ckYS/wr4aBGPpBKZGyzLUGRFuIuOl/Fa5JeE6Q+uILukCpgGZxZAIZRpGTSfVP
	 wsGp6WhCOBdTRian9eSDB5y1gxI+ChqHkbQhsarVwzUWmWm1X+laByAiGFtC+Fo+2r
	 76GHln3XjVUrCOOJDjj8orK0KjQAK8Uzm4VHZp38d3cFG9irPXxNSBbQe50E2DPb5O
	 zGFPMDzAym6lw==
Date: Tue, 27 Feb 2024 21:01:40 +0000
From: Simon Horman <horms@kernel.org>
To: Piotr Wejman <piotrwejman90@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: stmmac: fix rx queue priority assignment
Message-ID: <20240227210140.GP277116@kernel.org>
References: <20240226093144.31965-1-piotrwejman90@gmail.com>
 <20240227170012.GC277116@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227170012.GC277116@kernel.org>

On Tue, Feb 27, 2024 at 05:00:12PM +0000, Simon Horman wrote:
> On Mon, Feb 26, 2024 at 10:31:44AM +0100, Piotr Wejman wrote:
> > The driver should ensure that same priority is not mapped to multiple
> > rx queues. Currently rx_queue_priority() function is adding
> > priorities for a queue without clearing them from others.
> > 
> > >From DesignWare Cores Ethernet Quality-of-Service
> > Databook, section 17.1.29 MAC_RxQ_Ctrl2:
> > "[...]The software must ensure that the content of this field is
> > mutually exclusive to the PSRQ fields for other queues, that is,
> > the same priority is not mapped to multiple Rx queues[...]"
> > 
> > After this patch, rx_queue_priority() function will:
> > - assign desired priorities to a queue
> > - remove those priorities from all other queues
> > The write sequence of CTRL2 and CTRL3 registers is done in the way to
> > ensure this order.
> > 
> > Signed-off-by: Piotr Wejman <piotrwejman90@gmail.com>
> > ---
> > Changes in v2:
> >   - Add some comments
> >   - Apply same changes to dwxgmac2_rx_queue_prio()
> >   - Revert "Rename prio argument to prio_mask"
> >   - Link to v1: https://lore.kernel.org/netdev/20240219102405.32015-1-piotrwejman90@gmail.com/T/#u
> > 
> >  .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 42 +++++++++++++++----
> >  .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 40 ++++++++++++++----
> >  2 files changed, 66 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> > index 6b6d0de09619..76ec0c1da250 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> > @@ -92,19 +92,43 @@ static void dwmac4_rx_queue_priority(struct mac_device_info *hw,
> >  				     u32 prio, u32 queue)
> >  {
> >  	void __iomem *ioaddr = hw->pcsr;
> > -	u32 base_register;
> > -	u32 value;
> > +	u32 clear_mask = 0;
> > +	u32 ctrl2, ctrl3;
> > +	int i;
> >  
> > -	base_register = (queue < 4) ? GMAC_RXQ_CTRL2 : GMAC_RXQ_CTRL3;
> > -	if (queue >= 4)
> > -		queue -= 4;
> > +	ctrl2 = readl(ioaddr + GMAC_RXQ_CTRL2);
> > +	ctrl3 = readl(ioaddr + GMAC_RXQ_CTRL3);
> > +	
> > +	/* The software must ensure that the same priority
> > +	 * is not mapped to multiple Rx queues.
> > +	 */
> > +	for (i = 0; i < 4; i++)
> > +		clear_mask |= ((prio << GMAC_RXQCTRL_PSRQX_SHIFT(i)) &
> > +						GMAC_RXQCTRL_PSRQX_MASK(i));
> >  
> > -	value = readl(ioaddr + base_register);
> > +	ctrl2 &= ~clear_mask;
> > +	ctrl3 &= ~clear_mask;
> >  
> > -	value &= ~GMAC_RXQCTRL_PSRQX_MASK(queue);
> > -	value |= (prio << GMAC_RXQCTRL_PSRQX_SHIFT(queue)) &
> > +	/* Assign new priorities to a queue and
> > +	 * clear them from others queues.
> > +	 * The CTRL2 and CTRL3 registers write sequence is done
> > +	 * in the way to ensure this order.
> > +	 */
> > +	if (queue < 4) {
> > +		ctrl2 |= (prio << GMAC_RXQCTRL_PSRQX_SHIFT(queue)) &
> >  						GMAC_RXQCTRL_PSRQX_MASK(queue);
> > -	writel(value, ioaddr + base_register);
> > +
> > +		writel(ctrl2, ioaddr + GMAC_RXQ_CTRL2);
> > +		writel(ctrl3, ioaddr + GMAC_RXQ_CTRL3);
> > +	} else {
> > +		queue -= 4;
> > +
> > +		ctrl3 |= (prio << GMAC_RXQCTRL_PSRQX_SHIFT(queue)) &
> > +						GMAC_RXQCTRL_PSRQX_MASK(queue);
> > +
> > +		writel(ctrl3, ioaddr + GMAC_RXQ_CTRL3);
> > +		writel(ctrl2, ioaddr + GMAC_RXQ_CTRL2);
> > +	}
> >  }
> 
> Hi Piotr,
> 
> Sorry if I am on the wrong track here, but this seems a little odd to me.
> 
> My reading is that each byte of GMAC_RXQ_CTRL2 and GMAC_RXQ_CTRL3
> hold the priority value - an integer in the range of 0-255 - for
> each of 8 queues.

Thinking about this some more, and checking the code some more, I realise I
am wrong here. I now see that the priority values are bit-fields not
integers. So I think what you have is fine.

Sorry about the noise.

