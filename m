Return-Path: <linux-kernel+bounces-49829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82412847022
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF081C269A3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280B31420A0;
	Fri,  2 Feb 2024 12:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEpqDYqi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6686014079D;
	Fri,  2 Feb 2024 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876430; cv=none; b=P/qxJT1E37w+jbwjsUVZJ8JPFp85ui5q+sxyUimEEU38Zw3iYsNEqNi9cwLcLB8Q3nCC+YKVu3Nrg1RZyduoof63gAuxJoLiT4Y8cexIFVLHaAiuuRXL7SS48Lsv/gh9JcLN1+iruREhhOmY0ZYyQhkyU7N5amhnwbpiazuQ9xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876430; c=relaxed/simple;
	bh=kn7u04wfy8ymvQ6lKtK29MV+2GMKXsSRwya72f7h1v8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uqmDOcJNLPLsMSCWQTkRlPEQUxt7yJf/xlEKZVsRCM6eh2DWUyNs3D1bxyPBvMmW+6rvfd8cgd6glEn33BuwLM1pI28RfiSus3q05g2zQmxQ9igJXnQ5MyMMCKA4ChAwohgmKap2f32n2llLUR6Dgps1ToTTgdnLDDip4aYkXEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEpqDYqi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFF1FC433C7;
	Fri,  2 Feb 2024 12:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706876430;
	bh=kn7u04wfy8ymvQ6lKtK29MV+2GMKXsSRwya72f7h1v8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YEpqDYqiVUb1Nmy16MTlbFn+z8d3nwqXFoMw6ej53mkG/4Y7oiE7CVyMrCsxhkXqs
	 choNCgGdKGEQosyZ7TAD7ADWBJCghfxzjF2szs8a8+KWr/7e5KyXCXf1iUdsGgvV4S
	 1Y0gtMIu/av+R/QRymJfxUppKKjF2YvbwditNNlDZjFow04zyGE95dbY4v4NUOuKCC
	 vZK4d2VNc+ZlMpmfdohRQYhDuDKsDblZZFb/TbOTiLijkplI5RucWqETVcpiigDxiL
	 M0luGzRmP3zIsKUGTdfBoPQPROPjDQ1e9uWT5WBlbygjkU8EjwhV5WYPNeel6Wn+tJ
	 E5Mu3EQGInYiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6A70C04E27;
	Fri,  2 Feb 2024 12:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] Dynamically allocate BPIDs for LBK
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170687642987.27809.15518970048126764791.git-patchwork-notify@kernel.org>
Date: Fri, 02 Feb 2024 12:20:29 +0000
References: <20240131075441.17227-1-gakula@marvell.com>
In-Reply-To: <20240131075441.17227-1-gakula@marvell.com>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 31 Jan 2024 13:24:39 +0530 you wrote:
> In current driver 64 BPIDs are reserved for LBK interfaces.
> These bpids are 1-to-1 mapped to LBK interface channel numbers.
> In some usecases one LBK interface required more than one bpids
> and in some case they may not require at all. These usescas
> can't be address with the current implementation as it always
> reserves only one bpid per LBK channel.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] octeontx2-af: Create BPIDs free pool
    https://git.kernel.org/netdev/net-next/c/d6212d2e41a0
  - [net-next,v2,2/2] octeontx2-af: Cleanup loopback device checks
    https://git.kernel.org/netdev/net-next/c/ae703539f49d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



