Return-Path: <linux-kernel+bounces-82571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 297BC868676
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D74BA28D2C1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F12EAEB;
	Tue, 27 Feb 2024 01:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dK/OsA/a"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EB94C61;
	Tue, 27 Feb 2024 01:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708999079; cv=none; b=KiREwwrh2/tP+9WJKYC+K0DeEuN9clCb0coGlUvkWbk6/7w4iU8kQWN0e/dJNWfPV+FdOUvSeSnkd/wMi8DWzGWMeN++wP/PvRyEfuAuzVJ0VsjlpUOsR5XuI1Mmsgat2PWay6tBCsXTHl+LPfYkC3BWbG/tjdAQi6DkKt4AtR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708999079; c=relaxed/simple;
	bh=bmfovlKODQ8A2dBbQS7bpa+U3b0djNDXFKPKK1VxlFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwZaAiJ2shHUcrOjAhi75kpeMri575LPBmk6mGX9UUJ8/74dQICRJ8zhiLsbQBhfbHKaf6fWBC4jkeQLk9HVspA3h/Sf0Fsv+rx4GESkCkmHLpKbrtiqeh1OiY6DLQX5gxAY3eOSRXj9FF5jXHYzHCeprhEfWq5UvZ6VHaekMog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dK/OsA/a; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=DKJUCR6/peokmm2PkUIeXbzoDKYqMqCwg9yb/3qKCyo=; b=dK
	/OsA/avAGpJ0Li4TOEk4P6whUnCPRKvTPFlaj7wA8IVtfZdoc+EVvtT0uQeckiu3u9kWurf/YYgvD
	cFM3B3ZtTNFL7A/MXz0NPcjDh1TfcMJwDoiB1pgYvEpAH8fCW0aRfHNBpcekseYIcgLjREHmu1kKr
	1BWolNGW0/lwkic=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1remjS-008n4m-ND; Tue, 27 Feb 2024 02:58:10 +0100
Date: Tue, 27 Feb 2024 02:58:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	linux-kernel@vger.kernel.org, bryan.whitehead@microchip.com,
	richardcochran@gmail.com, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net 3/3] net: lan743x: Address problems with wake option
 flags configuration sequences
Message-ID: <b83b74b7-3221-4747-8b71-17738c18c042@lunn.ch>
References: <20240226080934.46003-1-Raju.Lakkaraju@microchip.com>
 <20240226080934.46003-4-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240226080934.46003-4-Raju.Lakkaraju@microchip.com>

On Mon, Feb 26, 2024 at 01:39:34PM +0530, Raju Lakkaraju wrote:
> Wake options handling has been reworked as follows:
> a. We only enable secure on magic packet when both secure and magic wol
>    options are requested together.
> b. If secure-on magic packet had been previously enabled, and a subsequent
>    command does not include it, we add it. This was done to workaround a
>    problem with the 'pm-suspend' application which is unaware of secure-on
>    magic packet being enabled and can unintentionally disable it prior to
>    putting the system into suspend.

This seems to be in a bit of a grey area. But ethtool says:

           wol p|u|m|b|a|g|s|f|d...
                  Sets  Wake-on-LAN  options.   Not  all devices support this.
                  The argument to this option is a string of characters speci‐
                  fying which options to enable.
                  p   Wake on PHY activity
                  u   Wake on unicast messages
                  m   Wake on multicast messages
                  b   Wake on broadcast messages
                  a   Wake on ARP
                  g   Wake on MagicPacket™
                  s   Enable SecureOn™ password for MagicPacket™
                  f   Wake on filter(s)
                  d   Disable (wake on  nothing).   This  option
                      clears all previous options.

d clears everything. All other things enable one option. There does
not appear to be a way to disable a single option, and i would say,
adding options is incremental.

So:

> a. We only enable secure on magic packet when both secure and magic wol
>    options are requested together.

I don't think they need to be requested together. I think you can
first enable Wake on MagicPacket and then in a second call to ethtool
Enable SecureOn password for MagicPacket. I also don't think it would
unreasonable to accept Enable SecureOn password for MagicPacket and
have that imply Wake on MagicPacket.

And:

> b. If secure-on magic packet had been previously enabled, and a subsequent
>    command does not include it, we add it.

If there has not been a d, secure-on magic packet should remain
enabled until there is a d.

	Andrew

