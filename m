Return-Path: <linux-kernel+bounces-139948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FBE8A097D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30D2A1C21C50
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AEB13DDB7;
	Thu, 11 Apr 2024 07:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TlD1DoIZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA9A63D;
	Thu, 11 Apr 2024 07:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819796; cv=none; b=p5fy1AZMqF0nQ6/+xcXE6MFFq011/z6zJwerHlRrF8Nrerteee6MzET7U2a/iQ06E2mmTq2hpfhDb6Pkus4pzX1+9FAJr/KCeXwoL+SfQdyiZhra/XxIQ556eY8CCbl45OYkwT5cuaUmzfs/qkv4wbtUED/IJzcDkGoPUSotZ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819796; c=relaxed/simple;
	bh=1xYOPTuqtpTLVmhwlopOxLtF8xWMfDY79SUp6Zprkhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BAkieN0JQh7jbKmMXuQ+d3YqdgjHDO0Duk7+cPYHGPkMlotTd4L3wgpk1ouG9uA8HN0/XD7qRZsWx9RoBf5UJaxIoK6uEwc3sAkUZNCWQutunH04l24IBqt84qjibXkMcJYRU8yibwzv0AQWzr2o9LZ2iXERrUaDFCEUUtMGr5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TlD1DoIZ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712819794; x=1744355794;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1xYOPTuqtpTLVmhwlopOxLtF8xWMfDY79SUp6Zprkhs=;
  b=TlD1DoIZP0MfejzZBcf3zO9DYoxfNeYoP7E/tsDYBjAzzlPuN9zCVlP+
   zOV906eMNqZgi6yAfaJr/QUGwTQyNrBzl5JWB7f4awO1df22BmkQ4wwCb
   GZBdnbHN3MXLGGHz3t07bCPitQskjk5xme5yBiLQiH+GKKw0/q3CRefOD
   vsCdytE8rQLuv2oM0YZ/XEUAzKQgG4MQHOI91Nr/YpcGVSKC5AYrntsz0
   4ic7XxsMZEV9Tfwsl/S6cGpTKKVbAQZK2xg2RtDgqm0ZvbVLSFV63hmQf
   RjPJ4Vhje9fjuywKDvjdWxuHklflpv0C0FsqCnjUc+5nvRbt6Vzk6jPGv
   g==;
X-CSE-ConnectionGUID: jIC+0rbRTS63WX8hHkmkoQ==
X-CSE-MsgGUID: /BqFLQzTRHSfmAj4DyZB+Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="33614631"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="33614631"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 00:16:33 -0700
X-CSE-ConnectionGUID: 9K0+1AyfRha/RGU+uETIcQ==
X-CSE-MsgGUID: gRrxQhn1TSy0zaj59tdxaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="20894302"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.215.66])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 00:16:20 -0700
Message-ID: <c9f382b2-cd96-4ee3-ad68-95381d9e09c0@intel.com>
Date: Thu, 11 Apr 2024 10:16:16 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bug: Fix no-return-statement warning with !CONFIG_BUG
To: Arnd Bergmann <arnd@arndb.de>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Anna-Maria Gleixner <anna-maria@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <20240410153212.127477-1-adrian.hunter@intel.com>
 <87be83da-6102-483d-b1dc-a77eecc9f780@app.fastmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <87be83da-6102-483d-b1dc-a77eecc9f780@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/04/24 10:04, Arnd Bergmann wrote:
> On Wed, Apr 10, 2024, at 17:32, Adrian Hunter wrote:
>> BUG() does not return, and arch implementations of BUG() use unreachable()
>> or other non-returning code. However with !CONFIG_BUG, the default
>> implementation is often used instead, and that does not do that. x86 always
>> uses its own implementation, but powerpc with !CONFIG_BUG gives a build
>> error:
>>
>>   kernel/time/timekeeping.c: In function ‘timekeeping_debug_get_ns’:
>>   kernel/time/timekeeping.c:286:1: error: no return statement in function
>>   returning non-void [-Werror=return-type]
>>
>> Add unreachable() to default !CONFIG_BUG BUG() implementation.
> 
> I'm a bit worried about this patch, since we have had problems
> with unreachable() inside of BUG() in the past, and as far as I
> can remember, the current version was the only one that
> actually did the right thing on all compilers.
> 
> One problem with an unreachable() annotation here is that if
> a compiler misanalyses the endless loop, it can decide to
> throw out the entire code path leading up to it and just
> run into undefined behavior instead of printing a BUG()
> message.
> 
> Do you know which compiler version show the warning above?

Original report has a list

	https://lore.kernel.org/all/CA+G9fYvjdZCW=7ZGxS6A_3bysjQ56YF7S-+PNLQ_8a4DKh1Bhg@mail.gmail.com/


