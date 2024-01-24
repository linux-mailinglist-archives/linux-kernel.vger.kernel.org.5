Return-Path: <linux-kernel+bounces-36597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C0183A393
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D3DBB27676
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9C3171D8;
	Wed, 24 Jan 2024 07:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkRH08Og"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D927171A2;
	Wed, 24 Jan 2024 07:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706082923; cv=none; b=EXilB8yHl7KqeNxS2xW2p+8eLurKp0DVSN7itScrju/KdSqsWZnm3wPUIbkvBi9YoBKviH3L9zfv3oc2fD34SxMSls1Rz7jPGh/uA6NF9h8QwC+XPdBDfswR4dIsfkD/mzsWhlnXi/t3Zh7RG+GJx+627CmRam6IJj+i9tIciOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706082923; c=relaxed/simple;
	bh=NT+Vf9nE136+iQ8X8hrDDr0oPQKV4IFmb3UOTg7wN3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bX9FBKRahkIrbS5a2cZf/IHVuOS//wBC4sj0D16jIMK2vN6mBxQCOvZCvs1rcKwtvGmxFMsBNrMo8wycKtPimeq1FkmITjzJoYwKIpGvJJ2UA4JzEL9ZH5Rh+pzSK8iCdGON16yxNx58BWVYHqV3aZE45R2xJW4z9BU2vdDgAX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkRH08Og; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1E6C433F1;
	Wed, 24 Jan 2024 07:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706082923;
	bh=NT+Vf9nE136+iQ8X8hrDDr0oPQKV4IFmb3UOTg7wN3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TkRH08OgLfYznR6++IxYRcC8cWcUxVT2AGh+/llDdDJrT9H2O65CLo0sndqoqhrid
	 JUU8ui2mXII78nEmwj4AegguQmGfCbuiVVONq0PXfrVe3Zg9wylzj6D1kCovi7KINd
	 iJNZf0CTtBYymdHlfZn6r8g0DsufA4wb2FzSVfjcF7AOFm7xlvBXMWDdCk4BYE1uUA
	 +kOor9A6L874Ndg2jhIB2K8nhpq0xo9mVZq8RfWOIK1JysnQWcsfgPjqTgeXpD0hVG
	 HRnCOYHlJeDcwGm+NG+I0mNT1LeJZVxfAYeRh0NiiRbtcEZeM/pKR5PyTXAf4C7pQH
	 RRGqU28b9c+Eg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rSY6h-000000001VA-1JkT;
	Wed, 24 Jan 2024 08:55:35 +0100
Date: Wed, 24 Jan 2024 08:55:35 +0100
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Xilin Wu <wuxilin123@gmail.com>
Subject: Re: [PATCH v2] power: supply: qcom_battmgr: Ignore notifications
 before initialization
Message-ID: <ZbDCd_R7NmXn6X0t@hovoldconsulting.com>
References: <20240103-topic-battmgr2-v2-1-c07b9206a2a5@linaro.org>
 <Za_iR0ctkgYO0W5L@hovoldconsulting.com>
 <b7e91951-e554-4baf-9b8d-fca4a2f0d412@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7e91951-e554-4baf-9b8d-fca4a2f0d412@linaro.org>

On Tue, Jan 23, 2024 at 06:53:46PM +0100, Konrad Dybcio wrote:
> On 1/23/24 16:59, Johan Hovold wrote:
> > On Wed, Jan 03, 2024 at 01:36:08PM +0100, Konrad Dybcio wrote:
> >> Commit b43f7ddc2b7a ("power: supply: qcom_battmgr: Register the power
> >> supplies after PDR is up") moved the devm_power_supply_register() calls
> >> so that the power supply devices are not registered before we go through
> >> the entire initialization sequence (power up the ADSP remote processor,
> >> wait for it to come online, coordinate with userspace..).
> >>
> >> Some firmware versions (e.g. on SM8550) seem to leave battmgr at least
> >> partly initialized when exiting the bootloader and loading Linux. Check
> >> if the power supply devices are registered before consuming the battmgr
> >> notifications.

> >> +	if (!battmgr->bat_psy)
> >> +		return;
> > 
> > This is not a proper fix. You register 3-4 class devices and only check
> > one. Even if your checked the last one, there's no locking or barriers
> > in place to prevent this from breaking.
> > 
> > Deferred registration of the class devices also risks missing
> > notifications as you'll be spending time on registration after the
> > service has gone live.
> > 
> > I'm sure all of this can be handled but as it is non-trivial and the
> > motivation for the offending commit is questionable to begin with, I
> > suggest reverting for now.
> > 
> > I'll send a revert for Sebastian to consider.
> 
> What you're saying is valid, but a "battery" device is always expected
> to be present. 

Yes, but that's not the point. battmgr->bat_psy is the first class
device pointer to be initialised, but that being set does not mean that
the other pointers are not still NULL when you hit this callback.

> If devm_power_supply_register fails, things would go very
> south very fast anyway.

Eh, no. Before the offending commit, if registration fails, we bail out
from probe() before registering the PMIC GLINK client (and callbacks) so
all is good.

That is no longer the case since b43f7ddc2b7a ("power: supply:
qcom_battmgr: Register the power supplies after PDR is up") which
happily ignores errors and could theoretically result in all but the
first class device being registered leading to further NULL derefs on
notifications.

I could have pointed this out in the commit message for the revert.

> I personally don't see this being a terribly bad fix, but I'm open to
> different propositions.

It's not a correct fix, only a band-aid that papers over the immediate
issue, I'm afraid.

Let's revert and if you care deeply about this you can possibly propose
a complete patch that addresses the above issues, even if I'm more
inclined to leave things as they were and not spend more time on this.

Johan

