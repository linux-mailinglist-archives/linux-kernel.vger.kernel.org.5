Return-Path: <linux-kernel+bounces-116520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D84E388A7EC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02E50BC2919
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50ED213E6B8;
	Mon, 25 Mar 2024 07:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5Q0lIA0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255601C257C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 04:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711341756; cv=none; b=SV6ywo9CLPrUwYazIY9HKIHmsItEcb3/kqMA2Bg8tSgnBcyloQaIj4AV4XRzLPQDyHiS1J+rhNG6qDw/bi3kvGMEKlUTFc5uuRvsL7vn8Q7LCZFfu3R3e0R0WWYxFDiwGFqy1cItZ6ovDkQ1wa2Bwf1s/IzpOVjADuq7lQtG21M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711341756; c=relaxed/simple;
	bh=bOCUeLS1C7wpm9pu8FD1Zt59GN4cTLuXNPaR2yCkUEQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ADfEKQofSrtprd3VddR7lEXC/nEIAIae/yPHBXNVdQs9vLEsHHeabc45kdSXfr7ZAWM5PtHi6PGtD/GeH0DL5MVFAZcHvCau1f6cuJLvdn+vlTd8YR3caH79+oByfYgaNIdf9aIJ2/6guDFuZM3IW8PD/e3rbx+gvvjxsWNBV+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5Q0lIA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1667C433B1;
	Mon, 25 Mar 2024 04:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711341754;
	bh=bOCUeLS1C7wpm9pu8FD1Zt59GN4cTLuXNPaR2yCkUEQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C5Q0lIA0AlWK7xzVNsghEMI2APioXYG4HH5Y+1Y2mU0nEtw3fCA5PRb0epP6MDuSP
	 OpPj40tc1RwWtS+G3X6Fylw6q6ZgCp6RmNcRoChBtYRudEB/Sy+Z0AOXDKlBg1f3BZ
	 BXbSseLeWfZKLCAUhSy7uiRF+/IqqMEYGB94GSmPcNv+0ambj/ibblarTxwzEptowg
	 3PsG4sUDEMcT9BocxJz8U/NFBPOokp5twbzSEJ3JUGsZ1saomvFUZpAGLZLzX8dYSJ
	 OWEgct6i9Cc7V4tvqAhbPaAZi9QDOcVpUP8XXmHjIfRUPBVkC2F9rjA6Q08TnOzXoM
	 QJI+TqltJCkpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B30BCD2D0E0;
	Mon, 25 Mar 2024 04:42:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] irqchip/riscv-intc: Fix use of AIA IRQs 32-63 on riscv32
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171134175473.18749.6561888891935488179.git-patchwork-notify@kernel.org>
Date: Mon, 25 Mar 2024 04:42:34 +0000
References: <20240312212813.2323841-1-samuel.holland@sifive.com>
In-Reply-To: <20240312212813.2323841-1-samuel.holland@sifive.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, anup@brainfault.org, tglx@linutronix.de,
 aou@eecs.berkeley.edu, palmer@dabbelt.com, paul.walmsley@sifive.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Thomas Gleixner <tglx@linutronix.de>:

On Tue, 12 Mar 2024 14:28:08 -0700 you wrote:
> riscv_intc_custom_base is initialized to BITS_PER_LONG, so the second
> check passes even though AIA provides 64 IRQs. Adjust the condition to
> only check the custom IRQ range for IRQs outside the standard range, and
> adjust the standard range when AIA is available.
> 
> Fixes: bb7921cdea12 ("irqchip/riscv-intc: Add support for RISC-V AIA")
> Fixes: e6bd9b966dc8 ("irqchip/riscv-intc: Fix low-level interrupt handler setup for AIA")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> 
> [...]

Here is the summary with links:
  - irqchip/riscv-intc: Fix use of AIA IRQs 32-63 on riscv32
    https://git.kernel.org/riscv/c/ca5b0b717b75

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



