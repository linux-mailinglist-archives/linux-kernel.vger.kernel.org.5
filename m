Return-Path: <linux-kernel+bounces-71166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1BC85A189
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 792C8280D7C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061902C69F;
	Mon, 19 Feb 2024 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8rRTUZi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDC82C1A2;
	Mon, 19 Feb 2024 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708340426; cv=none; b=FzLA7NkIfrWW5lykY9dLgHEoqyaxRBZoXhfK5mDsvtglN4SRbSy6nG7C72ufhz8zz51PAawqkhU2YtdOPitipCsA984tUL6GTmihJOBVS6bniHHn6knUqn1xeSeMQbyjfyHr+B0zJME1HnomH5GGY3vOEqvxEtcABFuw5+RbDKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708340426; c=relaxed/simple;
	bh=PyNFL+6BLJw6xZmpuPkzL57htYw4lW/sVgvmF1B5y4c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SAKKFU5pi/vXWCX3H2ZKB04zmPlfPPjgEEmmtXW16f1d0aX+F8CKD9zj152JLeqBTN1cVnAzOZFMjtowUIkqBuvhIKc2SQnxJzk7Pkhr1PlFnG39IXVX27BUWzKqXWs2rgVDa4HuDnlxnFxci8zWkNwgJqQwA85tF0qTuuEGAbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8rRTUZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0924C43390;
	Mon, 19 Feb 2024 11:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708340425;
	bh=PyNFL+6BLJw6xZmpuPkzL57htYw4lW/sVgvmF1B5y4c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I8rRTUZiP0lB7C+Clqrro4aOUvetw+cRcIYDmG31Bs1RyZSKLXhzRusSLsotRM9y8
	 spetq3fYnLUC4/snF4orR9m1DOY/dXUcZ6H4ife/rMFHFlbus84wPoIdzLpGapBrYe
	 NYi5sN2lFLPZyqJuO88ruTVFmgV67ZO92m2R59izpKT8PVr4HC7MbrA9nVXpQ8xsNX
	 ln1fGD8wCE3GnyuyQ2b+s7dHjt6TGKv1dOQiLDUJTOuWgIZ5lAA2/I43p8bpQXvMZe
	 JNRpuHNjtTZnJfmiOSQFP75+5hcaaBdjdpC0f8HtN4sm2DVX1lY3SWapuTOAtJ+991
	 s30Uxzf2Rx2VA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 968FAD990CD;
	Mon, 19 Feb 2024 11:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] enic: Avoid false positive under FORTIFY_SOURCE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170834042561.18215.8969035309568775232.git-patchwork-notify@kernel.org>
Date: Mon, 19 Feb 2024 11:00:25 +0000
References: <20240216233004.work.012-kees@kernel.org>
In-Reply-To: <20240216233004.work.012-kees@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: benve@cisco.com, satishkh@cisco.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 gustavo@embeddedor.com, netdev@vger.kernel.org, gustavoars@kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 16 Feb 2024 15:30:05 -0800 you wrote:
> FORTIFY_SOURCE has been ignoring 0-sized destinations while the kernel
> code base has been converted to flexible arrays. In order to enforce
> the 0-sized destinations (e.g. with __counted_by), the remaining 0-sized
> destinations need to be handled. Unfortunately, struct vic_provinfo
> resists full conversion, as it contains a flexible array of flexible
> arrays, which is only possible with the 0-sized fake flexible array.
> 
> [...]

Here is the summary with links:
  - enic: Avoid false positive under FORTIFY_SOURCE
    https://git.kernel.org/netdev/net/c/40b9385dd8e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



