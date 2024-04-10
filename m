Return-Path: <linux-kernel+bounces-137768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9D789E6DF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09D391C21180
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143124A3E;
	Wed, 10 Apr 2024 00:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dK05UXMI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502F339B;
	Wed, 10 Apr 2024 00:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712709031; cv=none; b=SaAt6hirhuuoFAp2OVJgGB906LxhKqQ5/fvoY7jRLLu1MeKvebum5sVt/ywXBDd4DwAPhQc3shekSQr8Z5xIK+vZ0PusTD3trhdO3AWqn1kvf2MEFH095hkp18En2PhbYQDVq4VDczAsxb9tWRhSrtZoScltHTWEkQ3FP7tejXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712709031; c=relaxed/simple;
	bh=gqTHKqsyAU163NzCL7lYEHSF6VfvBNSuZd9R9+AQZqc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DG72SX2NFNp9RJbCiyNv/gVwcwdcj5PCVcYeLAiYTFcINNPrbCdVeGpRJQVMdsdHoOA9aewqgjw2ID8pdz6TujuV4El0Vr5U/AdaS81CK8uzNIWarpI+U38o5z27Yci5UHIJu8dV2lOgZadjnZ/C8JPvFC67oNuVgJd0Q9KTzrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dK05UXMI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9F2EC433C7;
	Wed, 10 Apr 2024 00:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712709031;
	bh=gqTHKqsyAU163NzCL7lYEHSF6VfvBNSuZd9R9+AQZqc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dK05UXMIKJS9bTTkN6VoRZQwzZdOOamuMz/PfZ32eYh4mvihBoH2/1sHSDVGMWhLh
	 RY+sOe66A1VdfWQHSvo71ZjvoXlGG6PZ5oexaC6VwwiHUgpqzyj4XyJLjjUheBma9H
	 1IzDQlT6ZO5ZTPucd1dTpIvCHYLdcJqhrgwNFF7wiQbU3FLsZoy4Rfqh/LyzpJJY3v
	 2Inv/j5x5jFHx8+7viw1Fraxx8EOwdo2do4LEo/9Wj6JxOpLEaTSvMU8kpQZfhFR/6
	 IoIF5iTYrpBHrjQ3IjElj9xzsmICpC5mLVbnih3hehgmQX+pkx5m8+SSfTGIIyW8UP
	 7NFCXZGnQt67w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DD26ED60313;
	Wed, 10 Apr 2024 00:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: phy: dp8382x: keep WOL settings across
 suspends
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171270903090.7096.4342007764039088497.git-patchwork-notify@kernel.org>
Date: Wed, 10 Apr 2024 00:30:30 +0000
References: <20240408082602.3654090-1-catalin.popescu@leica-geosystems.com>
In-Reply-To: <20240408082602.3654090-1-catalin.popescu@leica-geosystems.com>
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 m.felsch@pengutronix.de, bsp-development.geo@leica-geosystems.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Apr 2024 10:26:02 +0200 you wrote:
> Unlike other ethernet PHYs from TI, PHY dp8382x has WOL enabled
> at reset. The driver explicitly disables WOL in config_init callback
> which is called during init and during resume from suspend. Hence,
> WOL is unconditionally disabled during resume, even if it was enabled
> before the suspend. We make sure that WOL configuration is persistent
> across suspends.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: phy: dp8382x: keep WOL settings across suspends
    https://git.kernel.org/netdev/net-next/c/9ef9ecfa9e9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



