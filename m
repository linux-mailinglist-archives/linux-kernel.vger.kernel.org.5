Return-Path: <linux-kernel+bounces-72902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1037185BA75
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E69283EBA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116FB69962;
	Tue, 20 Feb 2024 11:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBOlosSS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DE567E87;
	Tue, 20 Feb 2024 11:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708428178; cv=none; b=NGU4OkbA2ARCUIM896fbxzDypD3haArqPFWUeu2lrarppZeBDAGe/Gl9bfVuqkOd/yTZnqJNWSunxblxz577YBMK2oSAEHyiZVYL37YKvr3bJ2S5iyCL/AgX9VJ4Rf6MVJ3kWOXl3XHmGiHGlwDGZY2hUSQojECK7mcqWjc/8q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708428178; c=relaxed/simple;
	bh=ED0MxV9yoOK/Gkmdu1PKQmEBmEUPAd0+iNMpb1o5864=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyW2jWvSQgBBw96q7IEC8vtfUv2tUXoHvykaEsi1EUt9XXt5w+r+4yBZzRM3E6z4NCcrVKHHwsWXXjzqy1PndjmIgBg7LNChAty7se4mjmPoiLbF96pAVV7PSGaDpBIgbaPhix6D7cHd9KG9y68pLzLClTCS8lT9kvSOkql6kAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBOlosSS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF5DC433C7;
	Tue, 20 Feb 2024 11:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708428177;
	bh=ED0MxV9yoOK/Gkmdu1PKQmEBmEUPAd0+iNMpb1o5864=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dBOlosSSYD1yaUR6b+Ytt4zuKa3GFEKjteGD4XMNis+7WLkI23mMF6K1qwD63Uj+Q
	 Mpz9oD7BItkJkRlDT6dyPsT6P1YyBufDq2XWfHXqHkDGXDBZJSyg+Rg/o4cBxvh5kB
	 E9vbY5svKNtGmeKSTJWpnblZl9oYZUn5n1a348bH1f/YQFw27fVx3u3QM+Nr43pj8o
	 TOj/agVBPdtjtM0mBmPXqH6W7u4EAwlD6tfimKPPhxSLgUkYu4eFoe1C8UixZCFxZK
	 AVWl4EwrfqdcEsdqLI/doeaq2hMGGiLIO1svyEz5TA+EXsgHWNCo/bKtAoWgp8NeNT
	 01bCIib1byItA==
Date: Tue, 20 Feb 2024 11:22:51 +0000
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
Subject: Re: [PATCH 12/12] net: hso: constify the struct device_type usage
Message-ID: <20240220112251.GY40273@kernel.org>
References: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
 <20240217-device_cleanup-net-v1-12-1eb31fb689f7@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217-device_cleanup-net-v1-12-1eb31fb689f7@marliere.net>

On Sat, Feb 17, 2024 at 05:13:34PM -0300, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the hso_type
> variable to be a constant structure as well, placing it into read-only
> memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Simon Horman <horms@kernel.org>


