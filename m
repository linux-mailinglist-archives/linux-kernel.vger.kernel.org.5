Return-Path: <linux-kernel+bounces-84414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5F986A678
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EE391C25A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB861B7E9;
	Wed, 28 Feb 2024 02:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxmWfglb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C67F567A;
	Wed, 28 Feb 2024 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709086830; cv=none; b=Jcl9kxL7i9zkngBEX59Vl1K4MlM7uXM0enbkub/SYNTGTJfYSUnzrtoDPHQje41KPggJ9n++ZzIGlCMGZ23/uLvlbhU/xKt05mJ23+BevHX+zBYe3ENEHTGvLrnULdUSV1mAtGyzsS51qzuwLjDUPY14ejrlyQwSEojCRirItuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709086830; c=relaxed/simple;
	bh=l/rOErX5YaV77tJeUILtrCdkz7azE+TOycWzTxCWi7E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pYshnhtiz3ZpsUjipXouTl+txdHqzk/R984IJ4BX067/II+dtxQycBxw8k5G/SlKAbc1WxoZVMbojKxUuAtELFIfgTYOLb66zIgmg1BxhdqYZVkC6pgI3ckTcXqln7L61WmTaxOedK204UqVzSan2uZJqJhji1ctUDceVZMicmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxmWfglb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C16BC43390;
	Wed, 28 Feb 2024 02:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709086830;
	bh=l/rOErX5YaV77tJeUILtrCdkz7azE+TOycWzTxCWi7E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jxmWfglbh8JgkcphXS/yahGJXam+H672eiNkCkzKPjyWub0Havva8LHtvygXBvwuP
	 WKJRwHIo6xWqSrlP1bfJW2UQUuj2zU80oQjM+40cqALYKB0yWwBbNDKXt8fD3PTvoK
	 ykyhXw1SuzCzbYHMQqu+fS1mzMMTpmVP+1LlM2MOtlxLjzGmkI02mTRc0jCWiw2sOu
	 qaU6FweT/zNekJHT2wheBvq9dEOa7Di49Oz4G0d00ylMt+cSbttU8svvPZXW6T0cme
	 iEorlW2QqB4WohigqbqbTamr+8UcptnJvoTYLogDABscD7DPsmNpqxNbKF63QzGHdn
	 VuUorFp0GcCWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F38D7D88FB0;
	Wed, 28 Feb 2024 02:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: wwan: t7xx: Prefer struct_size over open coded
 arithmetic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170908682999.30494.11218571706711449846.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 02:20:29 +0000
References: <20240224181932.2720-1-erick.archer@gmx.com>
In-Reply-To: <20240224181932.2720-1-erick.archer@gmx.com>
To: Erick Archer <erick.archer@gmx.com>
Cc: chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com,
 ricardo.martinez@linux.intel.com, loic.poulain@linaro.org,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 gustavoars@kernel.org, keescook@chromium.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 24 Feb 2024 19:19:32 +0100 you wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1][2].
> 
> As the "port_prox" variable is a pointer to "struct port_proxy" and
> this structure ends in a flexible array:
> 
> struct port_proxy {
> 	[...]
> 	struct t7xx_port ports[];
> };
> 
> [...]

Here is the summary with links:
  - net: wwan: t7xx: Prefer struct_size over open coded arithmetic
    https://git.kernel.org/netdev/net-next/c/848e34ca2030

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



