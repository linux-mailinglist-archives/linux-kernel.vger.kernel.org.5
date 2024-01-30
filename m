Return-Path: <linux-kernel+bounces-43840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D204084196C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D3432885EE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6657737179;
	Tue, 30 Jan 2024 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRs+e7Y4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A470B36B1C;
	Tue, 30 Jan 2024 02:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706582425; cv=none; b=l65V/dDEn0TAvwqF+74k51zL91VLCWnvU55KXxuGFpSnuoRhZO5svvCixsU+9c4eEQmlNV4mAVqAqNKF06ISUd+umcnd0xl04vW5wdgQ4ZXilgLNzBwLoZpJQZvXuf3sa8+kCCuaNRRFrA6Qj/lhyqETKNA+uV7zrnlCxkG1S+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706582425; c=relaxed/simple;
	bh=dGfWjqEV/3CsfYMoXPfrOB2UNXCZuOUBF/oNPRXQk7g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bpv7TiHt12/NI77qpDCni6VQ8+kRz/MK6fmWdH2YqaMJl/AXLsB1LjiE4s0K9XU1n7N08aV0I4oG7s2lPh7ornavCzHYzY4T4kbZsXwjHMXQ9xCn3WXpQGMXeXHbhBwkpr+83cGkn4XJT/x9zbQ5W8r0ObAt/HbWuKtjHGn8oJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRs+e7Y4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25BEAC433C7;
	Tue, 30 Jan 2024 02:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706582425;
	bh=dGfWjqEV/3CsfYMoXPfrOB2UNXCZuOUBF/oNPRXQk7g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LRs+e7Y4BLQvSawg7FP9xU0V07xTKEDhcd4u5skI4aRr7h0niuZJDb6Ldzbh5Svsx
	 FCaI6+uRBpwlgKyxdt/EzvcrbshWy05v44N2jLnAxvesLWKQgaUsgfYWIKRj39oTF5
	 o3ZdVPApG5dPebLy6jSO9qeMs6d3bu1Go32s97y5UfqbZBwVAAweFNx/n6LrKj2utU
	 gEfLdSNy+2sqssIZhcMZRr7s6ZAS3p/zhPrhDjkaxEv297RNEOUEpSXnsPZ6TPyBD9
	 7GP0eLZ2mUG+9zDfqHLGLrGGC0KM3E4tNvI5TBOAMxkaMkP3sS8OcH3/PtWGEdZGm1
	 hBjxuZDy3KrRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 10FB7C00448;
	Tue, 30 Jan 2024 02:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: tcp: accept old ack during closing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170658242406.31723.1004142308570519706.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jan 2024 02:40:24 +0000
References: <20240126040519.1846345-1-menglong8.dong@gmail.com>
In-Reply-To: <20240126040519.1846345-1-menglong8.dong@gmail.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 26 Jan 2024 12:05:19 +0800 you wrote:
> For now, the packet with an old ack is not accepted if we are in
> FIN_WAIT1 state, which can cause retransmission. Taking the following
> case as an example:
> 
>     Client                               Server
>       |                                    |
>   FIN_WAIT1(Send FIN, seq=10)          FIN_WAIT1(Send FIN, seq=20, ack=10)
>       |                                    |
>       |                                Send ACK(seq=21, ack=11)
>    Recv ACK(seq=21, ack=11)
>       |
>    Recv FIN(seq=20, ack=10)
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: tcp: accept old ack during closing
    https://git.kernel.org/netdev/net-next/c/795a7dfbc3d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



