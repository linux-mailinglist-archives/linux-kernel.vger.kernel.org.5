Return-Path: <linux-kernel+bounces-93282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A54872D76
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BDF81F252A5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89C514280;
	Wed,  6 Mar 2024 03:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVOkVR2b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328D9DF43;
	Wed,  6 Mar 2024 03:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709695229; cv=none; b=FFWyye9CfkgSvSR/1Ofqp7fBKZ/iGizRaa4CjzcjWpxSSbhhTCWMUMSyMtHyBogkB3LZSPIifOvpBnb8shLK3YAs0XINWBeo202rz7spFL/gOQwwgNkh+aDTMYE2Akp++ppowRdgjcIyFUD9WQYf8l8CATddQ5HJ6yADaBqnaEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709695229; c=relaxed/simple;
	bh=VtOXsGaPWmEue4lEr3OdFcOU6LCRSF/qhkR0cK9mHKA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oeBKaiYLh6iBBBtHDRZPMQRh+yNKOxQorKypjfLfhrxCLOWZkEXbFBWsTS0NOug+KvxlteLod+b0Kbc7YdSg5kdbpb6JdmI9G2ac1ZllF51eI4G/Do+WQz88P5BOVoRE73goC7P/6m9QNKltWv1KwbL2SYHXE/Ty4kHqMBCPSsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVOkVR2b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 014B8C43390;
	Wed,  6 Mar 2024 03:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709695229;
	bh=VtOXsGaPWmEue4lEr3OdFcOU6LCRSF/qhkR0cK9mHKA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pVOkVR2bLQl6aPlFwiYVuMTjGqEm0Do+0imT63XAH4SMthPkzsEEDArkuwGHoX+HZ
	 K7y7mmoWQPZZqn28vUU2Li1qLn7Qc4Su/salrHv0GZTdMBh4QL1I4qEWzLfAT2R7b+
	 Mzj7fDn7MoLt0P5DOJXy2JEMEEMsC2kHhoV7mjR9QoI7i51eq8FzFw78oEG/MuwaVX
	 s/pI3vWrvlf8PqGQZrNuxJJdHupNr19G7m7SEdc1lEFAfOcF5ZMUzKW4ndLsIQfFiQ
	 PdaCQ8bit0Gn38hd3QVWlemGA7Mvk+Cv6TmWGJre+vb+dSqWTJQJj4f9ZXmtWdRcLq
	 tGP0KBZgxZP1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D982DC04D3F;
	Wed,  6 Mar 2024 03:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: microchip: fix register write order in
 ksz8_ind_write8()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170969522888.30303.17315909083697603983.git-patchwork-notify@kernel.org>
Date: Wed, 06 Mar 2024 03:20:28 +0000
References: <20240304154135.161332-1-tobias.jakobi.compleo@gmail.com>
In-Reply-To: <20240304154135.161332-1-tobias.jakobi.compleo@gmail.com>
To: None <tobias.jakobi.compleo@gmail.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, o.rempel@pengutronix.de,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  4 Mar 2024 16:41:35 +0100 you wrote:
> From: "Tobias Jakobi (Compleo)" <tobias.jakobi.compleo@gmail.com>
> 
> This bug was noticed while re-implementing parts of the kernel
> driver in userspace using spidev. The goal was to enable some
> of the errata workarounds that Microchip describes in their
> errata sheet [1].
> 
> [...]

Here is the summary with links:
  - net: dsa: microchip: fix register write order in ksz8_ind_write8()
    https://git.kernel.org/netdev/net/c/b7fb7729c94f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



