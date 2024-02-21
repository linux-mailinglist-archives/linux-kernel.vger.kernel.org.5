Return-Path: <linux-kernel+bounces-75614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8766C85EBF7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30A28B24760
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438DC8665A;
	Wed, 21 Feb 2024 22:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hfx2vUG+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC3A3EA92
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 22:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708555656; cv=none; b=phmO55qvco+m/ooqGFur+ScastyBoJBWv3gKUbiFk7DTwkNRCEKw8gcqkZJ423orzPkxhwsWH7Vd4nlWT9SMqhN3VqFTiqd5gCPiIgNL+Y9z/q298sR2FEaV0TPMtxOIkwdbqKHko9CBMp2fx72y8Rq6I3HCLFOahwhEm3ZGzC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708555656; c=relaxed/simple;
	bh=RuvAyZ6Ue4BESfM0SbafCLF33EGwJftc48UezQEsvd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s4F7TvBasXYODTYlsFwXgR6XSjuPbIweX9WZ0AZEASZjmqUr3zPJR3wIDU6BqrZfsyRvTJWhamiFSabpADCQM/PpC4KM8imLBx4eTGLMJqgK9twHzQx5ka0sRO3LnO1C3NyQllQPYvFs3tjiVXzc9+GWfSUO9GRmMu0cBA7WVcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hfx2vUG+; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708555641; x=1740091641;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RuvAyZ6Ue4BESfM0SbafCLF33EGwJftc48UezQEsvd4=;
  b=Hfx2vUG+TmiW/WGWfaxyNcW0AbaHrlTOtuWot1DSVGH5cTweWLS1+qu5
   iwdVI9LGBjW2aRoOkAQEjw69WpnHrd1LpZ8BcoTRNwZvYJw3Lf5gNGbkL
   VycprhIqdyxGz1NSn8jVyDxYAvC+GJ4PeILypLtG9wI2qd4/BNJRLfeX7
   48tYXnlK2Dndn0fTTlBn02iQA4BC/Sgj7r8fILRpPDOJgZGs9PTjkDY5N
   cTK47Rf04f2D3sCxUf38iYUyAhcO+4KiXzrxFK3ccvBIBB8Q2JPUQVODN
   gfFGViFX7GRwORULlTJPmNP/qdvuQn+YcVo+CAOFJ1DhDtbUzfN/qylgT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="13305962"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="13305962"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 14:47:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="36085089"
Received: from remiller-mobl1.amr.corp.intel.com (HELO [10.209.48.179]) ([10.209.48.179])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 14:47:17 -0800
Message-ID: <7a8c04bb-214b-4031-bdd6-59dad62f88a7@intel.com>
Date: Wed, 21 Feb 2024 14:47:18 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/coco: Require seeding RNG with RDRAND on CoCo
 systems
Content-Language: en-US
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Theodore Ts'o <tytso@mit.edu>, Thomas Gleixner <tglx@linutronix.de>
References: <20240221123248.25570-1-Jason@zx2c4.com>
 <eada8acd-9341-401b-b6c9-a05848eb91d6@intel.com>
 <CAHmME9o75KzsfMRDtr2K0+N-UM-MX7MWL4AZhy27CedZRNd2Tg@mail.gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <CAHmME9o75KzsfMRDtr2K0+N-UM-MX7MWL4AZhy27CedZRNd2Tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/21/24 09:19, Jason A. Donenfeld wrote:
> On Wed, Feb 21, 2024 at 5:55 PM Dave Hansen <dave.hansen@intel.com> wrote:
>> On 2/21/24 04:32, Jason A. Donenfeld wrote:
>>> +__init void cc_random_init(void)
>>> +{
>>> +     unsigned long rng_seed[32 / sizeof(long)];
>> My only nit with this is the magic "32".
>>
>> Why not 16?  Or 64?
> 32 bytes = 256-bits = what we're targeting. Very normal thing to see
> places in the RNG, used all over random.c and lots of platform
> drivers. Pretty obvious and straightforward to anyone familiar with
> this kind of code. Not the kind of thing you'd want to replace with
> some abstracted constant that makes you search.

OK, so we're trying to get 256 bits of seed data from RDRAND?

There's an entire section of the Intel whitepaper[1]: "Generating Seeds
from RDRAND".  It describes one "method of turning 512 128-bit samples
from the DRNG into a 128-bit seed value".  I was naively thinking that
if the kernel wants 256 bits of seed data from RDRAND, it might take
2*(512 128-bit samples).

I'm not suggesting that we use the exact construction from that
whitepaper, but I'm reasonably sure I could actually explain to someone
where a magic 1024 came from.

I also went through a smattering of add_device_randomness() users.  I
didn't see much of a pattern there that seemed to line up with a
256-bits convention.  If anything they seemed to just use what they had
laying around.  I saw byte counts of 16, 21, 12, 8, 1, strlen(), 56.
But no pattern I could discern.  Did you mean something different by
"platform drivers"?

If we're going to have arch/x86-specific crud, it would be great to make
it obvious and straightforward to those of us simple folk that are
familiar with arch/x86 code.

1.
https://www.intel.com/content/www/us/en/developer/articles/guide/intel-digital-random-number-generator-drng-software-implementation-guide.html



