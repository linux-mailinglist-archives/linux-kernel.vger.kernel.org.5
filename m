Return-Path: <linux-kernel+bounces-77759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 009BB8609DB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E915B24BD1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BB11119B;
	Fri, 23 Feb 2024 04:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oscyNRQu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB37B653
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 04:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708662630; cv=none; b=eTUmpfVzzxF0oEJ+6uU3hM5tiTePrDsRa0bvARcQdLmQgxLqyRJN968a8J2PtLzhlbJ08McgJgs8Kf7PnNPDcPpshaBpeDba3/S1j/Tx8m8uGsG0/RBynv+e1dKHor2Oc6IZwrscztPgyccoNjaj6NH74ep90ZHA6RXqu3H5D34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708662630; c=relaxed/simple;
	bh=KV/zJRKEvFeJWMlyATAkxWnGr6jaudLaHsE043jXY3Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=luPYmIbs5kLnodot2JLb0vRp93CDnfhPPmEQZ1v+EwpCM+SsM5gPXE771wllgUVV+Tip55FT8aqobvWjMgSDePaLbpR0LMqj2X+m8mgeuG0slvhONjVyGbN4nOs6rrhZrBWwktZjRx8UyDOxZ5DZkQOM+8pScBaG8fnIxHSQmaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oscyNRQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41C37C43394;
	Fri, 23 Feb 2024 04:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708662630;
	bh=KV/zJRKEvFeJWMlyATAkxWnGr6jaudLaHsE043jXY3Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oscyNRQu/geoGXX330qXkgOb3RquaHfcmfswu2flZ8ZEv2ZqoqnIImArljdFVdMM/
	 EmCsl1op258k4m0+rFdDYgQFuH9z3KKtSujc+xCWaY+QgL93dWQexkNVz2BC91B/jq
	 L3H6l0y0c9gV7puSKsOzDdtOdlOwtjegsxECcZkWN6b/5n0pyRSd1eiy9UttUDnSRj
	 n+Y+3cCiuwGAzHABI+ss2okBbUvTXNo3/t7Gm69ZSgRUha9uG7rZUNLFTDZ56CwHp4
	 zn7sPnj84pDhMKxbZlD9TLZmNa+eNA8JH2jMtEusiPfCPvqzeYE6PpfMI12Gi4Srd6
	 B2SqoqmUmG5DQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 24C5DD84BC0;
	Fri, 23 Feb 2024 04:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: mm: fix NOCACHE_THEAD does not set bit[61]
 correctly
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170866263014.22939.14636378102523037182.git-patchwork-notify@kernel.org>
Date: Fri, 23 Feb 2024 04:30:30 +0000
References: <tencent_E19FA1A095768063102E654C6FC858A32F06@qq.com>
In-Reply-To: <tencent_E19FA1A095768063102E654C6FC858A32F06@qq.com>
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, jszhang@kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, guoren@kernel.org,
 alexghiti@rivosinc.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 21 Feb 2024 11:02:31 +0800 you wrote:
> Previous commit dbfbda3bd6bf ("riscv: mm: update T-Head memory type
> definitions") from patch [1] missed a `<` for bit shifting, result in
> bit(61) does not set in _PAGE_NOCACHE_THEAD and leaves bit(0) set instead.
> This patch get this fixed.
> 
> Changes since v1:
> * reword commit message and add reviewed-by
> 
> [...]

Here is the summary with links:
  - [v2] riscv: mm: fix NOCACHE_THEAD does not set bit[61] correctly
    https://git.kernel.org/riscv/c/c21f01481860

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



