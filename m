Return-Path: <linux-kernel+bounces-153983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4CE8AD5A9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CABEE1C20E74
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059D81553B8;
	Mon, 22 Apr 2024 20:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nxM0lyA0"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA14415532F;
	Mon, 22 Apr 2024 20:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713816515; cv=none; b=JsEjK/m4twvwgVQbPQazcI3HDQNgN6F85KJHcahKykxxbuxGoPX9Hv+UIjMjEW4xf5Plbz7+9PrafiK/SFkGmnsDs3E7bNwG4LBvFMqwKzpORpgmc9TCGHbfrAZGV/kPWsrjhBvNX8m33PMFecfT9OzPx0j/mbLFv/hJoW6pH6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713816515; c=relaxed/simple;
	bh=KaJ+NKYdo03BsBZ2eLdFmRwcG8JugyABNskGFpktxOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBrIfcXhTtbaDIqFozJfhBqiZMgw2g3eUjz2MDIuU5tbakcCWO1DTJmr9Dc/Md5DuMMwDKD+wd224RKKImeZj5DbreftK840j9KQwaXhuBYH8pZhh3TtGYK3uMXsqCDOTp7MNYxW19R27DhB0WjrhAfoyfyEFd1BgbmmZBe1zEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nxM0lyA0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BtAYhAYP1vm83aI3IXJgYBpWB+UbrPUSs9pOyPbh51o=; b=nxM0lyA0bk8GWyydokRHEbJLL/
	CV5g+r4sECy1DVu7PShcc62sqVUsD6VpTTLZy+Hz73Io2xN3YgTzFEg3rpVr0AE2GSn1fBCLx19gl
	Jo5i6KOgr/ZtliulgwpA35L6BVZs8YXcmU6ZuDub+Stasm3uSdXLGK75Eh84gaH3cLNc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ryzxf-00DeGH-7N; Mon, 22 Apr 2024 22:08:23 +0200
Date: Mon, 22 Apr 2024 22:08:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
	ruanjinjie@huawei.com, steen.hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 00/12] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Message-ID: <5f73edc0-1a25-4d03-be21-5b1aa9e933b2@lunn.ch>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>

> Testing Details:
> ----------------
> The driver performance was tested using iperf3 in the below two setups
> separately.
> 
> Setup 1:
> --------
> Node 0 - Raspberry Pi 4 with LAN8650 MAC-PHY 
> Node 1 - Raspberry Pi 4 with EVB-LAN8670-USB USB Stick
> 
> Setup 2:
> --------
> Node 0 - SAMA7G54-EK with LAN8650 MAC-PHY 
> Node 1 - Raspberry Pi 4 with EVB-LAN8670-USB USB Stick

Would it be possible to chain these two setups together by adding two
USB dongles to one of the Ri 4s? If i remember correctly, there were
reports of issues when two devices were using the framework at once.

Thanks
	Andrew

