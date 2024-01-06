Return-Path: <linux-kernel+bounces-18673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 121F18260D6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 18:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1691F22193
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 17:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DDEC2C4;
	Sat,  6 Jan 2024 17:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QA7wa8jY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A065883B;
	Sat,  6 Jan 2024 17:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dPhfKVwequCMnYA34M18ravxgkggHOtfFd2lzVGsLBI=; b=QA7wa8jYyoMtu+bjotQg0Zsdsm
	IKilQpNxkJwQhZO8USBTx/egJpLnmfubJlWXjMK5ICvLiO8y4nEawNSVeT/O1LxJqEaUIHBMJDXMb
	MUEgkF3u55xxBtZweGb2ZnJ9OW/+1pW+n9fUj/+6fzFKJbiz+osQOH79C9OOgkXZ3LBs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rMA8V-004X2M-8v; Sat, 06 Jan 2024 18:07:03 +0100
Date: Sat, 6 Jan 2024 18:07:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Petr Tesarik <petr@tesarici.cz>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	"open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: fix ethtool per-queue  statistics
Message-ID: <878c4ac5-66fa-4ddc-95af-ad40fab11c9c@lunn.ch>
References: <20240105201642.30904-1-petr@tesarici.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105201642.30904-1-petr@tesarici.cz>

On Fri, Jan 05, 2024 at 09:16:42PM +0100, Petr Tesarik wrote:
> Fix per-queue statistics for devices with more than one queue.
> 
> The output data pointer is currently reset in each loop iteration,
> effectively summing all queue statistics in the first four u64 values.
> 
> The summary values are not even labeled correctly. For example, if eth0 has
> 2 queues, ethtool -S eth0 shows:
> 
>      q0_tx_pkt_n: 374 (actually tx_pkt_n over all queues)
>      q0_tx_irq_n: 23  (actually tx_normal_irq_n over all queues)
>      q1_tx_pkt_n: 462 (actually rx_pkt_n over all queues)
>      q1_tx_irq_n: 446 (actually rx_normal_irq_n over all queues)
>      q0_rx_pkt_n: 0
>      q0_rx_irq_n: 0
>      q1_rx_pkt_n: 0
>      q1_rx_irq_n: 0
> 
> Fixes: 133466c3bbe1 ("net: stmmac: use per-queue 64 bit statistics where necessary")
> Cc: stable@vger.kernel.org
> Signed-off-by: Petr Tesarik <petr@tesarici.cz>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

