Return-Path: <linux-kernel+bounces-65218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4AF8549A6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C2D51F21C5A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C3D5337F;
	Wed, 14 Feb 2024 12:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krzHweqC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4804452F7F;
	Wed, 14 Feb 2024 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915026; cv=none; b=BR7JnbIN3l6EkaclMwB1m/RB+x4RE0dIvtmZgNjHYMIWCgOxRw772x7JnL8Co5kF3M670sa/HX5wXfkzlndl6sPj+hxbVPF8HC3/jhN1z0QCETAZWC6ElGWeTgSSmAswCIsYBKfXvvqLLtf5/emnIThLtZXILn3DJeaMy/+ZLVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915026; c=relaxed/simple;
	bh=j27ZC7gvhVvN/TfBI+iXQULEDbsjY/1VfpRBROKcL5A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d70rjmZ9cZONMr61DYU5xZKgLE2DCxzsaCkxu+SnQEVqvy9CuaWe9YHWgKOLN0Xl3qZKHIXmjSZupEP/+HWNlCLC1OrJpYzD4larbqec94L8fcFNRF3f80Q5dGCfPnQn8VfabgWsrrSUPLTHdGd26NJcJNVhqaJObd6jFVmq+wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krzHweqC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3F46C43390;
	Wed, 14 Feb 2024 12:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707915025;
	bh=j27ZC7gvhVvN/TfBI+iXQULEDbsjY/1VfpRBROKcL5A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=krzHweqCNerRSYMsUctzLkbhfXtOSqMV/2C/DgPEsa6u1EO9swyLBD4PS3eUIaLhp
	 DLcHExjLXT4vNmOjSJX+DUeHdbP20U0KpcNt6egN2HOucXNZmuyoon4jnNtagkORD/
	 kXJwfaQVkmIuDsfX6NcR6URjUg5Rpo+PYIpdCV9ye1JdpTNHDR2xPkbkOKbKeeWiJ7
	 WnWvHQNKq37ehBVrQm2BlUB9BAIkGKFzIYRF6Ke6nfMeQOkrrTzU+RA+d8RGlcaUKD
	 Yx4F64kFf2BgimFsYHBZRuDHsM4WzCrfhEhWdXxqI1mPFNfMoqaanAiaMW9PeCWxeY
	 nxIv4pWvpEPTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96C5CD84BCE;
	Wed, 14 Feb 2024 12:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bnad: fix work_queue type mismatch
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170791502561.7127.2095546229162487454.git-patchwork-notify@kernel.org>
Date: Wed, 14 Feb 2024 12:50:25 +0000
References: <20240213100809.458571-1-arnd@kernel.org>
In-Reply-To: <20240213100809.458571-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: rmody@marvell.com, skalluru@marvell.com, GR-Linux-NIC-Dev@marvell.com,
 kuba@kernel.org, arnd@arndb.de, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, nathan@kernel.org, ndesaulniers@google.com,
 morbo@google.com, justinstitt@google.com, yunchuan@nfschina.com,
 huangj@Brocade.COM, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 13 Feb 2024 11:07:50 +0100 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang-16 warns about a function pointer cast:
> 
> drivers/net/ethernet/brocade/bna/bnad.c:1995:4: error: cast from 'void (*)(struct delayed_work *)' to 'work_func_t' (aka 'void (*)(struct work_struct *)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>  1995 |                         (work_func_t)bnad_tx_cleanup);
> drivers/net/ethernet/brocade/bna/bnad.c:2252:4: error: cast from 'void (*)(void *)' to 'work_func_t' (aka 'void (*)(struct work_struct *)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>  2252 |                         (work_func_t)(bnad_rx_cleanup));
> 
> [...]

Here is the summary with links:
  - bnad: fix work_queue type mismatch
    https://git.kernel.org/netdev/net/c/5d07e432cb38

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



