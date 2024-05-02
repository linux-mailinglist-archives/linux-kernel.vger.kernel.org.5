Return-Path: <linux-kernel+bounces-166644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF948B9D7D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C438B1C21B75
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C749915B551;
	Thu,  2 May 2024 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEkpbASg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A2E15B13A;
	Thu,  2 May 2024 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714663960; cv=none; b=oxlvmeuotEa114bui6v3IE4Biend1LfrAHM3nsNB3VLtf69+JgBq/B+RvRmhlC6sBzwooE/XwP9am6JsMwQsbycydL8itOieY7gNngxzcF24gboWfTtNr5cC0hWx6xas25ZhzG0oOJ9GYPb4s3pFIjsoHnFavGBXA19TiIphcaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714663960; c=relaxed/simple;
	bh=aAXlpuGCYiCX4G0olCs4UZZ5AIr8sCzw7aSZb0cCVSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3UwgXPXQNh+AO3UCjBX59SMvVyty4pubFF0qA3DbeMw2Tp8tbt1gUiIKY+91OVlNJJWUQiDHsrV4TmR2FJQteOB5UyCZFVfl82VY1gRTX9HLPwmY74cBr444PNmbzmHrxQo1XFxiWm2cP9zDpfbKKdFu5bNIBM1JfXgzGdkbw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEkpbASg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF14C113CC;
	Thu,  2 May 2024 15:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714663959;
	bh=aAXlpuGCYiCX4G0olCs4UZZ5AIr8sCzw7aSZb0cCVSE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CEkpbASgBKIee9HOhqLpQDJnkHErdpFtDlMxrHiUjiuJmDZZBbKBvP1QJJWSnGAgb
	 tRLnsq/+KBzCnwhWMkJ/SXsaJ4p2rUoyJsvq9ect/9DsbYXgzUQh0bnVhZJLGkSYMp
	 BgvRMzyT6W9ymz1rdiwnz15g/2k0ZDnc2VRMbj75UDfn9MuWMqTVy/duN0jyVsrbA+
	 W4YpnFtb9Mfz9BopH2qe4iiWq7G4VBhnFFmyAhNx4uLy2lezJ+AG1I8DVJwOX3/85u
	 8iyw6U5V9m9/voyIjUWHY6yPA3F0WHad1uC1PzPgymDN6L4MWF6YIRFnZ54+1hzBWc
	 HLu1rhRZ2UhKg==
Message-ID: <9f9966ed-106f-4fc2-82a4-b5057fb510d5@kernel.org>
Date: Thu, 2 May 2024 09:32:38 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next v5 1/6] net: move skb_gro_receive_list from
 udp to core
Content-Language: en-US
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
References: <20240502084450.44009-1-nbd@nbd.name>
 <20240502084450.44009-2-nbd@nbd.name>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240502084450.44009-2-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/2/24 2:44 AM, Felix Fietkau wrote:
> This helper function will be used for TCP fraglist GRO support
> 
> Acked-by: Paolo Abeni <pabeni@redhat.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  include/net/gro.h      |  1 +
>  net/core/gro.c         | 27 +++++++++++++++++++++++++++
>  net/ipv4/udp_offload.c | 27 ---------------------------
>  3 files changed, 28 insertions(+), 27 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



