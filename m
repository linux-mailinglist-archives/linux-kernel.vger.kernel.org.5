Return-Path: <linux-kernel+bounces-101212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5567487A411
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5CC01F21498
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C27D1B277;
	Wed, 13 Mar 2024 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d82jEuaD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20E318EB2;
	Wed, 13 Mar 2024 08:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710318029; cv=none; b=KqzdDbjf6rnNo4ey76+0FS3QDgYedAXcpNbRAUH6pjvl7daZzU5iP/qaIqxKKiILRwtMMutygCaMMlot5qOcS/9Ry7B0aYqGc3OXxiOcUl7EvjocgQ7sFdR1FYWw57AE5YTfyzpvxs/6/Q7zy8Q+0gUIWXFqsfTR2eA4k0zkIa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710318029; c=relaxed/simple;
	bh=WHOuWjV3IDXUssQ4CoKMeiF90k47wssjsrGAJV5cu4U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fHiEcN1YWYCUab3eLzolvu/JWCUN5mqrFqACODsCLRINIVs+KifNR7L4lL0RWMwHfIRyFccpqMGsbenYnpR58MYjAJGxfr8H3csFRPFCWLLfxiUl+K/wcIaSeMz0jrSycw54UaHkzAnFdO2dTW/t62Qt5qI4Qw34RjXib0c8Jm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d82jEuaD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6729AC43390;
	Wed, 13 Mar 2024 08:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710318029;
	bh=WHOuWjV3IDXUssQ4CoKMeiF90k47wssjsrGAJV5cu4U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d82jEuaD7bVXGbzKBcPIN9ASyXJ7OV2fy2+f5U1fckbB2EWSLafi2wY0g1ZYn0kQz
	 7Sz9Wp8GaYZ1B0ItYEbeT6NkNDE/JqR98d1hSK+GguXoS+L7wJ+cL6G1cTa/VjfwdI
	 v+QQrsjQIKtWMT4YRp8YtIgtRgzLoppxFUd6glWG6XTms5nkwCDqfHpXdfXB/NPNg8
	 6yWUSLnuNgqKL549fu2Ey3pjE93z9uhUIy+kEPj6+k+CbZuj8PlmGaHG3eT2xT+mAF
	 78OHYsEsT9np91CfAk7NpNR5sRsB3gqfcwXViOTr99HTaVp6RyUE6dCQ5p21N+BNjH
	 5dh5B9ObKRX3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4D806D95060;
	Wed, 13 Mar 2024 08:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 1/2] soc: fsl: qbman: Always disable interrupts when
 taking cgr_lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171031802931.29357.17308276522742025565.git-patchwork-notify@kernel.org>
Date: Wed, 13 Mar 2024 08:20:29 +0000
References: <20240311163830.12952-1-sean.anderson@linux.dev>
In-Reply-To: <20240311163830.12952-1-sean.anderson@linux.dev>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, vladimir.oltean@nxp.com,
 christophe.leroy@csgroup.eu, roy.pledge@nxp.com,
 linuxppc-dev@lists.ozlabs.org, madalin.bucur@nxp.com,
 s.trumtrar@pengutronix.de, claudiu.manoil@nxp.com, leoyang.li@nxp.com,
 oss@buserror.net, camelia.groza@nxp.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 11 Mar 2024 12:38:29 -0400 you wrote:
> smp_call_function_single disables IRQs when executing the callback. To
> prevent deadlocks, we must disable IRQs when taking cgr_lock elsewhere.
> This is already done by qman_update_cgr and qman_delete_cgr; fix the
> other lockers.
> 
> Fixes: 96f413f47677 ("soc/fsl/qbman: fix issue in qman_delete_cgr_safe()")
> CC: stable@vger.kernel.org
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> Reviewed-by: Camelia Groza <camelia.groza@nxp.com>
> Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> [...]

Here is the summary with links:
  - [net,v5,1/2] soc: fsl: qbman: Always disable interrupts when taking cgr_lock
    https://git.kernel.org/netdev/net/c/584c2a9184a3
  - [net,v5,2/2] soc: fsl: qbman: Use raw spinlock for cgr_lock
    https://git.kernel.org/netdev/net/c/fbec4e7fed89

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



