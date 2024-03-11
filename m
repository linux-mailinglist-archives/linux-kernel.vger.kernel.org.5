Return-Path: <linux-kernel+bounces-99477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE97878902
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B9628169A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3818856B62;
	Mon, 11 Mar 2024 19:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KippI1B9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791355579A;
	Mon, 11 Mar 2024 19:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710185962; cv=none; b=W4jBiouAGOzJqnj6XQ38GyOJpxVYtXBFpQnoaWAw2KY8CKFqFFJI40k+HV+R/GXO/sHvYJw5kDYBK81vYQSDN1FXaqHoPQQEJwIygp0QFYLa4Mcd8fyZ4Rr6E4aJkaYPG9UoGOBmxyKE5HwwDSX257TSZp1pugFvSmPR1vAeMDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710185962; c=relaxed/simple;
	bh=Tb3t3KEHkb0bKggnJvzoExyaezYnPNtP5SMbYxHfn14=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t71Ne+z/Z0CyBt0fylPDmyTqBs3LYkyXbryVDLq7pCV42o00SEf2T0mSy4GaJOzc78P3Z9kc+ZhABB73XxOCtUn0gZV4l1PL1KE8z1CTY/ySsFh+X8SRKD19MShQPBXkTigg1C9TuloiMa1Txzll9/wCNHNgQRXEDKfmNr/Zppo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KippI1B9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0AA25C43390;
	Mon, 11 Mar 2024 19:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710185962;
	bh=Tb3t3KEHkb0bKggnJvzoExyaezYnPNtP5SMbYxHfn14=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KippI1B9+gMzNcgca+X/Mg+moPrGpBMojeLHzlzD7kofcrcl2eKzS3MsnO0vgNa9G
	 gb/r9TyUGaMlembU6IikLIlDibUFseVPdcnSlblUjBtiSZrIV5PGJ9G55Vcbs7keGM
	 AuaB7RPOCT6psSNsX5udmvECgg7f30+WYf38EYvQI+h3bmTm9q4QHfnKLq15LfbTe0
	 6fUr0sDqC+KrQBkuGCkI6Q74CSfD0GubHL1E7ObHZrQ32ghYf/D8bTemUANSvmpg2/
	 qqOWvWbBR/hJ9ktnDvDj6S6596E8QSqrrED4g1FU1OKHZbZkXlleZVja31vSJdBZ0f
	 KNcp1VTImdd4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DFF40C395F1;
	Mon, 11 Mar 2024 19:39:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/6] fix incorrect parameter validation in the
 *_get_sockopt() functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171018596190.1144.12769091156381896490.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 19:39:21 +0000
References: <20240307142030.2708698-1-Ilia.Gavrilov@infotecs.ru>
In-Reply-To: <20240307142030.2708698-1-Ilia.Gavrilov@infotecs.ru>
To: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Cc: horms@kernel.org, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
 edumazet@google.com, jchapman@katalix.com, ms@dev.tdt.de,
 syoshida@redhat.com, almasrymina@google.com, kuniyu@amazon.com,
 tom@herbertland.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 7 Mar 2024 14:23:49 +0000 you wrote:
> This v2 series fix incorrent parameter validation in *_get_sockopt()
> functions in several places.
> 
> version 2 changes:
> - reword the patch description
> - add two patches for net/kcm and net/x25
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/6] tcp: fix incorrect parameter validation in the do_tcp_getsockopt() function
    https://git.kernel.org/netdev/net-next/c/716edc9706de
  - [net-next,v2,2/6] udp: fix incorrect parameter validation in the udp_lib_getsockopt() function
    https://git.kernel.org/netdev/net-next/c/4bb3ba7b74fc
  - [net-next,v2,3/6] ipmr: fix incorrect parameter validation in the ip_mroute_getsockopt() function
    https://git.kernel.org/netdev/net-next/c/5c3be3e0eb44
  - [net-next,v2,4/6] l2tp: fix incorrect parameter validation in the pppol2tp_getsockopt() function
    https://git.kernel.org/netdev/net-next/c/955e9876ba4e
  - [net-next,v2,5/6] net: kcm: fix incorrect parameter validation in the kcm_getsockopt) function
    https://git.kernel.org/netdev/net-next/c/3ed5f415133f
  - [net-next,v2,6/6] net/x25: fix incorrect parameter validation in the x25_getsockopt() function
    https://git.kernel.org/netdev/net-next/c/d6eb8de2015f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



