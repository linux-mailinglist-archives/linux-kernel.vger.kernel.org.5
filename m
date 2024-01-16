Return-Path: <linux-kernel+bounces-28375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 588F782FDBB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 00:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7B401F27F37
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FC967C61;
	Tue, 16 Jan 2024 23:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vv+0GgSa"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115FF67C54;
	Tue, 16 Jan 2024 23:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705447298; cv=none; b=NFg7aJZTidNZ2zcgYAI4fOZDtYyIZWmqIrARA4/FRkiVCP9wUTPu+i+Ttn/vZZazLanGXfqrVF/qKT2LfxVmcFL2Ix+E7c3aa/Egf12iBMYThPirzjP2cbVMiXxOa+E1ze3yF4MaDEhP4LX8o+KEWH2gxt7p0OZqj/hMfWE20IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705447298; c=relaxed/simple;
	bh=dqVyFBZEyz6eyoIIxKAAeMr8tIwXW4vzy/OcdF9P470=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=Mtp2RiAmebjqZvDvDzMUZcoksIIQ2HlYlMJIwWPgxvMkMycXFa20G9ro61M0UPBAbEoJhQZ19qAQJ9B0MJRn+YphrrK5rEGfzLnJQHGA+btaO6oDZXtztbWPaEDA9PX9XVPwWcx4wvruEDt63Vm+QM0JaxIo0dmVcy6+3a0Av0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vv+0GgSa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ys+BRocRaSfqSlTq8ygwsRyVjvYBvlkbZzx4GJg0Guo=; b=vv+0GgSaEPVrB7KP9yAoX/g8Ip
	d4TksbqqwZd2Y45PSAh1mSF9gI11uSIWDhhAQVLYxLPsX1kbnLCIb1q3Ik5Op5CqFJjCtt9IE7VYM
	+Zuo28wEXINBKHipCWC8Ut/6Il27kD4jHZzohxoFbLJl4BhK/RZkQ2FVi1EpR0nJi6CM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rPskJ-005MZE-KR; Wed, 17 Jan 2024 00:21:27 +0100
Date: Wed, 17 Jan 2024 00:21:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tim Menninger <tmenninger@purestorage.com>
Cc: f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: mv88e6xxx: Make *_c45 callbacks agree with
 phy_*_c45 callbacks
Message-ID: <da87ce82-7337-4be4-a2af-bd2136626c56@lunn.ch>
References: <20240116193542.711482-1-tmenninger@purestorage.com>
 <04d22048-737a-4281-a43f-b125ebe0c896@lunn.ch>
 <CAO-L_44YVi0HDk4gC9QijMZrYNGoKtfH7qsXOwtDwM4VrFRDHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO-L_44YVi0HDk4gC9QijMZrYNGoKtfH7qsXOwtDwM4VrFRDHw@mail.gmail.com>

> Hi Andrew,
> 
> It bubbles up as EIO (the translation happens in get_phy_c45_ids when
> get_phy_c45_devs_in_pkg fails) and ultimately causes the probe to fail.
> 
> The EIO causes the scan to stop and fail immediately - the way I read
> mdiobus_scan_bus_c45, only ENODEV is permissible.

O.K. At minimum, this should be added to the commit message.

However, i'm wondering if this is the correct fix. I would prefer that
the scan code just acts on the -EOPNOTSUPP the same was as
-ENODEV. Maybe the error code from phy_c45_probe_present() should be
returned as is. And mdiobus_scan_bus_c45() is extended to handle
-EOPNOTSUPP ?

	    Andrew

