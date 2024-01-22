Return-Path: <linux-kernel+bounces-33158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F427836563
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8269D1C22399
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14FC3D558;
	Mon, 22 Jan 2024 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JW4dmjn1"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648B93D547;
	Mon, 22 Jan 2024 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705933830; cv=none; b=Wm1B90zE9Tpx26MhX6Wv+w8EofJs2KOw8bDuWWTYnc1LQ9rxV42TofqipxJGWDhqnA83MQCXMyVucY9xPvX3VKLUvxGT3/4WmCUYBWOlo1/4hjxh275rSpr9cUU0dmlmuiJlrG0a2WcR1uPznrQBQqXRD4872ttIAqf7NkZd1AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705933830; c=relaxed/simple;
	bh=dgLOf7Khtp+J1XhVD9pejnsi3nX98vVH3ivdZpsrJpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJ15Qa4Din+FKgsAjpz7ATcsKqNsHsXXl7dA+DP+8CzbbEotDmEQfeYwvbAxNzhMGIkqJFQSOpoklVklgl+Fyv79q0QPs1lh2DwVFZKsuJIv/Fbsn6pp7fhSudTHYWMch3rd0gpc3gc98v5b6CRPddu7gFgzVBVAutEkC1/Wxcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JW4dmjn1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bzd1tg+vrjBmxQsgnC2fRQKVGdqRO1+ttiHgoPg/H0U=; b=JW4dmjn1facfKbazaZTJYnNKja
	VcChOwN1+nCfU6NLMutlzGzDgJXeThJaQ2AtgLGlYFETZ8+MK/poMXdnjJqemHlH8rAyoLovErOmw
	TcLT9woB8Qn++eGFlqUefMV43EZzCOpcDhJ1EnLIu8eWLlUnPLz5yLM3lDvuR4HyIKgY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rRvJc-005jNn-BL; Mon, 22 Jan 2024 15:30:20 +0100
Date: Mon, 22 Jan 2024 15:30:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Tim Menninger <tmenninger@purestorage.com>, f.fainelli@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: mv88e6xxx: Make *_c45 callbacks agree with
 phy_*_c45 callbacks
Message-ID: <1aab2398-2fe9-40b6-aa5b-34dde946668a@lunn.ch>
References: <20240116193542.711482-1-tmenninger@purestorage.com>
 <04d22048-737a-4281-a43f-b125ebe0c896@lunn.ch>
 <CAO-L_44YVi0HDk4gC9QijMZrYNGoKtfH7qsXOwtDwM4VrFRDHw@mail.gmail.com>
 <da87ce82-7337-4be4-a2af-bd2136626c56@lunn.ch>
 <CAO-L_46kqBrDdYP7p3He0cBF1OP7TJKnhYK1NR_gMZf2n_928A@mail.gmail.com>
 <20240122123349.cxx2i2kzrhuqnasp@skbuf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122123349.cxx2i2kzrhuqnasp@skbuf>

On Mon, Jan 22, 2024 at 02:33:49PM +0200, Vladimir Oltean wrote:
> On Tue, Jan 16, 2024 at 05:51:13PM -0800, Tim Menninger wrote:
> > My impression is still that the read_c45 function should agree with the
> > phy_read_c45 function, but that isn't a hill I care to die on if you still
> > think otherwise. Thoughts?
> 
> FWIW, Tim's approach is consistent with what drivers/net/mdio/mdio-mux.c does.
> 
> 		if (parent_bus->read)
> 			cb->mii_bus->read = mdio_mux_read;
> 		if (parent_bus->write)
> 			cb->mii_bus->write = mdio_mux_write;
> 		if (parent_bus->read_c45)
> 			cb->mii_bus->read_c45 = mdio_mux_read_c45;
> 		if (parent_bus->write_c45)
> 			cb->mii_bus->write_c45 = mdio_mux_write_c45;
> 
> My only objection to his patch (apart from the commit message which
> should indeed be more detailed) is that I would have preferred the same
> "if" syntax rather than the use of a ternary operator with NULL.

I agree it could be fixed this way. But what i don't like about the
current code is how C22 and C45 do different things with error
codes. Since the current code is trying to use an error code, i would
prefer to fix that error code handling, rather than swap to a
different way to indicate its not supported.

	  Andrew

