Return-Path: <linux-kernel+bounces-99654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C98C878B77
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1FB1F22447
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999925916B;
	Mon, 11 Mar 2024 23:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlN4t8ik"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F4758AA9;
	Mon, 11 Mar 2024 23:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710199231; cv=none; b=DLf6UfQSDqIrAGzVafR6OWxRFdvIu4PR6SnPt4ZjDmc+PeMTBkTQTJDohorEW9wW/3MQ9a43qUut279Wz/ApDV4VuiLaNjBrcrCgjuvuk7oYRm/GjYAq8GuZehxOhq3aykP3/OrcsWWEDZ8Ob3F0aVzr8XMmgTNIbHYKsVBNOX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710199231; c=relaxed/simple;
	bh=EWuCRZFEQs33N0jmAweFI2AzQaEORtQPMY+IgfcqAH0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BoHkjI0WM6Db1p8Dx1QXu+MIbN7Ts4gzxCaRYdVYh1PCTVGYRuvA18WDArHWfztZHyzqOzrcF5EkgEULAeVgH1Cr+Nc4VeE287uy1jhTaGpJbSIPR6RHloEWSMTROzAi/MCQh9qSbYS1K9Cc6ALWgFcEfgxD9BySOA5fTra9Ng8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlN4t8ik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA8D7C433F1;
	Mon, 11 Mar 2024 23:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710199231;
	bh=EWuCRZFEQs33N0jmAweFI2AzQaEORtQPMY+IgfcqAH0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GlN4t8ikybD7QHAH3jjnK+qNO4TTG4A4DXUrovZHcY3GivKdJnTCeI7zmKQqEV1Jv
	 z4zIx9RNG6ti3nMCFGyKqT46mEhHf8wp4V7Sbx1VvIC7MinmV/xlTYmlqkiA+ZK34d
	 1rdhjTh9lp3ubPDqiX3v3e70xanCWNyT8Uwtevbqyc8f1sAyEP8XkZUPetKqQK1hVi
	 kbZVCZa/Pe89jBMoUbpyk+wJeaYcv8UMGscnvpf2zjRVP9M5VWjLRrXgdCcjptN98y
	 i0wpN20bhQqBHufGN7bpfz718UhnNNjLSwtUsHw+tiIqFSDIVeI9My+QWy36vos0Io
	 ejaX4vygAfYAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91B63C395F1;
	Mon, 11 Mar 2024 23:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] vxlan: Do not alloc tstats manually
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171019923159.27198.11426721044166113476.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 23:20:31 +0000
References: <20240311112437.3813987-1-leitao@debian.org>
In-Reply-To: <20240311112437.3813987-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, keescook@chromium.org, idosch@nvidia.com,
 razor@blackwall.org, amcohen@nvidia.com, petrm@nvidia.com, jbenc@redhat.com,
 b.galvani@gmail.com, gavinl@nvidia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 Mar 2024 04:24:30 -0700 you wrote:
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
  - [net-next,1/2] vxlan: Do not alloc tstats manually
    https://git.kernel.org/netdev/net-next/c/e28c5efc3139
  - [net-next,2/2] vxlan: Remove generic .ndo_get_stats64
    https://git.kernel.org/netdev/net-next/c/195f88c57737

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



