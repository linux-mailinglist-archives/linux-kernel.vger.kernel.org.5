Return-Path: <linux-kernel+bounces-164188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A468B7A6A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 444FF285FBC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD49143729;
	Tue, 30 Apr 2024 14:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5zb0+b7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B931527B2;
	Tue, 30 Apr 2024 14:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488174; cv=none; b=UTcSqs6BVEu9Jp8f2U/9GZEEtNOaQycuu1vbcc18L8Fh6axa10nj9Dkm4EzR2s/jHZJSlqOXRotJub0Nn4/IFOeOFkJtJU/ij78j3OP3jsoczLbWAaH0m+vKhjdrTJCBjW+xUxsk0Zk+pH0Tjx/IHf/Mt3d7easYyWW2jlNl29k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488174; c=relaxed/simple;
	bh=QH1dfcYyIcPetkUCl+atKwQJ978quIcfRWzXslCTQwI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lkUgWS7fOMnXw9vFwNo7EUosT9XhEUYJla+bHpVZiRjxg0ClYJ9YkIfXliHH8i6bsGbaqcyeW/V/Y+qITlhS3oF0QmVtMdcx8bGv/TLe020Bqkx0Rpj1qbE/7UXTDXolAE2lgTuTwCyop50tTDOAa4ZIfLcinEyPGdoF/jilRZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5zb0+b7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E979C2BBFC;
	Tue, 30 Apr 2024 14:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714488174;
	bh=QH1dfcYyIcPetkUCl+atKwQJ978quIcfRWzXslCTQwI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X5zb0+b7+f45iFblEiSD/PT3vhYkLnqmZt0lVzVvqm5be/Ryl5j5Vft1WqY9bN9vv
	 Pg/BitOvX6C7v8nBBjjeLK4v4N1UmN5dyReZT/34rnVY0JK8/wRMuf57VbvhRkigVu
	 ABwlzx19+Ymje6YrRjRfDsnkKL04JsgeCzJVm+O4JmuLTV6ua6BLEVXli/hl0cs+rG
	 5GJZ4E8GKI83/KJLHc+WO8Uao8CRJzFInfiC5gkEsi0VjIzek1mgMqYpr6n53stEPy
	 hFBOv+DeGDlc6v9sRWDYNmdaRmWSrCtKcPaI3RuIzDDeiRP1xuzsOkdW15u7sbRLzI
	 KlG73TU8hz/+w==
Date: Tue, 30 Apr 2024 07:42:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Casper
 Andersson <casper.casan@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Eric
 Dumazet <edumazet@google.com>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Tristram.Ha@microchip.com, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Ravi Gunasekaran <r-gunasekaran@ti.com>, Simon
 Horman <horms@kernel.org>, Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 Murali Karicheri <m-karicheri2@ti.com>, Jiri Pirko <jiri@resnulli.us>, Dan
 Carpenter <dan.carpenter@linaro.org>, Ziyang Xuan
 <william.xuanziyang@huawei.com>, Shigeru Yoshida <syoshida@redhat.com>,
 "Ricardo B. Marliere" <ricardo@marliere.net>, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] hsr: Simplify code for announcing HSR nodes
 timer setup
Message-ID: <20240430074252.2690b639@kernel.org>
In-Reply-To: <20240430145243.34b82105@wsk>
References: <20240425153958.2326772-1-lukma@denx.de>
	<20240426173317.2f6228a0@kernel.org>
	<20240429120904.2ab5248c@wsk>
	<20240429104026.0fe3de0f@kernel.org>
	<20240430145243.34b82105@wsk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Apr 2024 14:52:43 +0200 Lukasz Majewski wrote:
> > Practically speaking I'm not sure if anyone uses any of the weird
> > IFF_* flags, but they are defined in uAPI (enum net_device_flags) and
> > I don't see much validation so presumably it's possible to flip them.  
> 
> Ok, I see.
> 
> Then - what would you recommend instead? The approach with manual
> checking the previous state has described drawbacks.

Add a bool somewhere to track if the timer has been scheduled?
The NETDEV_ events in question are called under rtnl_lock, so
no extra locking should be needed.

