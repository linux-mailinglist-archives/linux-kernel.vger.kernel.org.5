Return-Path: <linux-kernel+bounces-72899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F407285BA62
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF520286E70
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CBB67A18;
	Tue, 20 Feb 2024 11:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odxsIHfD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B86867756;
	Tue, 20 Feb 2024 11:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708428126; cv=none; b=cMRcXHV62x9TPcUHWIL5fr5Oft3WzgjZt6QIcnjr6Ad+ztqQZfPPBzj+A7RzqA5ieF8sEJekPVgdbGoIIypu2V32OcGfXfKZDHsiKRdQkFe4DFdpcLNR6Kd9upGyEjSL8Xt2W04dxs6YIYFryczB1WFJPuWZbZnebjbEdVwHo/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708428126; c=relaxed/simple;
	bh=zZeYaxpPJHZ8XVAbnPBguZr9gpvZgQs/927P1yPF+yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niOffYLUw3qwvFIwIRZ/hwINwHDMAt6TtEsa7VuLtxToAZ3FOcKLmo6YwR56QKVkrcIOg3+wxF7e6U2qLRV71RqEvrpczi/PqpFQgRkfZ6v/CadJwNuo4blUC1iOUAWq2fF2cy+CdKqsbe5TfAomc/mjIGPxZ/7fgL/HttvXaU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odxsIHfD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08ED7C433C7;
	Tue, 20 Feb 2024 11:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708428125;
	bh=zZeYaxpPJHZ8XVAbnPBguZr9gpvZgQs/927P1yPF+yQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=odxsIHfD/fmQf0V/ERnlKUhQ39SzHJLp4SETlhkYVANExKpg0jZobI/GyGW4AmJeA
	 lEo5uIkK5XVEptfSZ0rV6CyKr5n+WF6ko1w2mJCLSAr+uop1iXwYbBL6SHcWX19rUE
	 99rfmb7297hIvXM9Z+JyLTjMm8RqjnYBHxr97mzGLgFm+QZQdL0tphfdlQdgWNCtwP
	 9w2Ndtuv+QBZaqhSOIa1N2MS9xl7NkaB0uO4QuB1LaA8v3CHQe5Xk33U5a80dNP6+w
	 R8I6EHHcMz3dnx9cwz/wz5Num1E/8gXUjNH92YOT34MOSOP5CpQRNcuTe2LIwLwn6S
	 GRblApAwJlEGg==
Date: Tue, 20 Feb 2024 11:22:00 +0000
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
Subject: Re: [PATCH 10/12] net: netdevsim: constify the struct device_type
 usage
Message-ID: <20240220112200.GW40273@kernel.org>
References: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
 <20240217-device_cleanup-net-v1-10-1eb31fb689f7@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217-device_cleanup-net-v1-10-1eb31fb689f7@marliere.net>

On Sat, Feb 17, 2024 at 05:13:32PM -0300, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the
> nsim_bus_dev_type variable to be a constant structure as well, placing it
> into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Simon Horman <horms@kernel.org>


