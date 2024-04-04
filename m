Return-Path: <linux-kernel+bounces-130835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB200897DBA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 04:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90DF41F272F5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53F71CFA8;
	Thu,  4 Apr 2024 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/9X/BP8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2C723D0;
	Thu,  4 Apr 2024 02:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712197830; cv=none; b=XA79ycvTOFLqW0T7VFazu9rGkJO3nRbxzGljV4rOJ7LQJietupAMmAaFvwE4Yn60oG+poOhsqYngHpP2gUCOQR5R7HQum5XeS5ew45NPmwLM65WhQh8w6v8ZoC/+6FXyL3TEqAMM7y6z0WzI1P8D+VW1Ws+hQuAjRpMUIx9CJsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712197830; c=relaxed/simple;
	bh=DTSGNKqR3NUUz/Y6lLn6SDP+e7sPT1MDAR8sQVi3Qtk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XG6cSlXSkenaZYIe+F/54ze5OicVcKJqIRj3+AcBx3KCG+z2xrh02ArV4h6ZvZlpBDKwEzKlAgylmKATNfDhIXPV5T10W4Z6E1jsQI2ayQDdVTJFbaGZpLNchrhZppdtYgzljZLw9LvixWjYNa3D9+d9c/iUtnHXbTBIR7X1R3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/9X/BP8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA617C433F1;
	Thu,  4 Apr 2024 02:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712197829;
	bh=DTSGNKqR3NUUz/Y6lLn6SDP+e7sPT1MDAR8sQVi3Qtk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z/9X/BP8Sp9S5J5g7aIx5RSpVSpUw7x0tCLmkiNK9BjhU5xaJFAEmCckYjjOcwSDX
	 n3FDJ2wavlepIwwiUlgx/TkCcy8vGhQ1kuo02edYzkuI3TF08zkbK6UbzOZyZif117
	 CyEukJ1xtHW8254rrUiVvbtoADNSTLSFSO3WUiuG1wKDMk+mnPCPWkjPIV12c/1s2I
	 9bf4e+b72x7LP0eXQAGtjKgKmJQmMhygzFn/48ZC+xU93XeJHGtSe0qk9yLSd+vJLy
	 Do93t3AbCCYTJnbll4yq5ajDSCNAIfEy0EiYTnovvE8SUlNl1k1ivY2B56qhKrgL5R
	 kboINvUkfU8sQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9B16CD84BB4;
	Thu,  4 Apr 2024 02:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: micrel: lan8814: Fix when enabling/disabling
 1-step timestamping
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171219782963.25056.2283938285723904653.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 02:30:29 +0000
References: <20240402071634.2483524-1-horatiu.vultur@microchip.com>
In-Reply-To: <20240402071634.2483524-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, Divya.Koppera@microchip.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 UNGLinuxDriver@microchip.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 2 Apr 2024 09:16:34 +0200 you wrote:
> There are 2 issues with the blamed commit.
> 1. When the phy is initialized, it would enable the disabled of UDPv4
>    checksums. The UDPv6 checksum is already enabled by default. So when
>    1-step is configured then it would clear these flags.
> 2. After the 1-step is configured, then if 2-step is configured then the
>    1-step would be still configured because it is not clearing the flag.
>    So the sync frames will still have origin timestamps set.
> 
> [...]

Here is the summary with links:
  - [net] net: phy: micrel: lan8814: Fix when enabling/disabling 1-step timestamping
    https://git.kernel.org/netdev/net/c/de99e1ea3a35

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



