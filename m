Return-Path: <linux-kernel+bounces-133820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C30189A945
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 08:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235631F218A2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 06:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9571F2374E;
	Sat,  6 Apr 2024 06:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gC3Yov+6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA3D208C4;
	Sat,  6 Apr 2024 06:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712383829; cv=none; b=MTIaubK79e+IRe3lXKZ7DZDO4iRoXLzllJeSl/lyZcm0aJqjEeTqUtSl2XrkGOIUuQsY++LWYIhTm/41WdDUlfPuseShDIyZoJCullmUknjik5cV33o6sJ9HxoMU3c52fRKJulfIwMbFyiE+YIDvhzqaUvga8aLhGXBFhik11UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712383829; c=relaxed/simple;
	bh=8zAAZQ5FVJuQ9n09nU25o0th4TcxCMkiE15rYRVwHjk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SKlOBrZHihXrG+gQ3FemuYqxXEcE7OsmDX0PCcPQ6Cu/DkHGoC+foMjZIH/dZANdqjpinOjmnpWMFw53W9PM6u9Yc19QrqllOObEWpu7Foh/O6I5lOk57m5+w50nuGovuiEyKS+dvXdECD2g00jT8r9nbJDvJfRhUnlYboBCt7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gC3Yov+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53DB2C43394;
	Sat,  6 Apr 2024 06:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712383829;
	bh=8zAAZQ5FVJuQ9n09nU25o0th4TcxCMkiE15rYRVwHjk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gC3Yov+6vxydYB1n/dpImuWo7wA558nkRFgYjv3Episj1MvWbJbk5j217M8r2RNRJ
	 JK26Dc4Qo2OqQtWtnADTwFGYKxQtGXsqOme51/xkHiYmQkBTYyktog52wF8Q+YLg56
	 Rq2soHNO1iEIROm0ipFQ3fqbWoUjHB33nkbj+wmNqt+6DH8h9UEQohhH47qZBKprKa
	 p3JIt8pc5bPqmjEAYglkY+VplC1UIERPus+Lg+9hkX+GFwuTDD6L/IuuFKZz2rcq3s
	 9mpwGsGg8z9tY9e8zb2bAq9odx5zgiidSLwvzbA5h/AmvhysxXwzgTArc2w8i4Q3b1
	 3ADdotqUvdVFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D317D8A103;
	Sat,  6 Apr 2024 06:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] u64_stats: fix u64_stats_init() for lockdep when used
 repeatedly in one file
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171238382924.24936.14587108517208356483.git-patchwork-notify@kernel.org>
Date: Sat, 06 Apr 2024 06:10:29 +0000
References: <20240404075740.30682-1-petr@tesarici.cz>
In-Reply-To: <20240404075740.30682-1-petr@tesarici.cz>
To: Petr Tesarik <petr@tesarici.cz>
Cc: davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 regressions@leemhuis.info

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Apr 2024 09:57:40 +0200 you wrote:
> Fix bogus lockdep warnings if multiple u64_stats_sync variables are
> initialized in the same file.
> 
> With CONFIG_LOCKDEP, seqcount_init() is a macro which declares:
> 
> 	static struct lock_class_key __key;
> 
> [...]

Here is the summary with links:
  - [net] u64_stats: fix u64_stats_init() for lockdep when used repeatedly in one file
    https://git.kernel.org/netdev/net/c/38a15d0a50e0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



