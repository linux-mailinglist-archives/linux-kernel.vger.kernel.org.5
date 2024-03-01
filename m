Return-Path: <linux-kernel+bounces-88619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8C586E448
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DD7E1F2125B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D0E6EEF7;
	Fri,  1 Mar 2024 15:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqMXvMaG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96C838DC3;
	Fri,  1 Mar 2024 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709306862; cv=none; b=eUipSx8lhtodwgqFVfyFNQMaCetU1Gwl0xpGdCpZnfCsSI8vm95Ff0Y9nA7bjwZANo3NBOqSbCPXICh4Fc87MgXPAh7tfGoJgRA+ISc4SC2XoIfhh1ayNGEQhwH3idbaRgCCDPoZ2j2C7UKyCsnzpOV+odwXh8hTyCRwUOI+yW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709306862; c=relaxed/simple;
	bh=wrD3glGEGSHzriZwlvphFHNZeyybi3nx+Chglm6H5Ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aps8t1GiYWQvXz6EF5DSBbrsvw08MVhWZB+YMnxg2leVa6bdKTU2P3K+z/MkMVOB6D+BUi5Lc6YjiPqCxKBjORZ3qn2w4f+ppftOWlZof0dhaM+7IqcFeCL3sJIPhfgx+VC3X+OuVU/jku+xJu+ppgwA2RhK5Mpq26/M8yuaz/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqMXvMaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9087C433F1;
	Fri,  1 Mar 2024 15:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709306862;
	bh=wrD3glGEGSHzriZwlvphFHNZeyybi3nx+Chglm6H5Ww=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kqMXvMaGEMOROMXpmbH/+HtBHBdzi5ADfAH2yF3H4ZkYdQRj6itzbhtnt3q1tio63
	 Sx1lwAGtfQqyy7sTLW/u02oRaC9OZ7MVmH2Z7ymi/d4sMiJ2GBPCzvJtF7U2Rz63OK
	 h0YG+RDSVYA6X7oP1kUzLWJAIz5Qslyj8xGu16PU40ZoTS7pzbBEUQ2AZftGoQG6Ne
	 m5SrfnIHEjsp9zrW3VhYehhoQBKbcmCf2gHDYfoYHSEgKzZmfRTmnTv82AsbFTycA9
	 0eb2j18Ubfxsp4qflSExAP7qSWzYB3UKCBOT7DJmDfcu+32lTGLYsbeiV/lJw22hiI
	 WhxKY5REPwG6Q==
Message-ID: <177d3e62-2857-452b-bf42-e52587f825c6@kernel.org>
Date: Fri, 1 Mar 2024 08:27:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] ipv6: fib6_rules: flush route cache when rule is
 changed
Content-Language: en-US
To: =?UTF-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "jiri@resnulli.us"
 <jiri@resnulli.us>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 =?UTF-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?= <Shiming.Cheng@mediatek.com>
References: <09f2ab1b7946339da5092e10aa216e07c579c60b.camel@mediatek.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <09f2ab1b7946339da5092e10aa216e07c579c60b.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/1/24 7:39 AM, Lena Wang (王娜) wrote:
> From: Shiming Cheng <shiming.cheng@mediatek.com>
> 
> When rule policy is changed, ipv6 socket cache is not refreshed.
> The sock's skb still uses a outdated route cache and was sent to
> a wrong interface.
> 
> To avoid this error we should update fib node's version when
> rule is changed. Then skb's route will be reroute checked as
> route cache version is already different with fib node version.
> The route cache is refreshed to match the latest rule.
> 
> Fixes: 101367c2f8c4 ("[IPV6]: Policy Routing Rules")
> Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> Signed-off-by: Lena Wang <lena.wang@mediatek.com>
> ---
> v4: 
>   - add "Fixes:" tag.
>   - update subject as requested. 
> v3: 
>   - update patch description and name format in commit message.
> v2: 
>   - modify flush function same way as ipv4 flush cache.
>   - use tabs to aligh with existing code.
> ---
> ---
>  net/ipv6/fib6_rules.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



