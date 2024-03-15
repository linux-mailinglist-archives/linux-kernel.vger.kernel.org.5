Return-Path: <linux-kernel+bounces-104990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BADE787D758
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 00:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701A91F22AEC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE8F5B5B5;
	Fri, 15 Mar 2024 23:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xbiZUZgA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DYaRuyOC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0185B5A3
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 23:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710545556; cv=none; b=UANFh+JQR31qeBC0lo1IXPiFTYW3hxkydVfa3sbG4iGhMUqBy+DdCQWJCnz4bBege08YMKT8oWXKXEBhbcpMGgZO6vbda1M1hS9cQMJ50WW+pEPBiRj1JTtzY1dw8JzHi94mtwkiEEly8/pq9UVofCqEQ+2rZZhu1sFY6xssb/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710545556; c=relaxed/simple;
	bh=wGgLZfe1j8aEsI9BnVlU1qpcetPVIoO4qooYMmIQkb4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YWoUU5EwjnQlTwO1M71MfvFJiohKIbcEuY63ldjM+uTYnpam1cp3z8okdrAsBSa+gF/FI+mTAmcPgwDJeNDZflv+SpqSJlrDdtYsfzMlIeh2hU6UdNCALvIa/2TUzY7o0llLk4CpvbrKFJv7Nm6koY5CMzrM7erKTmh6V8CwFtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xbiZUZgA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DYaRuyOC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710545551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hPsi4ru9qiFSnbt3zUsnb9Vb/ug0QoonRw6BPPhMcuU=;
	b=xbiZUZgA+s18fxpr3n+2SL7/xrrjvmrCkmAIlAQwvDq2u108IP3iiKIQwMXknbvTJjX2+M
	t/G8yK3YdqJWHfKOAXOxqPhgHDbPEhp7QOT4vqm6kbSQWzL+iXec96N0PBYEIUYELT/qBN
	d3Dnh9ps3eK+woLggfvp8SmVOaf9mOa5eMXlKdZL08caP5Eqir/ZTp1Ja+6i4WfkeZ6jgR
	noB8AEVi2bCfaqVkvKHwvYBCtlPWmmnPxXr1/jQsv0tZtxN1i5UJaKs0+MDz/gWK+LPJac
	Jg0Ywrw4aPORAw8hDyxnk3s/DO8u1krPbdjdZIfV6/UiuFuf1g1pVwqzuTG/EA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710545551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hPsi4ru9qiFSnbt3zUsnb9Vb/ug0QoonRw6BPPhMcuU=;
	b=DYaRuyOC+tq4sfn8PNpPkF5sckrjbF+GXQJnqDaT6rzRea0PYHg+OF+flZXQDStJssLTnV
	LXpTkdB1SpyTc0DQ==
To: Reinette Chatre <reinette.chatre@intel.com>, Rex Nie
 <rex.nie@jaguarmicro.com>, james.morse@arm.com, "x86@kernel.org"
 <x86@kernel.org>, "Luck, Tony" <tony.luck@intel.com>, Babu Moger
 <babu.moger@amd.com>, Peter Newman <peternewman@google.com>, Borislav
 Petkov <bp@alien8.de>
Cc: fenghua.yu@intel.com, ilpo.jarvinen@linux.intel.com,
 linux-kernel@vger.kernel.org
Subject: Re: 32bit resctrl? (was Re: [PATCH v2] fs/resctrl: fix domid loss
 precision issue)
In-Reply-To: <fed6affb-c7f4-4992-8646-8f5a52c33966@intel.com>
References: <20240312075349.977-1-rex.nie@jaguarmicro.com>
 <fed6affb-c7f4-4992-8646-8f5a52c33966@intel.com>
Date: Sat, 16 Mar 2024 00:32:31 +0100
Message-ID: <87jzm3jckw.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Mar 14 2024 at 08:25, Reinette Chatre wrote:
>> On some platforms(e.g.,x86), the max cache_id is the amount of L3 caches,
>> so it is not in the range of 0x3fff. But some platforms use higher
>> cache_id, e.g., arm uses cache_id as locator for cache MSC. This will
>> cause below issue if cache_id > 0x3fff likes:
>> /sys/fs/resctrl/mon_groups/p1/mon_data/mon_L3_1048564 # cat llc_occupancy
>> cat: read error: No such file or directory
>> 
>> This is the call trace when cat llc_occupancy:
>> rdtgroup_mondata_show()
>> 	domid = md.u.domid
>> 	d = resctrl_arch_find_domain(r, domid)
>> 
>> d is null here because of lossing precision
>> 
>> Signed-off-by: Rex Nie <rex.nie@jaguarmicro.com>
>> ---
>>  fs/resctrl/internal.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
>> index 7a6f46b4edd0..096317610949 100644
>> --- a/fs/resctrl/internal.h
>> +++ b/fs/resctrl/internal.h
>> @@ -94,7 +94,7 @@ union mon_data_bits {
>>  	struct {
>>  		unsigned int rid		: 10;
>>  		enum resctrl_event_id evtid	: 8;
>> -		unsigned int domid		: 14;
>> +		u32				domid;
>>  	} u;
>>  };
>>  
>
> resctrl currently supports 32bit builds. Fixing this issue* in this way
> would first require that resctrl (the architecture independent fs part)
> depend on X86_64. Is this a change that everybody will be comfortable
> with?

Why? Making mon_data_bits::u larger in the way it has been done does not
have any dependency on 32 or 64 builds unless I'm missing something.

> (Of course, there are other solutions available to address the issue mentioned
> in this patch that do not require depending on X86_64, but I would like
> to take this moment to understand the sentiment surrounding continuing support
> for 32bit resctrl.)

Caring about 32biit resctrl on x86 is a pointless exercise.

Thanks,

        tglx

