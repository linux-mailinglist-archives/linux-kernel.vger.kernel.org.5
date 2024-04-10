Return-Path: <linux-kernel+bounces-139185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E6E89FFAA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2CEB1F22C4E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D314A1802D4;
	Wed, 10 Apr 2024 18:22:22 +0000 (UTC)
Received: from relay161.nicmail.ru (relay161.nicmail.ru [91.189.117.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5261802A5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 18:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712773342; cv=none; b=YokdzCl567T/of5As152EhfMkNnFdiT/FRKmZ7PEJUglDdET3uNBGQZkL1y8n06ybeJudo/XXZhLAseKia7lFMwGJfeA0N9Cw4I5NcKCssbaPxTpqta6e3BybM4uV4V0fH2rQgBiHieB0wgwkHP431A43vneL6NezOqWPoVO3Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712773342; c=relaxed/simple;
	bh=MiGYtVTPTlPJXtEc1JctOxEO0iGjODSuctCxjwC4WDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VF6GN/h5N5twoVYbbXKEwuGDp4NoerXKBhlCTdpmjVjAXf0giPyphXtJqEY6jFUXtTDbU3MDd9aKWloCBoWfojP7bedA01041H68R17iASBSRGz1kmEUYUtrdwpoxiEmiWRuEigik+Hhgxz8Qek8E5vvpkpMy7jjmC60NKFefJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.138.152] (port=4466 helo=[192.168.95.111])
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1rucF2-0007Tr-4O;
	Wed, 10 Apr 2024 21:00:13 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO [192.168.95.111])
	by incarp1104.mail.hosting.nic.ru (Exim 5.55)
	with id 1rucF2-009gh0-0h;
	Wed, 10 Apr 2024 21:00:12 +0300
Message-ID: <75c2b85a-da67-4037-b2b5-6a1dec838fa9@ancud.ru>
Date: Wed, 10 Apr 2024 21:00:06 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/smpboot: Add map vars allocation check in
 smp_prepare_cpus_common
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Ashok Raj <ashok.raj@intel.com>,
 David Woodhouse <dwmw@amazon.co.uk>, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240409182940.664482-1-kiryushin@ancud.ru>
 <ZhaUZFY5MUyy6hWK@gmail.com>
Content-Language: en-US
From: Nikita Kiryushin <kiryushin@ancud.ru>
In-Reply-To: <ZhaUZFY5MUyy6hWK@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MS-Exchange-Organization-SCL: -1

Thank you for the feedback!
I still have a couple of questions, if you could elaborate further?

>   - That doesn't really solve anything, nor does it propagate the error
>     further up.
This patch indeed is not fixing the problem, but tries to, at least
notify about it. Not sure, if it makes any sense in the context, as
noted that

> Plus memory allocation failures within __init functions for
>     key CPU data structures are invariably fatal.
If allocation errors in this case are indeed fatal, no one will be able to
get the printed warning (so it is indeed pointless).

But I do not understand, if all the possible allocation failures here are fatal?
For cpu 0 it is obvious (as set_cpu_sibling_map(0) right here dereferences
the allocated), but is it as fatal for the other cores?

> While there might be
>     more cores in the future - but there will be even more RAM. This error
>     condition will never be realistic.
In general case it is true. But there are some cases, for which we can not presume, that there will be enough resources: for example, building a new system with large number of cores and test-running it with one small stick of ram, or (more realistically) some quirky hardware/firmware fault. I myself had experience in the past with a buggy BIOS, that made memory resource available for the system usage so small, it led to allocation failures in places it was presumed impossible before.
>   - The canonical arch behavior for __init functions is to return -ENOMEM
>     and not printk anything.
Thank you for this observation! Is there any documentation I should read
to educate myself about conventional rules like that?
I was making my assumptions that printk is an OK solution in this case,
based on surrounding code (like arch_cpuhp_init_parallel_bringup,
disable_smp and native_smp_prepare_cpus, all of which do printk).
I guess it may be specific to this specific part of code that, as you
mentioned, are not meant to fail.
>   But that's not really an option for
>     smp_prepare_cpus_common(), which feeds back into the
>     ::smp_prepare_cpus() callback that doesn't really expect failure either.

> My suggestion would be to simply pass in __GFP_NOFAIL to document that
> there's no reasonable allocation failure policy here.
Thank you, seems like a more elegant solution, than adding new state
flags to the code!
But I have some questions considering __GFP_NOFAIL. It clearly shows, that allocation will not fail/is not expected to fail, does it not try making allocation until it succeeds? Would not it make the system hang in a problematic case? If all the allocations for all the cpus in this block are critical, we would be trading a possible crash for a possible hang (all in early startup), not sure which is better to debug. If some of the allocations are not that critical, with __GFP_NOFAIL the would still hang, is it OK?
> Also note that this code has changed in the latest x86 tree (tip:master).
Thank you for bringing that to my attention! Are there any guides to read
about the preferred workflow for patches for x86 subsystem? I was developing
the code on top of mainline kernel, not the x86 tree, and would like to know
if I should have done it differently for the future.

