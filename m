Return-Path: <linux-kernel+bounces-46699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A375A8442DE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64AB1C2249B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37BE86ADE;
	Wed, 31 Jan 2024 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="X9ZQmHcB"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27C184A4E;
	Wed, 31 Jan 2024 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706714400; cv=none; b=BCRDT8AHR7hFPE2pwNG9CgFNQIT+aOU96HQuRWjjo9+f9pq6kTWyzRmMs7ofO01OLaVAC16i79k6y2/mbfCsj2PXwuRgUCVaw8hZb7tQIBQ3zT5LRE/Of8yugBxD72tNQkMMOhSQMpm50hgM0guOrVANl9t66ZpKzaywOLwMCRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706714400; c=relaxed/simple;
	bh=zraZ4GAWYd3k1nTN/PDgHLRPmEqVILITkc+KhQpafPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSPEoZ8RWfPZikgOOgF0DxtmCgeQJuVuVixuEkmXBshCqXTH9hFiagklHaTF70ZTeRU7FJq96Odb3Zb1w4J3zjxG/IjICuqg/B8hMqUvSBnGQse/tXG8cf3S+6tedW8rJErxIbEfLcuTQXrCNMKklaLl4vDuvQU7veZxNKL5mEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=X9ZQmHcB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KgQbi6lyjFW5qirmbLoeKbLsIIOOKokmJfR24WR5lg0=; b=X9ZQmHcBVoKAYlIjjw+sYEBzyB
	2ACdNbkF9Hd0P/VS6B72nC8Gr5DvavMKEvsGhAVx4M4Gv/ZL/jbiDL/0MbXL2Z1fsj3sp85kADzln
	VGRkA9SfrfPpRqDGMUCHJJ13AJml/POrk5rGp1p44PdTipetUPmYqBdzK16R52a6+JgA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rVCNS-006ap9-HN; Wed, 31 Jan 2024 16:19:50 +0100
Date: Wed, 31 Jan 2024 16:19:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 net-next 10/13] net: phy: marvell-88q2xxx: make
 mv88q2xxx_config_aneg generic
Message-ID: <d640fd10-e2b7-4a56-956d-d37dc73f01bb@lunn.ch>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
 <20240122212848.3645785-11-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122212848.3645785-11-dima.fedrau@gmail.com>

On Mon, Jan 22, 2024 at 10:28:43PM +0100, Dimitri Fedrau wrote:
> Marvell 88Q2xxx devices follow the same scheme, after configuration they
> need a soft reset. Soft resets differ between devices, so we use the
> .soft_reset callback instead of creating .config_aneg callbacks for each
> device.
> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

