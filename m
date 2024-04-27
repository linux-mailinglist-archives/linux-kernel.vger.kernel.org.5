Return-Path: <linux-kernel+bounces-160816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C595D8B4342
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 02:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754331F22056
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE112AF0E;
	Sat, 27 Apr 2024 00:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNmdvtPm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8622570;
	Sat, 27 Apr 2024 00:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714177999; cv=none; b=hQYn2XmsZPubxCbAiT+PhON2u1hdh4Ud7DFeTRqwkfAVFTfGih5WOFesLJ+VGnqq0xnSaO5rORaiG++BH0kLzUaJWkXp2e71IRSeStbblyXM+zkl5rimiR3J0bUI1gKh/N/rpkyBi12W0WP3/Ychc/rSYUmlY7nnBpn3fp9KqLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714177999; c=relaxed/simple;
	bh=ExI0y1eLtvdS5sSntyhpyLpfJfO/Kp4Z8xHkYB9tJeE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RGlh065Dqer/g9hHXEIVcUbSHS5Vv7VKwysCZVEOgUNNNB/efAI27fMgpord1wriZWJkv1Zkw89qz1TGQG+tx14gvgJGXJpk2uYrWr21Ce5IKfVjkVjFST78sNbS4wKm127vcWeE7y2HwZ1hqkKvvdpSum4zPT1jYiph8kFnitM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNmdvtPm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53459C113CD;
	Sat, 27 Apr 2024 00:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714177999;
	bh=ExI0y1eLtvdS5sSntyhpyLpfJfO/Kp4Z8xHkYB9tJeE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VNmdvtPmD+z7Dan9QGzpYm9/IVpPVXeZHY/xKgzwxWgaTRraPcAFeqs3/S8qkP9ac
	 BfBwSCiey8KOnVAKoUZXkm4F0QSdSkoxDKu8poUVTXBnb1hYuto1iuplH4EubsHjbj
	 A9K4G9OpHL3hWO39kw16yrfK3MkjFsGrc48v9+bW8nU1Og3DeLCDj/yJUM6L1ibxvO
	 4SPKFBRBfZlRw6tvvFXRu62UfoXkARA99mlpHar3MV3liNplE7AO/fy78nvkVJWQRa
	 g5A6agyrXEUNvBf4QB0DbS5HtWXsrmcJKPsz2Lo0AVi+p9DcfseDVmpipw01DvnWBy
	 JNKl/S/9yYdJg==
Date: Fri, 26 Apr 2024 17:33:17 -0700
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
Message-ID: <20240426173317.2f6228a0@kernel.org>
In-Reply-To: <20240425153958.2326772-1-lukma@denx.de>
References: <20240425153958.2326772-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Apr 2024 17:39:58 +0200 Lukasz Majewski wrote:
> Up till now the code to start HSR announce timer, which triggers sending
> supervisory frames, was assuming that hsr_netdev_notify() would be called
> at least twice for hsrX interface. This was required to have different
> values for old and current values of network device's operstate.
> 
> This is problematic for a case where hsrX interface is already in the
> operational state when hsr_netdev_notify() is called, so timer is not
> configured to trigger and as a result the hsrX is not sending supervisory
> frames to HSR ring.
> 
> This error has been discovered when hsr_ping.sh script was run. To be
> more specific - for the hsr1 and hsr2 the hsr_netdev_notify() was
> called at least twice with different IF_OPER_{LOWERDOWN|DOWN|UP} states
> assigned in hsr_check_carrier_and_operstate(hsr). As a result there was
> no issue with sending supervisory frames.
> However, with hsr3, the notify function was called only once with
> operstate set to IF_OPER_UP and timer responsible for triggering
> supervisory frames was not fired.
> 
> The solution is to use netif_oper_up() helper function to assess if
> network device is up and then setup timer. Otherwise the timer is
> activated.

NETDEV_CHANGE can get called for multiple trivial reasons, if the timer
is already running we'll mess with the spacing of the frames, no?

If there is a path where the device may get activated without the
notifier firing - maybe we can check carrier there and schedule the
timer?

Also sounds like a bug fix, so please add a Fixes tag.

