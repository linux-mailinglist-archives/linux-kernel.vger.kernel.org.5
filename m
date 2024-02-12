Return-Path: <linux-kernel+bounces-61284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D33E2851059
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FA761F22258
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995C817C7C;
	Mon, 12 Feb 2024 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUU9AkGB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FD9101D0;
	Mon, 12 Feb 2024 10:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707732625; cv=none; b=IznsSUJvdHl0Wj0Zfn4D+apaVzUrJwPGvvuegZp0S9dmaCal/YotTZ2X/9eKUY6sDpPKbNDy8HHeKxVXIq70h62GvS3rBuBHYvJZFf6lLe7EkrRyM0TE2hOHYNi84ZHCha9ddJ24O3wXU4AGA33f+TSgGkoiwdPomp2nUrndqwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707732625; c=relaxed/simple;
	bh=+6v5ZKHrDKX3JIrADGFs9Q2XsmdwVt8R3IOjr7ikhes=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QZUGA7vSAEq9b6DTg1dk07N/t2IU0zkjR4MIlPbhrGlFJ3ns2J8ISxlWqiUtzSeWhdJCJmev/PKtPo0uEwm+p3YrWaHy7biG+B43gxYY9xpQc7TV9cBzuUDsqgPwx88lqLUytN5RdY3R8Jl7qopkGqbzE4sB8aWUmH3thuP/dK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUU9AkGB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27A8CC433C7;
	Mon, 12 Feb 2024 10:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707732625;
	bh=+6v5ZKHrDKX3JIrADGFs9Q2XsmdwVt8R3IOjr7ikhes=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rUU9AkGBlmEzQJyHlAAQc6HTtP1Zs890669IaUjP9h3eVzqqQ20Oq4EDBkPW6ZX8z
	 U95+JAr5HWBxKWwuqWAQ0TCVZCrRTRlRrdxAH2jbJ2JLJD0lk7v4xixFLF9c3YTTTV
	 36g48etFx1okhbl5Cp3HNxUpEKWooJbmhwXcEUB3CAKZjAxdLrjN8mVctUC9JyA2Dp
	 m2Gt4LFJHZIWA9oAeyt4LYvVCrjHXoY14N1xVIkCMXLnPUL/U5SVotIUTwxm5ZPrgI
	 3oLBlOc0/GqDsz7GJZ3FFGgDgQg7hlsQNYNF/iuCDurAhxbGOvdcIhdLXj+PN0KDCo
	 LCO/dDg5BGNQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04710D84BC3;
	Mon, 12 Feb 2024 10:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/7] mptcp: locking cleanup & misc. fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170773262501.4204.5549923375471395183.git-patchwork-notify@kernel.org>
Date: Mon, 12 Feb 2024 10:10:25 +0000
References: <20240208-upstream-net-20240202-locking-cleanup-misc-v1-0-f75cc5b97e5a@kernel.org>
In-Reply-To: <20240208-upstream-net-20240202-locking-cleanup-misc-v1-0-f75cc5b97e5a@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kishen.maloor@intel.com, fw@strlen.de, peter.krystad@linux.intel.com,
 dmytro@shytyi.net, benjamin.hesmans@tessares.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, cpaasch@apple.com, stable@vger.kernel.org,
 syzbot+c53d4d3ddb327e80bc51@syzkaller.appspotmail.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 08 Feb 2024 19:03:48 +0100 you wrote:
> Patches 1-4 are fixes for issues found by Paolo while working on adding
> TCP_NOTSENT_LOWAT support. The latter will need to track more states
> under the msk data lock. Since the locking msk locking schema is already
> quite complex, do a long awaited clean-up step by moving several
> confusing lockless initialization under the relevant locks. Note that it
> is unlikely a real race could happen even prior to such patches as the
> MPTCP-level state machine implicitly ensures proper serialization of the
> write accesses, even lacking explicit lock. But still, simplification is
> welcome and this will help for the maintenance. This can be backported
> up to v5.6.
> 
> [...]

Here is the summary with links:
  - [net,1/7] mptcp: drop the push_pending field
    https://git.kernel.org/netdev/net/c/bdd70eb68913
  - [net,2/7] mptcp: fix rcv space initialization
    https://git.kernel.org/netdev/net/c/013e3179dbd2
  - [net,3/7] mptcp: fix more tx path fields initialization
    https://git.kernel.org/netdev/net/c/3f83d8a77eee
  - [net,4/7] mptcp: corner case locking for rx path fields initialization
    https://git.kernel.org/netdev/net/c/e4a0fa47e816
  - [net,5/7] mptcp: check addrs list in userspace_pm_get_local_id
    https://git.kernel.org/netdev/net/c/f012d796a6de
  - [net,6/7] mptcp: really cope with fastopen race
    https://git.kernel.org/netdev/net/c/337cebbd850f
  - [net,7/7] MAINTAINERS: update Geliang's email address
    https://git.kernel.org/netdev/net/c/68990d006d42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



