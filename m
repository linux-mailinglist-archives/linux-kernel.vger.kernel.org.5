Return-Path: <linux-kernel+bounces-47362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5AC844D4F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7647FB20B37
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F274113BE91;
	Wed, 31 Jan 2024 23:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmMlgWeg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9773D56D;
	Wed, 31 Jan 2024 23:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706743226; cv=none; b=XrGOxqyDt8e95dMaiU0miOVkiEbGfmXd6pZqcxjHhrviWIiPjgmhWrGAzBNJNZGVt49ibaHvtKBVQzipBnmSFORWQNN0/ic8jEqrnr9ny6f/8QUZA+wdrHfALt60wwjhdND67vIsLJoW5OPZpiQlG2ZDzUxwWxuwhWNAJD6J/e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706743226; c=relaxed/simple;
	bh=YjchRn1j0HoZxhHAZdCfCE9OXw6PjDAB9pmgEv/aWAQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bV0zCJCA++b8E+SuHfjPZbwfd1u52OmTN5kxIup1WU4jjcU73rsmdRxmM+X+ykjx4JSbG8BJJcRrekbqcrw9TCHRD5RBqG8izIeBbxbieEOUnF0A4PTihZgsyNNVjqNMhCZonzXX5wlhyxDheAXqVMhRA6xPnn6eciOnAZqiI0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmMlgWeg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9F95C433C7;
	Wed, 31 Jan 2024 23:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706743225;
	bh=YjchRn1j0HoZxhHAZdCfCE9OXw6PjDAB9pmgEv/aWAQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cmMlgWegisTeP13/TPSM68U5m8C4LBXeuDSBMCCAXKjjR+W/tw0lbpY0jusfslO20
	 BFtEnOLzLlhPu3ImMXcj+U5XpWHEtyuqm0CRlVRkh505ROUwmIMjmvODGLwfyNJbgh
	 zRBmDPy9D3uwe9OvdzAnOIw7zQAH07Mk16Tmjf/i39kGwQq/8Yy3tZRTAg5rThdnlN
	 mLIeXM/jLWmmuJRiSJmXchUNPaoq0Mj4i6I0xd+AeM0iUJwUrEgfQfgHrTYu7+8uGk
	 ZHFIeiKp7GLPjLoovZiNOXkraL9IKNKWRlnIVYmoBk5szCLfSOr5N5V8cXTVtLkFvt
	 2nrHInso3sGYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E4EFC4166F;
	Wed, 31 Jan 2024 23:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ptp: lan743x: Use spin_lock instead of spin_lock_bh
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170674322557.11431.4839334192036860179.git-patchwork-notify@kernel.org>
Date: Wed, 31 Jan 2024 23:20:25 +0000
References: <20240128101849.107298-1-tanure@linux.com>
In-Reply-To: <20240128101849.107298-1-tanure@linux.com>
To: Lucas Tanure <tanure@linux.com>
Cc: bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 28 Jan 2024 10:18:49 +0000 you wrote:
> lan743x_ptp_request_tx_timestamp uses spin_lock_bh, but it is
> only called from lan743x_tx_xmit_frame where all IRQs are
> already disabled.
> 
> This fixes the "IRQs not enabled as expected" warning.
> 
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> 
> [...]

Here is the summary with links:
  - ptp: lan743x: Use spin_lock instead of spin_lock_bh
    https://git.kernel.org/netdev/net-next/c/96b93f08357c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



