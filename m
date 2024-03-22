Return-Path: <linux-kernel+bounces-111439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B9D886C5D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 569591C216ED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703C7446DB;
	Fri, 22 Mar 2024 12:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnT6VQq3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17772A1BA;
	Fri, 22 Mar 2024 12:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711111697; cv=none; b=q9vU6+ouLrw5kl6tHKP+g+XpZVURSmCCxLBgOGEy6tCv9HHC9z2NBDWbQYr+bxTy8gOZGwXrx8JpZzU4QtLpIoc2htWRk3kmroL24x2jiKSSkTv5m2nkoAFRGMocpRcY6p+HxfmIPSqcCRGRy4AYuALmO+FuQqr+XRojacl/CUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711111697; c=relaxed/simple;
	bh=EW1YyO0yfmBcthj5cjy+WTpTjJLjT2GTWuhVw+I+Mf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRMpQnOAgySuBHykEedgHrLBQ0gSPQCgS/g8WHg/FhV/3ujoeVnm7UJCBKcYAiHxbcyUTQW8S4jryUR7gZfMz9ixw9xTJphDIVf0sAdaJRq9EXbPTEw9weH3oQG+VqRE2dUYYt1sZ7Oqkdw5aRY3Uz1Ng6J+9NiavJ+J4Op59yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnT6VQq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A482C433C7;
	Fri, 22 Mar 2024 12:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711111697;
	bh=EW1YyO0yfmBcthj5cjy+WTpTjJLjT2GTWuhVw+I+Mf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bnT6VQq3nj5oQk2sWcavk09Fv0Bh2W4VfvDZoBmN5wWS2g5F1P7Z+FBPaUsXPOPuP
	 QmuPSpib7p6TKbtgAENDmRYrMkveuo7hsDYotLe0V+XyuIz6UVbnLkIRZeASuc/h2l
	 EHp3qMTPqtgaRFHyi1wQLQ5PflJ3frpu3MVwCsUFV7VlGyD+u4ga3CUY12XWUT3AQ3
	 M5fb3W7VunidJQYvwz3iZJaMacnNxSpzwpARl3s7c6tMgWJttzn8hM4YanSI9/+c5V
	 lOUSB6PMBdMp929wvrAFYfT+yYI9gKXHXsWMAdWdeU67gnw9Aj8KkN2XshRilJUTMM
	 nWwrLPbCydXRA==
Date: Fri, 22 Mar 2024 12:48:10 +0000
From: Simon Horman <horms@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Ziyang Xuan <william.xuanziyang@huawei.com>,
	Kristian Overskeid <koverskeid@gmail.com>,
	Matthieu Baerts <matttbe@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: hsr: Provide RedBox support
Message-ID: <20240322124810.GD372561@kernel.org>
References: <20240311115644.823829-1-lukma@denx.de>
 <20240322084244.7d0d17e8@wsk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322084244.7d0d17e8@wsk>

On Fri, Mar 22, 2024 at 08:42:44AM +0100, Lukasz Majewski wrote:
> Dear Community,
> 
> > Introduce RedBox support (HSR-SAN to be more precise) for HSR
> > networks. Following traffic reduction optimizations have been
> > implemented:
> > - Do not send HSR supervisory frames to Port C (interlink)
> > - Do not forward to HSR ring frames addressed to Port C
> > - Do not forward to Port C frames from HSR ring
> > - Do not send duplicate HSR frame to HSR ring when destination is
> > Port C
> > 
> > The corresponding patch to modify iptable2 sources has already been
> > sent:
> > https://lore.kernel.org/netdev/20240308145729.490863-1-lukma@denx.de/T/
> > 
> > Testing procedure:
> > ------------------
> > The EVB-KSZ9477 has been used for testing on net-next branch
> > (SHA1: 709776ea8562).
> > 
> > Ports 4/5 were used for SW managed HSR (hsr1) as first hsr0 for ports
> > 1/2 (with HW offloading for ksz9477) was created. Port 3 has been
> > used as interlink port (single USB-ETH dongle).
> > 
> > Configuration - RedBox (EVB-KSZ9477):
> > ifconfig lan1 down;ifconfig lan2 down
> > ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision 45
> > version 1 ip link add name hsr1 type hsr slave1 lan4 slave2 lan5
> > interlink lan3 supervision 45 version 1 ifconfig lan4 up;ifconfig
> > lan5 up ifconfig lan3 up
> > ifconfig hsr1 192.168.0.11 up
> > 
> > Configuration - DAN-H (EVB-KSZ9477):
> > 
> > ifconfig lan1 down;ifconfig lan2 down
> > ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision 45
> > version 1 ip link add name hsr1 type hsr slave1 lan4 slave2 lan5
> > supervision 45 version 1 ifconfig lan4 up;ifconfig lan5 up
> > ifconfig hsr1 192.168.0.12 up
> > 
> > This approach uses only SW based HSR devices (hsr1).
> > 
> > --------------          -----------------       ------------
> > DAN-H  Port5 | <------> | Port5         |       |
> >        Port4 | <------> | Port4   Port3 | <---> | PC
> >              |          | (RedBox)      |       | (USB-ETH)
> > EVB-KSZ9477  |          | EVB-KSZ9477   |       |
> > --------------          -----------------       ------------
> > 
> 
> Gentle ping for this patch...

Hi Lukasz,

Unfortunately the timing of this patch submission didn't work out:
it was submitted after or otherwise still under review
when Linus tagged v6.8 and the merge window for v6.9 started.

net-next is closed during the merge window and the usual
next step in cases such as this is to rebase and repost
once the merge window closes and net-next reopens.
That should occur next week.

See: https://docs.kernel.org/process/maintainer-netdev.html#git-trees-and-patch-flow

