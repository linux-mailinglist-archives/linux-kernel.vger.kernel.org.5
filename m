Return-Path: <linux-kernel+bounces-166545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 561588B9C1E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8CA61F24DA6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8FC13C808;
	Thu,  2 May 2024 14:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="f/Jy2fhF"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC4F13C68D;
	Thu,  2 May 2024 14:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714659245; cv=none; b=HMou/192Y21nIK8rIBY7uwcYEUwwXKvIfBLfM3zJSM5xTqKXZR+KNU4jzoFrFCd/xwQfisMuNnapm793UvjWRyBkkXSZYVLrN3EsZKm0Lpz+FtXRhTSaL12/zZJOPZiDv1eQwTrcUkP3BNkAVJB58wjcI4xsu2zqrSkC1oDoni4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714659245; c=relaxed/simple;
	bh=LrhW7BqJhH5lsbJc4mRqA52teKIZvgww5PHhZLou6BY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rEHCmIJ7gnjXjHX6M5u9z0GMb6pGg+OmLcNxbbQTjEgQ6qSWP4HmUnezHsNR5yZnRL46H4udjtTAn3zEqaUkqxIgjG40OyXz1B+cA+CrzJcaTy4OxvMjoRYd49SOrMDgT7o1xXBk7rF9HhXRL1Mp6PmpSo1raLWp5oW852GVYKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=f/Jy2fhF; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6B26347C52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1714659242; bh=tfULusTONwVOLuWBlwaVoOCnFSm3EJo4UthwfLmrGdE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=f/Jy2fhFzw4d3qlQu4XxQ8Cv1PQXC4Bb1pZU6OBgOEzNL7Oz6Ve2KH/zyoUQggpO1
	 xUnj/alWa0OBl5h3/1/V5Xqw0lIBvOtvWQCDTxNa+c5a2oXcGIcBXWXGmlVSExGDPq
	 sP3/rq9UzgehWwaqRLbtmneQssbh5YyqjZx2Hml/iQ6/6OzfcOv84gXCGHx+YDQgMU
	 0sNvoKT72AgSTS0qTSGqxTVKMHN8+ctGzGkLs4SXFetkWovmenBx+GWWMlX6+WGG5/
	 M+n7YQi2MHfIcPjXwNhuPkvScYgkE/SlPuqqCJjyQzhdfpCgqlriEPGGMdJzAit10J
	 dSPWly3D5z8TA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 6B26347C52;
	Thu,  2 May 2024 14:14:02 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Pascal Ernster <git@hardfalcon.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.6 000/186] 6.6.30-rc1 review
In-Reply-To: <daf3d612-283b-467a-82b7-bbf04fd8f723@hardfalcon.net>
References: <20240430103058.010791820@linuxfoundation.org>
 <356c4202-875f-4277-885e-31fdbfd746c1@hardfalcon.net>
 <2024050218-olive-majestic-f64b@gregkh>
 <daf3d612-283b-467a-82b7-bbf04fd8f723@hardfalcon.net>
Date: Thu, 02 May 2024 08:14:01 -0600
Message-ID: <87sez08fo6.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pascal Ernster <git@hardfalcon.net> writes:

> [2024-05-02 08:50] Greg Kroah-Hartman:
>> On Thu, May 02, 2024 at 08:44:30AM +0200, Pascal Ernster wrote:
>>> [2024-04-30 12:37] Greg Kroah-Hartman:
>>>> This is the start of the stable review cycle for the 6.6.30 release.
>>>> There are 186 patches in this series, all will be posted as a response
>>>> to this one.  If anyone has any issues with these being applied, please
>>>> let me know.
>>>>
>>>> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
>>>> Anything received after that time might be too late.
>>>
>>> Hi, 6.6.30-rc1 is running fine on an x86_64 Haswell VM.
>>>
>>> Note that I have *not* tested building the kernel documentation, and I
>>> suspect that building the documentation with docutils >= 0.21 would likely
>>> fail without the patch from
>>>
>>> https://lore.kernel.org/all/faf5fa45-2a9d-4573-9d2e-3930bdc1ed65@gmail.com/
>> 
>> What is the git id of this in Linus's tree?
>
>
> Hi,
>
>
> AFAICT this has not been merged into either Linus' tree nor into 
> linux-next nor into docs-next.
>
> I've added Jonathan Corbet because he seems to be the most likely 
> maintainer for Documentation/sphinx/kernel_include.py if I 
> understand/interpret the MAINTAINERS file correctly.

The patch was sent yesterday, so I've not had time to apply it yet.
That may happen today.

Thanks,

jon

