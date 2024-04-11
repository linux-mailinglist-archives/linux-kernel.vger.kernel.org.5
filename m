Return-Path: <linux-kernel+bounces-139939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DB68A095B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B722328114F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EE713DDB9;
	Thu, 11 Apr 2024 07:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAADJwxy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B2813DDD4;
	Thu, 11 Apr 2024 07:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819429; cv=none; b=jTi55ZYt9NhVP05ThyLpa0pMEVwOi6cdfk3VaZxqLmvPjvzgd42CnzE0WW+wRqZyx+cwxWlE2z6DqfH+AMdvkUBbhMy6fSDXuEhatcsXaBeKphwvQpF1yEDfqBOR3/bNb3vS5zN81OQrO6ftb6Kx7St1MdXfcFif9Y3WODkBf8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819429; c=relaxed/simple;
	bh=MpeUkIvYnFON6Fjo7ce2negdpnIzW7tLvWuReyJ4cPA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=svcRGKO0oXgozj2mFCvbWmZo+c489GCvY82eY3K0l22L354NGXAqoJ0NftoTAGXNnk+bQoqjAdM76TqFCfBxZa4m85yl6sufPXTU58CVBc9RYtkwrPpfgPdXRyGu1H3GTuCsVQ7gmrgstfqmruswCau6Xne/FgzxaVdlzOO3hus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAADJwxy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E018C43390;
	Thu, 11 Apr 2024 07:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712819428;
	bh=MpeUkIvYnFON6Fjo7ce2negdpnIzW7tLvWuReyJ4cPA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HAADJwxyIswYYPFsFluMzDA1iRQyBtBHYuYHCKg+Qq3qn/aHSimEhiQCtuPgYvFzq
	 A/O1WXHbF5TdiC63eOLFXhSbYIeYTJ9Eetm2icCNcHnF7S2MypsZLyDpckYzwytN0w
	 xHm9is6qUwcJ3GgstDPde4cReqJHJMkciP6Xdjm+IcZsbjnESGhXTBA9Ymlve4lVIo
	 iulgEuglaXbJJI5I0ifv8wTxClNa7KXHzKnKszOpYX7Dt20Mrz6MvkHlxhRyh4Xx1Q
	 JLN9u6NRGAQ1wkUFllwWuGfWHHAPq1xoaYJpz5tvWvMljXx2yZo4L4nfLIrzrK1wP0
	 GMvOTQjI3UZEg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5AE32D6030E;
	Thu, 11 Apr 2024 07:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: sparx5: fix wrong config being used when
 reconfiguring PCS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171281942836.8675.1443912107284247042.git-patchwork-notify@kernel.org>
Date: Thu, 11 Apr 2024 07:10:28 +0000
References: <20240409-link-mode-reconfiguration-fix-v2-1-db6a507f3627@microchip.com>
In-Reply-To: <20240409-link-mode-reconfiguration-fix-v2-1-db6a507f3627@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
 UNGLinuxDriver@microchip.com, bjarni.jonasson@microchip.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 steen.hegelund@microchip.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 9 Apr 2024 12:41:59 +0200 you wrote:
> The wrong port config is being used if the PCS is reconfigured. Fix this
> by correctly using the new config instead of the old one.
> 
> Fixes: 946e7fd5053a ("net: sparx5: add port module support")
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> ---
> Changes in v2:
> - Rewrite subject and commit description
> - Link to v1: https://lore.kernel.org/r/20240405-link-mode-reconfiguration-fix-v1-1-c1480bc2346a@microchip.com
> 
> [...]

Here is the summary with links:
  - [net,v2] net: sparx5: fix wrong config being used when reconfiguring PCS
    https://git.kernel.org/netdev/net/c/33623113a48e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



