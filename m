Return-Path: <linux-kernel+bounces-166649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EA08B9D91
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 544731C21954
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE71B15F308;
	Thu,  2 May 2024 15:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRTbwY9/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA76D15E7F6;
	Thu,  2 May 2024 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714663986; cv=none; b=nJrV4/YsMhj6hCsFgjotgOJk/suUWtBav1DndgnT6w30UN0tre76W6Ikjc0Ov8h6fL85jzxEZHNYSZovaPfe/3SJr/QB2tBQok312J9Z0F3sAiXjZ0rQdrmk6gI4roA73qv/RQVy9TKDGInP/Nlx1k/3Qt6NfsJpfCnhBWjHdLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714663986; c=relaxed/simple;
	bh=GvjJgiAM3PUJapyMwa4WtNG7VdzKsQguOtRnheGULpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oAOgQWlFFlBQ+5ZDcgR6FTuodwC3+CnkQ6CNQvo0r8IglSjU79XVfFlYhdfHoGK0czqDt4GmmaDP3LfRdt1wOnQcr+XU8AvY2aEoXryrRlQajJn3TN4rmthNTfVHo+Fa0SWXEGKr3BqgxhkgfOQ9ppnCjZ9krWPzNmz/Ib1sknE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRTbwY9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C156C4AF1A;
	Thu,  2 May 2024 15:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714663985;
	bh=GvjJgiAM3PUJapyMwa4WtNG7VdzKsQguOtRnheGULpk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PRTbwY9/laPMmo4/eJgvpC1MR9yVbDQjxF1Mfl7rbouHnYlCno/3dno+gS4seGYi8
	 Kkh/weVxtWoZQKhKakqwh5CywcMaIO69Zfsha1hAZCtOZQDdYK12buBF9zlq8MpJjW
	 KBiaXE47ncu8pienmBVvUaP8UANvRQMyv8T3LfEqK8Q00ScwXKj8v7nkhDrqOB5zzf
	 /t7D9agL9nGnTpyTuzFy7wcodUn0j8vM1nUQOzQkIshd8qbpoFBnxGvObCEp+9X6J9
	 TppmB1xArqn6JV/gna7K/d7SXYsyQZSX6RB70l03/QmK6CdueBH7CQ/wUqsfBzTNGb
	 yTEHyJncC1vrQ==
Message-ID: <d35c96ca-3c28-4745-a323-949365f5033a@kernel.org>
Date: Thu, 2 May 2024 09:33:05 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next v5 6/6] net: add heuristic for enabling TCP
 fraglist GRO
Content-Language: en-US
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
References: <20240502084450.44009-1-nbd@nbd.name>
 <20240502084450.44009-7-nbd@nbd.name>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240502084450.44009-7-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/2/24 2:44 AM, Felix Fietkau wrote:
> When forwarding TCP after GRO, software segmentation is very expensive,
> especially when the checksum needs to be recalculated.
> One case where that's currently unavoidable is when routing packets over
> PPPoE. Performance improves significantly when using fraglist GRO
> implemented in the same way as for UDP.
> 
> When NETIF_F_GRO_FRAGLIST is enabled, perform a lookup for an established
> socket in the same netns as the receiving device. While this may not
> cover all relevant use cases in multi-netns configurations, it should be
> good enough for most configurations that need this.
> 
> Here's a measurement of running 2 TCP streams through a MediaTek MT7622
> device (2-core Cortex-A53), which runs NAT with flow offload enabled from
> one ethernet port to PPPoE on another ethernet port + cake qdisc set to
> 1Gbps.
> 
> rx-gro-list off: 630 Mbit/s, CPU 35% idle
> rx-gro-list on:  770 Mbit/s, CPU 40% idle
> 
> Acked-by: Paolo Abeni <pabeni@redhat.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/ipv4/tcp_offload.c   | 32 ++++++++++++++++++++++++++++++++
>  net/ipv6/tcpv6_offload.c | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



