Return-Path: <linux-kernel+bounces-71531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8125585A6C7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22CCAB211D4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11AF381C4;
	Mon, 19 Feb 2024 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlLLfKxp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6FB376EC;
	Mon, 19 Feb 2024 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708354936; cv=none; b=bxPi2sPCdS2z8pghXVnyoRGtFop7ZgASc4pKptuJxr7GiaTRSJ2bLzd0lEvijN+7ir31MRLk2KfXAhCAHkWDDXT+uayaid/apwn9dFojo4D6MAvbt+bDktj7k8wz611osTQ9tpmXPKiY659bNmVrUZ1HSjmZtPot8Iaaxj/YOAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708354936; c=relaxed/simple;
	bh=qkvjpH6GcUSoKvmAK9+dudgyRxq2VO9xR86tq/v/1SU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=mVm9fBFfDjRwDU7KqR0Worwd29H3j3LahUhPf8JGIvxvZ1zq5ge6RKXBrqO1Q9vEzqp7qyP7lBRR+5kg5EsqF5KGPQ7AUvghtFqRKKdNR/zNH55uAUVqfdcPvT3AhQOyW+ryQkaqF+48tPMMJvqyP1UYck5MqyhPiSM5U+yctKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlLLfKxp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD934C433F1;
	Mon, 19 Feb 2024 15:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708354935;
	bh=qkvjpH6GcUSoKvmAK9+dudgyRxq2VO9xR86tq/v/1SU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FlLLfKxp4qgMC3C+sIlHLlkwXCefLV63VVOU7xikaY+/U2s1DyNILgjPgkCN+9epS
	 24t2pX3PJxpwd+TqdIaKSwyiw8cIrzttU0/pSnExtwmqvEcHUeruUUVshtOENlFeoJ
	 8Uinxezxeiu+aXba0uQEA/astLhhW9EMzc7gO6JBvfINHQ94jo8AqAcH7nJygp2Dzr
	 mws6VTHRkOfWzgG3Elyt+HbmA/Vq5gWt9gcd4h2ND8QkeFeklew+akKdJ23K05c8YN
	 1A5GsMuaPEPK1eBr/0x3GjtN6jQnFGLttEgzPXBTFzftoR/3rxWpDEuyPL/azbMjUI
	 7NV9lMjXDL48A==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1rc59k-004bwO-7z;
	Mon, 19 Feb 2024 15:02:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 19 Feb 2024 15:02:07 +0000
From: Marc Zyngier <maz@kernel.org>
To: Zenghui Yu <yuzenghui@huawei.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, open list
 <linux-kernel@vger.kernel.org>, Linux ARM
 <linux-arm-kernel@lists.infradead.org>, lkft-triage@lists.linaro.org, Linux
 Regressions <regressions@lists.linux.dev>, Catalin Marinas
 <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, Dan Carpenter
 <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Subject: Re: next-20240219: arm64: boot failed - gic_of_init
In-Reply-To: <a7d8e529-9a44-3f88-50ef-d87b80515c36@huawei.com>
References: <CA+G9fYugYiLd7MDn3wCxK+x5Td9WO-VUX2OvOtTN7D1d4GHCfg@mail.gmail.com>
 <86edd84wer.wl-maz@kernel.org> <86cyss4rl7.wl-maz@kernel.org>
 <a7d8e529-9a44-3f88-50ef-d87b80515c36@huawei.com>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <20adfff58d44d09d0e968f5c502f28ce@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, naresh.kamboju@linaro.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lkft-triage@lists.linaro.org, regressions@lists.linux.dev, catalin.marinas@arm.com, arnd@arndb.de, dan.carpenter@linaro.org, anders.roxell@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On 2024-02-19 14:46, Zenghui Yu wrote:
> On 2024/2/19 19:32, Marc Zyngier wrote:
>> For what it is worth, I've just tested both defconfig and my own
>> configuration with both 4k (kvmtool, QEMU+KVM and on SynQuacer) and
>> 16k (kvmtool), without any obvious problem.
> 
> I had a quick test on top of next-20240219 with defconfig.  I can
> reproduce it with QEMU parameter '-cpu max -accel tcg', but things are
> fine with '-cpu max,lpa2=off -accel tcg'.
> 
> Bisection shows that the problem happens when we start putting the
> latest arm64 and kvmarm changes together.  The following hack fixes the
> problem for me (but I **only** write it for kernel built with defconfig
> with ARM64_4K_PAGES=y atm).
> 
> I can investigate it further tomorrow (as it's too late now ;-) ).  Or
> maybe Marc or Catalin can help fix it with a proper approach.
> 
> diff --git a/arch/arm64/kernel/cpufeature.c 
> b/arch/arm64/kernel/cpufeature.c
> index 4f7662008ede..babdc3f4721b 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2798,6 +2798,7 @@ static const struct arm64_cpu_capabilities
> arm64_features[] = {
> | 		.sign = FTR_SIGNED,
> | 		.field_pos = ID_AA64MMFR0_EL1_TGRAN4_SHIFT,
> | 		.min_field_value = ID_AA64MMFR0_EL1_TGRAN4_52_BIT,
> |+		.max_field_value = BIT(ID_AA64MMFR0_EL1_TGRAN4_WIDTH - 1) - 1,
> | #else
> | 		.sign = FTR_UNSIGNED,
> | 		.field_pos = ID_AA64MMFR0_EL1_TGRAN16_SHIFT,

Yup, got to that point too.

Working on a slightly more elaborate fix.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

