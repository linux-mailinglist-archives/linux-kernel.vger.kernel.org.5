Return-Path: <linux-kernel+bounces-52801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D8C849CCF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEBA31F26A32
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4D724B5B;
	Mon,  5 Feb 2024 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8zWt1jP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72D41429C;
	Mon,  5 Feb 2024 14:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142571; cv=none; b=FZhLhrxfLso6RU9NzwTHmclwmSWB/TG7NU+HBQTL86fNojxE9O+DWpGyPedkUa3zSKc18UJwdCi/amJ0Clt/DiYke+oGxjNp4tLUny9tn9V3T2YreQHkvXgfSBDYeJuZT3p5eAkgKpju3MDiRKZMP25EVp8YEux/lXFdA/8AELI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142571; c=relaxed/simple;
	bh=6ablIt6+waMs7azbKT/PMUfSpGgQX2Q6sJAtWzCITww=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nBfyYibSBeyqaUdHOd/adkaVDXRcTOmcAHi+aeQ9s2vIVJkBJ6fLUr9uITr5Adl57fjc0tOM4IwZmWh/CveL27cdZ6AmpAh5h4JMm4GyVCE/KkIDy/5FxKShLkvfWaQMNzUtYX0RqSM5G0G3YgMmbedCXKwSJD4EP+76Ds3G3D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8zWt1jP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C23FC433F1;
	Mon,  5 Feb 2024 14:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707142571;
	bh=6ablIt6+waMs7azbKT/PMUfSpGgQX2Q6sJAtWzCITww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N8zWt1jPSwomWNhcShaWN1v5WUQYxbWOoRAwSTBx1bz3DO640gk2s6yJ7QftjLuSA
	 deZRZDMFr9iCeNRBolRYYkvz6zNqldekpfDM6AxYoXY8MHNnU+T6pz7aixF/ZaQiVW
	 7KpWgALv+uLC6CD+5pnwZC3oT5dChRRwFYcyRWdCkiCkh+OSltuD1JCbuEv6+YAK7T
	 VyWDuU75j/WrbYXik29aMsCKT58ZV78BL/TImh0DZJFxHHw4n4p6867IxQXGyS3/Tz
	 Ncixy2p6d2t763Sep+iBOymoFekKbWyiRh6u7H3czun8MaLyjQX2JkTxwVr3BGQpuB
	 oaI++xAOoYnXA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1rWzlY-000RWi-Cb;
	Mon, 05 Feb 2024 14:16:08 +0000
Date: Mon, 05 Feb 2024 14:16:07 +0000
Message-ID: <865xz36lp4.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: James Clark <james.clark@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	broonie@kernel.org,
	suzuki.poulose@arm.com,
	acme@kernel.org,
	James Morse <james.morse@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Rob Herring <robh@kernel.org>,
	Miguel Luis <miguel.luis@oracle.com>,
	Jintack Lim <jintack.lim@linaro.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Vincent Donnefort <vdonnefort@google.com>,
	Kristina Martsenko <kristina.martsenko@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Jing Zhang <jingzhangos@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/7] arm64: KVM: Use shared area to pass PMU event state to hypervisor
In-Reply-To: <ZcDg1sP3EYZG-i_3@linux.dev>
References: <20240104162714.1062610-1-james.clark@arm.com>
	<20240104162714.1062610-3-james.clark@arm.com>
	<Zb1mCCi13AJ_YjFZ@linux.dev>
	<8a908ee8-620a-d9c2-734b-5a6402950072@arm.com>
	<ZcDc8-FQo8wKavA4@linux.dev>
	<867cjj6ohz.wl-maz@kernel.org>
	<ZcDg1sP3EYZG-i_3@linux.dev>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: oliver.upton@linux.dev, james.clark@arm.com, coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, broonie@kernel.org, suzuki.poulose@arm.com, acme@kernel.org, james.morse@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, mike.leach@linaro.org, leo.yan@linaro.org, alexander.shishkin@linux.intel.com, anshuman.khandual@arm.com, robh@kernel.org, miguel.luis@oracle.com, jintack.lim@linaro.org, ardb@kernel.org, mark.rutland@arm.com, arnd@arndb.de, vdonnefort@google.com, kristina.martsenko@arm.com, tabba@google.com, joey.gouly@arm.com, akihiko.odaki@daynix.com, jingzhangos@google.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Mon, 05 Feb 2024 13:21:26 +0000,
Oliver Upton <oliver.upton@linux.dev> wrote:
> 
> On Mon, Feb 05, 2024 at 01:15:36PM +0000, Marc Zyngier wrote:
> > On Mon, 05 Feb 2024 13:04:51 +0000,
> > Oliver Upton <oliver.upton@linux.dev> wrote:
> > > 
> > > Unless someone has strong opinions about making this work in protected
> > > mode, I am happy to see tracing support limited to the 'normal' nVHE
> > > configuration. The protected feature as a whole is just baggage until
> > > upstream support is completed.
> > 
> > Limiting tracing to non-protected mode is a must IMO. Allowing tracing
> > when pKVM is enabled is a sure way to expose secrets that should
> > stay... secret. The only exception I can think of is when
> > CONFIG_NVHE_EL2_DEBUG is enabled, at which point all bets are off.
> 
> Zero argument there :) I left off the "and PMU" part of what I was
> saying, because that was a feature that semi-worked in protected mode
> before VM/VCPU shadowing support landed.

Indeed. The goal is that as far as userspace is concerned, the host
running in protected mode shouldn't impair the ability to run
non-protected VMs, and it should all be hunky-dory, unless you
explicitly ask for a protected guest (at which point you are facing a
lot of restrictions).

PMU definitely falls into that last bucket, although I would hope that
we eventually get some support by context-switching the whole of the
PMU state. Don't worry, it's going to be cheap...

Thanks,

	M.


-- 
Without deviation from the norm, progress is not possible.

