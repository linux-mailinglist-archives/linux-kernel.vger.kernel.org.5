Return-Path: <linux-kernel+bounces-161752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D038B50BC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAABB1F21F4C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 05:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A5ADF5C;
	Mon, 29 Apr 2024 05:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqItNznC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2759E8BE2;
	Mon, 29 Apr 2024 05:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714368630; cv=none; b=AwX/EZR6jwCbLJ12oT4TENvO4cgexN+yodygcsTkYvu3nFdGNNsUQkbAhWDgAGY4eZabJgZJwOmJrZCgvBb5cwS8CDSrVuDNUCmwmLMOf0PM6bUhCZTOYLGO0LJbkKBCdst7gGezJ8gqsKKmjklOw+Pe8ZBBWvLFWER47YAJIyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714368630; c=relaxed/simple;
	bh=rjOSUBao3IhikJsSx41/jAuu9PGrkqmrRnBC8aR66X0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pIuHjAMk32GV/0jLXOCGbepPOA4POUwS1JvlUSfcUw0SVoghtoQ7pdDXqkbYrvLArirAlriGK5rpKBSB9+W5yI+1J82kTxamfWGixuNaEG8kEk+Izy+9LiNLJeDp9YvTkW5f4eVaKKsEZ7rFAl/pg+/BPh4U2IH94vh3kWkagQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqItNznC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95DD7C4AF14;
	Mon, 29 Apr 2024 05:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714368629;
	bh=rjOSUBao3IhikJsSx41/jAuu9PGrkqmrRnBC8aR66X0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RqItNznC19fEOWHh054rGf7J5A3iJahvG1KOlb/GS9XZK6HLbf3SJvSGjBWX/ljAR
	 tg2249mS2SzdUZirHcW2DfcZS9Hur+pxfiwZpCeeaotxOddodiwoBuYpEVAG7oxz2L
	 97iFPQl8iwyKdpfG5julladRROmKw2QdmTYtfnT8NMMqvZERNxeUg5zDA9XE7s8e0B
	 VV1UFJId4Wi2MBvcmLnbyrYKjuLQIz6kMw3epdGgAsrzBR0H4jQ/3ByFATHG1rLfaZ
	 0ZQ9BUeIvDh59IvM4clCOR9EQCy9abne7O2YisjyeCOeKc/9VuhoPltuHRdXatU6DU
	 xFpvH+hg54d5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83AA3C4361B;
	Mon, 29 Apr 2024 05:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/3] net: bcmgenet: protect contended accesses
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171436862953.10386.10913338084330805580.git-patchwork-notify@kernel.org>
Date: Mon, 29 Apr 2024 05:30:29 +0000
References: <20240425222721.2148899-1-opendmb@gmail.com>
In-Reply-To: <20240425222721.2148899-1-opendmb@gmail.com>
To: Doug Berger <opendmb@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 25 Apr 2024 15:27:18 -0700 you wrote:
> Some registers may be modified by parallel execution contexts and
> require protections to prevent corruption.
> 
> A review of the driver revealed the need for these additional
> protections.
> 
> Doug Berger (3):
>   net: bcmgenet: synchronize EXT_RGMII_OOB_CTRL access
>   net: bcmgenet: synchronize use of bcmgenet_set_rx_mode()
>   net: bcmgenet: synchronize UMAC_CMD access
> 
> [...]

Here is the summary with links:
  - [net,v2,1/3] net: bcmgenet: synchronize EXT_RGMII_OOB_CTRL access
    https://git.kernel.org/netdev/net/c/d85cf67a3396
  - [net,v2,2/3] net: bcmgenet: synchronize use of bcmgenet_set_rx_mode()
    https://git.kernel.org/netdev/net/c/2dbe5f19368c
  - [net,v2,3/3] net: bcmgenet: synchronize UMAC_CMD access
    https://git.kernel.org/netdev/net/c/0d5e2a822326

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



