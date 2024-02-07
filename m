Return-Path: <linux-kernel+bounces-56171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A00684C6F3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D2F1F25138
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E843420B38;
	Wed,  7 Feb 2024 09:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpVjA9hi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2571922307;
	Wed,  7 Feb 2024 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297026; cv=none; b=HUyrlX/I6ag/oBuo9xGhryo4IXEjmK98H4ocwbVran26/pNpO67UD7lJ8u0QonOd4QcjslIj1FcZMGVDb/D7owWwOLcHoylgUTli06juCFnBcNU2wqSrjhr6aezhq3UK8u0sC4DKxariTe7WfEG/boNmXqWcN2hwAYWwGQt6xf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297026; c=relaxed/simple;
	bh=3Skvn/dUoFSwXi54r9T2MMdejeTQaB6k0PKGKLgLFW8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OMt7jkMG2sXZ2DDxTbyjJwKhEqoBvVvUdAY0SLg2v31v5QSSTE8KHnHtpwYFM8INoqmpiYD7K1debnM07GwzKpKnmq2t/tkGogGCuvPczgVRu5l6xAqRrvtG0VYWu4hABXbIfoA4fF6uY9OR87ETcGxA+qJamjDgZcU5v5Hb+FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpVjA9hi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E773C433C7;
	Wed,  7 Feb 2024 09:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707297025;
	bh=3Skvn/dUoFSwXi54r9T2MMdejeTQaB6k0PKGKLgLFW8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JpVjA9hi1PaqsZIiPpiX1hoyJ6QubNOqHgQGqadY/ZlSwQpDZevC20ottlioalOio
	 cpuxfbsbNgLGI7P5fvOp5m95VdLNvCcaroiZP/ZpHtbH8a1V/KPfNlIwVqoqOv/cDR
	 zJvWYTi2j9O/6pGfnyxQiT8XE1IT+lTKY0sa2MTJ3fOERzHmL89eJUJ3YI5FFPYFZp
	 Me2RVjPMY2VPi2RLjKXlUJ0bIsHwzUJ8c6GT8pJhR/jdYfzM5P25t5ovoA3MERwWuW
	 fxur5Ed2er7vR/xyJnLUkeMcdXnZCm2u7/U0nPfNwEmJS73jdbjBuOJbkXNJXNbSBr
	 rqnTjW1bObaEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6549FD8C96E;
	Wed,  7 Feb 2024 09:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: stmmac: protect updates of 64-bit statistics
 counters
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170729702541.31522.8754905006786635767.git-patchwork-notify@kernel.org>
Date: Wed, 07 Feb 2024 09:10:25 +0000
References: <20240203190927.19669-1-petr@tesarici.cz>
In-Reply-To: <20240203190927.19669-1-petr@tesarici.cz>
To: Petr Tesarik <petr@tesarici.cz>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, wens@csie.org, jernej.skrabec@gmail.com,
 samuel@sholland.org, jszhang@kernel.org, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev, mh+netdev@zugschlus.de, andrew@lunn.ch,
 f.fainelli@gmail.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat,  3 Feb 2024 20:09:27 +0100 you wrote:
> As explained by a comment in <linux/u64_stats_sync.h>, write side of struct
> u64_stats_sync must ensure mutual exclusion, or one seqcount update could
> be lost on 32-bit platforms, thus blocking readers forever. Such lockups
> have been observed in real world after stmmac_xmit() on one CPU raced with
> stmmac_napi_poll_tx() on another CPU.
> 
> To fix the issue without introducing a new lock, split the statics into
> three parts:
> 
> [...]

Here is the summary with links:
  - [net,v3] net: stmmac: protect updates of 64-bit statistics counters
    https://git.kernel.org/netdev/net/c/38cc3c6dcc09

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



