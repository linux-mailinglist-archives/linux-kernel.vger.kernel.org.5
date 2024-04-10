Return-Path: <linux-kernel+bounces-138724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EA989F990
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69AFB1F2BD52
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D37016C69C;
	Wed, 10 Apr 2024 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msU30hyI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBCB15FA80
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712758229; cv=none; b=WZymbkK94BXUMP03DW4psmUDUxJNsH2P3r76WWtaMG6Icf0qHwp5L0lT0sauvnA8wbW3LpyGYWoZoZ1TKSuTmzZCNeqYQCmGpDwnVFWq33M/PG8PWiYm6zNYvxc/V81nqDXyktFeZb8ycTJm+CVWtcR40EsEMrb+1lXkp8Q878A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712758229; c=relaxed/simple;
	bh=pRgnzoGAqN+8AmHMkslGDM2NWRVdlaRT9PhcUTzgJJY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CDYOjkY7hBIZG8GuJM+ogT1w16izC5BgfWtzM93/tN5rpMVr7+aL6OWF749LKuvnLpEuN6XJHeWwW4w5s2Kbx0T331I7OFAFe0YhCuMpXyqT6yCDy9H6vIaciR5ZCTC/L4Xx1lVw31NMZR+8LgJkTYME5w1Hutf/C7wvL5K1+Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msU30hyI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F286C43394;
	Wed, 10 Apr 2024 14:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712758229;
	bh=pRgnzoGAqN+8AmHMkslGDM2NWRVdlaRT9PhcUTzgJJY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=msU30hyIMeAZQZysjcS6nFd+A1m/bQG/yLGXEvqM3/QhZNHaK92i6sS7+k5ZvJ/J8
	 rMZb+AEl50BIQWKhEKfN7GJ9KmluajYdrA4EWxqwd+DEE/N7hbT8AU6oWrTwDpL6O9
	 aMS6lId5NtmTZ2EXnATJ+5KuWlNznBM8r+D1Qi6+RlRFN8AT+9WtkxjEqu/jMWbUGn
	 XdXB42FII76a9l0D/z36dXCZjIjh3W+sbIxPO53ReoZ8vQTsYONHA4X/N+xUr+0yOb
	 ymGobJUfVfKV+TZtTmrcFAaFKVbA6Xi/LbH5JZ1mVSD7nSzu5igqAAWsEUbf61wtTV
	 BdyWDP5KuFDkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4DD23D60310;
	Wed, 10 Apr 2024 14:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] RISC-V: only flush icache when it has VM_EXEC set
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171275822931.12683.7449228181407944312.git-patchwork-notify@kernel.org>
Date: Wed, 10 Apr 2024 14:10:29 +0000
References: <tencent_6D851035F6F2FD0B5A69FB391AE39AC6300A@qq.com>
In-Reply-To: <tencent_6D851035F6F2FD0B5A69FB391AE39AC6300A@qq.com>
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alexghiti@rivosinc.com, conor.dooley@microchip.com, jszhang@kernel.org,
 andrew@sifive.com

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 10 Jan 2024 02:48:59 +0800 you wrote:
> As I-Cache flush on current RISC-V needs to send IPIs to every CPU cores
> in the system is very costly, limiting flush_icache_mm to be called only
> when vma->vm_flags has VM_EXEC can help minimize the frequency of these
> operations. It improves performance and reduces disturbances when
> copy_from_user_page is needed such as profiling with perf.
> 
> For I-D coherence concerns, it will not fail if such a page adds VM_EXEC
> flags in the future since we have checked it in the __set_pte_at function.
> 
> [...]

Here is the summary with links:
  - RISC-V: only flush icache when it has VM_EXEC set
    https://git.kernel.org/riscv/c/542124fc0d5c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



