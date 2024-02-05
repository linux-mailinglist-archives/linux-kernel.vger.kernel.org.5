Return-Path: <linux-kernel+bounces-52781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE500849C9F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 686A0B263E9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7C924B21;
	Mon,  5 Feb 2024 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nDbBw276"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911DF28E02;
	Mon,  5 Feb 2024 14:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141993; cv=none; b=LTg9NexrOx2D4H16UHzpAzZy17IAWwZi3VlvgciNFhl8Vq47NdCS04/0WFWUSnBz5v6Bvg47m9JQHwBXr99LH4kzBhXef8t9q1yaJzfYdd0aqmXA3g3pLIwMzXf3AI2XPPBJONXLtoDjEno3F1T4FKahIji20PLBPx1nqnn6ZVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141993; c=relaxed/simple;
	bh=5qMUD4dTYuI6O98Rc3M142Ern5BGZyX9AE+gsv3796A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8fpH38srbc433sRbKVRzr71S8SlYlL6AXwP6cNtX2tQYsU52FRiVHVKg10Q+Dgsbn9j5YdfvppM7xZr1fuPzByVy4lDiWrASWTdRCqfD9AzZFoScqpmcg8EjWf3OdEKYRymfoMu8j5yQr7KbL6CkI78zelIPM9J/+081z23Ojg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nDbBw276; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=71XWms3GvCBYYvDyFyU6yaDWv9guXgKO7FOUNQLBf/Q=; b=nDbBw2761ggfrEoleFE0Zz1rgs
	YXVzaJ7zlgP0/wHp4P2y9Y/IiCHsNLDiQuzToli/u+NCfNAbL6PdCk3YNhE7HHV/r4nbAGbrX4nl7
	Wr9FjHcNpO8v7gzyJD5YL1w1m7c6uAY4yZRFYVeUEvDab8bdOBkpBFIqf4m6IqTU72tg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rWzbz-0072LD-6w; Mon, 05 Feb 2024 15:06:15 +0100
Date: Mon, 5 Feb 2024 15:06:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Ventura <david@davidv.dev>
Cc: Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Xiongwei Song <xiongwei.song@windriver.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] net: make driver settling time configurable
Message-ID: <1e08910b-8ae2-4985-8423-45a1a823cefc@lunn.ch>
References: <20240205114609.440597-1-david@davidv.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205114609.440597-1-david@davidv.dev>

On Mon, Feb 05, 2024 at 12:44:40PM +0100, David Ventura wrote:
> During IP auto configuration, some drivers apparently need to wait a
> certain length of time to settle; as this is not true for all drivers,
> make this length of time configurable.

Do you see this problem with multiple drivers, or just one in
particular. To me this seems like a driver bug, and you are just
papering over the cracks.

	Andrew

