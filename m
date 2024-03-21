Return-Path: <linux-kernel+bounces-109549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB5A881ABD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80B74B215D3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A61E7494;
	Thu, 21 Mar 2024 01:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McXJZvbU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71076FB6;
	Thu, 21 Mar 2024 01:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710985829; cv=none; b=WodaHJx9E202Jnj8/oN8uyjH3aLCWCl39aM6YO0VupCi1CB4LgMZyq4iPyTHVZodK5JYD5UxK1QQNZtc5YEHRP/D6vEC2YNW9TPBOFCrBPRtFtgKHkXEyKzAvfZ8bIEvqgNLAspec2xbVKY4h0OIZbQMQZYm+qoecRQhC6Nkc5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710985829; c=relaxed/simple;
	bh=9QAmHWjXpCP5yazUkb4ulnyleTCzmdF6cKhVhuhzJV4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bYFlZaKP1E7w6RzBOx1MbtxrBAwNOxUmRxnB+7Nc0aRy7aldgJHYjR2FE8EOmtvRoZnpfs5TUsEq0zXhGlP5e45nTZ7Lglwo6+2WtowIKdgJDq6Ld0MIp9/B3R9z0rEBQe1TmQjxbPOCBSubzMp0CNgfGv0z1wOCyO02bEW++J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McXJZvbU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48563C43390;
	Thu, 21 Mar 2024 01:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710985829;
	bh=9QAmHWjXpCP5yazUkb4ulnyleTCzmdF6cKhVhuhzJV4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=McXJZvbUsvNhxJhepixjJImLBuTcbrqbYLgnIzSXo+BQaKs1wyjDrSRyajLrQn5YP
	 ya3GSnJUr98K+mW+Rjt1AtzLgmdlo0bscKgPqrBUXoKZtMYRM6bBPN292EUOUX/U3y
	 K41Oyv2IWRDmLLYfxZNsnBurScIRGHZMgxyPDQLpsiVVSjF9KnHlMmEf1JmEdys1VJ
	 fgoQAWQJxX5EriabdQD6XTSaySv/VGDI/WD7FUgNZn07PI3Pow6F2UXj65yGBxTGTT
	 aSXFbOdi8AWXY4iiYMuxMv19f+rwqe83kPk7PE3hShtii9v6i9CsfNgMo7Xq8N/cM3
	 COUeC3BhY72Tg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F285D84BB0;
	Thu, 21 Mar 2024 01:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Fix syscall wrapper for >word-size arguments
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171098582918.5796.14005594073931825434.git-patchwork-notify@kernel.org>
Date: Thu, 21 Mar 2024 01:50:29 +0000
References: <20240311193143.2981310-2-samitolvanen@google.com>
In-Reply-To: <20240311193143.2981310-2-samitolvanen@google.com>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, keescook@chromium.org,
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org, raj.khem@gmail.com

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 11 Mar 2024 19:31:44 +0000 you wrote:
> The current syscall wrapper macros break 64-bit arguments on
> rv32 because they only guarantee the first N input registers are
> passed to syscalls that accept N arguments. According to the
> calling convention, values twice the word size reside in register
> pairs and as a result, syscall arguments don't always have a
> direct register mapping on rv32.
> 
> [...]

Here is the summary with links:
  - riscv: Fix syscall wrapper for >word-size arguments
    https://git.kernel.org/riscv/c/a9ad73295cc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



