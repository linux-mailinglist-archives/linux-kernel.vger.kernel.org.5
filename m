Return-Path: <linux-kernel+bounces-31915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A5183364E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 22:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C40022822DE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 21:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8585F28E1E;
	Sat, 20 Jan 2024 21:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czTnM6gw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F79208C9
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 21:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705784999; cv=none; b=qLQae1dPrCFTyBP2nGgQdiBCzcKxbms+DorTVwylK+BH/ZoGh64ubk0NyAIA+khAh/OUP/he3g7LmGgyPxT274diYTU4Oz6gj4i3A/JX/DGllbrZv4PGNhh26u+I4CiIc82zo6pDA/z91NwbsQBpPfFrZ4j14Xl2MvSOj0/aGIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705784999; c=relaxed/simple;
	bh=3pKI7Q2xGS+keEw8XPbBylHL6NJ5AoMP/3E4CwOX1y4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SP4JqiJSpvLUYn3StXOPH6WNLYftY/9sU4qZ8GE2awVklgp30V1EFfo7yp2i+gEECOFnLas1I8C3e0BNF0gpGHl7fCl7fWmgHYBTbKVdTePuqAbR900FZPK4/uKI5zRY2WQ3UmTGBaqYma8eYKj+YxjX/cyKdmJlhr8BKZ4vGaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czTnM6gw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49FEAC43142;
	Sat, 20 Jan 2024 21:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705784999;
	bh=3pKI7Q2xGS+keEw8XPbBylHL6NJ5AoMP/3E4CwOX1y4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=czTnM6gwEOanNR2SBguDowD8dYDt5D9AEwSrWTuZ6403O8NsPMTWl1uIrugYY4XrU
	 ch15I+3JhjkOGIPDF7+ZjnBTbeEdT/buFVuwmm0Gbx3WQa3uyEKafNya5me4dQZTxh
	 H76rd205lDGBMdMoYxs65rx5kPw+jo1beOiS+hdzpEyevReeopU2cwAA7LvCixnDUB
	 MCoQj3Jg6JfhqI+Na/BRuNrKVf8xJ+38CXGG4owX4ROp9hXX8kS39MkJ7nGp8nEd/n
	 uxb45lJoaO+BV2XFl4wfdQ6t0jHelXZooWN1ervcMAhjfeYU038JQ7oYPH88iVAK2z
	 eREL0C7Y2PKkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35B09D8C96C;
	Sat, 20 Jan 2024 21:09:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 1/1] riscv: optimize ELF relocation function in riscv
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170578499921.24348.3990929964303626751.git-patchwork-notify@kernel.org>
Date: Sat, 20 Jan 2024 21:09:59 +0000
References: <20231214063906.13612-1-fido_max@inbox.ru>
In-Reply-To: <20231214063906.13612-1-fido_max@inbox.ru>
To: Maxim Kochetkov <fido_max@inbox.ru>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 charlie@rivosinc.com, ajones@ventanamicro.com, conor.dooley@microchip.com,
 jszhang@kernel.org, kernel@esmil.dk, lixiaoyun@binary-semi.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 14 Dec 2023 09:39:06 +0300 you wrote:
> The patch can optimize the running times of insmod command by modify ELF
> relocation function.
> In the 5.10 and latest kernel, when install the riscv ELF drivers which
> contains multiple symbol table items to be relocated, kernel takes a lot
> of time to execute the relocation. For example, we install a 3+MB driver
> need 180+s.
> We focus on the riscv architecture handle R_RISCV_HI20 and R_RISCV_LO20
> type items relocation function in the arch\riscv\kernel\module.c and
> find that there are two-loops in the function. If we modify the begin
> number in the second for-loops iteration, we could save significant time
> for installation. We install the same 3+MB driver could just need 2s.
> 
> [...]

Here is the summary with links:
  - [v5,1/1] riscv: optimize ELF relocation function in riscv
    https://git.kernel.org/riscv/c/080c4324fa5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



