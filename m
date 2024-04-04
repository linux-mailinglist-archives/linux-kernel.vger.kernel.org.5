Return-Path: <linux-kernel+bounces-132049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 868B0898F21
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BB7BB267AD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADD4134743;
	Thu,  4 Apr 2024 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYyGxFmw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C11E763FD
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712259629; cv=none; b=ucXFQ89NKyyWKWotC92T4Tjo8NJi9QoFFFGnA3AEO26++KaWMFwjx9siolT3t+f6BsV9/UTUKkhlLgbCJXlARNW6xzJsgDFLwpMPsO+EqU1qvEcNGH7mYWpd9HgliKXX8v7Lgjyz1nuox7RDLrr5Q1WP0xqQK9jcb51HBdvbThc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712259629; c=relaxed/simple;
	bh=LF5HTKzkZrD0EN4i5nxerZtQ/C00sJAstrTwpuQo2Uc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ofp/LaHzhSDbVEZaaYvdWtqxSiRm9mQzC7Fxkk9HcOkaZ+meq5qU/ip58iRpsjiSHbpivHG85w4ZVMPs2+P7mQLhqHobZYI3Z2H72qkPq0VO+AZHUO1PB0582WDC7uDstFwNPzwci3RNn2aI5G38MJBeJfqhQ263U7rkS5Qan5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYyGxFmw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 302D6C43390;
	Thu,  4 Apr 2024 19:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712259629;
	bh=LF5HTKzkZrD0EN4i5nxerZtQ/C00sJAstrTwpuQo2Uc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gYyGxFmwRRWP4qfzFiZBtDZWTv3yQXSRvtHrVZiFJSyagXx9AfWjQJp/yrznoG8Sc
	 ZAra35p5W7jcn08ZjcqrSfLP+4On0PkPamZRz9nNUYpQsoRUEf4VUtpzPKF7CqYVRB
	 ZdnSdBPB+MEHeWAajIC0xOAb610ijKquwfxN7FSh5OTwSQ/XuE9lC0FP35mGJR8/+3
	 iog/b0I8WIf70GkjmeeAtbqFjSVPePX9WwmkKsqWqqzpBj2Sx7uIKTBaOsRtRXqfjL
	 +oK9AIdKuMYir8B2Q5l+QSdQBj7KddY4+ph2aFHGn7AZ9PhXp2F1buvEBOuh8nXaog
	 XsO96DmmuJ/sQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1CF6AD84BAD;
	Thu,  4 Apr 2024 19:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 RESEND] riscv: mm: implement pgprot_nx
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171225962911.17194.8100978585103376658.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 19:40:29 +0000
References: <20240325105456.1338-1-jszhang@kernel.org>
In-Reply-To: <20240325105456.1338-1-jszhang@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
 hch@lst.de, samuel.holland@sifive.com, alexghiti@rivosinc.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 25 Mar 2024 18:54:56 +0800 you wrote:
> commit cca98e9f8b5e ("mm: enforce that vmap can't map pages
> executable") enforces the W^X protection by not allowing remapping
> existing pages as executable. Add riscv bits so that riscv can benefit
> the same protection.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> Tested-by: Samuel Holland <samuel.holland@sifive.com>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> 
> [...]

Here is the summary with links:
  - [v2,RESEND] riscv: mm: implement pgprot_nx
    https://git.kernel.org/riscv/c/0ffe1ae7026d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



