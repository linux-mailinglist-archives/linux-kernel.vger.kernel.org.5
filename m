Return-Path: <linux-kernel+bounces-50805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFE8847E15
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 02:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7BF1C23C00
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78B8567F;
	Sat,  3 Feb 2024 01:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeRX6SA0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005785396;
	Sat,  3 Feb 2024 01:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706922941; cv=none; b=C4FjnDOKUitJzPdM3KqGhMZrbkO2NRh3ntE6pQKyTiH6EMiEHq1nLMUagoYKVSQhF17YBZqQfasFYVVV+5tcvWYUeD8mmlzJ7cRGrInUUX/FSXMnmwfI5/1rcwNglOSrOPCCYVWsaKAfEPSBIHDc0jbTNGvvrPaCPKHME0mgOLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706922941; c=relaxed/simple;
	bh=fjX8Xfgg5p0P4PaQxAJSZ98Hw4JnxJn3l63CVEt4OWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OIJb+BoRCAS54y9FUSx5q88C8jC3jxUQBkkSKETCT1XQ2/DlgSoCApIDhck312etVAkbc0y2u4cWsUHmZ4NgUvey35XQBvugyC3jq5dSGZDXNFEeG8LG6ubLdLpS2g47l65qZf1iMKlZu2BKai6DwpCh4kmYPMYZwCSLGjwS+E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeRX6SA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FE7C433C7;
	Sat,  3 Feb 2024 01:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706922940;
	bh=fjX8Xfgg5p0P4PaQxAJSZ98Hw4JnxJn3l63CVEt4OWU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MeRX6SA0Sa3BWVoNlGLzxBuYcToaonVLfr8XNP0yKeh3t3esYQynx3y0D9KJD/mum
	 i60EbTt+nGMNuT8iusV3x23kSySZJPqOaIaemfU8FFMlVLeKq1RdIS0AcF6bXad/e9
	 jCftWOiSNcuq0a1PcoDYFKFvOnOJnngqPGekbCKDSExkdWu7EyZPxzWOcOiYlB1PvR
	 26tAYOtGP1v4bDfqvHRGqfQ3QgzJuRqsUSJH9cUpSsAHSopWaOiCsFwQ2+wuamWTk/
	 WmhgdlBgSoIbQxd1LFmyTy242goCh1814ADwiRsrHAVeiEVWZhVmJpLWnC4moddS4+
	 5Hv9ktjTaRjbw==
Date: Fri, 2 Feb 2024 17:15:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Eric Dumazet
 <edumazet@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
 linux-api@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
 alexander.duyck@gmail.com, Wei Wang <weiwan@google.com>, Amritha Nambiar
 <amritha.nambiar@intel.com>
Subject: Re: [net-next 0/3] Per epoll context busy poll support
Message-ID: <20240202171539.7347cb01@kernel.org>
In-Reply-To: <20240202202344.GA9283@fastly.com>
References: <20240124025359.11419-1-jdamato@fastly.com>
	<CANn89i+YKwrgpt8VnHrw4eeVpqRamLkTSr4u+g1mRDMZa6b+7Q@mail.gmail.com>
	<5faf88de-5063-421f-ad78-ad24d931fd17@intel.com>
	<20240202032806.GA8708@fastly.com>
	<f0b4d813-d7cb-428b-9c41-a2d86684f3f1@intel.com>
	<20240202102239.274ca9bb@kernel.org>
	<20240202193332.GA8932@fastly.com>
	<20240202115828.6fd125bf@kernel.org>
	<20240202202344.GA9283@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Feb 2024 12:23:44 -0800 Joe Damato wrote:
> > Did you see SO_PREFER_BUSY_POLL by any chance? (In combination with
> > gro_flush_timeout IIRC). We added it a while back with Bjorn, it seems
> > like a great idea to me at the time but I'm unclear if anyone uses it 
> > in production..  
> 
> I have seen it while reading the code, yes. I think maybe I missed
> something about its interaction with gro_flush_timeout. In my use case,
> the machine has no traffic until after the app is started.
> 
> In this case, I haven't needed to worry about regular NAPI monopolizing the
> CPU and preventing busy poll from working.
> 
> Maybe I am missing something more nuanced, though? I'll have another look
> at the code, just incase.

We reused the gro_flush_timeout as an existing "user doesn't care if
packets get delayed by this much in worst case" value. If you set
SO_PREFER_BUSY_POLL the next time you busy pool the NAPI will be marked 
as "already scheduled" and a timer is set (to gro_flush_timeout).
If NIC IRQ fires before gro_flush_timeout it gets ignored, because NAPI
is already marked as scheduled.
If you busy poll again the timer gets postponed for another
gro_flush_timeout nsec.
If timer fires we go back to normal NAPI processing.

The idea is that you set gro_flush_timeout to some high value, like 
10 msec, and expect your app to poll more often than every 10 msec. 

Then the normal NAPI processing will never kick in, and there will 
be only 1 NIC IRQ after which the HW IRQ remains masked.
With high coalescing timer you technically still get an IRQ every
so often and interrupt the app. Worst case (UDP flood) you may even
get into an overload where the app gets starved out completely..

