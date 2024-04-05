Return-Path: <linux-kernel+bounces-133220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B79689A0B9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C0E11C224B1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF7016F836;
	Fri,  5 Apr 2024 15:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="KAAtwnPj"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED67F16EBF3;
	Fri,  5 Apr 2024 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329909; cv=none; b=WOXAleSo0wzYr5XT6k6OLpUldrIV6KI+lWvqcq0eV+StQrGXEgXchysBcIPiTEUfSGwT8or5VCDG2lnCsOnSGbGfYEgM+Vg8oR5WFcML7JCK56zcV3e5jYH0da6WY0i8+1dLu9PunhhPpFCS+DOvsnOyOyZTkiKZIS6DtCGYHz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329909; c=relaxed/simple;
	bh=i/FBrmXeRYRAkZo+w8z9IKfnevF7NzMKdBcR5i1GyaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F443aVuFKkdkpS12sG8fpctS5fBl3PV0thXZdzFoBFbc4s4fI3OF3vpRKPrpWJhWlDc1clujUyN/b5tXQZCeJZKSxSnyKENfm68UGq7LssYSWYfkDpl3cX9xZuEvXUpeNzT6bRjix9uYasN4GQ26qC+DECIwzMymYQ1gDx4CavM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=KAAtwnPj; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4VB1yQ1vzLz6839;
	Fri,  5 Apr 2024 17:05:50 +0200 (CEST)
Received: from [10.10.15.20] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4VB1yP6kvsz680y;
	Fri,  5 Apr 2024 17:05:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1712329550;
	bh=6CbXOq/C6yEQwlReHz1yEL3Ba6l2jK2jJJv8AXL2LzE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KAAtwnPjCFUeznelsBSSFkOTTnV258nZcPC+4Ie3DHVGsOl5E2LGvjPvWv8SY0tAu
	 beI/vYsBcUWaA8xVC0CbFQCSwViXKnjvaOHG/5byuWOMgNbyGSkc4G5DN9EPfwTJon
	 3kMOc8fNBTousHgMdaARXBuvBApkqf6cEEQ+cnLY=
Message-ID: <5f022f30-e1f2-46e3-b75b-0cb4b157448e@gaisler.com>
Date: Fri, 5 Apr 2024 17:05:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PROBLEM: Only one CPU active on Ultra 60 since ~4.8 (regression)
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Nick Bowler <nbowler@draconx.ca>, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org,
 Sam Ravnborg <sam@ravnborg.org>
References: <CADyTPEwt=ZNams+1bpMB1F9w_vUdPsGCt92DBQxxq_VtaLoTdw@mail.gmail.com>
 <CADyTPEyAidGgBT3f1VJLHb3ouO-r1UyvFp1PcwXxy0NRG94sbw@mail.gmail.com>
 <1df92fec-7f57-5080-94ed-b149ed384280@leemhuis.info>
 <14dcd743-144a-9f7b-849c-0843d50e4c04@draconx.ca>
 <4dce7447-678d-4e60-b76e-b01988bd6515@leemhuis.info>
 <CAHk-=wgFuoHpMk_Z_R3qMXVDgq0N1592+bABkyGjwwSL4zBtHA@mail.gmail.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <CAHk-=wgFuoHpMk_Z_R3qMXVDgq0N1592+bABkyGjwwSL4zBtHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-03-28 21:09, Linus Torvalds wrote:
> On Thu, 28 Mar 2024 at 12:36, Linux regression tracking (Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
>>
>> [CCing Linus, in case I say something to his disliking]
>>
>> On 22.03.24 05:57, Nick Bowler wrote:
>>>
>>> Just a friendly reminder that this issue still happens on Linux 6.8 and
>>> reverting commit 9b2f753ec237 as indicated below is still sufficient to
>>> resolve the problem.
>>
>> FWIW, that commit 9b2f753ec23710 ("sparc64: Fix cpu_possible_mask if
>> nr_cpus is set") is from v4.8. Reverting it after all that time might
>> easily lead to even bigger trouble.
> 
> I'm definitely not reverting a patch from almost a decade ago as a regression.
> 
> If it took that long to find, it can't be that critical of a regression.
> 
> So yes, let's treat it as a regular bug. And let's bring in Andreas to
> the discussion too (although presumably he has seen it on the
> sparclinux mailing list).
Yes, I am aware and I agree we should treat it as a regular bug.

Reverting it as a regression fix would lead to followup issues like
canceling the effect of commit ebb99a4c12e4 ("sparc64: Fix irq stack
bootmem allocation.") but with misleading comments left in place. 

Sam's fix looks like a good solution for me to pick up to my
for-next branch.

Thanks,
Andreas

