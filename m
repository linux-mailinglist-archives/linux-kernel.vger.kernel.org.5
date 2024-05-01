Return-Path: <linux-kernel+bounces-165157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 668218B88CA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F752869F6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A900556754;
	Wed,  1 May 2024 10:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKfYCWvJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E795D4F881;
	Wed,  1 May 2024 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714560631; cv=none; b=PTtHTKq/al3QEUVTUkJKTRD1wqD1ptBemjzCeZyNjtJ/lcqC0qlhQn74AVSl18z1rVnz//D/NxhDob2g37gfJRZkv+s0trxM4f/vfuJNhMBLar/TnWiRxVu+6ffUeRfVlv2/e89hXImQ2uR9cptBnXvZOqCnOtM8SSdhWxfBn8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714560631; c=relaxed/simple;
	bh=8kr5swjIrmpuZqLn9YgE4N/D/7JMs35Yyh27MQY1WbI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QgmpBOgHRNfWMqqbCoZGOWxHVjJnXnsQZ+1P35BoshHFirLrwCRqts8DBnP1mPkjlQ7JiKTWuALSerMC19mUIpk6o9aWBSJkR/V/EW16gP8iYurZbQAEUTVHhndHLqxWI9crYuTMoz3DvxSzQEl1nkf3bpucRzE+lPPuVQ+EjQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKfYCWvJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A432C32789;
	Wed,  1 May 2024 10:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714560630;
	bh=8kr5swjIrmpuZqLn9YgE4N/D/7JMs35Yyh27MQY1WbI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OKfYCWvJaS/KyTLnxvtj3deNdOlk1BBIYp+2j+JTDilhu72UmWiICgmak3mnRMhY5
	 kPhf6N8u/jO+nyxkB30fTJB3rEIGyZRb4HeNcfx/z1X70BO+5sVYLG8VIap2EvDdo5
	 ZZOAnPzL+2P9pX1Idat3DT0HKwJU5HqXtGXp8w+HY6OLkjkG1aqR09t0BS6NRgEfvC
	 q855kWzzgHkfKtmb8cD7FFf0UsUVKj+KscvZE2Jik3CuT4HP31ZpUTbEEUm8Pdn4YV
	 ORL/PQCvSE2quXlld0a8jTwN9VOgBP2vlF73UzaXt8awy2YVbuJ3/5XS4dZ7aNOhIE
	 xDtSAl1jXFEeQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65ABBC433E9;
	Wed,  1 May 2024 10:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] net: bridge: fix multicast-to-unicast with fraglist
 GSO
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171456063041.15428.922923783539409951.git-patchwork-notify@kernel.org>
Date: Wed, 01 May 2024 10:50:30 +0000
References: <20240427182420.24673-1-nbd@nbd.name>
In-Reply-To: <20240427182420.24673-1-nbd@nbd.name>
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, roopa@nvidia.com, razor@blackwall.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linus.luessing@c0d3.blue, bridge@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 27 Apr 2024 20:24:18 +0200 you wrote:
> Calling skb_copy on a SKB_GSO_FRAGLIST skb is not valid, since it returns
> an invalid linearized skb. This code only needs to change the ethernet
> header, so pskb_copy is the right function to call here.
> 
> Fixes: 6db6f0eae605 ("bridge: multicast to unicast")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: bridge: fix multicast-to-unicast with fraglist GSO
    https://git.kernel.org/netdev/net/c/59c878cbcdd8
  - [net,2/2] net: core: reject skb_copy(_expand) for fraglist GSO skbs
    https://git.kernel.org/netdev/net/c/d091e579b864

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



