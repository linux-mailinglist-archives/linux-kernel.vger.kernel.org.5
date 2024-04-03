Return-Path: <linux-kernel+bounces-128945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 176F6896220
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47ECC1C23629
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606D31C6B6;
	Wed,  3 Apr 2024 01:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBDVtB/7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8EF17BCE;
	Wed,  3 Apr 2024 01:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712108435; cv=none; b=fCy3CPqLRFMhx/vhGsfTotWZJ3YKCHLU6CH1NuUjtQ50M6MGoa7Rwy8Qfc/RtQheJZG/QpOWO2kGvM3RL+WHya6L+uchRgEMRArVS8b3h3VOWoY+cuAF/lpFI6uwoiygC0tPpRrS9RgKxUJzT4SRiPmotph+MRS0RMcPcpyn7e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712108435; c=relaxed/simple;
	bh=Z8qTCsLw7+oMuaV/qewhvl2ECFN/UQO0aDvA4mEBrSQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Frtkf+MnTKi79ih2EyyPz9wGoXPyd+aE1pHQ7EGw3Ly9Ltr73Dl8BlsfTJg+ghW6zs4BwsypB6WS745H6Nzv/Is2Voi/2JEjZlvivDbfuUcYs/DGolkB1fHJfEXkSlE/gctqCGr0tEQa7ApJk4ciN9aohmxXaYIm/3se2x9g970=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBDVtB/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 069C5C4166A;
	Wed,  3 Apr 2024 01:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712108435;
	bh=Z8qTCsLw7+oMuaV/qewhvl2ECFN/UQO0aDvA4mEBrSQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OBDVtB/7tU5LTpyvHP8SPA/Ha9HPwqUXGlFhpB1HRWUaeEXxARiMik9R2Jc4iDk9i
	 u7xmtdrl2pAEita/RFv957CjPMINipBrTHwR7/F76Ck6dnkFZQw+mXP6IbJ69dQpp6
	 Y3imF0c4luCuvMvb7NGXAvRCDjOw3tOmmfAXnm+kdHwhQS5ZKOkstfzZlnlaFuVyEz
	 j/9I16dar9AlJlYrNA2poqYZX1TKkUnWMwlRe873JejaERmvx022EWI/RZHQu8OSf7
	 myLMGQKnSB+yR6zDnYKy506gc7JGCmq/GUcnu6cO2qgkJYOO5J3MgxQAhKt6iMOsCk
	 aFLh+n27LQX4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE3ECD8BD1B;
	Wed,  3 Apr 2024 01:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] Avoid explicit cpumask var allocation on
 stack
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171210843497.14193.16578910884878610890.git-patchwork-notify@kernel.org>
Date: Wed, 03 Apr 2024 01:40:34 +0000
References: <20240331053441.1276826-1-dawei.li@shingroup.cn>
In-Reply-To: <20240331053441.1276826-1-dawei.li@shingroup.cn>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ioana.ciornei@nxp.com, wintera@linux.ibm.com,
 twinkler@linux.ibm.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 31 Mar 2024 13:34:39 +0800 you wrote:
> Hi,
> 
> This is v2 of previous series[1] about cpumask var on stack for net
> subsystem.
> 
> Change since v1:
> - For iucv_setmask_up() which returns void to caller, just make cpumask
>   var static which is protected by global lock iucv_register_mutex. [Eric]
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net/iucv: Avoid explicit cpumask var allocation on stack
    https://git.kernel.org/netdev/net-next/c/be4e1304419c
  - [net-next,v2,2/2] net/dpaa2: Avoid explicit cpumask var allocation on stack
    https://git.kernel.org/netdev/net-next/c/d33fe1714a44

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



