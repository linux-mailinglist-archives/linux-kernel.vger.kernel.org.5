Return-Path: <linux-kernel+bounces-103562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD4F87C122
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4971F219B4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916B47352A;
	Thu, 14 Mar 2024 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hF9pB5rw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1107319F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710433231; cv=none; b=ZuI7U7OHF6k3l1atYz3f7uR/txImMNQNkaxkK1qm+JzP9bAV2Dy5+F9f80eNWvkNfMDivVK3F/rnML8DpjYQCV9XATOmxKW9LthpRZ28P1QUgeH2RKChKaxZeWnicOzSlEmtrW9LFbBPFe2iHnCtLHbFKsvtDYT1rVhafF+JrhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710433231; c=relaxed/simple;
	bh=DiMMcNdh086cZ1dy2/SsqCOSR/rQG4XxC4tlfBQ3NIs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b72HTOT29Sgn587XQFDYeCSE7LM8PH6xp0AJk3X9mPsgiyvmwpc9EH+pc10d3LH3ubcevyx47h3s0SqyJl1fS+nBUM1L4pgFxIKAgk4rSuvHIanYhDCeBcSO7WX3ryxWeM4JBeyxWbOSbmxFv5VjOmsAx0flCp8isvD9gcxQjZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hF9pB5rw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82B05C43390;
	Thu, 14 Mar 2024 16:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710433231;
	bh=DiMMcNdh086cZ1dy2/SsqCOSR/rQG4XxC4tlfBQ3NIs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hF9pB5rwtQNKNi8cLb0VPwWDhJRtsUNAoHE5f7QVDsYRkJcE6GbiAalYTxtsxCK4t
	 a2iCRcQV/nw/5PD8jhzND6x1NdqSNRm++a5mIWON6CAWt/oG0fb8kp3RDmqoRa0hf8
	 5M15xbK3HaZkwSReUVEtfVLp9LnBXCTvjfbuVV0oCP9OA2yyCJ6fmWc8bjSvE51RhT
	 S7Usmy2qDtd/ofd0YxIbJzehl/Dw98De1F2/79aKYY81H0VdkKXfcwMuBNph1NdIg+
	 z0vhZp+fPlcITayDCK4gAo4Ot+kpj+UwaWLuV1uABpJjAc/2sA8yryinATt3sanklf
	 JjVzGaxdcHmdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6DCD3D95061;
	Thu, 14 Mar 2024 16:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid use-after-free issue in
 f2fs_filemap_fault
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171043323144.13516.1787617599417094605.git-patchwork-notify@kernel.org>
Date: Thu, 14 Mar 2024 16:20:31 +0000
References: <20240314020528.3051533-1-chao@kernel.org>
In-Reply-To: <20240314020528.3051533-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, hdanton@sina.com, linux-kernel@vger.kernel.org,
 Ed.Tsai@mediatek.com, linux-f2fs-devel@lists.sourceforge.net,
 syzbot+763afad57075d3f862f2@syzkaller.appspotmail.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 14 Mar 2024 10:05:28 +0800 you wrote:
> syzbot reports a f2fs bug as below:
> 
> BUG: KASAN: slab-use-after-free in f2fs_filemap_fault+0xd1/0x2c0 fs/f2fs/file.c:49
> Read of size 8 at addr ffff88807bb22680 by task syz-executor184/5058
> 
> CPU: 0 PID: 5058 Comm: syz-executor184 Not tainted 6.7.0-syzkaller-09928-g052d534373b7 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x163/0x540 mm/kasan/report.c:488
>  kasan_report+0x142/0x170 mm/kasan/report.c:601
>  f2fs_filemap_fault+0xd1/0x2c0 fs/f2fs/file.c:49
>  __do_fault+0x131/0x450 mm/memory.c:4376
>  do_shared_fault mm/memory.c:4798 [inline]
>  do_fault mm/memory.c:4872 [inline]
>  do_pte_missing mm/memory.c:3745 [inline]
>  handle_pte_fault mm/memory.c:5144 [inline]
>  __handle_mm_fault+0x23b7/0x72b0 mm/memory.c:5285
>  handle_mm_fault+0x27e/0x770 mm/memory.c:5450
>  do_user_addr_fault arch/x86/mm/fault.c:1364 [inline]
>  handle_page_fault arch/x86/mm/fault.c:1507 [inline]
>  exc_page_fault+0x456/0x870 arch/x86/mm/fault.c:1563
>  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to avoid use-after-free issue in f2fs_filemap_fault
    https://git.kernel.org/jaegeuk/f2fs/c/eb70d5a6c932

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



