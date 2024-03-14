Return-Path: <linux-kernel+bounces-103265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 499B187BD31
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32C31F25471
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F33F5A11F;
	Thu, 14 Mar 2024 13:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="T6V+5qj0"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EF855C35;
	Thu, 14 Mar 2024 13:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710421325; cv=none; b=FBPC/6F2igJEbU5v42xD01qfVBGGSd0LW6KuKu1Vu4wREBWAZcyNf8OXEnl63V1zgkCon45uHaq1ow1OUn8pqKWCw5m61+hnz1Anft2Y55xY8I1IWwejHdxGaaHLGCtPo55OLot50ZYyPv9OQoWKY1Mpeg5uT3v6Y9xV4atFjps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710421325; c=relaxed/simple;
	bh=qAQB9FK88epVTyF/LeZpqM5y5+oOyaphSDCBPPScblw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fE5WO93139YKMV9SC9RcA1OdNbZH6272II5iJPXkN7jab6og4WjINCZxkZ9l8GRR+C+9JXdImW38p6vJkkIOaahKSb1Lr58qyi5LAtPlNSnzWWtEL6PYqodVZQitjrVuGWDk9PP1VF8uKabEzaKn10svztxUfJbp9d5AYuc2ge4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=T6V+5qj0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EVli0OmFTuK34nwbOdblGGUn4WUi0rrQKbNKDtrDklk=; b=T6V+5qj0xaMOJrB2glYk53Eafv
	n2/VR9Pnz79XXEteuAxtf0EDuQkLwDObzh8LzRLOh1FS4OF4dSJgvf7QgNMAnzAlaJnKDE2nvAbAE
	CWrNAPdZzrStDUQ89uzZ8VNUnVwIJLv2lIv6bHeJGUXpQmvvKhu63CuORqIqeCb3L5UU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rkkiy-00AJtH-8f; Thu, 14 Mar 2024 14:02:20 +0100
Date: Thu, 14 Mar 2024 14:02:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alexandra Diupina <adiupina@astralinux.ru>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Reichel <sre@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] net: dsa: add return value check of genphy_read_status()
Message-ID: <99631ba3-36f9-4eed-80d9-4a663ef46d80@lunn.ch>
References: <20240314063008.11214-1-adiupina@astralinux.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314063008.11214-1-adiupina@astralinux.ru>

On Thu, Mar 14, 2024 at 09:30:08AM +0300, Alexandra Diupina wrote:
> Need to check return value of genphy_read_status(),
> because higher in the call hierarchy is the
> dsa_register_switch() function,
> which is used in various drivers.

I don't understand the commit message. Why is it important to
dsa_register_switch()?

	Andrew

