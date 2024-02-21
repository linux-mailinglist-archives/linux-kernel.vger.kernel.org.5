Return-Path: <linux-kernel+bounces-75661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAFB85ED11
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2D9EB21847
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C14A129A68;
	Wed, 21 Feb 2024 23:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZiC3pkZB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E475A126F00
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708558530; cv=none; b=MYybaJPR7zl58lNxzMP59G0rPhsLghVfFf1m6afsCLigBJ8RDdUSv00zKt+7KnkZXtqFyxUDPr9e4Lsxe/vLhLTNO0NG4zqhR2zbVDP9pk4BLkuAB5kEnNxQzeZd9ddC3on4nqvna59Em2JF3T9MzqkBBoh48UJfe6poeSG/4gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708558530; c=relaxed/simple;
	bh=7OauMgVsT3HrSDBYzevjreykklBEY0CoOi6bqg94xpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n2/wEF/ijsgJQNsw4eMfcOA9UVKUqeWN93icYdXAX/cI6GTdVoej5d3pK30jQW1Zep9dbB5d8XPpjpvaZrfZ/EP1cPcApVXSiQelLTSWwOtaC2wAb+jqjX2app1AmPU3WMdP/JnTCZ06eLQIXMIh3hYroOPvHdfB2dl79z5uCBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZiC3pkZB; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708558529; x=1740094529;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7OauMgVsT3HrSDBYzevjreykklBEY0CoOi6bqg94xpI=;
  b=ZiC3pkZBJtn/pnxMrQvTpdajtcTGfJCQsHRpvU0RKGjD8qF2wwh6GcLN
   gLjEToQSo+JMslDe4rRpvco7BwZTvc+DrVMRU4FORHhs2H4YIo8XICRXD
   nEWYvwSodMKcQ8pVezXqK1N2PmySrOq4HGXt8Q3o8asDo0+MhdN/fRrbh
   8v95ZgXOIPG85OxmKmQ8/CBGy/W/O6nFRwvAQnsL51GfsRtFrQQfNayxl
   jBAnS4RSFbxqbeKT3llAQxRqKEjet2YOFnT57+8KfAabMZRzQtzOveXlI
   3el9zAKdy6/OqBnpAj43PQtjAq/dkqbIeOb6OI0HkhNEI2P2+nzIACDuR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2666184"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="2666184"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 15:35:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="936722442"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="936722442"
Received: from remiller-mobl1.amr.corp.intel.com (HELO [10.209.48.179]) ([10.209.48.179])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 15:35:26 -0800
Message-ID: <5648f43d-76e4-4396-b626-411d60657c93@intel.com>
Date: Wed, 21 Feb 2024 15:35:28 -0800
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
 <7a8c04bb-214b-4031-bdd6-59dad62f88a7@intel.com>
 <CAHmME9rCQgY_DMmpOEJWO8qytNw3ErJNy9L-E7WzEKYHVyqCHA@mail.gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <CAHmME9rCQgY_DMmpOEJWO8qytNw3ErJNy9L-E7WzEKYHVyqCHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/21/24 15:09, Jason A. Donenfeld wrote:
> On Wed, Feb 21, 2024 at 11:47 PM Dave Hansen <dave.hansen@intel.com> wrote:
>> OK, so we're trying to get 256 bits of seed data from RDRAND?
> 
> Yes. This fills a 32-byte buffer of longs up with output from
> arch_get_random_longs().

That's what it's doing mechanically, but what's the end goal?

>> But no pattern I could discern.  Did you mean something different by
>> "platform drivers"?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/um/kernel/um_arch.c#n413
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/char/random.c#n655

Gotcha.

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/gcc-plugins/latent_entropy_plugin.c#n90

Isn't that one 32 HOST_WIDE_INTs and not 32 bytes? :)

>> If we're going to have arch/x86-specific crud, it would be great to make
>> it obvious and straightforward to those of us simple folk that are
>> familiar with arch/x86 code.
> 
> If you insist, I'll stick a local `enum { RANDOM_BYTES_COUNT = 32 }`
> in that function or something. Seems unnecessary to me but if that's
> what you need no problem. Would that suffice? Or a different variable
> name? Or a comment on "what is 32 about?"

"what is 32 about?" would be great.  What's the goal, and why is 32
enough to reach that goal?

