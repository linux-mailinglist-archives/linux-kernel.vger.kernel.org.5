Return-Path: <linux-kernel+bounces-130790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A72897D23
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8AC0B23A8B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1B24C97;
	Thu,  4 Apr 2024 00:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShYd/I9m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214334400;
	Thu,  4 Apr 2024 00:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712191329; cv=none; b=TtlvZwmMZKH4TAX++rDfwj78EWNRQjdItWSH7NHtSlA+g/+ulf1f81SCDrMMSckGVmKYqf/tOcGDmkTEYc2S+X1XwvTC7Sia84IgQ3mjrsAOW2Laf6D9p4PCoO5q2V62lCGmP+cCd0kmLqZCb6/42C8AVWSUSB/8G0vJ4D9Q00I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712191329; c=relaxed/simple;
	bh=D3jepi0zJ72xuRUzY0zYzN1f9UFpgiWhtB98tF6EXB0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FR1e7p0nQoCNWP26ZVwlVkPA3lUDW+UB5P1GtUM67hEC7mcMUkipdNNSwj87iih6tQegNwfuho0Azsx6N8r0Tf4thERjarEu1LiYu7Sl5inRvqW1TXoHtkG6pyNJH+DmcbYq9M/wniLdG9xIU2uyOJP2p+Otr9P/S/+I3aqLHZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShYd/I9m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FB6C433C7;
	Thu,  4 Apr 2024 00:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712191328;
	bh=D3jepi0zJ72xuRUzY0zYzN1f9UFpgiWhtB98tF6EXB0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ShYd/I9m2URUu0tlaxxk4WyWjJKgKXJ/4m8hRncP4yC/s7wnUoILOAP2kTBi6lX2n
	 5Qc5K4rpsr1BoFU4tsXpQ5NlpMTArIp96x3btM+/HkPEFqlsviC8em784f+IVwe1nM
	 MWCGmieyLFP361y+YypfCUa9Tklp1iS0V+HSoQCw0JKvkUnQOt3Q16MXoyJnLXcKgR
	 GexugvlF7GUD2gArHBV4d/gSwQy9VMK4kiYjQdfj7cFRne2l7BDgxBIKqOzNpMRGn+
	 s1piLHXEK7Vdnp9xXavg5Twc7iXubNBn46Aj1Pig0hXdogegPXXhL8fLSwM2kUssHO
	 x6+vIMKTlM8UQ==
Date: Wed, 3 Apr 2024 17:42:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean
 <olteanv@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Arun Ramadoss
 <arun.ramadoss@microchip.com>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com, David Ahern <dsahern@kernel.org>, Simon
 Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 =?UTF-8?B?U8O4cmVu?= Andersen <san@skov.dk>
Subject: Re: [PATCH net-next v2 5/9] net: dsa: microchip: add support for
 different DCB app configurations
Message-ID: <20240403174207.34205b6a@kernel.org>
In-Reply-To: <20240403092905.2107522-6-o.rempel@pengutronix.de>
References: <20240403092905.2107522-1-o.rempel@pengutronix.de>
	<20240403092905.2107522-6-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Apr 2024 11:29:01 +0200 Oleksij Rempel wrote:
> Add DCB support to configure app trust sources and default port priority.
> 
> Following commands can be used for testing:
> dcb apptrust set dev lan1 order pcp dscp
> dcb app replace dev lan1 default-prio 3
> 
> Since it is not possible to configure DSCP-Prio mapping per port, this
> patch provide only ability to read switch global dscp-prio mapping and
> way to enable/disable app trust for DSCP.

transient compiler nit:

drivers/net/dsa/microchip/ksz_dcb.c:86:17: warning: unused variable 'ksz8_port2_supported_apptrust' [-Wunused-const-variable]
   86 | static const u8 ksz8_port2_supported_apptrust[] = {
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

