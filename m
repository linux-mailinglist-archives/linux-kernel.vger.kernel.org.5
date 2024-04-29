Return-Path: <linux-kernel+bounces-162767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 020B88B6047
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E92F1C2167B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4391F126F2F;
	Mon, 29 Apr 2024 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iF93v2hv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A5580630;
	Mon, 29 Apr 2024 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412428; cv=none; b=BcKnU1w2oaNTziDgCXTPDjTBms3j+pWvjFPS+V6VpC+A3FFpMVyIP03gfLyIun6RwSHCMYZ6yQwGJK5y0Cbf+pfeYQv33ezzlRf0Sj/fpi9HlrV4bMNEDkyRWSF5USn7w7J6zeMr6aLoikgUZyyOL9pjAXsHYIosuy7blvmFMvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412428; c=relaxed/simple;
	bh=E11Va/fGQEDHKI15S2rcyyuzQ+3AMPPAvFdsSakTQGg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/VbbNWtRmujlHn5Eiljryp77YX/j0xNTzTWCLqD5O9vbNZcAjjnlutbaurO9kmw5O9C1FotaoeqVzAVWfXH7F35oIt9jnDbg+GJGLDJi+SJr6yJPIVbbOUYzBB78Qv0yFwXYEKkxN4NrYHoGWiraVxftAJHBJBPU97AukEPwPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iF93v2hv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5111EC113CD;
	Mon, 29 Apr 2024 17:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714412428;
	bh=E11Va/fGQEDHKI15S2rcyyuzQ+3AMPPAvFdsSakTQGg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iF93v2hvlLt56jU2WHJ2RyfRv/vPO6wqrX9sMGF7/xMB2jeAXWCfeZRgl7SqDhDcb
	 4AowmGyxC1i/lzZBLW1bfcIM+9CGscCLTPEjZU5LvY8g0O4+rwepIQVe9p2d7SkkB5
	 TKKCKcc0yxblXpFaid0P6jQ2N+1jX2s/1AGk7DtOdU6OwVMStQyA13tKPalhCAD9LT
	 2BLdTA+kKiof/YIuzATMWtuAbzKz5aT13JfwEh1mT/YU39Tl/4Fiqo5O06rPZ5Cx1w
	 duL+Vhjg5nqkc9tzg2M+NEZ/JAMhkup1Rp4xwuAolm8DbMtiOcVsLlSa5RIZvKqdt0
	 4leSwn0D5efWQ==
Date: Mon, 29 Apr 2024 10:40:26 -0700
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
Message-ID: <20240429104026.0fe3de0f@kernel.org>
In-Reply-To: <20240429120904.2ab5248c@wsk>
References: <20240425153958.2326772-1-lukma@denx.de>
	<20240426173317.2f6228a0@kernel.org>
	<20240429120904.2ab5248c@wsk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Apr 2024 12:09:04 +0200 Lukasz Majewski wrote:
> > if the
> > timer is already running we'll mess with the spacing of the frames,
> > no?  
> 
> When NETDEV_CHANGE is trigger for reason different than carrier (or
> port state) change and the netif_oper_up() returns true, the period for
> HSR supervisory frames (i.e. HSR_ANNOUNCE_INTEVAL) would be violated.
> 
> What are here the potential threads?

Practically speaking I'm not sure if anyone uses any of the weird IFF_*
flags, but they are defined in uAPI (enum net_device_flags) and I don't
see much validation so presumably it's possible to flip them.

