Return-Path: <linux-kernel+bounces-75251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 997E985E53F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89781C21635
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF6C8529C;
	Wed, 21 Feb 2024 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsQmEVwU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3BE42A8B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539031; cv=none; b=UMg514YH2UL3TuTFUPg0rwxE1pGZtrP3tuEFl8qnDvnR/T+X3z1lwN7GN0QxlzCwyJP+Csd4cmApyaqkYIjfApVHarFySwy6kleUm6Te5yCi/jeC+Z1oWUMnylyeV3+9r7Rj9HhNG4h1jd2K+E2AOQ0jkEW0d3AR8JzMEz3UMSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539031; c=relaxed/simple;
	bh=LSFSDBN2BbV4Ss6DjtJcV5DIXFbLDO9Oe2KGI/JU90s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Hngq2TXvLCQimsTWq0tDVzG3GxMpLuYxKSf896cRErU+X9Ek/+mvzy9lhroLrIsF2tSlY9WG/s8qxlY/nezbyLOIzw6zhgj/Nz+1nqNAB1KZiVE4DN07hK4ZqnfSVmmVpbv0ruAQ3WPkUJDe7b8OeJSwA+wFdqAP4xNjcQ+5sd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsQmEVwU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0663AC43390;
	Wed, 21 Feb 2024 18:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708539031;
	bh=LSFSDBN2BbV4Ss6DjtJcV5DIXFbLDO9Oe2KGI/JU90s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bsQmEVwUXjdVtTfsHXMUs1WEBqVwsmHT8htXjGEvXEOXUWUnwM4MYrT/DJBoRSEC/
	 El3PxgYnfxjxK9B4bhz5NCiVE3T+/TIsWVdMYZzfnCGYcuI/ObVQ6qRQgMlw+WzTJY
	 aNgbubCBLz+isAtPWE9MfC93bMK1GAm0uQi4Ra/q9xKTCDWo4AmNr488MI2m3aXNru
	 qMjhpCLETG2UQ5AObHkcENTrb9YE9PPxGKdH0h4TEwXhwPgjRuawt9vvBZdLhq0pA6
	 wSUHcqrameM/Jaks5n3KiRD7bNftWPs0QH9hfQPKdbG+iNADWdkJh0wwU3I7IbzgN4
	 Xh6/qMG6+Tsfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1581D84BCD;
	Wed, 21 Feb 2024 18:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v3 1/2] f2fs: separate f2fs_gc_range() to use GC
 for a range
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170853903091.7043.10526328421276609740.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 18:10:30 +0000
References: <20240213173812.1432663-1-daeho43@gmail.com>
In-Reply-To: <20240213173812.1432663-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com, jaegeuk@kernel.org, daehojeong@google.com

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 13 Feb 2024 09:38:11 -0800 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Make f2fs_gc_range() an extenal function to use it for GC for a range.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3,1/2] f2fs: separate f2fs_gc_range() to use GC for a range
    https://git.kernel.org/jaegeuk/f2fs/c/50581e3bda8f
  - [f2fs-dev,v3,2/2] f2fs: support file pinning for zoned devices
    https://git.kernel.org/jaegeuk/f2fs/c/2fded30d8dce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



