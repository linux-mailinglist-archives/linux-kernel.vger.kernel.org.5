Return-Path: <linux-kernel+bounces-166107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D70138B9647
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6584D1F23D0D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABDA383AE;
	Thu,  2 May 2024 08:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfWXzONG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8424D2E85A;
	Thu,  2 May 2024 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714638030; cv=none; b=qAR5CSJz+Ea12FnOAdnO2WTmMsgR4MMaPGU0TmC+XIcF18DWP1Te3tYTtHk9qksrlCQ2E/JgrnO7VJgqNwRZaK8rA7uRQEDQqoA0dclnzzWfnWiKkZ9oZeY3QBNl3voIXnt9c9iMfy+Mk/lYpYxVIYdRP/jkDGmwC/jeB7XJlBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714638030; c=relaxed/simple;
	bh=YQBen27imwkHlJoTAfQQ4ESQW0FwT0KYy1Oj/L+TEGo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q4C2uDi7wMtxvU9I6osKWyzHze6YWXEl/nChidhfEcF71WkypvZYuv9XVw5XUwNhTO54IW6hEpdGhUNH+W5m0VFKfd/IHXy9CSakDFrID5x1kXTh002FSiu8O1aKZioEEcTiCxKJ46yZOd/KWfUBFkSqpECIiIV+zxLkArNjoQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfWXzONG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 053AAC116B1;
	Thu,  2 May 2024 08:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714638030;
	bh=YQBen27imwkHlJoTAfQQ4ESQW0FwT0KYy1Oj/L+TEGo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pfWXzONGYCYwbAQg2NspsS6CFJykuMQIpE3pZwVA373yc7nPGK0Fc6kksIEhtXGkP
	 3o2ur3j/Bzo0a/BHwDgTCsJB/RrfHZolCn5maUcDQU2gec9IJCPe8DlPWHTqp2frTy
	 mPMmCieXf34NjnV5seaqwTvw5G5SWSy7I6mxCz7jF6SOd4yaSLVPFWEc6801SIp2zy
	 Hf7YQcwGayga6rjWC29RixYMej0Enx7Ojfizy9i3Wx2NYfry5Adp+G3meFUdS8uTJG
	 /i4Z3q56Y1iuXm3wY3GkI38u/gR+iSEtPszN7+NMrghyWJcENTjvorWYnK1Udj1owI
	 AqSVPnOIwDB8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA016C43335;
	Thu,  2 May 2024 08:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ipv4: Fix uninit-value access in __ip_make_skb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171463802995.31501.18180325804062708968.git-patchwork-notify@kernel.org>
Date: Thu, 02 May 2024 08:20:29 +0000
References: <20240430123945.2057348-1-syoshida@redhat.com>
In-Reply-To: <20240430123945.2057348-1-syoshida@redhat.com>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Apr 2024 21:39:45 +0900 you wrote:
> KMSAN reported uninit-value access in __ip_make_skb() [1].  __ip_make_skb()
> tests HDRINCL to know if the skb has icmphdr. However, HDRINCL can cause a
> race condition. If calling setsockopt(2) with IP_HDRINCL changes HDRINCL
> while __ip_make_skb() is running, the function will access icmphdr in the
> skb even if it is not included. This causes the issue reported by KMSAN.
> 
> Check FLOWI_FLAG_KNOWN_NH on fl4->flowi4_flags instead of testing HDRINCL
> on the socket.
> 
> [...]

Here is the summary with links:
  - [net,v2] ipv4: Fix uninit-value access in __ip_make_skb()
    https://git.kernel.org/netdev/net/c/fc1092f51567

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



