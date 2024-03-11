Return-Path: <linux-kernel+bounces-99628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A25A7878AF4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1A2F1C21667
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBBE59B45;
	Mon, 11 Mar 2024 22:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKUksWLV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06185822A;
	Mon, 11 Mar 2024 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710197437; cv=none; b=gcpfKGhNM9VMmk1C2SR0J+uRemQ1rJ+3ehaBSOYI4qpeVzjoGhYuO310sPPGjnsw8t/nZwSQpiHb3FZ+lptRSr1J7653rm1KRJO5DA9K+WR4ydwAJ/h+iz942phSSyHRBXG78liTlEdkqeDbGNwvJXo3qg9MY9/pTPIS/cEjhPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710197437; c=relaxed/simple;
	bh=cSCz5P23q9FXDrIgSgF2grmWUpwgQFj+vKmoLmhtkRU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LJo5X/7qcI7vNKcWVI5RSSLvnlm6nE5dDL/9ubnmRyWCNsnoXz7b0PiMAjf/Aep6xctJL2oTtqhltNweHU1OL+W/Z3Xzmfv3B1/I0DrozmPUGuq437jWqTTQvECBjOzuZ+zd27i+/QGxyhGThuLTXQlzEJCOfhY21fVwBXAGb+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKUksWLV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28F63C43399;
	Mon, 11 Mar 2024 22:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710197437;
	bh=cSCz5P23q9FXDrIgSgF2grmWUpwgQFj+vKmoLmhtkRU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gKUksWLVEtkwNW+j5WLNqqU7s3OjkEevoAIWr9O1gxl539vmXBVwVAmhJvEJPvKGi
	 o2cr4pvdFhWSSxmjcSam4hdoYIfogsZr4bH61g5Wps7Q2sRL6lwEgpO97alQzP6nzR
	 xo49MA7Kz8LpeagbG0TJvx9+nX/4ru2x0OUHjnJsFXvF8S6vtGAa/U1ocZYJX3oWDw
	 fxJPCffiWutiyQWktOmpc9Uoe+5itWv1hMwaTe3nLf8rmrADR9+4P4kPL9VQGYCMhA
	 0+Iw1LOHbZwzYQ6A3NjHAFY/U0z6XoZbjZH17pgOE86cfqaCfaAMlIhuingJhFHesR
	 vjUkfccyT563g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0E1EEC395F1;
	Mon, 11 Mar 2024 22:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] net: amt: Move stats allocation to core
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171019743705.8733.4727108419167706575.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 22:50:37 +0000
References: <20240308162606.1597287-1-leitao@debian.org>
In-Reply-To: <20240308162606.1597287-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: ap420073@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org, dsahern@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  8 Mar 2024 08:26:04 -0800 you wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core instead
> of this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: amt: Move stats allocation to core
    https://git.kernel.org/netdev/net-next/c/2892956e93f7
  - [net-next,2/2] net: amt: Remove generic .ndo_get_stats64
    https://git.kernel.org/netdev/net-next/c/7598531c3aed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



