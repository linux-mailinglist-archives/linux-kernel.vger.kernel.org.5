Return-Path: <linux-kernel+bounces-130836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EED897DBB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 04:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EE791C21CEB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C541B1CFB2;
	Thu,  4 Apr 2024 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrzPhlOY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D32E1C6B8;
	Thu,  4 Apr 2024 02:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712197830; cv=none; b=PskjRR0gezNLAJAT7qBGwFRC4Ha5CXI8Ryhof9pO1DcX/T2hmmWm58S4gXiydplC5xL3GKHJcGWerMQXv0bhKcEChsLuQWAAsUmcqEA1UPFeSooUNqm2ZspwKRIw+QRziNnfl9jpT2LTy0sewctkfBZLwcBbOUdjuwzu/ll7ORw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712197830; c=relaxed/simple;
	bh=X8DfIdcDi4N/TU1s3UMLPmbO8VTXuYl1Q1HzzE8A/+I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gdJeOltGQ8jMEIx805jO8f/Vb/AUFJXBPXoktePSDwxy/gDCVvqQ7fQM9c8FuOsUdrIU+3BL0z9M6Ov6G/W5eLMoZ3LBYHozkym3hXmgoefLhKj4sHLhF8XSSn0u9lpfWyUqDiPQxnpHM+UYK3Y6krivyPgChKkh2HWk2/6Cvfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrzPhlOY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F40AC43390;
	Thu,  4 Apr 2024 02:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712197829;
	bh=X8DfIdcDi4N/TU1s3UMLPmbO8VTXuYl1Q1HzzE8A/+I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UrzPhlOYy4Spar0kSlbJIJsXNRobB8h4E4LnlCoAiyyIoiMCRS4CLmQBu/yQ0Zgcx
	 kcgzHzyyxo1OOSxXOsLO/+aE/0JqFnGtLrUgYKAcFliT9x0av/Mi/MkYyBMGj8agZO
	 32Kix23i30eq+KtkTHZWhv/hV76zZyiD/MdhXTf7yEpCLeN1KzqTSwti79fjel65mo
	 YP0Pp9sqtTYFtEP0MkK78G2GTbgLOPRbKSNV5CTzKa9vEZefNfNKVlTdllAX+jgs5G
	 VPIavOaRj8zJKGAmU7bhe3C/Ccypw37kpOmTWYJwAEThtyXR+CmvtfxGJ0c+PxZ2Gy
	 xbGSVrqR/IQfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91517D9A151;
	Thu,  4 Apr 2024 02:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] net: stmmac: fix rx queue priority assignment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171219782959.25056.10876480260034448901.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 02:30:29 +0000
References: <20240401192239.33942-1-piotrwejman90@gmail.com>
In-Reply-To: <20240401192239.33942-1-piotrwejman90@gmail.com>
To: Piotr Wejman <piotrwejman90@gmail.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, Joao.Pinto@synopsys.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  1 Apr 2024 21:22:39 +0200 you wrote:
> The driver should ensure that same priority is not mapped to multiple
> rx queues. From DesignWare Cores Ethernet Quality-of-Service
> Databook, section 17.1.29 MAC_RxQ_Ctrl2:
> "[...]The software must ensure that the content of this field is
> mutually exclusive to the PSRQ fields for other queues, that is,
> the same priority is not mapped to multiple Rx queues[...]"
> 
> [...]

Here is the summary with links:
  - [v4] net: stmmac: fix rx queue priority assignment
    https://git.kernel.org/netdev/net/c/b3da86d432b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



