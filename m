Return-Path: <linux-kernel+bounces-81474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D25867662
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 839D82899EA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686AD12836C;
	Mon, 26 Feb 2024 13:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KglfUhfF"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770031CFA9;
	Mon, 26 Feb 2024 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708953821; cv=none; b=uHL3UOMIQgqPvH2M1lNf1mM6n0lztxDg9ZHBDOWIfrsgNlIdxD+EMh99NbcQfqujkdYLHhsC3AByy4nKXxKJ0UcYx6WdR5Kz4DOvIi1CcfXxoMqbq50n7andSyBHybZ9lCvKR+2qgA85eQ2Ms1QgVCQa1Bi99cX+NlV441knj+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708953821; c=relaxed/simple;
	bh=FSsP/gIPNxGhuPogvvjZRJ+z4u9hWzSoEWz5moPh4EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMCR9O+euE+5D0sGdRqgZ8l2WfXhyP5R79sQoFK7IUqtBlC6F5gsOrhFyBJRMUyUuDO31sAibZoPjirzkk45KVPQQEMfIDCqDCUIGGokUJkXec1+vX0etwCrUr825/Z7yEpbTn41qQ2nw2+UUvqheOwdc05kk2glCHubPayLQBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KglfUhfF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=m/tSf7s6oMy9b/w5e5M2eW7k6sYnkwvDfWsBiPp021M=; b=Kg
	lfUhfFNbD/uo2XP4HWJqG3U9zZ1JfRKrGuWh/lAEcsrcl1TmGflONf4sc1z8+iB08sImLBd6SH2tt
	q1sd9sIcHnRqorzaGs6loyNxajtfsSnmsJhfngCg1f8IXWqozs5MklUMmOZrS47Ad14jTAlhsXNIe
	8N3urXo81ehQ6iI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1reaxB-008iyE-Vr; Mon, 26 Feb 2024 14:23:33 +0100
Date: Mon, 26 Feb 2024 14:23:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Steffen =?iso-8859-1?Q?B=E4tz?= <steffen@innosonix.de>
Cc: Fabio Estevam <festevam@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: dsa: mv88e6xxx: fix marvell 6320/21 switch
 probing
Message-ID: <bebf9512-2af9-4f55-9b1c-209045230779@lunn.ch>
References: <20240226091325.53986-1-steffen@innosonix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240226091325.53986-1-steffen@innosonix.de>

On Mon, Feb 26, 2024 at 10:13:23AM +0100, Steffen Bätz wrote:
> As of commit de5c9bf40c45 ("net: phylink: require supported_interfaces to
> be filled")
> Marvell 88e6320/21 switches fail to be probed:
> 
> ...
> mv88e6085 30be0000.ethernet-1:00: phylink: error: empty supported_interfaces
> error creating PHYLINK: -22
> ...
> 
> The problem stems from the use of mv88e6185_phylink_get_caps() to get
> the device capabilities. Create a new dedicated phylink_get_caps for the
> 6320 and 6321 to properly support their set of capabilities.
> 
> Fixes: de5c9bf40c45 ("net: phylink: require supported_interfaces to be filled")
> Signed-off-by: Steffen Bätz <steffen@innosonix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

