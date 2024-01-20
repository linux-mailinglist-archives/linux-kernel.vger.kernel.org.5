Return-Path: <linux-kernel+bounces-31899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 784DC83362B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 22:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1521C20D37
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 21:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A003D1401C;
	Sat, 20 Jan 2024 21:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2rcdUCV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC19B39F;
	Sat, 20 Jan 2024 21:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705784988; cv=none; b=cYNnPlb2+G1G/fPsWI/QF/P9guzXaWGViFQrl1xrEDg9yy4LuqvcUXtxitZ7zbbwQed7SCg3/KEtWYu1T8K+7pO1APvSQkqrzokbR24ZKhJRzNTUc8lsXggnuPBqugDmHy3OEbB/S3LiQtvgCfICT+8EojPStgBKs4qkJger6Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705784988; c=relaxed/simple;
	bh=eTLr4dy/uLuhEZDSb8RfdP2ShpbC5ub3YzsOlB3z738=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W01eqRY6cvqw83RJD6xwFvifMhqsAX2lCBQqJtTzt1taVsBCFWPaBY0ou67BFrbUL+oVm+dBCyAJcwJ7HUxG7eRYVCFy1ma4M4BwBBxLjc6RF4P3TzAqKvG1yp42nP6ngIiwDSy2tb21riZGQeCs9KgOCxruGDTb/BOdm7ZRUpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2rcdUCV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DCC9C43390;
	Sat, 20 Jan 2024 21:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705784987;
	bh=eTLr4dy/uLuhEZDSb8RfdP2ShpbC5ub3YzsOlB3z738=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L2rcdUCVcDzOWn4Bg5S9EC1E2ulioUxc9CfH4ixgBvNXMr43iVg8K2rDLBlXN6hgN
	 vfNqwW5kWUqsXpVgY+wcBKjzzLbfJ/wHXLvIYXeBmg7t8/6EvA4QYoak48KaE+j/x8
	 lmnoqo+r1LcL7vqDDaPszC3IC5d48QHizq0iBOklFmos6nie6hg/3rQbfXQzXRSIsC
	 4wSPQrJB/JODPKeDz2+Hsy3ynf1vnoIH+JS71tJlB4/lUhQTXbfCY4KWD91DHL08Ub
	 6NnxzmBVBW+i1Svnfg58mBoUe+uYY3tov4jL6JVC8GrErk7qDYXH44wX+Jx14G668P
	 xaQOEg/YnDowQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 874E3D8C96C;
	Sat, 20 Jan 2024 21:09:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] arch/mm/fault: fix major fault accounting when retrying
 under per-VMA lock
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170578498755.24348.16166096320323933297.git-patchwork-notify@kernel.org>
Date: Sat, 20 Jan 2024 21:09:47 +0000
References: <20231226214610.109282-1-surenb@google.com>
In-Reply-To: <20231226214610.109282-1-surenb@google.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: linux-riscv@lists.infradead.org, akpm@linux-foundation.org,
 willy@infradead.org, will@kernel.org, catalin.marinas@arm.com,
 palmer@dabbelt.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
 agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Tue, 26 Dec 2023 13:46:10 -0800 you wrote:
> A test [1] in Android test suite started failing after [2] was merged.
> It turns out that after handling a major fault under per-VMA lock, the
> process major fault counter does not register that fault as major.
> Before [2] read faults would be done under mmap_lock, in which case
> FAULT_FLAG_TRIED flag is set before retrying. That in turn causes
> mm_account_fault() to account the fault as major once retry completes.
> With per-VMA locks we often retry because a fault can't be handled
> without locking the whole mm using mmap_lock. Therefore such retries
> do not set FAULT_FLAG_TRIED flag. This logic does not work after [2]
> because we can now handle read major faults under per-VMA lock and
> upon retry the fact there was a major fault gets lost. Fix this by
> setting FAULT_FLAG_TRIED after retrying under per-VMA lock if
> VM_FAULT_MAJOR was returned. Ideally we would use an additional
> VM_FAULT bit to indicate the reason for the retry (could not handle
> under per-VMA lock vs other reason) but this simpler solution seems
> to work, so keeping it simple.
> 
> [...]

Here is the summary with links:
  - [1/1] arch/mm/fault: fix major fault accounting when retrying under per-VMA lock
    https://git.kernel.org/riscv/c/46e714c729c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



