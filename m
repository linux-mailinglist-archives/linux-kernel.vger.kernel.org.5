Return-Path: <linux-kernel+bounces-72900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB8185BA68
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD708286CC1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6676967C5B;
	Tue, 20 Feb 2024 11:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTtLS8wH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A90E664BC;
	Tue, 20 Feb 2024 11:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708428154; cv=none; b=GZEBWY/d/lL2j2jRe6OtPD6geg+cb+EajeeptVdshlHuQxUzmi2LjGKA5fTdIJ7DT42/JgNe9HCvy4bqAlJ65GlbmxPAIa0U+LY6NgJABzIjIVj0v0fTh57ncFaZTzAjhI7K18l+Daed6MDRUAttaS0M9TpyKOI9B3FEsh1rweo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708428154; c=relaxed/simple;
	bh=XFlWrpeVYPjEb2KzqcQ5CIkDfid3kdrI5OAY7b5n6Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7j8f8/Z04dIsKHE+kH6b2Qnr5WzevQldCsWIUK4+PEnrqUf63Yt95SL6BnieiRrK3XFV/Ah1hUmJClTeFhHKF1UbLJcAi7z5btLVXqqpPlFOH/yzPdMxN9B+OSQTHg/N3Cb4bLHwj7bSvWDFyOkG4jIcBSEZF365SkvIwn7+gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTtLS8wH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B91C433F1;
	Tue, 20 Feb 2024 11:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708428154;
	bh=XFlWrpeVYPjEb2KzqcQ5CIkDfid3kdrI5OAY7b5n6Bk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jTtLS8wHbg7bC6vT4Z5iOXxfJKaq4Dvba1fYAmrdDNymWL7PmtKG93qT3EF/Lfgym
	 knqsHh5JoRmzLuknzT2u+LcYVLIL9kkwDtLoqADmrzjJUQE31ahfuOlesoYxOaEt9t
	 8lETJcZnAV2limJjtLFUh4kcQWjCI4mqvB8p46RfealEjqecfv+C1d21Ros6fTxDIG
	 4UMsJ0AI5gtBbediZvqHXlX+WZyJ8MMdkh9WvSfAi5+mKvm7x6kiv6E/3zAcRCZDPy
	 oC+J/DGwdRNVvSqfJrL7IvgQTvu9oGx0xals0fvzC6oqXGDPbTwikZpKq3AyaxATgU
	 7QOWo70SLjtxA==
Date: Tue, 20 Feb 2024 11:22:28 +0000
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
Subject: Re: [PATCH 11/12] net: wwan: core: constify the struct device_type
 usage
Message-ID: <20240220112228.GX40273@kernel.org>
References: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
 <20240217-device_cleanup-net-v1-11-1eb31fb689f7@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217-device_cleanup-net-v1-11-1eb31fb689f7@marliere.net>

On Sat, Feb 17, 2024 at 05:13:33PM -0300, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the wwan_type
> variable to be a constant structure as well, placing it into read-only
> memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Simon Horman <horms@kernel.org>


