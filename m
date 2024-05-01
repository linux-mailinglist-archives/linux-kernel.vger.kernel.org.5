Return-Path: <linux-kernel+bounces-165782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 865E48B9185
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 00:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C1DE1F2450F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841D1168AE6;
	Wed,  1 May 2024 22:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzSws62e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6424D5BF;
	Wed,  1 May 2024 22:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714600831; cv=none; b=mlSFOfx0wiuUhZ0U6bhZgr8PtG4T+71GuJUMhGR1kPsvPxFMaxRkgiw4PUHgeJTqDIKM0KbCIqooK5Bs68OU+Sff0L2EPe/dQ/S0NWFx31GBOHXGWgax8K/WgRX7p4HBWXCx9nhlaDRpfWDtpsxPKK+hC+yvIOhfUtYGmMrsR5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714600831; c=relaxed/simple;
	bh=A/ULxomzRkdzCJ1CT9lhGis0VqIr8toM8xMJNNMXbIw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lXvjJ11bUAypYDcSDoT/9EIs/uBrVvRyP0qjBR4SgKdme1PAgDVUHhjyT+bbcutz7AlbyT9AQQWNnxZSDFxIS+xQ9ebjZ6SCZ5sCAV4sB+muBxT1OQu2mHzuQVqwmUu2sF1JgPjsawNoDhSm2+pLNhcB4C+lfnx2ZWbgJpJCtF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzSws62e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1078FC4AF14;
	Wed,  1 May 2024 22:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714600831;
	bh=A/ULxomzRkdzCJ1CT9lhGis0VqIr8toM8xMJNNMXbIw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BzSws62e9IyAsiDTwsx4IOJVsO9VDZbrPi6IQzKFh2QbyKkvTxJkkJzwgfcRH8SnB
	 reBwOM9y8aiiDQ7eu+URCVXb5OHzNWL8fe/gW51Wq7CEW3cAGeUE8wKJlOIOG3HoAY
	 VCMNTfTNICyW2ozu/KGYnmbp4rhQ/6rmYVSAbMjuEiUFNK3EV4Hg9GfIjSKSoFJQRN
	 wTBMhgbFyE6QatmO3+UWrPnFWmvF/aKdsfdzlYtC0e5WPnZOQy6U+AhbtSct3esbi1
	 zglho/xxJplAPxa1I5CBdcszRaRfmigM4N+V5iOnItEhuldNSTBwyYNXvlgVWulwos
	 IvTT7tdkrPwxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE363C43440;
	Wed,  1 May 2024 22:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] rxrpc: Clients must accept conn from any address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171460083096.4291.841928169259901736.git-patchwork-notify@kernel.org>
Date: Wed, 01 May 2024 22:00:30 +0000
References: <20240419163057.4141728-1-marc.dionne@auristor.com>
In-Reply-To: <20240419163057.4141728-1-marc.dionne@auristor.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: dhowells@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 jaltman@auristor.com, linux-kernel@vger.kernel.org,
 linux-afs@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 19 Apr 2024 13:30:57 -0300 you wrote:
> From: Jeffrey Altman <jaltman@auristor.com>
> 
> The find connection logic of Transarc's Rx was modified in the mid-1990s
> to support multi-homed servers which might send a response packet from
> an address other than the destination address in the received packet.
> The rules for accepting a packet by an Rx initiator (RX_CLIENT_CONNECTION)
> were altered to permit acceptance of a packet from any address provided
> that the port number was unchanged and all of the connection identifiers
> matched (Epoch, CID, SecurityClass, ...).
> 
> [...]

Here is the summary with links:
  - [net,v2] rxrpc: Clients must accept conn from any address
    https://git.kernel.org/netdev/net/c/8953285d7bd6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



