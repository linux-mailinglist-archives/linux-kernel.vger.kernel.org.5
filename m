Return-Path: <linux-kernel+bounces-53392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B321984A3D0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54391C2216D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54952129A94;
	Mon,  5 Feb 2024 19:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="va6iihuI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F678615F;
	Mon,  5 Feb 2024 19:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159809; cv=none; b=t521ZNzayr+NPzTujD29J+AndU4Y+5j4KepZ9KVFl5nnd5E+yiBpqRlTQmOwSCnvskN6X4KuO2UsgKEOA6ZALjYFEhcOR7ZI2MUdA1xR4X3tiJvBFB3PNWzipMv5fv1uLEcKfOYL0JKhF3WKI4sXM7FaR/W/ZC4AFjME3ahc+K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159809; c=relaxed/simple;
	bh=H8f1M8b6apfQrDwjE9TiNKtV/aNKPCj66fgR1fgv7Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQn2xrjw3kIN6sXakG2cHBuH0WKdr9qgiF7o6TETDkJLtIY3aRF2BsvXyRliBj1sYevhVwS0J1UMlWHINn7S/QQWpRrHuav6iNreU9Up1gGZU428bD/38tLO0ki/sUgBxJpqSGhSxgmcsc4+SvXrOBBcXJpxscmj1tFNFfsbvDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=va6iihuI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5810C43394;
	Mon,  5 Feb 2024 19:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159809;
	bh=H8f1M8b6apfQrDwjE9TiNKtV/aNKPCj66fgR1fgv7Aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=va6iihuIWnm/P/haKvgIHxRk4giKwrOAGMcay+FzCxQ0iWtEEz7EhUbGh5KaXlKGG
	 8ic2o1mSK580KK0ZBAfawhuAQtI3Q73VTsr3ntHyl7J3oMCKtbDQ098cpsuD5i8sBq
	 RipJBi0nk9vqvnUbuf3mc9J6LGrA+RPUCwQ9QLpA=
Date: Mon, 5 Feb 2024 04:48:23 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netdevsim: make nsim_bus const
Message-ID: <2024020518-reattach-linguist-c212@gregkh>
References: <20240204-bus_cleanup-net-v1-1-704b36d75901@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-net-v1-1-704b36d75901@marliere.net>

On Sun, Feb 04, 2024 at 05:16:34PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the nsim_bus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

