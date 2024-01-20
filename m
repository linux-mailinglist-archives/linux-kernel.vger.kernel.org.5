Return-Path: <linux-kernel+bounces-31909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23944833647
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 22:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412401C20D5E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 21:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAA02577F;
	Sat, 20 Jan 2024 21:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4V7szfQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E49716425
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 21:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705784999; cv=none; b=FWqsMcBUzcGU+HLiJJmfhHudOHkO4bDi2ts5z7qgU3iIOAcsOd/C6CLzAqUhKdA862a7xIRAZGcrhhfatGmoLCo5meNLedejZ8duVxTHYj6f/5+HzW0ZciRPjT/mVScRNUaplySw6UYSPqNIFug702NdnCKesihRGxSnBx6D8GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705784999; c=relaxed/simple;
	bh=QASk6X8mHI815lMQx7vHiMYhTE5lGqSmqP8w+R4JeKg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kq4e5cHbhZF3aLQzn9rCjHSRbEk6wAP1pu6j0qPm7Jt3qmLw9d3DGeamzH15rgWIviicOxgW22VhcXMQ22mJemt0QJGeT4zqU4StiLaEPtJCTLAv1obTaFCZf6tAl7ZYD9/POIq7OpQIa+nwRj8GyLr+NE+3er8u5VLnsIjNxR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4V7szfQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9527C433A6;
	Sat, 20 Jan 2024 21:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705784998;
	bh=QASk6X8mHI815lMQx7vHiMYhTE5lGqSmqP8w+R4JeKg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X4V7szfQDwYJfFcOdTjrWH386mx6c46RbuwBiop3XbWj9B/KpP5P8C8NC4tcUkhbd
	 I/lEC03ex8YEwRl+POcM796TedTPPd486rqM1J3il9coj6D1bjkXgqP8MyeMFToQt3
	 KuK+9ZBmbcMOI+nwDAdOa2QAST/rOhKLSSdq0pt+Rlaf3+WMo1otM7sHV3cnzF8FD3
	 TBCYNbioirus6IFsWMtdoP0Q1G5djUXe3F7tuAkODLYG0odOSBadDHH0JuFWkfdcI9
	 mkJ1xx8/Zw8CiMbgpx4XiqUIgMD83JW+xakSUZ6xuJYDhlTJmUGFBPE0eJTxx6oH2/
	 azb2CEYi3YhAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9807D8C970;
	Sat, 20 Jan 2024 21:09:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Optimize hweight API with Zbb extension
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170578499888.24348.15332028365241008797.git-patchwork-notify@kernel.org>
Date: Sat, 20 Jan 2024 21:09:58 +0000
References: <20231112095244.4015351-1-xiao.w.wang@intel.com>
In-Reply-To: <20231112095244.4015351-1-xiao.w.wang@intel.com>
To: Xiao Wang <xiao.w.wang@intel.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, anup@brainfault.org,
 haicheng.li@intel.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sun, 12 Nov 2023 17:52:44 +0800 you wrote:
> The Hamming Weight of a number is the total number of bits set in it, so
> the cpop/cpopw instruction from Zbb extension can be used to accelerate
> hweight() API.
> 
> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> ---
>  arch/riscv/include/asm/arch_hweight.h | 78 +++++++++++++++++++++++++++
>  arch/riscv/include/asm/bitops.h       |  4 +-
>  2 files changed, 81 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/include/asm/arch_hweight.h

Here is the summary with links:
  - riscv: Optimize hweight API with Zbb extension
    https://git.kernel.org/riscv/c/55ca8d7aa2af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



