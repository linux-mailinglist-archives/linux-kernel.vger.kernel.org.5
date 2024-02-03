Return-Path: <linux-kernel+bounces-51088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FED9848659
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 13:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8CC51F2AE7B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 12:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE5C5DF15;
	Sat,  3 Feb 2024 12:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgtu4Zzi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC6732182;
	Sat,  3 Feb 2024 12:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706964626; cv=none; b=A7HEbUq+pbBYzO2Auut4/qiBoGkoN7jgPpmv/DiNri7GMcmJYMrcsvOLdV6epGqLc9JaD2L18B0P86RuFqzMrvLj7CYxx7uGJvUHXfMON4/CaD6pGSp9IZPrWqBMHTlli7163doRuaYLvimOgf8+HHvj3Iv1K5sHLWWSTNtZEh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706964626; c=relaxed/simple;
	bh=4t2eIXWmLTL3rV1oNChspwpxsKgkirNwskZFHZ26KM0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=shcu1G7smZWWpsJXIEMD91M3l/X9gZIECtQm4ZnF43JdJ55ubuM0HQHg5STNqlLye/1tfXNqM0BK0TYJnoNH08y6bait4HvzktgLmqrYKLsz5MpKTosnNkB08Tf3s8V3EurzBjI4ob2CQ4LxrD9hSPNz8vDQGW6WTXoNpo+F+UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgtu4Zzi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1780BC433C7;
	Sat,  3 Feb 2024 12:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706964626;
	bh=4t2eIXWmLTL3rV1oNChspwpxsKgkirNwskZFHZ26KM0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mgtu4ZzifVN6REyYY3QFsME1HKSeDaqDxTuB24piiiwUObISN5akIdxDmMFQP+kxO
	 qob7nAtXz5wwVrRkzdohShkjE1LLVUN6G4+HLXAdIUWsxvOLJG+1rt/cLYj/AZl4bo
	 3577M+Qk9hZ8tJZ/0vbkip3A594gA+1dnK3Jo4Iqxj38reUkth4KKkDHbvJETRjjYm
	 xev7CJfstiEjyn+EsGOBLTepF13nkCzLYYn+jzwkW4wNrhIf8uD+XoILQAWpBl5+3y
	 Mooxk/FMxEs3u9EPfXsfWD+2WpnrMV2LxGfXqJvjughw2xNcmbdBD32ABJQTs/8dai
	 Batf4Iw7jkWqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EDF46D8C970;
	Sat,  3 Feb 2024 12:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] atm: idt77252: fix a memleak in open_card_ubr0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170696462596.20224.10963989876118755848.git-patchwork-notify@kernel.org>
Date: Sat, 03 Feb 2024 12:50:25 +0000
References: <20240201124108.3052635-1-alexious@zju.edu.cn>
In-Reply-To: <20240201124108.3052635-1-alexious@zju.edu.cn>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: 3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  1 Feb 2024 20:41:05 +0800 you wrote:
> When alloc_scq fails, card->vcs[0] (i.e. vc) should be freed. Otherwise,
> in the following call chain:
> 
> idt77252_init_one
>   |-> idt77252_dev_open
>         |-> open_card_ubr0
>               |-> alloc_scq [failed]
>   |-> deinit_card
>         |-> vfree(card->vcs);
> 
> [...]

Here is the summary with links:
  - atm: idt77252: fix a memleak in open_card_ubr0
    https://git.kernel.org/netdev/net/c/f3616173bf9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



