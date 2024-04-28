Return-Path: <linux-kernel+bounces-161588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 738B58B4E62
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E7B28118A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 22:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A58B10A17;
	Sun, 28 Apr 2024 22:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2Hnp/Dc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376638F4E
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714341635; cv=none; b=TeIJlLoiRsXq4sXEc3TFSwdc+lzThhJ8cOB9fWqsvHKMPq27ItG2Atr1SZjNkHI2kFA6Lw9IV41sD8Ujyf2pdyrxekkY5L0a0TeC02gfrLHDGA2AmAtvSmVaVp8dtfd/IZ+8u4f4Nio3R1ZdRzcXZ8UXQjuEWDpvlLDJOx3amOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714341635; c=relaxed/simple;
	bh=KC1Yo+XrpJuh0Ne3EzvGhOeRZkWrMX/+3F9OQYAAjOI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=asmRRGom0wtboqjeq/+dUYj2NEjfKVdEHMxRwXythwWewoNf3c2XmnmNVmoEC/I0156YEgE6wXOqo0k2IARjk3oP9ZtN9uVU3T2VzAOW1/+HMCJ3uvWTHs06zqBDxBjGK3IeHITCjd+gmKHcMMYYKbOpnzXP/K3Yb4EhUz2N/4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2Hnp/Dc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8679C4AF1A;
	Sun, 28 Apr 2024 22:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714341634;
	bh=KC1Yo+XrpJuh0Ne3EzvGhOeRZkWrMX/+3F9OQYAAjOI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M2Hnp/Dcu4sDVlPACCyZ9vfEPsQt97EJonugf1tdn2ldnRdoxxXIIpsCnJwqaVQTU
	 YOXcvermLT+EDVjEI7EgcyNjsSnSDcVOtQJJbwOTd+OJEIqdTpI1vX5ZtDYY0qaSYR
	 fD+hpQDebee6kcavBHzkQmO8ak+G4CiQ73QlrkYxEFv8mxSVWaUfPsEjQwaxk+IB/X
	 PqdYg83/OFR0aqsCYanzqaUZs4SGboDrQSfMcNlDx+Y95pKJ2EVdfdbd1E2trpHO7S
	 D2UU9d7kHPR1t+9os3Cx8x6R8OBQU/YjRrIjCjuQfXAVvkwa8cyzCoZ04FTE9ZaVUZ
	 tq2d9RuFr2SJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC6A0C43638;
	Sun, 28 Apr 2024 22:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 RESEND] riscv: mm: still create swiotlb buffer for
 kmalloc() bouncing if required
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171434163482.22130.12186262884085784070.git-patchwork-notify@kernel.org>
Date: Sun, 28 Apr 2024 22:00:34 +0000
References: <20240325110036.1564-1-jszhang@kernel.org>
In-Reply-To: <20240325110036.1564-1-jszhang@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
 alexghiti@rivosinc.com

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 25 Mar 2024 19:00:36 +0800 you wrote:
> After commit f51f7a0fc2f4 ("riscv: enable DMA_BOUNCE_UNALIGNED_KMALLOC
> for !dma_coherent"), for non-coherent platforms with less than 4GB
> memory, we rely on users to pass "swiotlb=mmnn,force" kernel parameters
> to enable DMA bouncing for unaligned kmalloc() buffers. Now let's go
> further: If no bouncing needed for ZONE_DMA, let kernel automatically
> allocate 1MB swiotlb buffer per 1GB of RAM for kmalloc() bouncing on
> non-coherent platforms, so that no need to pass "swiotlb=mmnn,force"
> any more.
> 
> [...]

Here is the summary with links:
  - [v3,RESEND] riscv: mm: still create swiotlb buffer for kmalloc() bouncing if required
    https://git.kernel.org/riscv/c/fc7a50eed986

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



