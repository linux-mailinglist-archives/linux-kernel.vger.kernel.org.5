Return-Path: <linux-kernel+bounces-152106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2678AB939
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 05:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B15E7B21F2E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 03:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD44D28D;
	Sat, 20 Apr 2024 03:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ih8+tYUt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563B3205E12;
	Sat, 20 Apr 2024 03:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713583827; cv=none; b=EBs6ku1VXTdqzD4XxfMW2bfntT5TOcWMgDTP3UR9LJcFivOuw2qOgxqvs9MEvpfCN0ouTcZdPKDW+Usi3kUAh4KipzkrGknXy0lRiYp09bp/f5EGZ8m36Q8XwvqUlt+7bHCSZZvs7LpzGflPEExq+Qi7me0YvpRb2v7TbEtwVak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713583827; c=relaxed/simple;
	bh=ge+p0vlGL3TK17rE/0pRocV+1Vdpj2kDg6BqmdERj0Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QSNZtsi/CFcmDrP0+GFs9cN5csn0kaopmaTK31wxTwXcaRtV07CuYJGpyOnNV6enqH+rcmQJAeF2kwF46YKUROpZrX2PSo1XOphoaKMkmvXHkob5TRdOsLEQa54azt5qmWnoWbtL/GFn6FeS5AoJeeDCteWm1LOLPbXBrdH9cQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ih8+tYUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC70EC2BD10;
	Sat, 20 Apr 2024 03:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713583826;
	bh=ge+p0vlGL3TK17rE/0pRocV+1Vdpj2kDg6BqmdERj0Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ih8+tYUtqQakxySPlijyM52BXGgjnDI+LNp/gSG7StKi0K8wcj+vyxH09YGozGJce
	 zJp8O1bJTzorTwS3ih5Q2LPHUabagY2MwQ9NN9gHzQxPsNHedq0GWIZ2RFXPkPhfDM
	 eg9qiFdhrdfB5cbWOiLfk1PYhaj5H0hPqCv/qY6brVuPC+h0GvcT6Ika8XgjQaujlw
	 bz9NHAs/WnFN/YEuiEE0S4Eou4KIGb00lyG2GavLnnTKKC17/BINivsSv9Gdmidw6c
	 Tui1uslspTdWYuvw4ySubTkbCx5/3+4fQ6N4wSXKeo8dTiEpG98TiyPxEn59F1bDg8
	 BxzVy9CWwnWKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B80C4C43618;
	Sat, 20 Apr 2024 03:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] udp: preserve the connected status if only UDP cmsg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171358382675.21761.12628659317542908003.git-patchwork-notify@kernel.org>
Date: Sat, 20 Apr 2024 03:30:26 +0000
References: <20240418170610.867084-1-yick.xie@gmail.com>
In-Reply-To: <20240418170610.867084-1-yick.xie@gmail.com>
To: Yick Xie <yick.xie@gmail.com>
Cc: willemdebruijn.kernel@gmail.com, willemb@google.com,
 netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 19 Apr 2024 01:06:10 +0800 you wrote:
> If "udp_cmsg_send()" returned 0 (i.e. only UDP cmsg),
> "connected" should not be set to 0. Otherwise it stops
> the connected socket from using the cached route.
> 
> Fixes: 2e8de8576343 ("udp: add gso segment cmsg")
> Signed-off-by: Yick Xie <yick.xie@gmail.com>
> Cc: stable@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - [net,v3] udp: preserve the connected status if only UDP cmsg
    https://git.kernel.org/netdev/net/c/680d11f6e542

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



