Return-Path: <linux-kernel+bounces-46701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2518442E6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3562928C8C2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0069129A9B;
	Wed, 31 Jan 2024 15:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5uCE/gq6"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3C684A2E;
	Wed, 31 Jan 2024 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706714434; cv=none; b=pTfWsaWU1vsk552ZEDQ2AUrFFzNUW6iyLLEVbhQFDn4nkHspxookiRSPviHuOaRrb6Ap6JozK4A8qR9ID4glWgUdvztRpjXq65qcSfsBJ1Bw4PNmxRb/gl+WPr4Z5/okmflDWYcms+yxP0Q6Xlt9FnFaWVNr2OR2gDi4mKXdGM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706714434; c=relaxed/simple;
	bh=hSq/rS+/sj1ZW+78bBSyVTV1gAASm9SdkSgn5s0g174=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXZEDuSP3ScJt4+gw2ZB8sRd1cxD4XsZMftJgNZPVYe3ior3J7h076aQvhNA2rt+PgAtRcFLWPosT+R+8hGfRIjpbOg99J34q4ihGiePnzjmgykrJZz1byXGxKIIdYBxSgtP6KGNU7JhUDZicq+H8y4cGw8g6pBXgnuKeLLmfKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5uCE/gq6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=s8/uO8oPBYYeVJc9njQs7gJcmTyx0owNSRkWw9GXJbM=; b=5uCE/gq6EC485K0Rv0MnWkOV/G
	iMmTo4AG8zCBIPoR1TKNeXENSrNC7+uu3H/xj/Evt/w5gmwkm+C3VSKajqupXUAoVQUJyvq5YhVOo
	a5TU8xB+UG9a5wT7ysbNZ7CQeQRr1vHyvNh0NtVb2qvCAWBfPMSdnTW0hRpzmtmr4YzA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rVCO1-006apn-8H; Wed, 31 Jan 2024 16:20:25 +0100
Date: Wed, 31 Jan 2024 16:20:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 net-next 11/13] net: phy: marvell-88q2xxx: switch to
 mv88q2xxx_config_aneg
Message-ID: <5d5bd7c5-dfa8-42ac-9c89-3ec510043467@lunn.ch>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
 <20240122212848.3645785-12-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122212848.3645785-12-dima.fedrau@gmail.com>

On Mon, Jan 22, 2024 at 10:28:44PM +0100, Dimitri Fedrau wrote:
> Switch to mv88q2xxx_config_aneg for Marvell 88Q2220 devices and remove
> the mv88q222x_config_aneg function which is basically a copy of the
> mv88q2xxx_config_aneg function.
> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

