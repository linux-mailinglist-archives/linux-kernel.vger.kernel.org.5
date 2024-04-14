Return-Path: <linux-kernel+bounces-144237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF64F8A4373
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C802817B5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA3E1369B2;
	Sun, 14 Apr 2024 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFyAuMoU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59C9134CDC
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713108765; cv=none; b=bfvpcXT2q+C4CMBxWiV3RFi7brxfbGoeinq6SsVnSm37eroJMBnULXxNJRvdF3PKIlL12kkyGN+ItiF//znihEzk36a+eOnYDBAwxFNql2/uJmZfTfeaS7SKrxRnRHHOisHGzNey9FoHGHYYkviO4KrvTNkYoYx1TMMuOLv9a6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713108765; c=relaxed/simple;
	bh=4ggQ41BG3rYA6nIIBBk8X4i+JEP2BD4lyUROk9QZV3c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GVO5Yq6JbYp1xvmESh99F9oZTLrK6eDicEEqXr8eBEqKXNmlNl7dyoxoN9Yd+3cuH4TEk8cMtsIigOR9nIgWdXXCCiiIvv3++u/J8rrxxfEOnY+qcKvP5KmSzMah+gaiYkJKcXa8ZMnAbhNBfXAfKU8LzgXQC4mX2TBzWy7mnog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFyAuMoU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 635CEC4AF13;
	Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713108765;
	bh=4ggQ41BG3rYA6nIIBBk8X4i+JEP2BD4lyUROk9QZV3c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KFyAuMoUy1JlvllZWRJz/lLmYyLTww7klLoY8RQMIVrbx+47VUVhxFOVAP4puAJbV
	 zBn7T7YQ2U/mfbBuX9bhf28yRxgRGcUorPTy7f/Fl2sshJgL/6+acT9NrMe0oP9SLQ
	 XeiBVbURaBgZn1eG0RE3QMaEOHhdJSk4WKCNPknsLadLPrb8mM/8JStaa0w/UJuR5p
	 7R+1cI6U/7LI/yxISvPMI5gon3Fy4OXV6vDP6Jgmgt6M8moykE/8NhRyh4dDql4EZQ
	 kvhJ/AAgq8zKxoU7l9R5tF3tgIgeDDpquU1KRf5KATHaV56TacSXmfl7AZWjoMROHd
	 Sybv9HEXinfpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56AADC32751;
	Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: Prevent s_writer rw_sem count mismatch in
 f2fs_evict_inode
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171310876535.3156.3836022504525734711.git-patchwork-notify@kernel.org>
Date: Sun, 14 Apr 2024 15:32:45 +0000
References: <20240322041639.23144-1-youngjin.gil@samsung.com>
In-Reply-To: <20240322041639.23144-1-youngjin.gil@samsung.com>
To: Yeongjin Gil <youngjin.gil@samsung.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, sj1557.seo@samsung.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 22 Mar 2024 13:16:39 +0900 you wrote:
> If f2fs_evict_inode is called between freeze_super and thaw_super, the
> s_writer rwsem count may become negative, resulting in hang.
> 
> CPU1                       CPU2
> 
> f2fs_resize_fs()           f2fs_evict_inode()
>   f2fs_freeze
>     set SBI_IS_FREEZING
>                              skip sb_start_intwrite
>   f2fs_unfreeze
>     clear SBI_IS_FREEZING
>                              sb_end_intwrite
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: Prevent s_writer rw_sem count mismatch in f2fs_evict_inode
    https://git.kernel.org/jaegeuk/f2fs/c/3127f1010c9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



