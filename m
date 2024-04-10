Return-Path: <linux-kernel+bounces-138741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C75AE89F9C5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 088E028A943
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A2615FA60;
	Wed, 10 Apr 2024 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c02H669+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09AA15EFD0;
	Wed, 10 Apr 2024 14:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712758833; cv=none; b=jbt8AmO0FDR2sJ2onnEzd2HhtTueuq0HKCtbvzOBoEteDC5Qx+ZMh33zLLuWNr9qu14cDIR4viayYhLd2xoltRaT+qlWyrl31kK8ZV7ihqyg8pY+a49XwMIb36WdrXXXKUSbIVp8FnaJNS8//ZyyTEPq9wglo7G0LOFD4dplzZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712758833; c=relaxed/simple;
	bh=0DhS4EK0I4APNslc3wne19z1VN4gidak3VARFGUl/0o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H/l8SWJgaIvxAmO5/ZLsMNp1Xp256TLoe5INL7HwrbYLj/0iFkotcmaSGyySevrwpukrAKnfWYvSZtGsFN7tuoOgshh24ONb+z2kP+1ZcyonNCx/AB3qutzhnQCQyaSsiNGNi+rTMrwS3l2+lOa9eyxmUCsL80Zqehkhg/56KOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c02H669+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7ECA2C433B1;
	Wed, 10 Apr 2024 14:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712758833;
	bh=0DhS4EK0I4APNslc3wne19z1VN4gidak3VARFGUl/0o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c02H669+4EVdfAUg8t85q4fzFena0/vNFU7go8zrbdoO3G26BjMljhZdsw9YaHSCe
	 KAOMh4B4U9/di7pW7tqFJL363BOtAN8Ez1p2QYhmhIHIKzMhvQKEQ/+oQay1iHuPqF
	 eX08E+TjZA9OrqzoArP+KbizTzuIHMCtSVONtl9EJwj5AXbWAJ2J2qRI+YOvmCsrDZ
	 VTVAD6XHwOeqUhWyxiirdp5e3ioIedXhIILMVSzIfIIBEnGrbK4OL4LZnJ6N/X9eit
	 Avuur1aX5W+zXL5Knz4BuPRpjMALXPlNZHpPsg16H1upV48mqd6yqHvkiWYU9BRpCC
	 gUlyy6w0T88Pg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 705C7D6030E;
	Wed, 10 Apr 2024 14:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Do not save the scratch CSR during suspend
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171275883345.18495.7862735068515050043.git-patchwork-notify@kernel.org>
Date: Wed, 10 Apr 2024 14:20:33 +0000
References: <20240312195641.1830521-1-samuel.holland@sifive.com>
In-Reply-To: <20240312195641.1830521-1-samuel.holland@sifive.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, ajones@ventanamicro.com, conor.dooley@microchip.com,
 leyfoon.tan@starfivetech.com, paul.walmsley@sifive.com, pavel@ucw.cz,
 rafael@kernel.org, jeeheng.sia@starfivetech.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 12 Mar 2024 12:56:38 -0700 you wrote:
> While the processor is executing kernel code, the value of the scratch
> CSR is always zero, so there is no need to save the value. Continue to
> write the CSR during the resume flow, so we do not rely on firmware to
> initialize it.
> 
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> 
> [...]

Here is the summary with links:
  - riscv: Do not save the scratch CSR during suspend
    https://git.kernel.org/riscv/c/ba5ea59f768f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



