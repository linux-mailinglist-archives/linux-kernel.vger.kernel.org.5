Return-Path: <linux-kernel+bounces-94973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA98874769
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 05:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD77286B7A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476621CAAD;
	Thu,  7 Mar 2024 04:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkrskTff"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768A0134B1;
	Thu,  7 Mar 2024 04:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709786431; cv=none; b=nowdy8NIn7LrSH/uzJ9GVznFd3fwbBSeBgONleaLa/9s74hpfQ6RQb+dwOH3EUWpPXOYTjsdHlxep68Yej2ywptvIfBV8X5o4FVh5hjlhChwE/VOCsUgD9yM1RFxas237/svwRcvajpnHt9koRegLRkUzKavKqEqQhr+rp5nZdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709786431; c=relaxed/simple;
	bh=xumRY2llcFnaIqyNp0q+wuyDc++SJePpxNOhoLRvLrY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oHsY93Fm0S0DF4MUOlK3uHSHgrnHsHfHsf5KCi8iaJlOgHxg/dyr5nbt271qdIP5c+8C4rna5K0dE7uIejgzWYN5PdcfYJ/WxQM/GyzxH9I1QTR0HLOJHwxtIdD56bBFSh4SexpnUhSgaI0o9n31LbuI42Y2a6IZPyog3prsz+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkrskTff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02FABC43601;
	Thu,  7 Mar 2024 04:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709786431;
	bh=xumRY2llcFnaIqyNp0q+wuyDc++SJePpxNOhoLRvLrY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dkrskTffNx3kgRhOeCo1B/uVJIzE02iO2Jg8XYos2WWvhDUCGZ0oX66Z0/wpMdvcT
	 zoHEQgkZFnxgPGCvGv8q6DNLiLI1bYGKAmp6/G60HdxZxcYoLvGWsUPKZVDIx4wFwi
	 zoL8jPKfz/qsC1gYqk+UEDxd3QZ8YW1NObmWuB8UH4JqJOl+Y0knbaf9Y/WvuOr2sN
	 EJnna3K9sr2FyMuqnioo75v+ID9ASwrS9QE7DSDzuB2Ly1PcTzKrBg3nrTCbc2wDu7
	 Ii3An0nIzvEETt540cWZppcaApMOCdAs3oI5gL1fjzj7gns4X+MNeFjD+J8ju2VMWF
	 wNK1piG4X/1ZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E13B9D84BDE;
	Thu,  7 Mar 2024 04:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: macsec: Leverage core stats allocator
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170978643091.7855.64479673102977946.git-patchwork-notify@kernel.org>
Date: Thu, 07 Mar 2024 04:40:30 +0000
References: <20240305113728.1974944-1-leitao@debian.org>
In-Reply-To: <20240305113728.1974944-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, sd@queasysnail.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org, dsahern@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 Mar 2024 03:37:27 -0800 you wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core
> instead of in this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> [...]

Here is the summary with links:
  - [net-next] net: macsec: Leverage core stats allocator
    https://git.kernel.org/netdev/net-next/c/1d03d51e9d24

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



