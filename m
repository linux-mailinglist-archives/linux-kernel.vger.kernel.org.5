Return-Path: <linux-kernel+bounces-135207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9337989BCB8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D01F281D7C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2F953E28;
	Mon,  8 Apr 2024 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlp4k2VD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754425338D;
	Mon,  8 Apr 2024 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712571027; cv=none; b=U7fWdaoXLNFdDmBG9UuvA13PhIthVc6SQVQ8KCtq6p1ay3rhB66JVNmnsUIYhrMuoGzuFDfNhS7+3MKyJBlY02MNhxato6V+ocf6bWK9W/p1OUMPy0ksHiHY5WDIvj1iTQxnZhD8axehoz2aHGVvn+SKEq9GuKhu1QW6JoTDuZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712571027; c=relaxed/simple;
	bh=x+XrOol6yWyCizxrCWOJ4+a0py0a9Q0xvIdnby2O6R0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jc3aDZ6MKd4BkiQRvvkZmX44KXTyeveMk/PZ93Gmxd2UAX1IsuT7rC8D5Ges8SgbYSaCQ4Db5SJNdFYhbPSGr688XklmO3k1iv7WSeLt4Z7iCr6g7oZvjPBWc+u/wGffsmQb83wvo6kmFTEGoPgMaxh3RjEnfvhd2N/4A7yc4SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlp4k2VD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2BE3AC43394;
	Mon,  8 Apr 2024 10:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712571027;
	bh=x+XrOol6yWyCizxrCWOJ4+a0py0a9Q0xvIdnby2O6R0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qlp4k2VDn9EuhCEJk7K3FBy3HYyssjwc6Q8Z6TIDwXjvRWs8iEtjO8rtbGlclPSSW
	 lyiHMiLP6hYzFvOL0oJ5QKSTNTWmnfH5dKpu+A9oAJcLIxzvVp/KZvMkLT9UvjnK6A
	 ymVtTiu81lybfdx0DhYxq3h9orjun1qP1LgpD9VXlXo8whpqXOrI+54W/CDI0Zdu6y
	 CClsuWCjtzn+dWR+HgM76Kvu1nplipakS2h8Y8Ypj2OUQaQj3lPWvpv1HCi8l/6jhI
	 TG75Zya/QxSLXpW22pdQpxI0f7QVDu4lhouQz4GIL5Pl9q//g/u7plnfHKRaUztIJL
	 1ebsv50Ml6aBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 212C4C54BD9;
	Mon,  8 Apr 2024 10:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ip_tunnel: harden copying IP tunnel params to
 userspace
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171257102713.30740.3149927029161291551.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 10:10:27 +0000
References: <20240404160302.3585661-1-aleksander.lobakin@intel.com>
In-Reply-To: <20240404160302.3585661-1-aleksander.lobakin@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dan.carpenter@linaro.org, dsahern@kernel.org,
 horms@kernel.org, nex.sw.ncis.osdt.itp.upstreaming@intel.com,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  4 Apr 2024 18:03:02 +0200 you wrote:
> Structures which are about to be copied to userspace shouldn't have
> uninitialized fields or paddings.
> memset() the whole &ip_tunnel_parm in ip_tunnel_parm_to_user() before
> filling it with the kernel data. The compilers will hopefully combine
> writes to it.
> 
> Fixes: 117aef12a7b1 ("ip_tunnel: use a separate struct to store tunnel params in the kernel")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/netdev/5f63dd25-de94-4ca3-84e6-14095953db13@moroto.mountain
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> [...]

Here is the summary with links:
  - [net-next] ip_tunnel: harden copying IP tunnel params to userspace
    https://git.kernel.org/netdev/net-next/c/5a66cda52d7d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



