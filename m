Return-Path: <linux-kernel+bounces-93277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F7A872D5F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 735421C26E70
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AD21426F;
	Wed,  6 Mar 2024 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2d585M6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3BB101D5;
	Wed,  6 Mar 2024 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709694629; cv=none; b=GgMyGz4Rke12zXykWZ4mPCIfEkZ5E7DtlDbHLfVE2dmQNHP4X947tdmFuelkxAZvkOfaJg5m8OrxIR7XGWJeZGSMmRva/4QnozzQF7KsvlxuBxE7emt1n0wK+Mnsh5Njlk8mwSzHmjpCG1G/sRMstJ4QhRT+OvI0RwhSMHgng+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709694629; c=relaxed/simple;
	bh=/YslR42HHcCT8sP2owzUHr13FtcYZuFcf1y1syHWAZg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aEkOIoIDmgJhds1ZalK/ADAz7kU81oPOhpBBUPbMcOv/NnvV0E6pb8PKp71fz7jtnxzEbR3SSMmr/yWA615pvpa8Zd+tdd1DVRdUdMUooa9zRBOWDNyPQwyuSjitdy0cBaqYShom/yIPtkLhnEVQXPAw6Ydx+x1a4CEkE7N7fhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2d585M6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8EA3EC43390;
	Wed,  6 Mar 2024 03:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709694628;
	bh=/YslR42HHcCT8sP2owzUHr13FtcYZuFcf1y1syHWAZg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r2d585M6FNt260vmjaiMeW6EVvSaH2z2yRcJKBO/D/hgpMl6TnuHo63A4kkuMiCDJ
	 SXUHMEAbtCC122J6cs7g+dIpTU6WP/rb9Yo5FPJklTP8/1/rlF3AxH9Tu0OuuYC4XO
	 AdQSidFW2plxVWMI/gcXApA2m/4ILTriD8l4boBulWrNMYogZz/X+Z2ByNsfWTtJlN
	 SijJXcj5WQu48qiuhtSLknlqCViuR/ljg6hp217roVzp8vx3a+f83qMIJb2mbpAnLB
	 GZOdves6jhRbUz4EhNiWBC/bciDVCPI8zFezUwAN5TwZXaIsHhkFLXcmMtdRaQa/BQ
	 lITNDhWRIsGVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7307DD9A4BB;
	Wed,  6 Mar 2024 03:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] sock: Use unsafe_memcpy() for sock_copy()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170969462846.24513.2351243182107643239.git-patchwork-notify@kernel.org>
Date: Wed, 06 Mar 2024 03:10:28 +0000
References: <20240304212928.make.772-kees@kernel.org>
In-Reply-To: <20240304212928.make.772-kees@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, dsahern@kernel.org,
 kuniyu@amazon.com, wuyun.abel@bytedance.com, leitao@debian.org,
 alexander@mihalicyn.com, dhowells@redhat.com, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  4 Mar 2024 13:29:31 -0800 you wrote:
> While testing for places where zero-sized destinations were still showing
> up in the kernel, sock_copy() and inet_reqsk_clone() were found, which
> are using very specific memcpy() offsets for both avoiding a portion of
> struct sock, and copying beyond the end of it (since struct sock is really
> just a common header before the protocol-specific allocation). Instead
> of trying to unravel this historical lack of container_of(), just switch
> to unsafe_memcpy(), since that's effectively what was happening already
> (memcpy() wasn't checking 0-sized destinations while the code base was
> being converted away from fake flexible arrays).
> 
> [...]

Here is the summary with links:
  - [v3] sock: Use unsafe_memcpy() for sock_copy()
    https://git.kernel.org/netdev/net-next/c/ff73f8344e58

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



