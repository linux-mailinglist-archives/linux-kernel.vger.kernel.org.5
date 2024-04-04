Return-Path: <linux-kernel+bounces-132198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9FC899138
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D1B01F24C5B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8C013C825;
	Thu,  4 Apr 2024 22:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvRPV+kJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F92B13C3EC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 22:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712269232; cv=none; b=sJzMm5LYW8L5ZZVeT+LMWJD8Jls3JQXH/kafS3+8yMkcssrDvs1I/W2C47CdO1cbWxkAUDXS/w7cmBwlRxTqJ1JLw985ZAD7FXycAYGaq6Hi6gILcgk5P4CQaiHCyM2mBeSndyCKBoNjPAm1ZKAeIh/FdxvwYNBX6kRLGAf+E0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712269232; c=relaxed/simple;
	bh=qrAEyFoT6o3bchi+2ioxOMyxKattiEg45Vsi0QCjJUw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bN486eaW1UF+TaAXWoYT5esM6yeZdWs1PLNhIIeZOdOCKaTcne+FNbQmSMw+Nez+A/Uhqpg12Oev7md90BberpQ7Jckt+RKn+28d5+NdlZyz9A9AVABtarEXz5bfkYdaXlX+DskjDyz0Qt1+P69QIw/iuH4c3SLW3IxNwByRz0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvRPV+kJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 235D9C43390;
	Thu,  4 Apr 2024 22:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712269232;
	bh=qrAEyFoT6o3bchi+2ioxOMyxKattiEg45Vsi0QCjJUw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IvRPV+kJp5+WzRN1BoW25HQWFycjRxPonO+uN1qNV6YQxSDgYlHWv7m+xB9+cqiFL
	 ns86QvTfrou2+/M5+iQcTvPSeNCjOGRY3qM99rvLCJaro4U/2egvi0W7lbe6hc96RX
	 S4Dkcw9TFcEPMaTjwIpw9vKTTXyul7xs+HvwzbrnPJm5UvGAWQrVoqMFF+7lZhX8U7
	 hv5prmDn317MfuEO4FZ43lD5ggXgowQpK4WL7SkEq/RqT195Ixjn+ojlWEXTzbI7ri
	 ihcxFmhmEqxWm9cEJ5OBrUmhocKSI8eBUO3KxTXCp4IUIAQ7Otk4FGXLDIoJAuVeA+
	 0QqkIRKpTBlvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0FFA8D9A153;
	Thu,  4 Apr 2024 22:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: process: Fix kernel gp leakage
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171226923206.6067.4805872086419688742.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 22:20:32 +0000
References: <20240327061258.2370291-1-sorear@fastmail.com>
In-Reply-To: <20240327061258.2370291-1-sorear@fastmail.com>
To: Stefan O'Rear <sorear@fastmail.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 27 Mar 2024 02:12:58 -0400 you wrote:
> childregs represents the registers which are active for the new thread
> in user context. For a kernel thread, childregs->gp is never used since
> the kernel gp is not touched by switch_to. For a user mode helper, the
> gp value can be observed in user space after execve or possibly by other
> means.
> 
> Fixes: 7db91e57a0ac ("RISC-V: Task implementation")
> Signed-off-by: Stefan O'Rear <sorear@fastmail.com>
> 
> [...]

Here is the summary with links:
  - riscv: process: Fix kernel gp leakage
    https://git.kernel.org/riscv/c/d14fa1fcf69d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



