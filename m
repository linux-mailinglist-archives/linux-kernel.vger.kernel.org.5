Return-Path: <linux-kernel+bounces-37647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7D283B308
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 488441C230E7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63561339B9;
	Wed, 24 Jan 2024 20:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KduiNtAw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AB317F3;
	Wed, 24 Jan 2024 20:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706128227; cv=none; b=CC6+gK6rmxR/5wDqtD6kL/j4o5CQQXTypXUXGdBEiEbILSlNjp8DIu/X40P0+VBYqeN0y25OrYvsWVF+h0aPdXf40xvUamD64KXqZzni/s28qYgjQkTsTNZuZyMBUGwlCfoZPSVteexKfV7SXCB6ZnLwAngKT3dsFxTTAXUZ0RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706128227; c=relaxed/simple;
	bh=7E96YLzl01LGs3tIQR8nbla5IaWuZRVsGIuS0bJ9CzU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lzZfQr4lwvkZF9KNtbWins6OYsT+afl8VPuTVNYcHcSjX1pKNZiI9SIToY8KNK81swEjRK76r3lqhzWOGPy1e4aTQUmZU3ZsvGrfnbF9PXR3uj6IcNgpSAFwxSa+T7qe6mr+su9oCkRNUpwEbmYbEmnwVhFjWgd8YErUfVpSpgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KduiNtAw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C83BC43394;
	Wed, 24 Jan 2024 20:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706128226;
	bh=7E96YLzl01LGs3tIQR8nbla5IaWuZRVsGIuS0bJ9CzU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KduiNtAwZIx/I/f6Cbt9YS2wXTbz1SEXUy9R2myM36I5ojYB01E84P16k9FpzjNyn
	 s9oLIXWqYk0T+q5fFbiPP2vtmLn4AcULVQ9jTq6U0Fsi8ysZq5s6xaV9/geGfP25xG
	 fUtvpsyO2d/nHVv75dl4z0HzirRcLac6hwJjhyvh4AhuwhzLXWubKeTK3+U0vA/+UV
	 PksdEG9qJGJFl6YoiFDd8jaL/hpTZajzbixCoNik1O1KNYX3xXu9VPISrvG8z6gid6
	 rM7n5i6YoMoertn1+Rihg6O+QQLB0WIDmZ1bN3n6PD20Q1TVUmq5MMIb13WK2+z852
	 vPEjBwN48ToGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72213D8C962;
	Wed, 24 Jan 2024 20:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: stmmac: Wait a bit for the reset to take effect
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170612822646.416.13224306306608084186.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jan 2024 20:30:26 +0000
References: <AS8P193MB1285A810BD78C111E7F6AA34E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
In-Reply-To: <AS8P193MB1285A810BD78C111E7F6AA34E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
To: Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 jiri@nvidia.com, akpm@linux-foundation.org, fancer.lancer@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Jan 2024 19:19:09 +0100 you wrote:
> otherwise the synopsys_id value may be read out wrong,
> because the GMAC_VERSION register might still be in reset
> state, for at least 1 us after the reset is de-asserted.
> 
> Add a wait for 10 us before continuing to be on the safe side.
> 
> > From what have you got that delay value?
> 
> [...]

Here is the summary with links:
  - [net,v3] net: stmmac: Wait a bit for the reset to take effect
    https://git.kernel.org/netdev/net/c/a5f5eee282a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



