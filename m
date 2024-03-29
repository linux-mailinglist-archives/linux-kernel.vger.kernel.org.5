Return-Path: <linux-kernel+bounces-125274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C1F892330
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3D7728491D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03828137902;
	Fri, 29 Mar 2024 18:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="EVHvlatA"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AC31C0DF8;
	Fri, 29 Mar 2024 18:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711736147; cv=none; b=DMrddVbHut9ODmv3adBkbfh8DB4x+kY4PXwaUCtJxDwS61H7TXLb0S8FWw/1i8caO2J95315cicyrontXypHb2tklV9G5wE5YoRhY1LM7C63JCxNaXn8361903r72dZOJWWZFX0Z7gdZlRzd7cwZriHC7ulmiZMvxKCCVglUvkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711736147; c=relaxed/simple;
	bh=Fl9+3J1/oK8uIQd+22QFYM3vM+ksNaxIpZgRdfXlHss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M3wAdddjNyfgxui/q2f27mtQY+y6iP3IT34RHrczVKoZ91P4t0xygicZSa5pFE2mw1kpAmzdTdNblygaulNBUDayyEyXsHNKzYaAeAFM9eAENQGxafMKteJ1/5m1L/v3YT/QU3R53mxjhtI5aC3D+YVe9i2Ta+5fpurjrGKUm3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=EVHvlatA; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4V5pVm1Xhhz6Cnk8t;
	Fri, 29 Mar 2024 18:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711736142; x=1714328143; bh=GJ1n1WrpcfiZuAd5K78JZW56
	w27mzJMFDvMl1ypxNfo=; b=EVHvlatAQ0Onhm0tvAY+Ilus/cLiH5tBciX2URyt
	jbGm+N21P4uFTFm2zx2mpCV1MGlNoAxwVfQ+dSctIXdxFhz4QgG5KM+Sa2g7X1Vh
	vVxUwsqSCzPVoL631xc6237Y7na2uz0nQXSBMuohasLAY4rWTqrPW2AB0Jzfc/4R
	bOZNvmhhj/1rKMrdba66xnOx2fWmACoklmDZigwpUxpg2tZcPMos5Dtehu/5IIwP
	cJV6KryuCi0OoVYtpN43kH7WsTKsrWEG6rNwTZaYIQi2RlG/s9NC+aIhwSTafgMj
	qvEbLMykeM9NQ2ToVQfw8R+e9wGscpMu0YIxeHLH/vJ/hQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id H5vHcGFKJvpK; Fri, 29 Mar 2024 18:15:42 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4V5pVh58M5z6Cnk8m;
	Fri, 29 Mar 2024 18:15:40 +0000 (UTC)
Message-ID: <848d1259-ff6e-4732-b840-a02a5e5fe2cb@acm.org>
Date: Fri, 29 Mar 2024 11:15:38 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-wbt: Speed up integer square root in rwb_arm_timer
To: I Hsin Cheng <richard120310@gmail.com>, axboe@kernel.dk
Cc: akpm@linux-foundation.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240329091245.135216-1-richard120310@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240329091245.135216-1-richard120310@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/29/24 2:12 AM, I Hsin Cheng wrote:
> As the result shown, the origin version of integer square root, which is
> "int_sqrt" takes 35.37 msec task-clock, 1,2181,3348 cycles, 1,6095,3665
> instructions, 2551,2990 branches and causes 1,0616 branch-misses.
> 
> At the same time, the variant version of integer square root, which is
> "int_fastsqrt" takes 33.96 msec task-clock, 1,1645,7487 cyclces,
> 5621,0086 instructions, 321,0409 branches and causes 2407 branch-misses.
> We can clearly see that "int_fastsqrt" performs faster and better result
> so it's indeed a faster invariant of integer square root.

I'm not sure that a 4% performance improvement is sufficient to replace
the int_sqrt() implementation. Additionally, why to add a second 
implementation of int_sqrt() instead of replacing the int_sqrt()
implementation in lib/math/int_sqrt.c?

 > The experiments runs on x86_64 GNU/Linux Architecture and the CPU is
 > Intel(R) Core(TM) i7-2600 CPU @ 3.40GHz.

Since int_sqrt() does not use divisions and since int_fastsqrt() uses
divisions, can all CPUs supported by the Linux kernel divide numbers as
quickly as the CPU mentioned above?

Thanks,

Bart.

