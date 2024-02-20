Return-Path: <linux-kernel+bounces-72894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E5F85BA4C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66F85B237A9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D73E67A19;
	Tue, 20 Feb 2024 11:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJ4U8sCe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E48566B5E;
	Tue, 20 Feb 2024 11:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708428091; cv=none; b=D/v+kA4tHzN86vOjAMAXQHFinl61imqJeVVciQg9tl6JvdSiW0k3KgliJGgWD2tWlEzDn+Ql7bnymts+Wt9mvjvuQxsfpf9YXputs9maWjpNsTvB49+Cdb8qviT/H4qr2pJECKHwq7KxM9eg9+CoEOi7nspQl+JsVohYpOSpdkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708428091; c=relaxed/simple;
	bh=M58MZcQaPOao7iwprIie+9OLC12Mm/dqk+jYeODJ+8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFd3FmIuEx90iz6hiYUR/aaIZoKnRdazM4VVNSBGTCnqMZe0+f4PUwEYw0VdWIBk9FpiIGVh6Z2/maiPE/ezjn6QvrMrR1QAK+rGPCx2mLzeXPTKmOF9rQ3QLD9zUSCDKTlfRUUvV9uvM33rrUF0r2Ox5fxb11MaKkH1Vmf4P1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJ4U8sCe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C81C43390;
	Tue, 20 Feb 2024 11:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708428090;
	bh=M58MZcQaPOao7iwprIie+9OLC12Mm/dqk+jYeODJ+8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MJ4U8sCeL0HL/jwZrw4Wha5gWUQjlaqRi60kHel96GNuYSJ5ryvYvU0B18K7nDQ2y
	 xscd5vuaE9pZZE1YUZ6Ua5q9cylQemqLVzbZ/4Mslve9trqo6fX+6VmiKpeFuN0+aN
	 DychayaNwVCKoGUR4Y5qAMjpETzUbV7TeSkNJa6cb3tRg4djLxQbfOvpI391QoWNGf
	 MJLOVa8C+uYc307n3SDOJWpB4+5UsLIj8lXsGxRSzhcn3ohJvG2QCVHk2FZt1Ee+3A
	 1fiYJkUpeOPhOG1i1PCeGayRq70cfoKGqpoxblivXoM4XYOmQg3Yllxw+HeenwYoZj
	 rFCt8Syw1DawA==
Date: Tue, 20 Feb 2024 11:21:24 +0000
From: Simon Horman <horms@kernel.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Oliver Neukum <oneukum@suse.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev, linux-ppp@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 07/12] net: hsr: constify the struct device_type usage
Message-ID: <20240220112124.GU40273@kernel.org>
References: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
 <20240217-device_cleanup-net-v1-7-1eb31fb689f7@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217-device_cleanup-net-v1-7-1eb31fb689f7@marliere.net>

On Sat, Feb 17, 2024 at 05:13:29PM -0300, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the hsr_type
> variable to be a constant structure as well, placing it into read-only
> memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Simon Horman <horms@kernel.org>


