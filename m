Return-Path: <linux-kernel+bounces-132166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AC5899072
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D41641F228A6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFB613BC14;
	Thu,  4 Apr 2024 21:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGEe3nIl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFB5745C2;
	Thu,  4 Apr 2024 21:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712266450; cv=none; b=gFARZm4Vf8f5DrwcUDyJucbrKxpprG9Dqx5nRn19D7bqvSUGViVzmCbwm5+j57H3sQpeT+WmcmSfQvdQjis/bIzIlmHwGkVLkBVGSYKRTpY1msafzsm6mqwG54pPAJmf8Ze95vDkjCf/5liP7qhDmQVauQt2jXlIE72xFM9sK8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712266450; c=relaxed/simple;
	bh=MvO4hn6NceYnIx1psf+rZClmgr9/kqbNuQw4jwCybUo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tGtd2eMm/DH9jhwVh7CoJwIruFnxLQHcLBAIQlLrnWfEXWo03W9UVrG1B/orEFre2poDsRAM8MsXRj7FgYVgP1sBH8J4ijZ1xmX/FF3GVCW8gk56Lw/7mX8fBim+YqVrh5vT25EUy1YRGEz+zQH9Znpyv9+s5pi2HOAUVZHBuyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGEe3nIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111D7C433F1;
	Thu,  4 Apr 2024 21:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712266449;
	bh=MvO4hn6NceYnIx1psf+rZClmgr9/kqbNuQw4jwCybUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hGEe3nIlsl2LY3b6fNhY82fq0TjwggHOYHq+XKfEVZWZNEP1RGwR4GKxprMif+jkh
	 3fvBcREXd3TxdL5GamnEG+A6/mZ+rKP8aaSNAItzn/4HN3HB8My+kUfaYNSh3oarSd
	 OK1m3i4qS0lZxLXVYtGJtH+dg6Q42PyU7wwSwVCz+ZAWRX9DAiJK27B6myCvBqwLPu
	 XeeHup5JEeJLwuFxWKWFKFPpF4AD/aOr/8v6uSjGtJn3mZuB1mWT30zMRBLus2eWOV
	 PTEKSkoiWTKb7923YStB7hkm3cQVy6DBLyLdcpKEYTUZ7b3qL8VRNDkxDKsd1S6yOg
	 yCUBV3S4Mx4hQ==
Date: Thu, 4 Apr 2024 14:34:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Edward Cree <ecree.xilinx@gmail.com>, David Ahern <dsahern@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christoph Hellwig
 <hch@infradead.org>, Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko
 <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>, Itay Avraham
 <itayavr@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Aron Silverton
 <aron.silverton@oracle.com>, linux-kernel@vger.kernel.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Andy Gospodarek
 <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240404143407.64b44a88@kernel.org>
In-Reply-To: <20240404204454.GO1723999@nvidia.com>
References: <Zf2n02q0GevGdS-Z@C02YVCJELVCG>
	<20240322135826.1c4655e2@kernel.org>
	<e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
	<20240322154027.5555780a@kernel.org>
	<1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
	<0ea32dd4-f408-5870-77eb-f18899f1ad44@gmail.com>
	<20240402184055.GP946323@nvidia.com>
	<83025203-fefb-d828-724d-259e5df7c1b2@gmail.com>
	<20240404183305.GM1723999@nvidia.com>
	<20240404125339.14695f27@kernel.org>
	<20240404204454.GO1723999@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Apr 2024 17:44:54 -0300 Jason Gunthorpe wrote:
> > To my knowledge the "customizations" are mostly around fitting into OCP
> > servers.  
> 
> Nope. I understand it is significant. If Meta had to work with a COTS
> environment like a HP/Dell customer then Meta would have a list of
> flash configurables to set. I think you greatly underestimate the
> privilege of being at a hyperscaler and having vendors create custom
> products just for you..
> 
> > Those unfamiliar with how hyperscalers operate can mentally
> > replace $hyperscaler with HP or Dell in your message. Minus all the
> > proprietary OOB management stuff those guys also provide.  
> 
> A significant Dell customer will get a server pre-populated with a NIC
> with some generic Dell configuration. In most cases the customer will
> have to then program the flash to match their needs. Set a specific FW
> version, set site specific configurables, etc.
> 
> Similar to how a Dell customer will have to change the BIOS settings
> in the Dell to match their needs.

I can only guess that you are again thinking about RDMA/HPC.
Flashing tunables is not a workable solution for extremely varied 
and ephemeral TCP/IP workloads :|

