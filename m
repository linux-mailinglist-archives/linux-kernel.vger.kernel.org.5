Return-Path: <linux-kernel+bounces-93715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B468733B7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A73511C21176
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CD25F841;
	Wed,  6 Mar 2024 10:12:53 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32A35D47B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 10:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719973; cv=none; b=iw6oVlyoOOAUY9MigI9OtQujxG0GQjScQXUxA5sdAsdn3/4XqhKWIYXG35Es9DNhqP5zXBt6EwVbHJvfPKNaTm0zVqhel9lzv6ndUIrg1xNdqP6YBco7jdDM+5zb8h0yX6kjmUtEx7oMcvpn/kE/mr6+PQWooNjMsTZR8U/Rn/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719973; c=relaxed/simple;
	bh=pYJ8RoW3njByOCi+aPiV5Mm4Sa6geAxfPuOwTiOKc4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YMl5wCXB6BznRitWFZgFKLNKrHK8WoaEun4v37W9dhEgx8oiNXeiUELpUQRmqL4Gj6u1bYnTfrHCcMXORkJXJsluXBMlbdEAkmVNbG0cISbfBaV0pQ45Hb45Izkpx11T0DpJHumLx04fRQdNxHVTpUMLeBVYJ0vVziH8awiyJiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 426ACLMq026383;
	Wed, 6 Mar 2024 19:12:21 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Wed, 06 Mar 2024 19:12:21 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 426ACKY1026379
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 6 Mar 2024 19:12:21 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <8dba5e3c-8c18-40f8-8467-da9a3c34516d@I-love.SAKURA.ne.jp>
Date: Wed, 6 Mar 2024 19:12:21 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86: disable non-instrumented version of copy_mc when
 KMSAN is enabled
Content-Language: en-US
To: Ingo Molnar <mingo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <3b7dbd88-0861-4638-b2d2-911c97a4cadf@I-love.SAKURA.ne.jp>
 <06c11112-db64-40ed-bb96-fa02b590a432@I-love.SAKURA.ne.jp>
 <Zeg0hpElT3TSZcNW@gmail.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <Zeg0hpElT3TSZcNW@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/03/06 18:16, Ingo Molnar wrote:
> 
> * Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
> 
>> Ping?
>>
>> This is current top crasher.
>> I hope this patch is applied before the merge window opens.

I posted this patch on Sun, 25 Feb 2024 13:40:59 +0900 but did not get response.
Therefore, I reposted on Sat, 2 Mar 2024 07:52:23 +0900, and Linus responded
that this patch is wrong.

> 
> 1) A false positive is not a 'crasher', it's a bug in instrumentation.
> 
> 2) A false positive in intrusive instrumentation that top distributions do 
>    not enable in their kernels has no immediate relevance to the timing of 
>    the merge window.

Not fixing a bug prevents us from finding and fixing other bugs. A refcount bug at
unknown location is preventing linux-next.git from finding other bugs for 20 days
( https://syzkaller.appspot.com/bug?id=8e4e66dfe299a2a00204ad220c641daaf1486a00 ).
Failure to fix bugs as many as possible in linux-next results in more bug reports
when failed-to-find-in-linux-next.git-bugs arrive at linux.git. I want to make it
possible to bisect linux.git cleanly before that refcount bug arrives at linux.git
by fixing bugs which we can fix now.


