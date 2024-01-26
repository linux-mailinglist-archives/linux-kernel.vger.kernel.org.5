Return-Path: <linux-kernel+bounces-39489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC8783D1FC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADFB228B22F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503605CBD;
	Fri, 26 Jan 2024 01:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3eOvBwz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932EF4439;
	Fri, 26 Jan 2024 01:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706232027; cv=none; b=ZeVSssKzWb27Se2pEiV++pKcYXUWpfXHJ1OpT4gjEN387sYZoI5RMNf54FXQUom9fmbtMhi7uN5dk2ffTnPJmJP21vW5Y1pdY/owMo44FL4tT+s7XAjgo51UVJQ5RRkjxaYbAx6kT53JN8DueIwLos5XLlekEAuDDjMKDXefhXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706232027; c=relaxed/simple;
	bh=o3SfrIDpOT4MwLEhl2c0vzaTkf9QuTqTt0SwP10ukbk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q6tl6MiWLxOet//y7TRE/TfP+AA6T5SrJ5SzjmZ0uipDP98hcRFWBziZsVyViLTCD9PfgFDpvi0BJdsYI66eEvGqoAp1Dk9ujg6ivf8dTzuR2MHW7QqP3dyBowghbwPGKrzT4xMGgU7CPwDYHyG7olnd4B8WMP7kR50FoDZR/O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3eOvBwz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10C9BC43394;
	Fri, 26 Jan 2024 01:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706232027;
	bh=o3SfrIDpOT4MwLEhl2c0vzaTkf9QuTqTt0SwP10ukbk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R3eOvBwzCqLhI41sB/Ul5tSI45FuKkB5qhAN95sswQW6K7IgDqaYaoYYJmR4KMyDf
	 tcgU4UQQshKWNMcwKwTOB73QTX3Rqw2+b5R/tnKCBLGyMb79ORksuXWxe8OnWXofmw
	 zRjiJhRxDrKhXtAjrl8N2CAdSeLf1gAUSP2d8f1RKZ6do1w5q7C2ZAjrHDbbw4ELT/
	 Kb1Wahf2lcykDBY6u0WAfa3sVevgaIFIblOh0VkhW6lhMgM9fdvroLAXVSV7sy5AkG
	 tbqF8cuMTCDjpXZfa/V8Ri8BDEItOWASEge3SZVPq3yK4zF6X6zlyVi1WJHnSrMvR/
	 8dLH2X16L/+ew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F13F8D8C962;
	Fri, 26 Jan 2024 01:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] gve: Modify rx_buf_alloc_fail counter centrally and
 closer to failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170623202697.2360.15676490828216158973.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jan 2024 01:20:26 +0000
References: <20240124205435.1021490-1-nktgrg@google.com>
In-Reply-To: <20240124205435.1021490-1-nktgrg@google.com>
To: nktgrg <nktgrg@google.com>
Cc: netdev@vger.kernel.org, jeroendb@google.com, pkaligineedi@google.com,
 shailend@google.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jfraker@google.com,
 linux-kernel@vger.kernel.org, stable@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Jan 2024 20:54:35 +0000 you wrote:
> From: Ankit Garg <nktgrg@google.com>
> 
> Previously, each caller of gve_rx_alloc_buffer had to increase counter
>  and as a result one caller was not tracking those failure. Increasing
>  counters at a common location now so callers don't have to duplicate
>  code or miss counter management.
> 
> [...]

Here is the summary with links:
  - [net-next] gve: Modify rx_buf_alloc_fail counter centrally and closer to failure
    https://git.kernel.org/netdev/net-next/c/3df18416267b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



