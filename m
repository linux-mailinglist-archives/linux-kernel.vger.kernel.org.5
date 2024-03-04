Return-Path: <linux-kernel+bounces-90532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABE08700C7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4DC41F21D25
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CD13BB28;
	Mon,  4 Mar 2024 11:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jr6uTHQ4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67151250E2;
	Mon,  4 Mar 2024 11:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709553032; cv=none; b=HX7ntXEWswMkUbLALi9DgIGWIjFX3FLaRAEDZFWhSOcKHOvc4C9LxqWTxYEapO280QskbBd/Fi2inLXsUJL2+VOO58nBhXRIqPXlUhtpuNhGD/A96Zi0nHGkRbgDKoe54zqEiNHVUMV3aU/MN1ZIDsyS09s4kQsyXB6CGiYXhak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709553032; c=relaxed/simple;
	bh=jT2/furrCydOEBIbad8LySxFMG2kvxtCTG4GzM5ZTvY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F+co/YHLplrS6a+E9eIfGONSR4iMk4cdM7zkNaNZXWHUtMlnf8t65+P46ArYHLEV6dkXgYvZizmTOBYZ8Awcg8xXK++rAD1sH4DuZxz59ODtn7SiMGBYLG3P3YQ7tbD7nU5fjKKgP3z0iA/TI/hgOQGyOb+h+Sjb4YsjDXa+CqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jr6uTHQ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E17C8C433F1;
	Mon,  4 Mar 2024 11:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709553031;
	bh=jT2/furrCydOEBIbad8LySxFMG2kvxtCTG4GzM5ZTvY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Jr6uTHQ4WhXGKIhfZmn0zqSIcPWcykrrWkyNGtDPdCXqXNtiFrrO3o/f3GfP2Y5w6
	 4UGUGzOhHUeb0DGz2aQZ5bWGxkXNpKy6Q+rbHzlCR2lBfbykr3t8UvH5iM3krRGdp2
	 4OhxwAcldDo7x3zbRZJnr+cci7TOeJyPKH8reFci1aa65Po55G8VPnepypr1YcCC6s
	 7Fq68zt037KgbXpwhCG+y8y9xXDP2sbiPbX7qmNK0pPDH2jhKPJVzRh0epshD7qEcy
	 fUZ82IuraZ2GQeMZomN4gZB95rKQ5KB0uyrhzyICjXG8yKDOISCXKhQ8CLtoBmchqY
	 7txoosW5E9Leg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C8FF9D9A4BB;
	Mon,  4 Mar 2024 11:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/7] net: ipa: simplify device pointer access
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170955303081.27377.10483078205421623482.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 11:50:30 +0000
References: <20240301170242.243703-1-elder@linaro.org>
In-Reply-To: <20240301170242.243703-1-elder@linaro.org>
To: Alex Elder <elder@linaro.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, mka@chromium.org, andersson@kernel.org,
 quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
 quic_jponduru@quicinc.com, quic_subashab@quicinc.com, elder@kernel.org,
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  1 Mar 2024 11:02:35 -0600 you wrote:
> This version of this patch series fixes the bugs in the first patch
> (which were fixed in the second), where ipa_interrupt_config() had
> two remaining spots that returned a pointer rather than an integer.
> 
> Outside of initialization, all uses of the platform device pointer
> stored in the IPA structure determine the address of device
> structure embedded within the platform device structure.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/7] net: ipa: change ipa_interrupt_config() prototype
    https://git.kernel.org/netdev/net-next/c/e87e4371edfc
  - [net-next,v2,2/7] net: ipa: introduce ipa_interrupt_init()
    https://git.kernel.org/netdev/net-next/c/ad1be80d7582
  - [net-next,v2,3/7] net: ipa: pass a platform device to ipa_reg_init()
    https://git.kernel.org/netdev/net-next/c/a47956e72a3e
  - [net-next,v2,4/7] net: ipa: pass a platform device to ipa_mem_init()
    https://git.kernel.org/netdev/net-next/c/95c54a963b24
  - [net-next,v2,5/7] net: ipa: pass a platform device to ipa_smp2p_irq_init()
    https://git.kernel.org/netdev/net-next/c/59622a8fb453
  - [net-next,v2,6/7] net: ipa: pass a platform device to ipa_smp2p_init()
    https://git.kernel.org/netdev/net-next/c/81d65f3413da
  - [net-next,v2,7/7] net: ipa: don't save the platform device
    https://git.kernel.org/netdev/net-next/c/5245f4fd28d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



