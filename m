Return-Path: <linux-kernel+bounces-132052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEABF898F22
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2FAA1F2B02A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA46134CF8;
	Thu,  4 Apr 2024 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/nMSGiT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0699134402
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712259629; cv=none; b=XnqVCq/cdV2XQeq+4+GD0m69+fH7Qc+IC0Abnf5jDe5Kj3jjApfqObciXyBsmoaUsPPC6zVZebz3rOk7cdAl2KjILus3FQGrxOMKxXSCLbOuhcyx7jdBzSON5MpjOhmw606w7tc/7Nr7YUfbq58zPKl319P/PUK3/HStYWJoqVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712259629; c=relaxed/simple;
	bh=v3DmZ6IXGPe5rmr1R70F45K790DmFZH1xRFy3xse5qQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LTt0tedB48krSQQQn3K+fLqsPq7PMrEvSljAl2Vr0bDaM1Mrq5Ft/b8StPBuCSE0Qn6UAclimffo2b54jWO57Nddke/ghfaWlYoQ/Aojikp8jvVpoR3GXG5ME0Juuet+Fn6IbG+p/G1c6/u4gE8iTf4FfAf5efQKRQT3KcfspEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/nMSGiT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 410A8C433A6;
	Thu,  4 Apr 2024 19:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712259629;
	bh=v3DmZ6IXGPe5rmr1R70F45K790DmFZH1xRFy3xse5qQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P/nMSGiT2HZuY4F1eJVEGD4tL/q3+PDK4EubRDWddlO5sk06QgyGOiMuDn/QK6mNZ
	 ar1kD8ZdsWSQPKWgYuoRJxBv9FY6RKMOIhh5B4XCisaUpHnvyn/gpjmcmEtX3pMllN
	 MlZUN/l+tdV7v0BE7Ru6EY8xLS7CZOt1HtgV347mtBXrHDYqBj8hQtPOJKirlfnx0E
	 75HIGbWo04ElX3Ni0XHs2SO7crjCajopSwv9spXYFq7Flxvw0c/yDgFx07aM7/6GyM
	 ORgy5PExAz9/begalm0nZxRMMahZoXOARzuNMIR/4yfvhX9K5fT2Kbcq1/1qFOS4l7
	 Rd0SdaoU/azMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A674D84BB1;
	Thu,  4 Apr 2024 19:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Fix vector state restore in rt_sigreturn()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171225962916.17194.17766920994807052898.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 19:40:29 +0000
References: <20240403072638.567446-1-bjorn@kernel.org>
In-Reply-To: <20240403072638.567446-1-bjorn@kernel.org>
To: =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@codeaurora.org
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, andy.chiu@sifive.com,
 bjorn@rivosinc.com, conor.dooley@microchip.com, heiko@sntech.de,
 vincent.chen@sifive.com, ben.dooks@codethink.co.uk, greentime.hu@sifive.com,
 ancientmodern4@gmail.com, jerry.shih@sifive.com, nick.knight@sifive.com,
 linux-kernel@vger.kernel.org, vineetg@rivosinc.com, charlie@rivosinc.com,
 vgupta@kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed,  3 Apr 2024 09:26:38 +0200 you wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> The RISC-V Vector specification states in "Appendix D: Calling
> Convention for Vector State" [1] that "Executing a system call causes
> all caller-saved vector registers (v0-v31, vl, vtype) and vstart to
> become unspecified.". In the RISC-V kernel this is called "discarding
> the vstate".
> 
> [...]

Here is the summary with links:
  - riscv: Fix vector state restore in rt_sigreturn()
    https://git.kernel.org/riscv/c/c27fa53b858b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



