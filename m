Return-Path: <linux-kernel+bounces-130607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE241897A68
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65684B258EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36901156655;
	Wed,  3 Apr 2024 21:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metaparadigm.com header.i=@metaparadigm.com header.b="r6MMeVXJ"
Received: from anarch128.org (anarch128.org [23.253.174.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303A01514DF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 21:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.253.174.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712178559; cv=none; b=H0hjb9dTAFsA3SpMxo+7AG/2cioI51HYbhrju88UQ9rHMpBUJbbHQH61e3RhvXqqUIIYHPYWBYrozcZWuDB3PAtIjm81E4tKstYWhdrvJScRNaLD4/vmE76uqz6elVduEfJLETL820ntm331u4uGVh51ZXk6oOSULkyvnTn51rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712178559; c=relaxed/simple;
	bh=nuAESWLU4gI8q+WylOWnOVd3iZvUzYqUM2as5Y3TWqg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ho5nulCx6fJjdbSQZaBp88UknhkdIPTGSTKZPn9Ooa2OGCV3Z50hK/Jds0046n8LwacdT9bbe7jmispFdM5PJFMJnOB7/lBMm+rjwKrfwfk0wjl+gBA+6AVmuJCFdljM670CnWyLvIsLB3+2bVvOhdQOX/aZmpRKRO00ZWFHDgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metaparadigm.com; spf=pass smtp.mailfrom=metaparadigm.com; dkim=fail (2048-bit key) header.d=metaparadigm.com header.i=@metaparadigm.com header.b=r6MMeVXJ reason="signature verification failed"; arc=none smtp.client-ip=23.253.174.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metaparadigm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metaparadigm.com
Received: from [192.168.1.5] (default-rdns.vocus.co.nz [202.150.110.104] (may be forged))
	(authenticated bits=0)
	by anarch128.org (8.15.2/8.15.2/Debian-22) with ESMTPSA id 433L2FEa382974
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 3 Apr 2024 21:02:18 GMT
Authentication-Results: anarch128.org;
    auth=pass;
    dkim=pass (2048-bit rsa key sha256) header.d=metaparadigm.com header.i=@metaparadigm.com header.b=r6MMeVXJ header.a=rsa-sha256 header.s=100043;
    x-return-mx=pass header.domain=metaparadigm.com policy.is_org=yes (MX Records found: mail.anarch128.org);
    x-return-mx=pass smtp.domain=metaparadigm.com policy.is_org=yes (MX Records found: mail.anarch128.org)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=metaparadigm.com;
	s=100043; t=1712178140;
	bh=nuAESWLU4gI8q+WylOWnOVd3iZvUzYqUM2as5Y3TWqg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=r6MMeVXJrYh8TU6IvNXWfAJ/jeI0p8AzI0MBiYN24S55BTnH0aE/+ZT6ACEtW6ba6
	 R8FacpREBQ+MEzthYU4wcIR0PPlVJvctyB0rnvPi4XAJfbJ37GMdNQUneRBVjzlZaK
	 OoE24hC9Sn2gITNZGv08DXa92LBdEgUSHCA6FDlxYO1712DdMHjVpuHVrtwVFUr5y+
	 go3+N0FKNjhQ0Za5Nf64eqTy4ZaBAEOtXk7yNe3gbEn+5qiBtuEvC4KvW2VRQItHQT
	 8sl8fh8XBORNtfjxHl4RaJxjzDU5nGiZOgnZx5HIq9fN2C++110U+HcW4yT12HMMqb
	 /si3w31lC/Zww==
Message-ID: <422feb1a-4b4e-45b6-838a-78e394dec9cc@metaparadigm.com>
Date: Thu, 4 Apr 2024 10:02:10 +1300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: user-space concurrent pipe buffer scheduler interactions
From: Michael Clark <michael@metaparadigm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
References: <969ccc0f-d909-4b45-908e-e98279777733@metaparadigm.com>
 <CAHk-=wj3khqjXnHmShPj+tZvC=SyUitTZ7BkDO-rqu_aCVPrXA@mail.gmail.com>
 <1a116a43-fd2e-4f03-8a17-75816fc62717@metaparadigm.com>
Content-Language: en-US
Organization: Metaparadigm
In-Reply-To: <1a116a43-fd2e-4f03-8a17-75816fc62717@metaparadigm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/4/24 09:39, Michael Clark wrote:
> So maybe it is possible to look at how many LOCK instructions were 
> retired in the last scheduler quantum ideally with retired-success, 
> retired-failed for interlocked-compare-and-swap. Maybe it is just a 
> performance counter and doesn't require perf tracing switched on?

just occurred to me that you could stash the address and width of the 
last failed interlocked-compare-and-swap to deduce wait-on-address or 
even ask the processor in some circumstances to generate a precise 
interrupt so that you could reschedule it. an idle thought. like if it 
is going to fail we might as well jump straight to the scheduler.

