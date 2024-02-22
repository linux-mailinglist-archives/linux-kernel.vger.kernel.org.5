Return-Path: <linux-kernel+bounces-75761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D5985EE96
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6F71F228BD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECFC1428F;
	Thu, 22 Feb 2024 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGWWEz00"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCC511C82;
	Thu, 22 Feb 2024 01:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708564829; cv=none; b=lvo9wWpflVP3s/yW8pTX7HmQbNOl9rJ5vBcbaDJiH4OaY4FF4ppV4s5XeAM38a7R/Z2ji4UjFW2l1J2i00x30rJZ1JUouyRkeIosdiBqmXwrxVKXLggBZh9vUeYvPdtK46jRJXWNC7rinQ8heiOQjaQvOBrDpRGoN829wWQhQTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708564829; c=relaxed/simple;
	bh=oJice3h7lKvI03uvkbTvPLODbANJ+MXKqJ7PhH71xK0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ecePToxaxm0HLrESNVTQ0F/CmYz+21Kc+M6scV22olEdbIIMwt1JoaZe2L35Jcew98WNWHErJgSp5a/cu/dgG5G9cD9F/xwwcbtZ5vIJ+sWzP6O55C/tZw910fWPFO69gzo3PVwNnoFAYODpY4pxlFu1RJS62PJhDDlouRmRXQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGWWEz00; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC10EC433C7;
	Thu, 22 Feb 2024 01:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708564828;
	bh=oJice3h7lKvI03uvkbTvPLODbANJ+MXKqJ7PhH71xK0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AGWWEz00aMhBewq+Bt7qKL9JI3DE9/lP2Goc95JrMkbweIgFPx5BHTF1uUe2BS8Sc
	 cTDhIONgFOy2Gkci+gUXoATQ9Y9Vql9ZvVbrE+4gIUBeiWoqjYtUurDUeTQD8MdthA
	 9ABP9mFou6EZaVKG/ue95rGG736mxc2ybaMCQvfx/km91NwBIlrAAP6ddRJJGYOqpT
	 /xMZPnAo1+1LDbwuU1BKFuG6ks6udlgmneBEaYsoM/zGoH3nkIv4jDOJuSGVUeV8On
	 I+lqeFSCMhFLyBUP4/ukzl/YIhdSjvRp/T5rPRJuebdZWo5wd3bUM4wZt+gI6B3RkA
	 MHWxnpgphMwug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 93739D84BCA;
	Thu, 22 Feb 2024 01:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: sparx5: Add spinlock for frame transmission from
 CPU
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170856482859.21333.7578746670670805119.git-patchwork-notify@kernel.org>
Date: Thu, 22 Feb 2024 01:20:28 +0000
References: <20240219080043.1561014-1-horatiu.vultur@microchip.com>
In-Reply-To: <20240219080043.1561014-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
 daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
 rmk+kernel@armlinux.org.uk, u.kleine-koenig@pengutronix.de,
 yuehaibing@huawei.com, vladimir.oltean@nxp.com,
 bjarni.jonasson@microchip.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Feb 2024 09:00:43 +0100 you wrote:
> Both registers used when doing manual injection or fdma injection are
> shared between all the net devices of the switch. It was noticed that
> when having two process which each of them trying to inject frames on
> different ethernet ports, that the HW started to behave strange, by
> sending out more frames then expected. When doing fdma injection it is
> required to set the frame in the DCB and then make sure that the next
> pointer of the last DCB is invalid. But because there is no locks for
> this, then easily this pointer between the DCB can be broken and then it
> would create a loop of DCBs. And that means that the HW will
> continuously transmit these frames in a loop. Until the SW will break
> this loop.
> Therefore to fix this issue, add a spin lock for when accessing the
> registers for manual or fdma injection.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: sparx5: Add spinlock for frame transmission from CPU
    https://git.kernel.org/netdev/net/c/603ead96582d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



