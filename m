Return-Path: <linux-kernel+bounces-109416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 642AA8818CA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951DC1C20BE0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B13F8665B;
	Wed, 20 Mar 2024 20:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JN/d0Foc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70A48594C;
	Wed, 20 Mar 2024 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710967839; cv=none; b=O0PbG+vyZWMDC5gC65svDpc4e+OICCATw2PCNiTvMMCGF2nbQ7On8gvG+MmlROITIeYT+Zloh3aSMWt4iUtZL9gW36EhI6vRcuvTKLxMdvrqAPjdoQxmKQWjNdC8oqnY3CinJC/efuosBHsLrNflGrjAztS8GIn8EHFm6xTlV9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710967839; c=relaxed/simple;
	bh=btAeiZEcxlPc+5rjYdZBbRGASbJnixxCwyL87/+mmOo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ibXl7DyzfHYajXqd65+nij8/f6WKAv4ot8iq6MPYJZIVNKhkXS08qpKQiFTWGh3JnaK9bMNPZEMKix2hI3N9r91naYg23Fjtrei7E2EOQ4tyYALWyW5I2L5uqZ17CTReAGuZD5MF3FqgysV/6iaITh5el/lFcHz47ub2w9UDTQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JN/d0Foc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57AADC43142;
	Wed, 20 Mar 2024 20:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710967839;
	bh=btAeiZEcxlPc+5rjYdZBbRGASbJnixxCwyL87/+mmOo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JN/d0FocPRzqdLlU5VONUvcBZvnw9D4YRv8Y3S5UurFmfqHDO7Sqn0paBjrkfe+Qj
	 e/UDyZU3WH3eIoBQRu2Z4rHSTGvWyGxZOYGSeGXRYN2r9a0mx/YfyL8tyLYED5iQxU
	 BSUtRnwhMtjbjXw5qX9tBgugPTbOUEZhLJ+g60ruK3nVWm7kB6JG8kqdEo7Nwuo0P2
	 yQXBRtKyme+0ak27W6kGkJ02ncA95rZvSQpkLXoohaVPRZ5ET0drm0UCoKA2Vx85nH
	 fWxULX7R8Lg8zokts8jPRZq4aOoNRY6cHsZT/X3fr2mCowtqrWEAuju+2l5s1bOWCh
	 bVl1azAGYztTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A960D84BB0;
	Wed, 20 Mar 2024 20:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Use kcalloc() instead of kzalloc()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171096783930.6804.853209401745501176.git-patchwork-notify@kernel.org>
Date: Wed, 20 Mar 2024 20:50:39 +0000
References: <20240120135400.4710-1-erick.archer@gmx.com>
In-Reply-To: <20240120135400.4710-1-erick.archer@gmx.com>
To: Erick Archer <erick.archer@gmx.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, conor.dooley@microchip.com,
 ajones@ventanamicro.com, evan@rivosinc.com, cleger@rivosinc.com,
 jszhang@kernel.org, charlie@rivosinc.com, gustavoars@kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sat, 20 Jan 2024 14:54:00 +0100 you wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> [...]

Here is the summary with links:
  - riscv: Use kcalloc() instead of kzalloc()
    https://git.kernel.org/riscv/c/28e4748e5e3d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



