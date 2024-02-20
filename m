Return-Path: <linux-kernel+bounces-72898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7FA85BA5C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE970286C75
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16141692F2;
	Tue, 20 Feb 2024 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8QSmgKN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C8A66B4F;
	Tue, 20 Feb 2024 11:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708428111; cv=none; b=m1DcYoYf2VaBUOcuk8CKqygoRuj70IRCYMSSZsx/RbbBcUt8ctywXrfkQgWPjG4jdfgXesIQAIQFW1uAB4MBgY7nSwkFZlI4k+ufb5KzFGYYmDwRTw7y5ty6CCyJ3/q1b85154Lcl5695F1wprGxmnzvlqfxXHxYazol9xjbfGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708428111; c=relaxed/simple;
	bh=K9kRLFE6qbuHSyYAojt0up/YcOzPrVds+QVISmtZiyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juMg98FiKX2Uu659JIkxna0ofow9qbVS2UM6xAEW3wHheLsdJhNnHDrGiz7HIf7CP+oDH3uOrzfRPZCD5+K0n7aIjuPJQQ5uPvIcx7L7cQ4tx9fk6ukPCT4glQRZrR/5+OHEBjC+iR34VBJGyPr83pUQUuyo/4l9KmfnPKMaFts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8QSmgKN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68CB7C433F1;
	Tue, 20 Feb 2024 11:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708428111;
	bh=K9kRLFE6qbuHSyYAojt0up/YcOzPrVds+QVISmtZiyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E8QSmgKNuuP+DmAaC+lXosOoPLEb5ly4pIc/GLi1LZzygTRuU3ggE1GzM6fZoFTs8
	 MvV4i3ypONTv89i2XNrE2dIaSjX5WdMHngcp678Iu2utk6mFNZLhhx8va+r7h3Wiut
	 QlwGQ8a+S0CzWMdvvdk64xVxYaREREU4NTLOCEldmHbHPOpWce6fKPsOnQohYU/0m3
	 g1uRDdutqxsbQjXrZxDI200gtWB4t5MsejKkjZ3DuFY9Ki1a8A13MmsqmRkDgcapk5
	 k8XlO89N9wYVVShIGDYlIN/etgxlbPdFTOfpEHhprRgZDmq4cEV01P5roshnHV7cmL
	 xz2GTOeQQ3Zjw==
Date: Tue, 20 Feb 2024 11:21:45 +0000
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
Subject: Re: [PATCH 09/12] net: vlan: constify the struct device_type usage
Message-ID: <20240220112145.GV40273@kernel.org>
References: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
 <20240217-device_cleanup-net-v1-9-1eb31fb689f7@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217-device_cleanup-net-v1-9-1eb31fb689f7@marliere.net>

On Sat, Feb 17, 2024 at 05:13:31PM -0300, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the vlan_type
> variable to be a constant structure as well, placing it into read-only
> memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Simon Horman <horms@kernel.org>

