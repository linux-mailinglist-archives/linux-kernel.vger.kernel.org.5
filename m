Return-Path: <linux-kernel+bounces-89196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C59F86EBD2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 273CB286AAF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4E35916C;
	Fri,  1 Mar 2024 22:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oJcDlh65";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Psw1Iw80"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B1A58129
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 22:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709332004; cv=none; b=e05sDMjC15osxYPkp7jkfafrpTfuUbz6u094cxm+1Qv7T8YXFbejvBWIifbLJhrnEwRuDdDxcvgQEIMmREYOVm6V4MWE7/nbOSA+OeQM61GFMr7hQB6Akn/kXU7i0iH8jG9vhRNtMb6mbYifdnXq2/zCMLh84SZO6Pt3Q00CZi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709332004; c=relaxed/simple;
	bh=IN6JRKtqw3vFCB6giVFudPNWSiuT9ONdqL6N7win0MM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s+yjZO6vIgZNryAQUi67ZoDOdBUXGA3+sycBtOaA8KygsPheIBFd7HlV9SW4qA7mnGjImYq8CRQqpEPPYfGc4hwJ8OF3sWYvuQwBTHoN7vtPaxzN8SWjyt1EAXvq2BOkuWvE5SqpluDwLfyn1lG71akHSRtZmNlGL2GXM/tygg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oJcDlh65; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Psw1Iw80; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709331996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cJM8o0dTZP9U5vHZ05HO7IC/rt7sp3jInBHTx/HcMEc=;
	b=oJcDlh65rNJTdki55CleIS9AsLFQXvvxF/JOue0xbiLJqS2sBeHTwyN827SeCda7zBb/iF
	v0m8KLubTheQ1WC23ofqeLjR4tWwzcb3oxTY5ROo1lAEpkPdbM4rtVonbUGKliKSaIeMhj
	/usZj3HVF8Z8TgDWJkX998Yhq127usfPt9gay4Y7hFAZVCIxAMCplMQtsqd8BOCKus82QL
	4n34bKODO1FKzap4b2LuN/a9Ds6FpB6oAqn8uHrLzBzFve9AMhcHkQhP9Pr1un8T6zjr6X
	TjtiPRWJ5/tzn6G+iC3V29gYA15rfCy0fX6xOH9mAK7+/qX/bbz+GtsmmEWKpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709331996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cJM8o0dTZP9U5vHZ05HO7IC/rt7sp3jInBHTx/HcMEc=;
	b=Psw1Iw80zlQEHBMp+q0ZZKpSWAoGe97qc3WdsQYzCfN+acIbyaUO7R1FYStWCzEvG2qSJC
	Ls7tCBVQ7lAQ8FDA==
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, Arjan van
 de Ven <arjan@linux.intel.com>, x86@kernel.org
Subject: Re: arch/x86/include/asm/processor.h:698:16: sparse: sparse:
 incorrect type in initializer (different address spaces)
In-Reply-To: <87edctwr6y.ffs@tglx>
References: <202403020457.RCJoQ3ts-lkp@intel.com> <87edctwr6y.ffs@tglx>
Date: Fri, 01 Mar 2024 23:26:35 +0100
Message-ID: <87a5nhwpus.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Mar 01 2024 at 22:57, Thomas Gleixner wrote:

> On Sat, Mar 02 2024 at 04:12, kernel test robot wrote:
>> FYI, the error/warning was bisected to this commit, please ignore it
>> if it's irrelevant.
>
> I have no idea to which previous thread you are replying to because your
> mail lacks any references.
>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   87adedeba51a822533649b143232418b9e26d08b
>> commit: 6e29032340b60f7aa7475c8234b17273e4424007 x86/cpu: Move cpu_l[l2]c_id into topology info
>> date:   5 months ago
>> config: i386-randconfig-062-20240301 (https://download.01.org/0day-ci/archive/20240302/202403020457.RCJoQ3ts-lkp@intel.com/config)
>> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240302/202403020457.RCJoQ3ts-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202403020457.RCJoQ3ts-lkp@intel.com/
>>
>> sparse warnings: (new ones prefixed by >>)
>>
>> vim +698 arch/x86/include/asm/processor.h
>>
>>    695	
>>    696	static inline u16 per_cpu_llc_id(unsigned int cpu)
>>    697	{
>>  > 698		return per_cpu(cpu_info.topo.llc_id, cpu);
>>    699	}
>>    700	
>
> This is bogus and I looked at another related bogosity today:
>
>   https://lore.kernel.org/all/202403010704.oGQZPu0P-lkp@intel.com
>
> which has similar complaints.
>
> So I went and downloaded the config and followed the reproduction
> instructions except for one detail.
>
> The only difference is the sparse version:
>
>     1) I had the regular debian variant installed.
>
>        Version:  0.6.4 (Debian: 0.6.4-3)
>
>     2) I updated my sparse clone and rebuilt
>
>        Version:  v0.6.4-66-g0196afe16a50
>
> Neither one of them exposed the problem, but you are using:
>
>        sparse version: v0.6.4-66-g0196afe1-dirty
>
> which is obviously based on the latest upstream tree, but seems to have
> some extra muck on top which I don't know what it is.
>
> Does this reproduce with an unpatched upstream sparse for you?
>
> If so then I'm really curious why it does not reproduce here.

Sorry, my fault. I can reproduce now but it still does not make any
sense. The code is correct...

Let me put something together which the sparse folks can digest.

Thanks,

        tglx

