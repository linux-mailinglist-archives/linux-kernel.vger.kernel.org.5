Return-Path: <linux-kernel+bounces-107581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 235C787FE89
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 405D9284200
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7D78062F;
	Tue, 19 Mar 2024 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zx7C/jNz"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1413FBB9;
	Tue, 19 Mar 2024 13:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710854383; cv=none; b=jVWqLblXaKqmOPntMsbVKGd3TFnSoYEef2W7ZKs6t0wxTXZviggtJTUGX8aSn93oH0+Tm9afdrFqJWlsaWwkle/gGggQIzsFd1MXUfCZLbvXCe8cejcM4TUW1lFc6ufyitESp3r128YP+8LjdjOnZdknDLOegg3Z5dmB0d1KrSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710854383; c=relaxed/simple;
	bh=xGfGEg1NmOvDoMhIZ7MT4PvjgibSCw62ywA9sT5WeYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lheua8Y7GRwbF9TcW60lYV1rGc5Yr0+4j52RkDurCmpvs1RIKm2dQiZNVYAjvx3PO8mpW6JKbn4pu5iKvL1OLYnsOAJuXo0bPr8x9z1+xXv4JsGXyFaad0MlOZnMyKKMtvqgBZBpSviqUMDIRqdUdiatDj5bIk39/RtHjKvU9pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zx7C/jNz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eM2s0jFpcVvcghsG7scph+n4U/V5mjD2JNZH/KutU6g=; b=zx7C/jNz9btddQyTivtDBwDUVR
	wThOKRIKBW0/HQS2lbMkEAhKDJt9OMw4V/j17nNBI5cTJ2nlK+5rjQVEJSq927K8tiyb02nRnONh2
	gJzRZloQ7xupKPMbHyvXAnmJcXxt6cBbfbvUb6uz/6HfS5htJAliKZNYaw/stjpVGFvw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rmZN9-00AhnS-Kf; Tue, 19 Mar 2024 14:19:19 +0100
Date: Tue, 19 Mar 2024 14:19:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban.Veerasooran@microchip.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, Horatiu.Vultur@microchip.com,
	ruanjinjie@huawei.com, Steen.Hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v3 08/12] net: ethernet: oa_tc6: implement
 transmit path to transfer tx ethernet frames
Message-ID: <96dd422f-0bf9-411d-8cc2-5755c1e60e27@lunn.ch>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-9-Parthiban.Veerasooran@microchip.com>
 <208fb61b-4740-46bf-8c70-29ab59cbb965@lunn.ch>
 <f9d8a18c-b1fe-450c-a5ca-d91f96793a04@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9d8a18c-b1fe-450c-a5ca-d91f96793a04@microchip.com>

On Tue, Mar 19, 2024 at 12:54:30PM +0000, Parthiban.Veerasooran@microchip.com wrote:
> Hi Andrew,
> 
> On 07/03/24 10:38 pm, Andrew Lunn wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> >> @@ -55,6 +77,14 @@
> >>                                                (OA_TC6_CTRL_MAX_REGISTERS *\
> >>                                                OA_TC6_CTRL_REG_VALUE_SIZE) +\
> >>                                                OA_TC6_CTRL_IGNORED_SIZE)
> >> +#define OA_TC6_CHUNK_PAYLOAD_SIZE            64
> >> +#define OA_TC6_DATA_HEADER_SIZE                      4
> >> +#define OA_TC6_CHUNK_SIZE                    (OA_TC6_DATA_HEADER_SIZE +\
> >> +                                             OA_TC6_CHUNK_PAYLOAD_SIZE)
> >> +#define OA_TC6_TX_SKB_QUEUE_SIZE             100
> > 
> > So you keep up to 100 packets in a queue. If use assume typical MTU
> > size packets, that is 1,238,400 bits. At 10Mbps, that is 120ms of
> > traffic. That is quite a lot of latency when a high priority packet is
> > added to the tail of the queue and needs to wait for all the other
> > packets to be sent first.
> > 
> > Chunks are 64 bytes. So in practice, you only ever need two
> > packets. You need to be able to fill a chunk with the final part of
> > one packet, and the beginning of the next. So i would try using a much
> > smaller queue size. That will allow Linux queue disciplines to give
> > you the high priority packets first which you send with low latency.
> Thanks for the detailed explanation. If I understand you correctly,
> 
> 1. The tx skb queue size (OA_TC6_TX_SKB_QUEUE_SIZE) should be 2 to avoid 
> the latency when a high priority packet added.
> 
> 2. Need to implement the handling part of the below case,
> In case if one packet ends in a chunk and that chunk still having some 
> space left to accommodate some bytes from the next packet if available 
> from network layer.

This second part is clearly an optimisation. If you have lots of full
MTU packets, 1514 bytes, they take around 24 chunks. Having the last
chunk only 1/2 full does not waste too much bandwidth. But if you are
carrying lots of small packets, say voice, 130 bytes, the wasted
bandwidth starts to add up. But is there a use case for 10Mbps of
small packets? I doubt it.

So if you don't have the ability to combine two packets into one
chunk, i would do that later. Lets get the basics merged first, it can
be optimised later.

	Andrew

