Return-Path: <linux-kernel+bounces-166645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8968B9D80
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A738281D1F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEDB15B988;
	Thu,  2 May 2024 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THqsVB/U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E3415B985;
	Thu,  2 May 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714663965; cv=none; b=g5eqXZ6dZvDCTyaM5YKX8DK0ivTINWtTAIMHC+FLcYbzEYI929f4CzSxv3gjP0gZgNWbG5cXTvjH5mtufIjiJOQ6mes18UzCVtU0YCY03dm+sSFMOvwoFM5nSJkr6EzTDgH7HXqeSDw2T6VrY5bbMu/6jys1nx1WgdEeNFeuWXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714663965; c=relaxed/simple;
	bh=pt4zlHTT9OvGWaMFCnzMhIH7CmgAlwGeTW0qeOhhvWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sM/96d0mXqTzx+ZEdd2iPoh8464NpNVnhPcszNo09SEBg3nTH+uuVZut5saNhzOsGiUMxbgbrfFdcwtvncHuWuEJS+ipaD4UQPumH7Ft4AjWRXvjZw2bY0CiBqiQ/HdgvS8vU7kJZZFFnFcxMA00GLabriN+UlDvZERgj5lvOc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THqsVB/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6B2C113CC;
	Thu,  2 May 2024 15:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714663965;
	bh=pt4zlHTT9OvGWaMFCnzMhIH7CmgAlwGeTW0qeOhhvWI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=THqsVB/UfiU5ffbla8qrOphUxCrslXLnCCf7kzl56E8sDxLkjMFMuMxc0FaL/RiEw
	 UgJAaWuKTGLbOTpS6sH3Rtcdh09eLciVPuFcbPPusUDzKcSmYR0A8venuTTw8TJs9f
	 75kkOA6UCQyD06gyhrIVzlIOV7JjfWL9IDVTMIBpLI2E1tkV10pgNEV71kR84LT4ZK
	 aTuhH8cz+n6oCqUCjc68mpeIak7ACL3Bg7LBuUp0caAb7iWGFYlVVo213oYGJTMVcD
	 dGLH3lZov/sfNRxa8jBFV5/8U802WC9nffbb/lOrpEfifa+br08y54ftK0srAXAOr9
	 CXocA2JmS2QLQ==
Message-ID: <451bcdfa-0799-4cae-9127-d1e00c8b87ea@kernel.org>
Date: Thu, 2 May 2024 09:32:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next v5 2/6] net: add support for segmenting TCP
 fraglist GSO packets
Content-Language: en-US
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
References: <20240502084450.44009-1-nbd@nbd.name>
 <20240502084450.44009-3-nbd@nbd.name>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240502084450.44009-3-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/2/24 2:44 AM, Felix Fietkau wrote:
> Preparation for adding TCP fraglist GRO support. It expects packets to be
> combined in a similar way as UDP fraglist GSO packets.
> For IPv4 packets, NAT is handled in the same way as UDP fraglist GSO.
> 
> Acked-by: Paolo Abeni <pabeni@redhat.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/ipv4/tcp_offload.c   | 67 ++++++++++++++++++++++++++++++++++++++++
>  net/ipv6/tcpv6_offload.c | 58 ++++++++++++++++++++++++++++++++++
>  2 files changed, 125 insertions(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



