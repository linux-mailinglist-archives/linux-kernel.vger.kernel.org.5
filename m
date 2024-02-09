Return-Path: <linux-kernel+bounces-58963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EDD84EF42
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F76928417E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DF8DF61;
	Fri,  9 Feb 2024 03:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLB6RbP4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE5D4C8B;
	Fri,  9 Feb 2024 03:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707448269; cv=none; b=nUEZYqfBbcEh20KQetjJDiCNP2XPzl1lvmfYebDSfqAy2vFYOulYdCF48HmDo7vxGKdO72E3BEfmpN8R7djz4Sd0TWjINjVv/vAqZ1P+Q65PXsVi5ZLpp4n7TTHMuWuoEan63zyLiy1UhB5Eixj31NrpjOYmkiqGKNQqkLzA3FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707448269; c=relaxed/simple;
	bh=IGK3/aKzRGBu17JJaI5GYQZ9QiBJsZ88T2WUDQD9Fds=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Tvk5rn3HYl+XEX9Wd8PkvXam0u7Aad0WXZsv71BndRnyji/9/2HD8CHCKRV+NYh+hU7Lx1DpvicWz6jHxJxNMAENbcph7v6cEf3cNP6SB0RM3TCkQdRJL90xLEyGFG1WIT6aVeJ6STQGyToEA1XctiLtysYBYKfu2HDFHk5I9bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLB6RbP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CAD1C43609;
	Fri,  9 Feb 2024 03:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707448268;
	bh=IGK3/aKzRGBu17JJaI5GYQZ9QiBJsZ88T2WUDQD9Fds=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hLB6RbP4cH7XnuC71eMQjZGzbd+UPyk2J/WCudxfz2iO+KA/vBWszqak4FcwqmVzQ
	 6P0ILzyKtbqSSrDY7rrxUjQIG5zuG/C++DnWpBNYP6HLN9H7pgtM4VHcbEtKtgNYBo
	 vf1bdBQfiRQs7LvIbA0fJw1hUW0W6f0xJSsC5QT6mBibKclD8gMEEu8CdvHrwSvf7N
	 O3svXSWhdA8R6RU9Y1TVipq8xXZUQUD5hCD4fK6ITwA2SRHQdnS0K89PI/djP/8siR
	 ayX+4FWMSqLLohmQEn3tCWk/CUMGwVmQNz3WBLLKpcl4kBKn6FtGi1d07IGBfB5BTk
	 jUkZrRYKWp5fQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 570A3D8C96B;
	Fri,  9 Feb 2024 03:11:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/sun3_82586: Avoid reading past buffer in debug output
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170744826835.23533.602886165980090200.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 03:11:08 +0000
References: <20240206161651.work.876-kees@kernel.org>
In-Reply-To: <20240206161651.work.876-kees@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: sammy@sammy.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, gustavoars@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 Feb 2024 08:16:54 -0800 you wrote:
> Since NUM_XMIT_BUFFS is always 1, building m68k with sun3_defconfig and
> -Warraybounds, this build warning is visible[1]:
> 
> drivers/net/ethernet/i825xx/sun3_82586.c: In function 'sun3_82586_timeout':
> drivers/net/ethernet/i825xx/sun3_82586.c:990:122: warning: array subscript 1 is above array bounds of 'volatile struct transmit_cmd_struct *[1]' [-Warray-bounds=]
>   990 |                 printk("%s: command-stats: %04x %04x\n",dev->name,swab16(p->xmit_cmds[0]->cmd_status),swab16(p->xmit_cmds[1]->cmd_status));
>       |                                                                                                               ~~~~~~~~~~~~^~~
> ...
> drivers/net/ethernet/i825xx/sun3_82586.c:156:46: note: while referencing 'xmit_cmds'
>   156 |         volatile struct transmit_cmd_struct *xmit_cmds[NUM_XMIT_BUFFS];
> 
> [...]

Here is the summary with links:
  - net/sun3_82586: Avoid reading past buffer in debug output
    https://git.kernel.org/netdev/net-next/c/4bea747f3fbe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



