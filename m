Return-Path: <linux-kernel+bounces-32787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0990F836011
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C5161C21F20
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C053A269;
	Mon, 22 Jan 2024 10:50:47 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D803A1BE;
	Mon, 22 Jan 2024 10:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705920646; cv=none; b=bhvjMGPfH0jrr/o0mBJuq1JoKzJ8SzoHL08pywOTE+N0o3g9kAV74sgWwoadrv5wjP6OvrP0kcXG6NjBSHsLeBNy4yTBQ/MiqGurb/mClKghXhHkPwe08Z/dznQIrYle5ogHYweo3+M8XCEcYT/8P9moq2I12CNIvZbM9wT/ZDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705920646; c=relaxed/simple;
	bh=6GGGsTAkyuykJmXCUUzWPb7tQVhFfHYPnkRQ7X+yi7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RNsyAMJuWXBzyuzDLD9rDnmKSaMgtMHFigabA5EKQeR87+5UNktnZxdrTG/yu+WVLerYGFr66+RAqSYffM/088IrYfqiXeLp57p1/ubM56RNYFldVKGP+BdQj1olrGUR8S3ZjEPsVYSC5X5D8cp8yhpLCkhjJ9tEsi84asI3goU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rRrt4-0005LQ-UK; Mon, 22 Jan 2024 11:50:42 +0100
Message-ID: <5ae01623-3f0f-4c19-bf5e-29e39e9e9349@leemhuis.info>
Date: Mon, 22 Jan 2024 11:50:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [MAYBE REGRESSION] kbuild time of kernel compiling
Content-Language: en-US, de-DE
To: Jingbo Xu <jefflexu@linux.alibaba.com>, linux-kbuild@vger.kernel.org,
 masahiroy@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
 nicolas@fjasle.eu,
 Linux kernel regressions list <regressions@lists.linux.dev>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <be1abcda-4cf0-4441-9a27-831eaef28f2e@linux.alibaba.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <be1abcda-4cf0-4441-9a27-831eaef28f2e@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1705920645;979e1402;
X-HE-SMSGID: 1rRrt4-0005LQ-UK

On 22.01.24 09:32, Jingbo Xu wrote:
> 
> I noticed a regression of kbuild time in v6.7, especially when running
> `make` command when all images have already been compiled.  In v6.6 it
> takes ~3s, while in v6.7 it takes ~18s.
> 
> I'm not sure if it's a known issue, or an extra action configurable with
> a "CONFIG_XX" option.
> [...]

Not my area of expertise, so take this with a gain of salt, as I might
mislead you. Nevertheless:

One problem with compile times in 6.7 was noticed and fixed in mainline;
I wonder if that is the same issue as yours:

https://lore.kernel.org/lkml/18c6df0d-45ed-450c-9eda-95160a2bbb8e@gmail.com/
https://git.kernel.org/torvalds/c/31e97d7c9ae3de072d7b424b2cf706a03ec10720

I think there was another issue, but can't remember it from the top of
my head. Maybe simply checking if 6.8-rc1 fixes things might be the best.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

