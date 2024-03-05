Return-Path: <linux-kernel+bounces-92436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1FA872021
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF6791C23881
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D77D85C77;
	Tue,  5 Mar 2024 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fcCvJcgA"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF7D43AB0;
	Tue,  5 Mar 2024 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709645321; cv=none; b=iQG/ovB2lVZk0N5rIwWF0IudaiuqE8rt/oxdm8XcwTyT5kVcK8Ly12E6rgC8smZYs1wlCxVqUNoaudxjJHrne/RhCmf+6QnKpognuTc1DgUVXQ0AY7QzPCVflrjJmIc32Ww0dVDMnMgkZDu48pGueTGTtvG5HHGAjBwmX8HoLvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709645321; c=relaxed/simple;
	bh=9nHBU801rt03QXGVs4K6yWHFgU//kmL7q1mSOjCjtSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWqqNaeOQly6QjYj9M5M/lkkTZN2WDpbVpCeMy5to7yjHww8nVlsYl5s6eznTonBNl60vr0wTtYaDwCyetmhgcLPy6QeUkyb3/FphHvs2TyYrE9C6pEqC5VoAb3c1itQhYy/dKq8ykbg9zlqaoCzRZX70hcvUQkZmtPzMeZqRMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fcCvJcgA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2o5mFGZCvQCk7WKP/xRNSu+/KpBgcWlkfRQoWTuInbY=; b=fcCvJcgAkcMcQFOc4nYDR/Yzhv
	Y8IiVBCtwKjUMpOh02072azemJ8Sb6tC/SVw+f74ahwPgdczkKF8WJ9UMCYkcOVxYnaoVgZ6Z3Jwt
	iiS6/PoKPPutlUHIT5TpgkIpdugZ8H0BsYpd3BejSVa4AjBYvnRK+kDjUeDZosHHJi3Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rhUqi-009Qae-FR; Tue, 05 Mar 2024 14:28:52 +0100
Date: Tue, 5 Mar 2024 14:28:52 +0100
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
Message-ID: <be16d069-062e-489d-b8e9-19ef3ef90029@lunn.ch>
References: <20240223-am65-cpsw-xdp-basic-v2-0-01c6caacabb6@baylibre.com>
 <20240223-am65-cpsw-xdp-basic-v2-2-01c6caacabb6@baylibre.com>
 <356f4dd4-eb0e-49fa-a9eb-4dffbe5c7e7c@lunn.ch>
 <3a5f3950-e47f-409a-b881-0c8545778b91@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a5f3950-e47f-409a-b881-0c8545778b91@baylibre.com>

On Tue, Mar 05, 2024 at 11:46:00AM +0100, Julien Panis wrote:
> On 3/1/24 17:38, Andrew Lunn wrote:
> > On Fri, Mar 01, 2024 at 04:02:53PM +0100, Julien Panis wrote:
> > > This patch adds XDP (eXpress Data Path) support to TI AM65 CPSW
> > > Ethernet driver. The following features are implemented:
> > > - NETDEV_XDP_ACT_BASIC (XDP_PASS, XDP_TX, XDP_DROP, XDP_ABORTED)
> > > - NETDEV_XDP_ACT_REDIRECT (XDP_REDIRECT)
> > > - NETDEV_XDP_ACT_NDO_XMIT (ndo_xdp_xmit callback)
> > > 
> > > The page pool memory model is used to get better performance.
> > Do you have any benchmark numbers? It should help with none XDP
> > traffic as well. So maybe iperf numbers before and after?
> > 
> > 	Andrew
> 
> Argh...Houston, we have a problem. I checked my v3, which is ready for
> submission, with iperf3:
> 1) Before = without page pool -> 500 MBits/sec
> 2) After = with page pool -> 442 MBits/sec
> -> ~ 10% worse with page pool here.
> 
> Unless the difference is not due to page pool. Maybe there's something else
> which is not good in my patch. I'm going to send the v3 which uses page pool,
> hopefully someone will find out something suspicious. Meanwhile, I'll carry on
> investigating: I'll check the results with my patch, by removing only the using of
> page pool.

You can also go the other way. First add page pool support. For the
FEC, that improved its performance. Then add XDP, which i think
decreased the performance a little. It is extra processing in the hot
path, so a little loss is not unsurprising.

What tends to be expensive with ARM is cache invalidation and
flush. So make sure you have the lengths correct. You don't want to
operate on more memory than necessary. No point flushing the full MTU
for a 64 byte TCP ACK, etc.

      Andrew

