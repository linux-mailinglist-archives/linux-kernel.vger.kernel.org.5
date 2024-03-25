Return-Path: <linux-kernel+bounces-117045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E00388A666
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1341C3A3F2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5086EB74;
	Mon, 25 Mar 2024 12:46:17 +0000 (UTC)
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A8815F406
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.28.154.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370777; cv=none; b=ukMMExJNfK0DbR2QLMe1tu0wsWNtNcW/yUEouNHG699BnJDNg1jM1jvf/u7YeGJrSoX7U/09TyVKplioHZtdsRH2lqrVN79yiaELbVQbeHdCNW5i5HQZW3ZwbuO61n+itqmS+PRWE+XRlV2K55CgDmb0vVBC+gg7S7QmhLYmD9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370777; c=relaxed/simple;
	bh=2k4F1nQWeCCo4oPFNKDQJU2HDXCryI+vJYqFmBLbAf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WNm6+VdZdGjLf1HZCVUMn9NA4OUzNCr2Bn+MmhtqQof7NcF9SWLGkATP1uBt5CViB0cLK6pjT+W473mKL6W+AEkEEipzLti/BahMSzyjE29uM+d5tRsOty3YDRHXBqyR+1tEU5oaiu+voBZnmRfMrL5PJimjHHfhW2PwlQ1Dz68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name; spf=pass smtp.mailfrom=maciej.szmigiero.name; arc=none smtp.client-ip=37.28.154.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maciej.szmigiero.name
Received: from MUA
	by vps-vb.mhejs.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <mail@maciej.szmigiero.name>)
	id 1rojiG-0002Uk-Ci; Mon, 25 Mar 2024 13:46:04 +0100
Message-ID: <cfcdae85-8ebd-4723-a15c-8010e6d20d0f@maciej.szmigiero.name>
Date: Mon, 25 Mar 2024 13:45:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -v2] x86/CPU/AMD: Improve the erratum 1386 workaround
Content-Language: en-US, pl-PL
To: Borislav Petkov <bp@alien8.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, X86 ML <x86@kernel.org>
References: <20240321120548.22687-1-bp@alien8.de>
 <20240321120548.22687-2-bp@alien8.de>
 <79125c93-285c-43f8-ac05-87c34c99e6bb@maciej.szmigiero.name>
 <20240324200525.GBZgCHhYFsBj12PrKv@fat_crate.local>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Disposition-Notification-To: "Maciej S. Szmigiero"
 <mail@maciej.szmigiero.name>
In-Reply-To: <20240324200525.GBZgCHhYFsBj12PrKv@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.03.2024 21:05, Borislav Petkov wrote:
> On Thu, Mar 21, 2024 at 04:21:39PM +0100, Maciej S. Szmigiero wrote:
>> On 21.03.2024 13:05, Borislav Petkov wrote:
>>> From: "Borislav Petkov (AMD)" <bp@alien8.de>
>>>
>>> Disable XSAVES only on machines which haven't loaded the microcode
>>> revision containing the erratum fix.
>>>
>>> This will come in handy when running archaic OSes as guests. OSes whose
>>> brilliant programmers thought that CPUID is overrated and one should not
>>> query it but use features directly, ala shoot first, ask questions
>>> later... but only if you're alive after the shooting.
>>>
>>> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
>>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>>> Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>> ---
>>
>> Tested-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> 
> Yeah, thanks but still not good enough. Turns out we already have the
> min microcode revision testing functionality so there's no need for me
> to reinvent the wheel.
> 
> No harm no foul, tho, the stuff in those two previous patches I will use
> in the microcode loader soon for simplifying the loading.
> 
> Here's one *final* variant, I promise! :-)
> 
> Sorry about that.

No problem, it happens :)

> ---
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Sun, 24 Mar 2024 20:51:35 +0100
> Subject: [PATCH -v2] x86/CPU/AMD: Improve the erratum 1386 workaround
> 
> Disable XSAVES only on machines which haven't loaded the microcode
> revision containing the erratum fix.
> 
> This will come in handy when running archaic OSes as guests. OSes whose
> brilliant programmers thought that CPUID is overrated and one should not
> query it but use features directly, ala shoot first, ask questions
> later... but only if you're alive after the shooting.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> ---

I have tested the updated patch now, including negative test by
increasing the required microcode version by 10, and can confirm that
this version works properly too.

Thanks,
Maciej


