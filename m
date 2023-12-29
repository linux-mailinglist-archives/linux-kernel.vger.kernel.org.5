Return-Path: <linux-kernel+bounces-13264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB1982023B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 23:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE099282F82
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 22:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E276F14AAF;
	Fri, 29 Dec 2023 22:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqDGwR2n"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD4C14A92;
	Fri, 29 Dec 2023 22:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B26B2C433C9;
	Fri, 29 Dec 2023 22:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703890224;
	bh=zLKGYy9v9XGw8j9gQF7uqPziGB9EX+1ZBl9IaY3B82g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hqDGwR2nCkMNzLruk+Hc/u687Yc/T9V15WJkdTH/9ilO6spxNJUxCULrYPeimzsRb
	 kuULWdddDKH/ky0xlmmsedidvV0FNh5MCFurULLYj7+b4cTALYSdZmkyYlyEWDXSQg
	 cdTzz+8L07P09uwbyqeuXaTSzNW7S7J1zFU1RB2lslBhzGEQxzhkG5B3IL0F2KF52Z
	 xrX/8ZCIaE8ID8rHC/qQjAXlDFHvrXoQXXQ4BEdEOjOI8rCBrpjwep8L1umBclv94r
	 +a1QjVCV21bVvc+1OAEVEjJUc8iCf6HAtWO4PFxYYYGtDox1gF3mwg57NfEhROVinQ
	 iD4MMrbSLxS+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 99209E333D8;
	Fri, 29 Dec 2023 22:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] mlxbf_gige: fix receive packet race condition
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170389022462.11317.1228428127301048793.git-patchwork-notify@kernel.org>
Date: Fri, 29 Dec 2023 22:50:24 +0000
References: <20231220234739.13753-1-davthompson@nvidia.com>
In-Reply-To: <20231220234739.13753-1-davthompson@nvidia.com>
To: David Thompson <davthompson@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, tbogendoerfer@suse.de, horms@kernel.org, asmaa@nvidia.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 20 Dec 2023 18:47:39 -0500 you wrote:
> Under heavy traffic, the BlueField Gigabit interface can
> become unresponsive. This is due to a possible race condition
> in the mlxbf_gige_rx_packet function, where the function exits
> with producer and consumer indices equal but there are remaining
> packet(s) to be processed. In order to prevent this situation,
> read receive consumer index *before* the HW replenish so that
> the mlxbf_gige_rx_packet function returns an accurate return
> value even if a packet is received into just-replenished buffer
> prior to exiting this routine. If the just-replenished buffer
> is received and occupies the last RX ring entry, the interface
> would not recover and instead would encounter RX packet drops
> related to internal buffer shortages since the driver RX logic
> is not being triggered to drain the RX ring. This patch will
> address and prevent this "ring full" condition.
> 
> [...]

Here is the summary with links:
  - [net,v2] mlxbf_gige: fix receive packet race condition
    https://git.kernel.org/netdev/net/c/dcea1bd45e6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



