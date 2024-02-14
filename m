Return-Path: <linux-kernel+bounces-65239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A29208549DF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8F11C249CE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CC85336C;
	Wed, 14 Feb 2024 13:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdwdWDKm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440BE4315C;
	Wed, 14 Feb 2024 13:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915628; cv=none; b=k23+bzlLsCyWYWoxFrAUBJBtHGzXigk9stq4+9K3h8d1j9gng7OFWpVifqInPdlO0U7raVflWaq13ECesJp59Yg5vaXorl+P67Lc0qKa96sj0lGOKvqufPgsqmIhi0H4nMOZtW9JwErxHa9Ugeasnnzg56kLMUYGtARtyZIb8UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915628; c=relaxed/simple;
	bh=3pRvKC+/bkYHXhcV5Eim0BrHFJuWGf19pUaCh6PMG78=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TvlJ737WpHlF4tBzV1aCosMy09XDyCItSVySgG/A3HYgaVhx+I4iD/Vz2WkNBOJHCd8N61a5rlVP+ZAATMy94WWfiWHgL6iKNkxooY/9l4i2D49a8kPeDvC4+Rsdig950sNt1TD9OzLr7Aa768R3J9yRpgC8xif4fAll8OWRNW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdwdWDKm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B63A1C43390;
	Wed, 14 Feb 2024 13:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707915627;
	bh=3pRvKC+/bkYHXhcV5Eim0BrHFJuWGf19pUaCh6PMG78=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gdwdWDKmuqwx9ndoTdlSlTiJPGJzCKaqfK7oN8oHYovjbc3ELCNfHUxucC8TLevFJ
	 Sbm7wjl6T+jXEwopqdKnbM5JJ0flqavvlh2h0afJzajGVi/SjSygjEiePaOorycyiW
	 k1CBTKPx89Q8Phi0PdR+/JjU0WzLuRQ5ztGNGlWMSflWGu0c4+/ErxCxkK4cUrg0vG
	 yUM/jc59x0DQ9g43XgPhxlnzLsP56BQsjUM0r4coAzRwQGVhdJHwzn3JeC3LydcRgT
	 9r6/u1ncZMwWtzDRx6TjYV5uF+JHAiG/PbS5sZhV48Txmm9+eC4leTrPcbmwU4CEI0
	 pwRlZtzdLzokg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 99821D84BCE;
	Wed, 14 Feb 2024 13:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ethernet: cpts: fix function pointer cast warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170791562762.13263.17726811271145661649.git-patchwork-notify@kernel.org>
Date: Wed, 14 Feb 2024 13:00:27 +0000
References: <20240213101654.461239-1-arnd@kernel.org>
In-Reply-To: <20240213101654.461239-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: kuba@kernel.org, arnd@arndb.de, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, nathan@kernel.org, ndesaulniers@google.com,
 morbo@google.com, justinstitt@google.com, richardcochran@gmail.com,
 grygorii.strashko@ti.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 13 Feb 2024 11:16:34 +0100 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang-16 warns about the mismatched prototypes for the devm_* callbacks:
> 
> drivers/net/ethernet/ti/cpts.c:691:12: error: cast from 'void (*)(struct clk_hw *)' to 'void (*)(void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>   691 |                                        (void(*)(void *))clk_hw_unregister_mux,
>       |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/device.h:406:34: note: expanded from macro 'devm_add_action_or_reset'
>   406 |         __devm_add_action_or_reset(dev, action, data, #action)
>       |                                         ^~~~~~
> drivers/net/ethernet/ti/cpts.c:703:12: error: cast from 'void (*)(struct device_node *)' to 'void (*)(void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>   703 |                                        (void(*)(void *))of_clk_del_provider,
>       |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/device.h:406:34: note: expanded from macro 'devm_add_action_or_reset'
>   406 |         __devm_add_action_or_reset(dev, action, data, #action)
> 
> [...]

Here is the summary with links:
  - ethernet: cpts: fix function pointer cast warnings
    https://git.kernel.org/netdev/net/c/9b23fceb4158

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



