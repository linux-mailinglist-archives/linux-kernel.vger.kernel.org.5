Return-Path: <linux-kernel+bounces-47433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40014844DD9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F202F290605
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB2723D2;
	Thu,  1 Feb 2024 00:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqvHczmP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4578C2107;
	Thu,  1 Feb 2024 00:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706747430; cv=none; b=PCDlS56HTnpSpfDifQuuCW3yTjf3SE0nEHjKw01rZHiU5/ouZSguXQaJQnUxctcvr7ulu5d6Oecq/MHAoh7E6SVkQWb9S9+nAhnzRFNjw8CAA14yE5RJo4/ywMMwV+wJestv9vdQ+UzHP1qlaU6D6PuyT9jpBIr9NEkp084Qna4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706747430; c=relaxed/simple;
	bh=s9Lc3xCZcWT6Gc/qFKin3FTGgWgE4VISCyf253K8LYQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jteKlErdkbmkXaEixl/zbTGYgvKFB7TAlj63PdZ20/87V593D2IBjm9+86WuMU9HJ7wgoF92glfk7Y7HGhW7nFcaBb8Kak2htBzZ09w7YQVUOHG8G+L3dVfP21XNURpRtnynW37EJgWA1II2cuLngbOUp8NIssc6n0iTbDh2eTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqvHczmP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF446C43390;
	Thu,  1 Feb 2024 00:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706747429;
	bh=s9Lc3xCZcWT6Gc/qFKin3FTGgWgE4VISCyf253K8LYQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DqvHczmPrRqbedC76fEBYyvHSzsrw/m2EKqJdMWzfsF/hdE/UZ2jsZfWjEg4PwyVZ
	 yc2IVhtSavp+q2HLIE6/cq8YUakFq9EVDImRxfVuQtRCUyTQocyUKaxp2qdP+gJFuL
	 EmzOSKbphRiOkhR1oVup74CX8sTcCSKfFOawxX4EAvZ4qTcFX3IgDQdfHfInXy9xGb
	 IrJfLTqdW5wXyy7tpa2aD/o0LhmqvM4IxOe9O/dvr1pd3fkQ2Cbd73r2AapA0YSRV2
	 kMtYyAleWoj2LpfGabuQ+WXrLERHZqkAB5+P67GTGOGnm4DIWv5KMpFw2Su/YGA+AL
	 sJ+7qC7pJ5bIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A347CD8C96C;
	Thu,  1 Feb 2024 00:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v5 0/2] Prevent nullptr exceptions in ISR
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170674742966.15954.14353747489471422118.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 00:30:29 +0000
References: <20240129135734.18975-1-andre.werner@systec-electronic.com>
In-Reply-To: <20240129135734.18975-1-andre.werner@systec-electronic.com>
To: Andre Werner <andre.werner@systec-electronic.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Jan 2024 14:55:03 +0100 you wrote:
> In case phydev->irq is modified unconditionally to a valid IRQ, handling
> the IRQ may lead to a nullptr exception if no interrupt handler is
> registered to the phy driver. phy_interrupt calls a
> phy_device->handle_interrupt unconditionally. And interrupts are enabled
> in phy_connect_direct if phydev->irq is not equal to PHY_POLL or
> PHY_MAC_INTERRUPT, so it does not check for a phy driver providing an ISR.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] net: phy: phy_device: Prevent nullptr exceptions on ISR
    https://git.kernel.org/netdev/net-next/c/61c81872815f
  - [net-next,v5,2/2] net: phy: adin1100: Add interrupt support for link change
    https://git.kernel.org/netdev/net-next/c/08b47dfdd6b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



