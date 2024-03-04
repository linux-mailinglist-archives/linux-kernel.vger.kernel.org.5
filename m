Return-Path: <linux-kernel+bounces-90672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89066870304
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6551F26F32
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1B03FB31;
	Mon,  4 Mar 2024 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dROnP1oN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6E33F8C8;
	Mon,  4 Mar 2024 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559685; cv=none; b=QOctCK1gQMYqi2d6N/heMdvMyJMe/Y7cqA/Efx5c0Ob4AA9SVtNy/OT20EjmCpBSCHJNhEVhbkbkK52OcmNlsD9WCjbwfMTO05+AzbjENXcYrrIOIKHM2kqY+Rf2ZQwGuAgG5ZLsGpvseyUCxk9PUrt0VjwWfL5QsfJ9sCD3jSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559685; c=relaxed/simple;
	bh=4PKnYEG8L0X+Wp1CY0SR1GBVZMalfPoIaGfMeCCjp0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xc1rG5mI30+Bps8+Q0adXX3u0YOsCLYMls6AmhR/jLHcQbbzUczZ0kjisMA+IF1NXraKuQYaAcVWUaGqKlPMSKw+nx+Y63X+cK92MsOun4ckDUXlZkqPR93WihtMlSmRRDLEpftUSuBUvAYG/IoPwrBV7M3NVeq9sVI9GSUbSzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dROnP1oN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9812DC43390;
	Mon,  4 Mar 2024 13:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709559684;
	bh=4PKnYEG8L0X+Wp1CY0SR1GBVZMalfPoIaGfMeCCjp0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dROnP1oNY2n9RgCuft2wiRjW6gonTtpSIXpHyG0LJDDv6GR/NqTgsU9ZOz9fYo+Cf
	 HcgSVCe5VNVcGBl0TsToeAxXX00xMMSHPEr9ty+0GiUckX5WaMIanuarfC17orVxlc
	 Yv7RVjHdh1QACdLkY6ImAbX5ToStPduFoG7yw0RENoxv09fXVGoCttqWQ40GjgMVEM
	 oYn1bMHrVnj7sT9C7ad51BqHSRNd6+FQeqE1KAhViirA+exzz+cB6fEwpgvrckzxft
	 H/DTwkhH8E6JhoHV9WrnL2Tl5Q1o5kAMmSyDt5fpHSnwA8Z4lzfJeLkWbSrJXcXOmV
	 6WPfbkMBlr1cA==
From: Will Deacon <will@kernel.org>
To: catalin.marinas@arm.com,
	nathan@kernel.org,
	mark.rutland@arm.com,
	broonie@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Puranjay Mohan <puranjay12@gmail.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH] arm64: prohibit probing on arch_kunwind_consume_entry()
Date: Mon,  4 Mar 2024 13:41:16 +0000
Message-Id: <170955720098.2136218.47711104039103934.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240229231620.24846-1-puranjay12@gmail.com>
References: <20240229231620.24846-1-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 29 Feb 2024 23:16:20 +0000, Puranjay Mohan wrote:
> Make arch_kunwind_consume_entry() as __always_inline otherwise the
> compiler might not inline it and allow attaching probes to it.
> 
> Without this, just probing arch_kunwind_consume_entry() via
> <tracefs>/kprobe_events will crash the kernel on arm64.
> 
> The crash can be reproduced using the following compiler and kernel
> combination:
> clang version 19.0.0git (https://github.com/llvm/llvm-project.git d68d29516102252f6bf6dc23fb22cef144ca1cb3)
> commit 87adedeba51a ("Merge tag 'net-6.8-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: prohibit probing on arch_kunwind_consume_entry()
      https://git.kernel.org/arm64/c/2c79bd34af13

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

