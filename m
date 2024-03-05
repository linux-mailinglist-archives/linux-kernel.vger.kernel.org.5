Return-Path: <linux-kernel+bounces-92705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EF1872495
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8572B272B1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFA4D2E6;
	Tue,  5 Mar 2024 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mhUL2ny0"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34F38F5B;
	Tue,  5 Mar 2024 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709657012; cv=none; b=X68p7wibkvE/hUveQ5awlHkDZLs2P/u+qKI9ncDNYr0kB+/YSKczUX/EokaDIfo7BMr4APiel/ror0uOdtgOA1cSOoGpuJw/5ucDMcu4hhM4B9xJn75cioJKllftoMmX+Ks0t+679eHWDlbfPjf0N7nukGjzQvxlVjKTFjvpdds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709657012; c=relaxed/simple;
	bh=P6nN8nYe2p11CQet9y+FM78XpoJb0cF9rQOnA6XJi5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d71LcvihVRxahcH+qQUvxdnJcbD7MzTcJ8RhRtrA/ppSEUtkGnZgFiPIur/zNKqhSKqb71U4DvXOwAF78k4aYkOPn156L7Y3lkvGUNPWw6zUbjznN7KFmGCLeDOq0HpQcuG46gs/6S3K2S56BaHSgMZkQoK9wWSLQZIhNE7x6Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mhUL2ny0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=PVFgwp/QdjijP88eb7vICgQD/i/Cph89zRHBxuPxLkQ=; b=mh
	UL2ny02+IbdPCp6v1dKZFbBjeeeQDV3sgFlQePTH9Xj1Qf5l727zlZQk/V3XqUZ9h3vfqXUS37Aq2
	kADHFM6R/J8U4GCObrUHbjmWU8PnlkVpr2vG9qt4EJbrkoFskDQSB9PQblK4sHK+FqBJ8+7mKNzmg
	ZHYTg3rHDi3vRR0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rhXtH-009RlL-BZ; Tue, 05 Mar 2024 17:43:43 +0100
Date: Tue, 5 Mar 2024 17:43:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Julien Panis <jpanis@baylibre.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v2 2/2] net: ethernet: ti: am65-cpsw: Add minimal XDP
 support
Message-ID: <ff4ba8c9-8a34-41c3-92ed-910e46e1ca99@lunn.ch>
References: <20240223-am65-cpsw-xdp-basic-v2-0-01c6caacabb6@baylibre.com>
 <20240223-am65-cpsw-xdp-basic-v2-2-01c6caacabb6@baylibre.com>
 <356f4dd4-eb0e-49fa-a9eb-4dffbe5c7e7c@lunn.ch>
 <3a5f3950-e47f-409a-b881-0c8545778b91@baylibre.com>
 <be16d069-062e-489d-b8e9-19ef3ef90029@lunn.ch>
 <f0a9524a-08cd-4ec2-89f8-4dff9dd3e09e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0a9524a-08cd-4ec2-89f8-4dff9dd3e09e@baylibre.com>

> 3) From 2), am65_cpsw_alloc_skb() function removed and replaced by
> netdev_alloc_skb_ip_align(), as used by the driver before -> res = 506
> Conclusion: Here is where the loss comes from.
> IOW, My am65_cpsw_alloc_skb() function is not good.
> 
> Initially, I mainly created this 'custom' am65_cpsw_alloc_skb() function
> because I thought that none of XDP memory models could be used along
> with netdev_alloc_skb_ip_align() function. Was I wrong ?
> By creating this custom am65_cpsw_alloc_skb(), I also wanted to handle
> the way headroom is reserved differently.

What is special about your device? Why would
netdev_alloc_skb_ip_align() not work?

	Andrew

