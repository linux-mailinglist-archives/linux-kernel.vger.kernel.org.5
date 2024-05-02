Return-Path: <linux-kernel+bounces-166647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 127758B9D8A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C32ED282705
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBE215E216;
	Thu,  2 May 2024 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/sDTOpW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF87515B578;
	Thu,  2 May 2024 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714663976; cv=none; b=ejW9wDghCKwx4M+o3OwzCDSYK1OyAVJU03YTrjle5CIMWmuRmBwj/tVbeFaIfBIxEgIBYOjxSSWXr9oiGQtg0vEtaJvdm28wF9FKt3KRgeggNfoKfzxqZdeJ7CmpDAot8uqNNU82aRcSOEIdzGU8xaiM2ujwUN0JSIPtKeWtcnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714663976; c=relaxed/simple;
	bh=fDqnVxGodJqzUEp4Z+La2f6PfFMp+/vl3kBOgroRkPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kai/NGZCO5w168CpRfIvku3v06Jospa2rpVbtVB82XumiGwJbJ4c1tT2RS4l6hFGVP02vL56BXi1FL/2qDp6KEhvPk6HYPSVbh/q6EIyLawIvVzfoUufBOsvDqgqGODGCQkpMSUcHv6l0agOccZnZQM90t0s4TJHbwQvEE+xt2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/sDTOpW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEE7C32789;
	Thu,  2 May 2024 15:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714663976;
	bh=fDqnVxGodJqzUEp4Z+La2f6PfFMp+/vl3kBOgroRkPc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R/sDTOpW4FXuZkaqrmfShZy0FT+c3ZXt92OttendTIuKGlvM7CmZI0s05syV38qXx
	 6ePCc6oz4IFvjlYoNXU8WKL6F96jPTCuCLk4kBcyWPNlEHyZxWHyi+h3uO4SPRY/xB
	 avIhjBzbU18FQh21V3n0SlY95HT9wp+R0VkXNjbJ94kK5SJwHaZy4eY8E2esrLOuFl
	 VY9oE+krsAUolzETEWXZ+jgN+2gTyDmD0JncEXT8gVFc/JKd7LLS6vTwAL1aEcmK8y
	 A02uk7Jf2TKVzbuOpFlkzQlEBS72kGnSNS1vuwKbzyi/NNDMp4q3T6GDvV/V4VE1B8
	 z8aduofQBkHdA==
Message-ID: <544298db-3772-4064-a012-9d7ba8867cf3@kernel.org>
Date: Thu, 2 May 2024 09:32:55 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next v5 4/6] net: create tcp_gro_lookup helper
 function
Content-Language: en-US
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
References: <20240502084450.44009-1-nbd@nbd.name>
 <20240502084450.44009-5-nbd@nbd.name>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240502084450.44009-5-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/2/24 2:44 AM, Felix Fietkau wrote:
> This pulls the flow port matching out of tcp_gro_receive, so that it can be
> reused for the next change, which adds the TCP fraglist GRO heuristic.
> 
> Acked-by: Paolo Abeni <pabeni@redhat.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  include/net/tcp.h      |  1 +
>  net/ipv4/tcp_offload.c | 41 +++++++++++++++++++++++++----------------
>  2 files changed, 26 insertions(+), 16 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



