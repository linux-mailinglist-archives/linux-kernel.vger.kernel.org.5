Return-Path: <linux-kernel+bounces-67292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F20856946
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E355288057
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E0813A885;
	Thu, 15 Feb 2024 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iqy+2rtv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F144134725;
	Thu, 15 Feb 2024 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013431; cv=none; b=qL7wUJbC1V+n7/5pOAPx0jZzaoHs3Tn1DgTdTTnI1/WWVT0EdngRWZ5NNWo+//jxsLviU28Yr/xlydY5KLxNMGuESKUhP4W/IPpLvS+Od0SiNDp+AM01G5f4Kej1SIHY2eNAtxJsnTU+71388HsX4cswedix7U71u4ilEOJoqFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013431; c=relaxed/simple;
	bh=csHU2dVdvi6wNw0t1Q0Uvz4xWdReEtSKu2k3/exycJk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A2uLvqEwaH8XrgqyOuq/IAbYp3f9bnQJMaS6IiY2uTTP4dEWm8c3XRgzKEkfOSu3UA2PcZP+E2esR/7HGCkSTT2TPxoOhQgPEnsobIsy90eGe1oYfNjW6bPPaatq55eRf0Rp17EnSxNDb9jMoqyh+breWovU2SBTO1MaVDW93cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iqy+2rtv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E77B5C43394;
	Thu, 15 Feb 2024 16:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708013431;
	bh=csHU2dVdvi6wNw0t1Q0Uvz4xWdReEtSKu2k3/exycJk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Iqy+2rtvU9WQC9dVk0XHWldjVAQsBU4CEgTNWDfSFUiKjRMtrPRxmR4Xdqylwl5od
	 IbT5LjGBsk0fCbBdQnTmijrx6hM8/tKs9IlirloWqKWTwvtM3SbZ2SoA/rXkfNq9ya
	 Io9UyquAwKguBtIdZ6d9ZqeSi24jOLxIOSnzRm/JPjamlh0ckM9cRUGOLI4AcQN2FX
	 cIZiBhcAaC6uib00yZOS4vVYg/NrZ5VEXWQ1asqJzFcQvEn33+yseLezAyXKMNTyVm
	 BueFb6OfGaXaQQYWJ/tLJkeYOn2+h49fDltJ00kurdkGhbtXgUVKbA9WXeY9efSDA6
	 U0DsouUiWDZZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C8FBEDC9A08;
	Thu, 15 Feb 2024 16:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: ravb: Count packets instead of descriptors in
 GbEth RX path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170801343081.17977.4230371879642264476.git-patchwork-notify@kernel.org>
Date: Thu, 15 Feb 2024 16:10:30 +0000
References: <20240214151204.2976-1-paul.barker.ct@bp.renesas.com>
In-Reply-To: <20240214151204.2976-1-paul.barker.ct@bp.renesas.com>
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, yoshihiro.shimoda.uh@renesas.com,
 wsa+renesas@sang-engineering.com, nikita.yoush@cogentembedded.com,
 u.kleine-koenig@pengutronix.de, claudiu.beznea.uj@bp.renesas.com,
 prabhakar.mahadev-lad.rj@bp.renesas.com, biju.das.jz@bp.renesas.com,
 netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Feb 2024 15:12:04 +0000 you wrote:
> The units of "work done" in the RX path should be packets instead of
> descriptors, as large packets can be spread over multiple descriptors.
> 
> Fixes: 1c59eb678cbd ("ravb: Fillup ravb_rx_gbeth() stub")
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
> This patch has been broken out from my previous series "Improve GbEth
> performance on Renesas RZ/G2L and related SoCs" and submitted as a
> bugfix as requested by Sergey. I've labeled it as 'v3' so the ordering
> is clear. Remaining patches from the series will follow once we've done
> gPTP testing.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: ravb: Count packets instead of descriptors in GbEth RX path
    https://git.kernel.org/netdev/net/c/ed4adc07207d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



