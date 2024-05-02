Return-Path: <linux-kernel+bounces-166202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3078B9782
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91A1B2874F8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6072D54BE7;
	Thu,  2 May 2024 09:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkhKLdhj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A7D51C5C;
	Thu,  2 May 2024 09:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714641632; cv=none; b=dYjDVn2U2pxYsp92X6r5bkbwmHoOiz6rZMv0d7T4gkb7w5zewDDYE6jSdL5gAivAyBd3CFafJPKtxG/yrYlpVpm8VIJuaL+hc2fpcIyyGA6ZfWAilnobmCt6bYnCvOYKGBjv6kTJzI6qGUN7JSzSm6rOO/jVACoW3+nnqVQin+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714641632; c=relaxed/simple;
	bh=lHYbtV4vdHeUwnG3ppsQrzBHZPrjq6ArtI4mJoHPxkY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BoJrgo7Slvfrl/tGx50auh/IRA2gcfztRVpphuDZEjjXklgqsif8LfjH7Vz0gCM3JHIe50Mz03UasUnhJQWLdyxXsakiNXCcCoxxlBymWAI3vgLHZXdfdh83XFeif1+WEOxFoAAjHnoZQr/fsBpubpRUl0hoQAM55fkQwxCQTXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkhKLdhj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 172A2C32789;
	Thu,  2 May 2024 09:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714641632;
	bh=lHYbtV4vdHeUwnG3ppsQrzBHZPrjq6ArtI4mJoHPxkY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tkhKLdhjinVTxybvPTcsJ9dMKZK/z/Nrfme+nG3EXn9t10WOfMfq8BIbWywaLcA+Y
	 2P37FLB8zXZ0aSCtBbV//Hqtm7TfZZEEaz3cZNX+e5IShm/1zKrIifXrtncZvfPEbz
	 0AjbKKk4l8FHMQ4ndBYS6LFl1z2JKeCnnm/7wSi5INl4QKbi2oKp1jxjrhEruUB+GP
	 Ab3HozklZLIm8llYaPRAwK7cIdhxCApJGwKHsZfxYlCRXZ4w//3JBGXftK8XjcASrf
	 jQ6FvPDywMc3EyPVtLT8smuKHsr6BHUg64BGXWHVHt/4vhczbvk/OAWjW65eIwPJTj
	 6qHiZmNrsj79A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0A87C43336;
	Thu,  2 May 2024 09:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/2] net: gro: add flush/flush_id checks and fix wrong
 offset in udp
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171464163198.15356.9947080323509993851.git-patchwork-notify@kernel.org>
Date: Thu, 02 May 2024 09:20:31 +0000
References: <20240430143555.126083-1-richardbgobert@gmail.com>
In-Reply-To: <20240430143555.126083-1-richardbgobert@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 alobakin@pm.me, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Apr 2024 16:35:53 +0200 you wrote:
> This series fixes a bug in the complete phase of UDP in GRO, in which
> socket lookup fails due to using network_header when parsing encapsulated
> packets. The fix is to add network_offset and inner_network_offset to
> napi_gro_cb and use these offsets for socket lookup.
> 
> In addition p->flush/flush_id should be checked in all UDP flows. The
> same logic from tcp_gro_receive is applied for all flows in
> udp_gro_receive_segment. This prevents packets with mismatching network
> headers (flush/flush_id turned on) from merging in UDP GRO.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/2] net: gro: fix udp bad offset in socket lookup by adding {inner_}network_offset to napi_gro_cb
    https://git.kernel.org/netdev/net/c/5ef31ea5d053
  - [net,v4,2/2] net: gro: add flush check in udp_gro_receive_segment
    https://git.kernel.org/netdev/net/c/5babae777c61

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



