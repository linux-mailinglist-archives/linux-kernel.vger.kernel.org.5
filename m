Return-Path: <linux-kernel+bounces-76982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC0085FF70
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1CB7B230B6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3FB155A43;
	Thu, 22 Feb 2024 17:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoglI1Vq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3740E18657;
	Thu, 22 Feb 2024 17:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708623143; cv=none; b=i4bXukvH1xDp5TfHehEoajqdaanTYqjXKEwbSlktMfk0JpYmD2Fo+bw8kn9/oOtYy5kQTMV6+HCVZOxUVflqXsoL25pb0ViDyDm3MmnVANws4LuiwepTxbUkJphA8nd3u2NQTkN7RnvckTAF1mpNRPPkk2UGiLDGczsU1/TjDXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708623143; c=relaxed/simple;
	bh=m2EphDgXSycSEJVGvlSpYbFNhwOXxoGjBqbRCStEAqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Saf1k7Cwl2C3aZZkfr8I3Bgv2JZUFPTOB2izi1j9qcVrU1LC/IZGmdU2d/ySD6Ot6b6pHtQu0b7v+sMOSk2IcODXcw7K5QLM9T32U00RdqX6L7Ov8mcdQH7pJK5w6VZX6j1IzmGUkBJRCnMbMm3L71hL7hHd79WQo9/ll+0FyzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoglI1Vq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D76C433F1;
	Thu, 22 Feb 2024 17:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708623142;
	bh=m2EphDgXSycSEJVGvlSpYbFNhwOXxoGjBqbRCStEAqs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CoglI1VqMRrSUBgKHqsI4qjQrt/BUGfhuOemEhc5lqrobKsVI0yIQlKJyeq9v3Knc
	 T61V5Wnj2H4vwaOiMBlCRoH9HP511eMp9zDEewaS+081/xJ/LP89JwIQxDXm6XpOe4
	 uUTx3bIumL3RNXRdsgYcNuMRTEAo1Djgcm+NZEJ4bycUCnPgZgg955NeBTa3rl4MoP
	 2h4duNcSUCrXyEWUPuxPYHzj/hH/kPddGZFb1DygpT3CNUDBbaf95tA8QTKgAlIDPK
	 EntIbQIZV5cAQq99R5ojnRMeMCOWI9DsghPfvwTGPKmfXHodqx4T6E3muQxGQ4WK6F
	 utduE2Ifb/ddA==
Message-ID: <032f132f-274d-4a23-82b8-fcc4393f7954@kernel.org>
Date: Thu, 22 Feb 2024 10:32:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6/sit: Do not allocate stats in the driver
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org
References: <20240221161732.3026127-1-leitao@debian.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240221161732.3026127-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/24 9:17 AM, Breno Leitao wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core
> instead of this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> Remove the allocation in the ipv6/sit driver and leverage the network
> core allocation.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/ipv6/sit.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



