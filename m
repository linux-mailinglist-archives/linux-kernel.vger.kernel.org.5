Return-Path: <linux-kernel+bounces-125788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7025B892C19
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 17:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26C2A1F22BE4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 16:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917873BBDB;
	Sat, 30 Mar 2024 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UVwvyipm"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513D31DFC5;
	Sat, 30 Mar 2024 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711817589; cv=none; b=qv61lceoNu0tZwEIaPVgaKqoG2H6djKyVUUUimGZw82ZQ/Ewfzm2luYqNnlqkLzK/Aub9TNxLumt3rbBZXrn2BE9uJoXEzsFGYHqc+hxi2Kjel9PGCr9DXX1Na5RBlO+6iSVYQc6gETjBAmk7TRy/OnglsJM6Y8udfL9j499/vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711817589; c=relaxed/simple;
	bh=N/kkFVF4XLvTlZanq+KnyI5NRgwQU5kEQUJVAK8hRg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyzA326XbTrgIK1qXIcuk45VCya7c9tD5k3TdLV8oEMwtOZWqAJzYBTSILYfqI0LdWBtyiQcwaElhxk6foCvziu5UbIelRWmN6EeFCmV7ReYi4S2tEUDbzY2KPh7mVdOGUGL/7RcU6nHlhLh9mq4VQp2FxLH/uAv6BLv7eOJ78M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UVwvyipm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=12mOhfEACnQyGFold5e2GlfBr4qaG6UXLXc0BoVz+8E=; b=UVwvyipmhk/X+OTKxJg4/JQEqp
	K+nxXxZgIa4ijOfK66c0HfSvKRK1uxkX7vw03Sa3g0Dj4USxCQvBrWqyOELcPeaNW1+exJg21XVM6
	t6QmvOxpf25zKVjXkM/RKhez8PWvMOpUpW/e0il1PYysSoyhMRui4UssYkfMk/gl75NY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rqbwj-00BjOd-Mp; Sat, 30 Mar 2024 17:52:45 +0100
Date: Sat, 30 Mar 2024 17:52:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Divya Koppera <Divya.Koppera@microchip.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH net] net: phy: micrel: Fix potential null pointer
 dereference
Message-ID: <9e326e82-d1a6-4058-b9e2-299817fea953@lunn.ch>
References: <20240329061631.33199-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329061631.33199-1-amishin@t-argos.ru>

On Fri, Mar 29, 2024 at 09:16:31AM +0300, Aleksandr Mishin wrote:
> In lan8814_get_sig_rx() and lan8814_get_sig_tx() ptp_parse_header() may
> return NULL as ptp_header due to abnormal packet type or corrupted packet.
> Fix this bug by adding ptp_header check.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: ece19502834d ("net: phy: micrel: 1588 support for LAN8814 phy")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

