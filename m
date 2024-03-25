Return-Path: <linux-kernel+bounces-116524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F8088A050
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443CB2A670D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2D944C77;
	Mon, 25 Mar 2024 07:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCEzRCyz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6EA1C2581;
	Mon, 25 Mar 2024 04:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711341756; cv=none; b=Kb82BEw47+ufWUCPP+i6ceakZpz4bpruf22NvZI/N+wN/KbU+bpuoepeYikvN7tsDKGc11xDYuSXGWLbiRK0rnIe2PjTLSJFC+E7eUP+6xC1B/R6vI5HbQI8j1S9O+R1E7zGI6PEryUuvn+kDlE5T8V5g1rYMGDUGLfXQqk+7Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711341756; c=relaxed/simple;
	bh=4yStfrK4SQVUbj2aqcQE+48u8AfaMFrS4+tHEELssTw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Km0/Pw3+rlzmRWm1yZs7U3BufIFrLQVQIY1dOQw2eh0hCv+l1QJtCGbfNDd521WK0IA2d8Rn711+7ZMfmSa/gWN3ebCoCQJawYoMHSI64rRyvrmR9UBxgg410k/r2f+Gv1bBmZANE741p6MmsXzEK0/HUEBaPwsg3yGhX2m3wB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCEzRCyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7D52C43141;
	Mon, 25 Mar 2024 04:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711341754;
	bh=4yStfrK4SQVUbj2aqcQE+48u8AfaMFrS4+tHEELssTw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZCEzRCyze7tj2dRAQEKT/yrQWS3Pqn4bPaxgQKZdu9YbhUtZLJD0OydpAcdL20PC4
	 7iWeNBDav2s+KtOjaj7l27OB0sCln5/g9V5SXAhjhM7EBkT+L/FFYX1S4pcK4XwWRQ
	 pBtQ6pxqVCSVdLLo8XRAXV45QE85EquJCd+GGNsSq4aDXrJ8fipEZWgCqfrqGbzsa5
	 oRYEe7vAr9h4RbHDCPMVAVMXcT3uCr2OT6NCXc2+AgDiyEYVn3ZkL0eQXFcRH4bldD
	 F4bUwh+2thCfZ6iLVZBp6HqT2GbT5c7VdFpeMjQyP5Lvmvg7/udPNRbiMi7Bn4c6f4
	 XPWJGMvrygDww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A971DD2D0ED;
	Mon, 25 Mar 2024 04:42:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] arch/arm/mm: fix major fault accounting when retrying
 under per-VMA lock
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171134175469.18749.11610415936860732367.git-patchwork-notify@kernel.org>
Date: Mon, 25 Mar 2024 04:42:34 +0000
References: <20240123064305.2829244-1-surenb@google.com>
In-Reply-To: <20240123064305.2829244-1-surenb@google.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: linux-riscv@lists.infradead.org, akpm@linux-foundation.org,
 willy@infradead.org, will@kernel.org, catalin.marinas@arm.com,
 palmer@dabbelt.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
 agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, rmk+kernel@armlinux.org.uk

Hello:

This patch was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Mon, 22 Jan 2024 22:43:05 -0800 you wrote:
> The change [1] missed ARM architecture when fixing major fault accounting
> for page fault retry under per-VMA lock. Add missing code to fix ARM
> architecture fault accounting.
> 
> [1] 46e714c729c8 ("arch/mm/fault: fix major fault accounting when retrying under per-VMA lock")
> 
> Fixes: 12214eba1992 ("mm: handle read faults under the VMA lock")
> 
> [...]

Here is the summary with links:
  - [1/1] arch/arm/mm: fix major fault accounting when retrying under per-VMA lock
    https://git.kernel.org/riscv/c/e870920bbe68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



