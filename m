Return-Path: <linux-kernel+bounces-112798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E148887E48
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 19:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3BBDB20D2C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81897210E8;
	Sun, 24 Mar 2024 18:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J2oynpNT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E411E51A;
	Sun, 24 Mar 2024 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711304213; cv=none; b=ew/ZQ3yB7qG0O27E13J5hU6QwBKV8DF5gMSf+sabtH1z75p06NTf2JuI3DjHgElFEG3A4xym6ztylLCrtK/CeI9wbvzSskVfRDWu3H+dNhdrIPqOpslcU6izwWnw9ng81AxdEBkISWGmJ7gHypJIKycvlqVUZAG4JkrBdKMbeqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711304213; c=relaxed/simple;
	bh=9XDBBGPbDfqQIxYQlbQ+33bNBI0Fs7TlS1pRmwYLwqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STHae/gG9mGuKNmsXPbQr5hoUsgHFaVxSFV5YBaSbClQZDC2gYq9qO2LDgBD68icUoilnRUIrJ98/zGyyxRhtvdMQP3mIgh5GuiHwKKkzwHk3dU2/IlMNLRSN/mROWslXCrbJpD+0ikXVSu2JeuK1mBqsQvj5+K9g5W86b/A3do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J2oynpNT; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711304212; x=1742840212;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9XDBBGPbDfqQIxYQlbQ+33bNBI0Fs7TlS1pRmwYLwqk=;
  b=J2oynpNTXyodga5Ex5tOn2Oy22Nwp5qe8nYi+NDGUtTWgt3S+UJhQdbg
   a9dw0eMIlxAyLQC4V4DmXGOI842PXviHPxVqNoLTrri679I14TKV6V+MI
   NzRFm5MD5vuEjpkmGnmxvA4t72PJwzSJfhrRktGElfv5TIK8V+r6J9xmA
   7j1irhjBcNB0rodw/aUC/VB1YucJ5PSy7qsb5FHBnq/jWwKl+tOsW6aSX
   PKY1QmAV/CGOZ11WewWL9iQjgXhit70lUGr9yjrqZ+FDYfCrR0Tmq7AHV
   bg6YKVHK3bN94ePssSAblaMEmosBSrWT6vPIPT21fJcOCtby1zI3PziOC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6154209"
X-IronPort-AV: E=Sophos;i="6.07,151,1708416000"; 
   d="scan'208";a="6154209"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 11:16:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,151,1708416000"; 
   d="scan'208";a="20070636"
Received: from bmarken-mobl2.amr.corp.intel.com (HELO [10.212.140.250]) ([10.212.140.250])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 11:16:49 -0700
Message-ID: <8142c0de-e3a4-4e78-aa1b-f5e6503752e4@intel.com>
Date: Sun, 24 Mar 2024 11:16:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mm/ident_map: Use full gbpages in identity maps
 except on UV platform.
Content-Language: en-US
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Steve Wahl <steve.wahl@hpe.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Pavin Joseph <me@pavinjoseph.com>, stable@vger.kernel.org,
 Eric Hagberg <ehagberg@gmail.com>, Simon Horman <horms@verge.net.au>,
 Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>,
 Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>
References: <20240322162135.3984233-1-steve.wahl@hpe.com>
 <8cc9e238-fa70-402f-9990-f7e391b367a9@intel.com>
 <87r0g09r0m.fsf@email.froward.int.ebiederm.org>
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <87r0g09r0m.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/23/24 21:45, Eric W. Biederman wrote:
> Dave Hansen <dave.hansen@intel.com> writes:
>> On 3/22/24 09:21, Steve Wahl wrote:
>>> Some systems have ACPI tables that don't include everything that needs
>>> to be mapped for a successful kexec.  These systems rely on identity
>>> maps that include the full gigabyte surrounding any smaller region
>>> requested for kexec success.  Without this, they fail to kexec and end
>>> up doing a full firmware reboot.
>>
>> I'm still missing something here.  Which ACPI tables are we talking
>> about?  What don't they map?  I normally don't think of ACPI _tables_ as
>> "mapping" things.
> 
> Either E820 or ACPI lists which areas of memory are present in a
> machine.  Those tables are used to build the identity memory mappings.
> 
> Those identity mapped page tables not built with GB pages cause kexec to
> fail for at least 3 people.  Presumably because something using those
> page tables accesses memory that is not mapped.

But why is it not mapped?  Are the firmware-provided memory maps
inaccurate?  Or did the kernel read those maps and then forget to map
something.

Using GB pages could paper over either class of bug.

>> It seems like there's a theory that some ACPI table isn't mapped, but
>> looking through the discussion so far I don't see a smoking gun.  Let's
>> say the kernel has a bug and the kernel was actively not mapping
>> something that it should have mapped.  The oversized 1GB mappings made
>> the bug harder to hit.  If that's the case, we'll just be adding a hack
>> which papers over the bug instead of fixing it properly.
>>
>> I'm kind of leaning to say that we should just revert d794734c9bbf and
>> have the UV folks go back to the nogbpages until we get this properly
>> sorted.
> 
> That is exactly what this patch does.  It reverts the change except
> on UV systems.

Maybe it's splitting hairs, but I see a difference between reverting the
_commit_ and adding new code that tries to revert the commit's behavior.

I think reverting the commit is more conservative and that's what I was
referring to.

>>> @@ -10,6 +10,7 @@ struct x86_mapping_info {
>>>  	unsigned long page_flag;	 /* page flag for PMD or PUD entry */
>>>  	unsigned long offset;		 /* ident mapping offset */
>>>  	bool direct_gbpages;		 /* PUD level 1GB page support */
>>> +	bool direct_gbpages_always;	 /* use 1GB pages exclusively */
>>>  	unsigned long kernpg_flag;	 /* kernel pagetable flag override */
>>>  };
>>
>> But let's at least talk about this patch in case we decide to go forward
>> with it.  We've really got two things:
>>
>> 1. Can the system use gbpages in the first place?
>> 2. Do the gbpages need to be exact (UV) or sloppy (everything else)?
>>
>> I wouldn't refer to this at all as "always" use gbpages.  It's really a
>> be-sloppy-and-paper-over-bugs mode.  They might be kernel bugs or
>> firmware bugs, but they're bugs _somewhere_ right?
> 
> Is it?
> 
> As far as I can tell the UV mode is be exact and avoid cpu bugs mode.

The fact is that there are parts of the physical address space that have
read side effects.  If you want to have them mapped, you need to use a
mapping type where speculative accesses won't occur (like UC).

I don't really think these are CPU bugs.  They're just a fact of life.

> My sense is that using GB pages for everything (when we want an identity
> mapping) should be much cheaper TLB wise, so we probably want to use GB
> pages for everything if we can.

Sure.  But the "if we can" situation is where the physical address space
is uniform underneath that GB page.

It's not at all uncommon to have those goofy, undesirable read
side-effects.  We've had several issues around them over the years.  You
really can't just map random physical memory and hope for the best.

That means that you are limited to mapping memory that you *know* is
uniform, like "all RAM" or "all PMEM".

