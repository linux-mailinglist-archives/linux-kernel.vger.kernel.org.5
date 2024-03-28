Return-Path: <linux-kernel+bounces-122886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D9488FEEC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13466B223C0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55927F494;
	Thu, 28 Mar 2024 12:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9jEuvem"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BF07E575;
	Thu, 28 Mar 2024 12:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711628755; cv=none; b=lyiioQOA5J3ohE286ldWOILLaAeCdC2ihew3HyBEn0n9eXgW423j72RDWpx19SON8eR0okcKUFxc/wAzt7XliP93jMSLtRkmeLceE4azEeLqr3DulxATJVeJDVm1VsW6B9aXOy/mmk9kLH7Q0WPkwKx0FbjYl/4jljdfPDNxhiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711628755; c=relaxed/simple;
	bh=BfyepUCPUZFKLn0+q11h5xNB6kNozPxJq/XAGESUjts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c17ccXk+qD6+54zVfnsjI42ewj2s7twuxDZ8qtKA08A+ByKF2pi5/HtYNsku0knsLK3vjBkrGJubYQkvspknfJUl/j1r8A8t06vRV5uPs5YFZzQ0RB0yt1qcYBwWwt+SzzWTg5b+tM2bHL95Xs0FvakUpxVUC26fSXe2RtETUb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9jEuvem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE65C433F1;
	Thu, 28 Mar 2024 12:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711628755;
	bh=BfyepUCPUZFKLn0+q11h5xNB6kNozPxJq/XAGESUjts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q9jEuvemfKaUfbAp3lYMf289x2fuQIl1EQTIyV7/VznHbJwdPX9Y99qCZTc4L5Rma
	 27UZ7+dPMRscrMH14JppQuGPvw3CBMh087urv9+FwGTjebaWTcUbmKc6v7rjqSYbWk
	 cDPJxOs3dVJmbe2f/UadXoLmVLL16jN8g/Iduhqq3UqWAn15h8ilD3YTyfeh2USXTQ
	 3uKaZw4FkCTkUoJEw+q9XhNc6LZgckEmzoZ/16GCNDzLoGDViM+2dXzdVSLyvk1B4m
	 FBICgyhGBpe1LwpgJn5Ms1ZYGXih4ypLhLzD2ozHf7tFtvJSVIAa2zS/UmDvxTDYad
	 XUptbSzvQqG5w==
Date: Thu, 28 Mar 2024 12:25:49 +0000
From: Simon Horman <horms@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Ziyang Xuan <william.xuanziyang@huawei.com>,
	Shigeru Yoshida <syoshida@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RESEND] net: hsr: Provide RedBox support
Message-ID: <20240328122549.GJ403975@kernel.org>
References: <20240326090220.3259927-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326090220.3259927-1-lukma@denx.de>

On Tue, Mar 26, 2024 at 10:02:20AM +0100, Lukasz Majewski wrote:
> Introduce RedBox support (HSR-SAN to be more precise) for HSR networks.
> Following traffic reduction optimizations have been implemented:
> - Do not send HSR supervisory frames to Port C (interlink)
> - Do not forward to HSR ring frames addressed to Port C
> - Do not forward to Port C frames from HSR ring
> - Do not send duplicate HSR frame to HSR ring when destination is Port C
> 
> The corresponding patch to modify iptable2 sources has already been sent:
> https://lore.kernel.org/netdev/20240308145729.490863-1-lukma@denx.de/T/
> 
> Testing procedure:
> ------------------
> The EVB-KSZ9477 has been used for testing on net-next branch
> (SHA1: 709776ea8562).
> 
> Ports 4/5 were used for SW managed HSR (hsr1) as first hsr0 for ports 1/2
> (with HW offloading for ksz9477) was created. Port 3 has been used as
> interlink port (single USB-ETH dongle).
> 
> Configuration - RedBox (EVB-KSZ9477):
> ifconfig lan1 down;ifconfig lan2 down
> ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision 45 version 1
> ip link add name hsr1 type hsr slave1 lan4 slave2 lan5 interlink lan3 supervision 45 version 1
> ifconfig lan4 up;ifconfig lan5 up
> ifconfig lan3 up
> ifconfig hsr1 192.168.0.11 up
> 
> Configuration - DAN-H (EVB-KSZ9477):
> 
> ifconfig lan1 down;ifconfig lan2 down
> ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision 45 version 1
> ip link add name hsr1 type hsr slave1 lan4 slave2 lan5 supervision 45 version 1
> ifconfig lan4 up;ifconfig lan5 up
> ifconfig hsr1 192.168.0.12 up
> 
> This approach uses only SW based HSR devices (hsr1).
> 
> --------------          -----------------       ------------
> DAN-H  Port5 | <------> | Port5         |       |
>        Port4 | <------> | Port4   Port3 | <---> | PC
>              |          | (RedBox)      |       | (USB-ETH)
> EVB-KSZ9477  |          | EVB-KSZ9477   |       |
> --------------          -----------------       ------------
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Hi Lukasz,

this patch (2) seems to have a build dependency on:
(1) [v2,RESEND] net: hsr: Use full string description when opening HSR network device
    https://lore.kernel.org/all/20240326085649.3259424-1-lukma@denx.de/

Which is pending review.

With this in mind, I suggest waiting for the review of 1 to be completed
and then either:

* If 1 is accepted, then follow-up by sending v4 of this patch (2); or
* If changes are requested to 1, include 1 and 2 together in
   a patchset after addressing relevant feedback

..

