Return-Path: <linux-kernel+bounces-144229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA97E8A4368
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5841F213B2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438F91350DE;
	Sun, 14 Apr 2024 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbkqDmak"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C58413473B
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713108765; cv=none; b=CYsLWuAP1OFllBY3Y2FELa8XDQCAbxdByEG8XdNVJnnCmNYhvunPt51S2ZKAfeyuwCCE2XG7Pcu05rKD+lyvURHB5wZ9kPxjWx6Ml7lWwH3k5bUaN5ybms7LawsukYXKXGRbNPAjuFTxDvB1mVUU8Kwo5MMmd4vMHhTqKrPQK0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713108765; c=relaxed/simple;
	bh=/b615jjEaFmNIs7LXPqjCCapz512Lm5RVdgG3VRbsAM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jnp3Rk05KTQIEXM9IP6UrvRYSJIOD7ojnydl/TDkoNsFtTLx5XmdY1CRE3ukQdy8uzHTS/9uJooWMcVjr3kXoejkq5XYfD7E4cOB0SW4lmfvSUD5wp1p1wc9XdO541CRGNoqxQ3anNVMNbhRUnjYUxJb9vMUUIs2tr1VDL/JBcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbkqDmak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4DD00C4AF08;
	Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713108765;
	bh=/b615jjEaFmNIs7LXPqjCCapz512Lm5RVdgG3VRbsAM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JbkqDmakr9djWwllgYEm3aWqcdqpxO9Ul/750YHDEFHzRN/ZW1ECNztQmFlHkrZdJ
	 K4Zpf0dF6aOaltuLmEyeHyR+BjlXycGgtHHepzIfHv5U+ArikNC+kusNEcpemiB2KF
	 ti4mhf6uP4mE3RKdynyqpDJO+ZnbXeW57GUpTf2fhLhwPAeC9TJ1uCk2mYyC792PZ6
	 xNnG814oHE2r4/JRFHL7XfWRtZrB3mPbzOm77gM/xOS58DsQI5L7QreGRvb4A5HCot
	 1yr4VCFR8BgSJsKLlvVv1rsdht1fg+lnTibovCE5VB/3xy80qMxCzy9DwBWQ0+p7Zw
	 8JTA/2vfdWydA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A25FC54BD5;
	Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: prevent writing without fallocate()
 for pinned files
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171310876523.3156.12747424719057521546.git-patchwork-notify@kernel.org>
Date: Sun, 14 Apr 2024 15:32:45 +0000
References: <20240411175410.2406710-1-daeho43@gmail.com>
In-Reply-To: <20240411175410.2406710-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com, daehojeong@google.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 11 Apr 2024 10:54:10 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> In a case writing without fallocate(), we can't guarantee it's allocated
> in the conventional area for zoned stroage. To make it consistent across
> storage devices, we disallow it regardless of storage device types.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: prevent writing without fallocate() for pinned files
    https://git.kernel.org/jaegeuk/f2fs/c/3fdd89b452c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



