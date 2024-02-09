Return-Path: <linux-kernel+bounces-60140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F08248500A4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3E11C21311
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576DA38399;
	Fri,  9 Feb 2024 23:15:53 +0000 (UTC)
Received: from davidv.dev (mail.davidv.dev [78.46.233.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB037374C1
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 23:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.233.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707520552; cv=none; b=V1cMUOUD/dG1s70xOOMmHqQ0DePZ5MniQxdpFpEVCiQWdBlpeV/mnATpI6IYZKkQvQ3PyAotzyXYJPC6NrFoGHlIIoJg4gi2IgdxDj7pzC6dxZ8TfhsBjy1eI1PRkjeVKaGpKCtiVwsqJeZBvtosVVPntjnM8kSuGf7zR/jsL70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707520552; c=relaxed/simple;
	bh=xEYmqoe0JpXF+8LCEEn18mFm7SSFoDzDPkuEOR2M26Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bngff5n4E6oNTAnHQdDXN16NcoAi6tILcWo/xliaierNd8ZBxhV0X/U5PGSJcJvLsK91Zo2SQHxlprf1hqhUmwuVgxN7QWHkQgwZGQdQwWs10ZKkoI/Ceja9n2kjQWBrDOidysZR3kYJ66ezwpEFPZRfnpU21z/RFqVP3wemG5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidv.dev; spf=pass smtp.mailfrom=davidv.dev; arc=none smtp.client-ip=78.46.233.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidv.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidv.dev
Received: from [192.168.2.131]
	by mail.davidv.dev (chasquid) with ESMTPSA
	tls TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
	(over submission+TLS, TLS-1.2, envelope from "david@davidv.dev")
	; Sat, 10 Feb 2024 00:15:43 +0100
Message-ID: <ee37f457-3d2d-4c18-b22f-dfb315b3c078@davidv.dev>
Date: Sat, 10 Feb 2024 00:15:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] net: make driver settling time configurable
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Xiongwei Song <xiongwei.song@windriver.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:NETWORKING [IPv4/IPv6]" <netdev@vger.kernel.org>
References: <20240208093722.246930-1-david@davidv.dev>
 <20240208095358.251381-1-david@davidv.dev>
 <20240209135944.265953be@kernel.org>
 <7485f0b2-93fe-4c82-95e8-5b0e10f9fa7a@lunn.ch>
From: David <david@davidv.dev>
In-Reply-To: <7485f0b2-93fe-4c82-95e8-5b0e10f9fa7a@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/9/24 23:11, Andrew Lunn wrote:
> On Fri, Feb 09, 2024 at 01:59:44PM -0800, Jakub Kicinski wrote:
>> On Thu,  8 Feb 2024 10:52:29 +0100 David Ventura wrote:
>>> During IP auto configuration, some drivers apparently need to wait a
>>> certain length of time to settle; as this is not true for all drivers,
>>> make this length of time configurable.
>> Please CC folks who gave you feedback, Andrew's is missing.
Thanks for the feedback, still learning this workflow
>>
>> Andrew, what do you think about just removing the wait?
>> Or decreasing it to 1ms?
>> It feels a little wasteful to be adding uAPI for something
>> which as you said is likely papering over ancient bugs. We'll
>> fix the bugs which are still around and the uAPI will stay
>> forever :(
> My guess is, the broken drivers are doing setup stuff after they call
> netdev_register().
>
> Reducing it to 1ms will probably continue to hide such bugs. So we
> could just go with that, and probably not see any regressions. Or we
> can decide we really do want to know about broken drivers, and just
> remove the delay.
>
> Either way, we don't need a new uAPI.

Would it make sense to move this to a build-time configuration flag?

I do not have a gut-feeling for which behaviors should be configurable

at build vs run time.

> David, is 1ms too long for you? If we do take the delay out, you are
> going to receive some of the flack from regression reports.

I've used this patch to experiment with different values, and the sleep time

behaves as described in Documentation/timers/timers-howto.rst, that is, a

call of `msleep(1)` usually delays boot time by 12~13 ms in my tests.

On top of this, I'm running this specific example on a no-smp systemm, 
where I

do not believe the `msleep` achieves anything (but I'm a kernel newbie 
so please

correct me if I'm wrong).

>
>        Andrew
>

