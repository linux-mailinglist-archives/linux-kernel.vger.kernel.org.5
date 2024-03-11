Return-Path: <linux-kernel+bounces-98606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E90877C8C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A3AF1F20FC6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C614917578;
	Mon, 11 Mar 2024 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfFmCu/m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136A517558;
	Mon, 11 Mar 2024 09:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148928; cv=none; b=sYi6TFYT4eQZaOiejTLU4ewcMEQ2UDf6YGJesw35YkZh00+IqD4v6Jdizc+zKHCFUVcDuxoEJTzXBv6gJz2/cwvqejw+P101V5c9RE3vRWcK/JWe2IPWSX3Lna0XLD2IKrQWtAlzb1Z0yMa4e0AF2fshcsmbG7cihJtXZL08bYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148928; c=relaxed/simple;
	bh=jfyM81qdr/fr+0vUOBaGhfZQoUtRfEy6ZlsHkzSG4Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUCw6q4IxqPj2IKuJewUVzLLmQawI7FWWUOQqjSVNpQQP0qThfQu7Y1tSusj+QmUDTpAYLN9Q1v8Phh/Dr/aVnbfo9Wj3dG1++bMzKktM6XFs+pkAVJ+GzXbdbwhzaL1fSVsgd5yqTX/+jwem9y3jqwrgLzk3HZU2DNOIwacS24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfFmCu/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007DEC433C7;
	Mon, 11 Mar 2024 09:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710148927;
	bh=jfyM81qdr/fr+0vUOBaGhfZQoUtRfEy6ZlsHkzSG4Dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cfFmCu/m8X2Ov7QlNEH7h1QsK5WSMliR4lIvskJx0ed6YtsDC/H6InjgJZKAUGsYC
	 ZjenPVOfJ/ULuGYE/pkI61qG9yB+8B9Pb1IMYyOrR+OCEZKzzALGYo5oS9SCW8Z5Jc
	 h9qO1adY9JZNizKkTK5PuWTAw4LP0Nu0JGT6RDl4lBrQwHZRsMrlugDKdp+Z1wgAcu
	 qsmAApFtMLvA4a22oXFjzBp/8ZVIVlw7fMcchQrV1ECGOdTRexs/YEMvLDxqJ4i8Wv
	 mjKOJXDQtfv/YifzswWIag3lU343wLoidon/pzQzMcPopUdkiCC930fUeKf5sj84at
	 TbSVn4taC5+oA==
Date: Mon, 11 Mar 2024 09:22:00 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	dsahern@kernel.org,
	"open list:WIREGUARD SECURE NETWORK TUNNEL" <wireguard@lists.zx2c4.com>
Subject: Re: [PATCH net-next v2 1/2] wireguard: Leverage core stats allocator
Message-ID: <20240311092200.GF24043@kernel.org>
References: <20240308112746.2290505-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308112746.2290505-1-leitao@debian.org>

On Fri, Mar 08, 2024 at 03:27:44AM -0800, Breno Leitao wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core
> instead of in this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> Remove the allocation in the wireguard driver and leverage the network
> core allocation instead.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>

..


