Return-Path: <linux-kernel+bounces-82439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B88D8868497
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ECBFB21889
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8306135A5C;
	Mon, 26 Feb 2024 23:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LIHF3bBM"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F363A130AC0;
	Mon, 26 Feb 2024 23:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708989978; cv=none; b=TFm2UqnP843nRSONSJ+azCILgZFoEZQgDmJkImZT/6Wkl4lSmCHWGTAsw0NcI/1ryvmM82HJVrDV3uuH5QErmUB+ZwXPvnMcDhr5izqjScgEBc0V6oXwiopvBeAP9RGrkzizGwRAfhNQ4RaZvqaJs0BFNC8cnAuJHuB6mrdvjIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708989978; c=relaxed/simple;
	bh=k6DsSpNh48Sd/XTDGAsFs3Ij13eGd9dXlcEZK7NCcl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apO5XJI+rtBw4EdW4bXhWT3d6BCgaEwY6iXCuWN/AvxNz33V2mXq97LYQ9OPp2kZxsuQKENb8pbINNiWbV7GJxR9SWyceoeWDJyhirtXdavFihoK7X1FQ1bQRGJKqiCgcGaukRzjXhpM0v5B+qW1k+SaiM00GtPl81WBrZohU5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LIHF3bBM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lDGfX7QPvoDkuIo+WuAjkIkZrjlZ9yTRhPTHLDxVAds=; b=LIHF3bBMRfOQlc5fVQGIwwJ0GV
	4rvPz5JEchvi7d9hx2tTNLf0he47NxOHgW0WLpU6hO9yEAD27sut4KCS4xtf83EZjQJH/HVdVFkVg
	DqUJKnpHXTPzVBh97AquaRKladJqWL6PSLUWrGcPdATt47lNuTLqdFZroOxNUUB3urE8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rekMQ-008lth-VT; Tue, 27 Feb 2024 00:26:14 +0100
Date: Tue, 27 Feb 2024 00:26:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ciprian Regus <ciprian.regus@analog.com>
Cc: linux-kernel@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	Dell Jin <dell.jin.code@outlook.com>, netdev@vger.kernel.org
Subject: Re: [net-next v2] net: ethernet: adi: adin1110: Reduce the
 MDIO_TRDONE poll interval
Message-ID: <aaf490d5-e903-4638-9a7e-ab273b81df5e@lunn.ch>
References: <20240223162129.154114-1-ciprian.regus@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223162129.154114-1-ciprian.regus@analog.com>

On Fri, Feb 23, 2024 at 06:21:27PM +0200, Ciprian Regus wrote:
> In order to do a clause 22 access to the PHY registers of the ADIN1110,
> we have to write the MDIO frame to the ADIN1110_MDIOACC register, and
> then poll the MDIO_TRDONE bit (for a 1) in the same register. The
> device will set this bit to 1 once the internal MDIO transaction is
> done. In practice, this bit takes ~50 - 60 us to be set.
> 
> The first attempt to poll the bit is right after the ADIN1110_MDIOACC
> register is written, so it will always be read as 0. The next check will
> only be done after 10 ms, which will result in the MDIO transactions
> taking a long time to complete. Reduce this polling interval to 100 us.
> Since this interval is short enough, switch the poll function to
> readx_poll_timeout_atomic() instead.
> 
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

