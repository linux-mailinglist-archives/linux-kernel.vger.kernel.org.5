Return-Path: <linux-kernel+bounces-46692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C26C9844300
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EE74B2D0BC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A6B84A50;
	Wed, 31 Jan 2024 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QGgSjckB"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4434E62A09;
	Wed, 31 Jan 2024 15:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706713939; cv=none; b=W75+mu7NasBzOnO/c3ijXDLSsMLYw2p0U/hhyRFff+kM8KQ1S88Vd9MDvfW6CKlMsPDUEM39I4RmI8l2t0WFrGS6uV+WvLrtNi+4Eymb2QHqMbeuY2gs9oOt+t0PsoHAC66KVdezMr5gaN9zfdkqsiSSVbDRjqG6NgWzBLJP948=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706713939; c=relaxed/simple;
	bh=nbdDlxkkF8cVjN7UUBx3gJB7l95DjikCQYsqd/qj/ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUWXcRfEiVgGEPMGdCZo+3oZJkCnrTutdoGTxQBbLvqlXrPS1/G901N1WlhsshJY0fb23IJjV/a7pR1CWT4TJxaImk+p3j2amOcVjNktY7dn+Kp1jEDB+xLu5KKG1Z3y/DwxncdM4lw9FsPNxCC1ddnT2a7FlMtY3aBecL2Bl0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QGgSjckB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HSa8UkkGFQrhJI5bAmssW8tue1PcMN3B2lq7dqK1nZw=; b=QGgSjckByHHOLBE3n5mZpKVKWf
	tb0y0/NbhOQJx3qKmQJrkHnKEZ99Jka7EkJ1/tGqNfOQwxRG/uU69bVhRfm1YfoXlTKVl7SkFkhDQ
	dhzA0Ul8qXgtF4c1Kf4CJlHnBYN7HvraZOACswHkGh/s6CZIXcV3DNX3gekTXhKaTDfw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rVCFz-006amM-Cn; Wed, 31 Jan 2024 16:12:07 +0100
Date: Wed, 31 Jan 2024 16:12:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 net-next 06/13] net: phy: marvell-88q2xxx: add
 interrupt support for link detection
Message-ID: <b9243c30-1163-4011-ab9f-16d8fa882773@lunn.ch>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
 <20240122212848.3645785-7-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122212848.3645785-7-dima.fedrau@gmail.com>

On Mon, Jan 22, 2024 at 10:28:39PM +0100, Dimitri Fedrau wrote:
> Added .config_intr and .handle_interrupt callbacks. Whenever the link
> goes up or down an interrupt will be triggered. Interrupts are configured
> separately for 100/1000BASET1.
> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

