Return-Path: <linux-kernel+bounces-33101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87CE83647F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A1C1C22624
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB593CF7D;
	Mon, 22 Jan 2024 13:34:14 +0000 (UTC)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343763D0A1;
	Mon, 22 Jan 2024 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705930453; cv=none; b=MTvsTQruAgAZWjMLTXMeyEyXaz5A2e7/JyED5uUfsLpm78AyZ8xdUBslyykHWxwZgvitqNs7l6j3ak0oNyBU54SWltDpoLt25olXNO1lhiRvtshl5ev0NJ3+RgK6A5CQAyh/kryZoWBPq2ma3gKR+OzIB0Eo22loRnUe32eZOvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705930453; c=relaxed/simple;
	bh=nrhXgeUYKdwjzvb9v5T6b0okthObDexHCxzaKGYihZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vC5sSwUTL1Jv3H9cu6PVP7gm2NAAgnUhcV7yHzKAhihLqpN5kcRlC3FXABkBvXNQ7hEvxZG9mNAWdIO8/oBx2eAE9SFOSA8D3DjKSfVZxC+wuEAwakJja4LUMhNVjQIWSg0L+LZ6T7iZ80rhjVzjihGsZztzdGBF7e0rhUTtFvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W.9YBSO_1705930441;
Received: from 30.221.145.129(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W.9YBSO_1705930441)
          by smtp.aliyun-inc.com;
          Mon, 22 Jan 2024 21:34:02 +0800
Message-ID: <d953b39c-94ea-43af-9ca6-19630ead6c87@linux.alibaba.com>
Date: Mon, 22 Jan 2024 21:34:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [MAYBE REGRESSION] kbuild time of kernel compiling
Content-Language: en-US
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 linux-kbuild@vger.kernel.org, masahiroy@kernel.org, nathan@kernel.org,
 ndesaulniers@google.com, nicolas@fjasle.eu
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <be1abcda-4cf0-4441-9a27-831eaef28f2e@linux.alibaba.com>
 <5ae01623-3f0f-4c19-bf5e-29e39e9e9349@leemhuis.info>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <5ae01623-3f0f-4c19-bf5e-29e39e9e9349@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/22/24 6:50 PM, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 22.01.24 09:32, Jingbo Xu wrote:
>>
>> I noticed a regression of kbuild time in v6.7, especially when running
>> `make` command when all images have already been compiled.  In v6.6 it
>> takes ~3s, while in v6.7 it takes ~18s.
>>
>> I'm not sure if it's a known issue, or an extra action configurable with
>> a "CONFIG_XX" option.
>> [...]
> 
> Not my area of expertise, so take this with a gain of salt, as I might
> mislead you. Nevertheless:
> 
> One problem with compile times in 6.7 was noticed and fixed in mainline;
> I wonder if that is the same issue as yours:
> 
> https://lore.kernel.org/lkml/18c6df0d-45ed-450c-9eda-95160a2bbb8e@gmail.com/
> https://git.kernel.org/torvalds/c/31e97d7c9ae3de072d7b424b2cf706a03ec10720
> 
> I think there was another issue, but can't remember it from the top of
> my head. Maybe simply checking if 6.8-rc1 fixes things might be the best.

Yeah this issue doesn't reproduce anymore after pulling 6.8-rc1.  I
didn't test the latest 6.8-rc1 as our internal mirror repo is one day
later than the upstream, while my machine can not connect to github at
the time...

Anyway thanks for the feedback and sorry for the noise.


> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.

-- 
Thanks,
Jingbo

