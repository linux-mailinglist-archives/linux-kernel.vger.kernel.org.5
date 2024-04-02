Return-Path: <linux-kernel+bounces-128684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7AF895E24
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5991F233DD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3FC15E1F6;
	Tue,  2 Apr 2024 20:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metaparadigm.com header.i=@metaparadigm.com header.b="PUn6dMCQ"
Received: from anarch128.org (anarch128.org [23.253.174.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735E915E1ED
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 20:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.253.174.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712091277; cv=none; b=GZlLwuqm75Y/JSfPQfZOFFGookZX//T4R0Y+W1DRPL/pIa0cOoK/S16CAfAVl0G+1owdaudlq2cdh6pgmoD6GjVg44ceefyO5QCIEgZhq2oBzEpnoHydk2OC06dK+B/D7y7v5mSk6sn3iyDhiYbO0cL6VNSEPj+RfWzkpl6h9oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712091277; c=relaxed/simple;
	bh=ItRqQxRVa/m81QrwLlyILDa0UEZoouUYVtvYXJrTq84=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=W7XWjEscTKYWIUCAJHtBmi9JwYMQeOA3aJzExQLh/F9/GGfbKg+j1jmSLaT7IkFyqc/VYb4X1zJiO/vwhI246pEPfR487ezj8Y0Qzjur0xLW/x8wj3d4hbYvzwI2wCLC7NrGlcfqD56HSyOXwJBtNTmQbM1/d49fCb8vqGkVo/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metaparadigm.com; spf=pass smtp.mailfrom=metaparadigm.com; dkim=fail (2048-bit key) header.d=metaparadigm.com header.i=@metaparadigm.com header.b=PUn6dMCQ reason="signature verification failed"; arc=none smtp.client-ip=23.253.174.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metaparadigm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metaparadigm.com
Received: from [192.168.1.5] (default-rdns.vocus.co.nz [202.150.110.104] (may be forged))
	(authenticated bits=0)
	by anarch128.org (8.15.2/8.15.2/Debian-22) with ESMTPSA id 432Kres7305610
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 2 Apr 2024 20:53:43 GMT
Authentication-Results: anarch128.org;
    auth=pass;
    dkim=pass (2048-bit rsa key sha256) header.d=metaparadigm.com header.i=@metaparadigm.com header.b=PUn6dMCQ header.a=rsa-sha256 header.s=100043;
    x-return-mx=pass header.domain=metaparadigm.com policy.is_org=yes (MX Records found: mail.anarch128.org);
    x-return-mx=pass smtp.domain=metaparadigm.com policy.is_org=yes (MX Records found: mail.anarch128.org)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=metaparadigm.com;
	s=100043; t=1712091227;
	bh=ItRqQxRVa/m81QrwLlyILDa0UEZoouUYVtvYXJrTq84=;
	h=Date:To:From:Subject:From;
	b=PUn6dMCQn2mU3DsTfuPGuqL0pJlpQS1McPZeld8JHbMmpePBaX1Ia4/f6ip9/dN4c
	 XLawcUrgIcUxcuo1cxOnNgx90VzjYCtTEljXbFWEKdevozx9YSV7HO6IeKnnoBpWs3
	 woQSgtLeCQb6MnYilyrynw7QbcXx6aEC4ddbD53+1c7bkScKLlaTeEeSq7aZR+nSfB
	 2VfeG3QFpiVoTB4B9eEXklMfbva/ul65XMRGJ1e06mihWRyzeWP3HNjEk3eowRz2nq
	 rYdtqdxig/Y+BPAtF9vEBNEcUAQFPHD6upDD0p2LT+hedB/x1jCyifPmWkf87qOc3a
	 IZPEhqKEzyPvg==
Message-ID: <969ccc0f-d909-4b45-908e-e98279777733@metaparadigm.com>
Date: Wed, 3 Apr 2024 09:53:34 +1300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm
Subject: user-space concurrent pipe buffer scheduler interactions
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Folks,

I am working on a low latency cross-platform concurrent pipe buffer 
using C11 threads and atomics. It is portable code using a <stdatomic.h> 
polyfill on Windows that wraps the intrinsics that Microsoft provides. 
There is a detailed write up with implementation details, source code, 
tests and benchmark results in the URL here:

- https://github.com/michaeljclark/cpipe/

I have been eagerly following the work of Jens on io_uring which is why 
I am including him as he may be interested in these scheduler findings, 
because I am currently using busy memory polling for synchronization.

The reason why I am writing here, is that I think I now have a pretty 
decent test case to test the Windows and Linux schedulers side-by-side. 
Let's just say it has been an eye opening process and I think folks here 
might be interested in what I am seeing and what we could predict should 
happen based on Amdahl's Law and low-level cache ping-pong on atomics.

Let me cut to the chase. What I am observing is a situation where when I 
add threads on Windows, performance increases, but when I add threads on 
Linux, performance decreases. I don't know exactly why. I am wondering 
if Windows is doing some topologically affine scheduling? or if it is 
using performance counters to intuit scheduling decisions? I have 
checked the codegen and it is basically two LOCK CMPXCHG instructions.

I ran bare metal tests on Kaby Lake and Skylake processors on both OSes:

- `Windows 11 Version 23H2 Build 22631.3296`
- `Linux 6.5.0-25-generic #25~22.04.1-Ubuntu`

In any case, here are numbers. I will let them speak for themselves:

# Minimum Latency (nanoseconds)

|                      | cpipe win11 | cpipe linux | linux pipes |
|:---------------------|------------:|------------:|------------:|
| Kaby Lake (i7-8550U) |      ~219ns |      ~362ns |     ~7692ns |
| Skylake (i9-7980XE)  |      ~404ns |      ~425ns |     ~9183ns |

# Message Rate (messages per second)

|                      | cpipe win11 | cpipe linux | linux pipes |
|:---------------------|------------:|------------:|------------:|
| Kaby Lake (i7-8550U) |       4.55M |       2.71M |     129.62K |
| Skylake (i9-7980XE)  |       2.47M |       2.35M |     108.89K |

# Bandwidth 32KB buffer (1-thread)

|                      | cpipe win11 | cpipe linux | linux pipes |
|:---------------------|------------:|------------:|------------:|
| Kaby Lake (i7-8550U) |  2.91GB/sec |  1.36GB/sec |  1.72GB/sec |
| Skylake (i9-7980XE)  |  2.98GB/sec |  1.44GB/sec |  1.67GB/sec |

# Bandwidth 32KB buffer (4-threads)

|                      | cpipe win11 | cpipe linux |
|:---------------------|------------:|------------:|
| Kaby Lake (i7-8550U) |  5.56GB/sec |  0.79GB/sec |
| Skylake (i9-7980XE)  |  7.11GB/sec |  0.89GB/sec |

I think we have a very useful test case here for the Linux scheduler. I 
have been working on a generalization of memory polled user-space queue 
and this is about the 5th iteration where I have been very careful about 
modulo arithmetic and overflow as the normal case.

I know it is a little unfair to compare latency with Linux pipes and 
also we waste a lot of time spinning on queue full. This is where we 
would really like to use something like SENDUIPI, UMONITOR and UMWAIT 
but I don't have access to silicon that supports those yet.

Regards,
Michael Clark

