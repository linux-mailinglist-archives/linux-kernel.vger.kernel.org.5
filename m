Return-Path: <linux-kernel+bounces-61839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A2985174B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9B1C1F21B93
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC2B3B794;
	Mon, 12 Feb 2024 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y06efXCx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jZa/qDW/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67763B2A2
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707749410; cv=none; b=dJBa8wPp7MjMTtW2YAltW/FIBEEmO6OZ66PcMlFffuaeFo3HtK0+TTjxzxPJy0AzOAeIFV1KJfL6HYPO4YmFNnu2Yu6jAqKsB6Y8ImyW5T/nFurpw4mPSMUBxi/RstajBc41R4calg5vkwiRBiCA3bU1CxKj//GwqzT/VB5Px0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707749410; c=relaxed/simple;
	bh=FB4YzGxesZ1Hb/39/+XOurT2KV2CbVkG19sH0Wio5+U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GdRXrdW/jgzvAEdYey5QQej+yx2LY7EbyAQ7yF//nIdRDBsFOeG1W6S3Hoa11dJoN6X87VkZmodx+TQJl7EiYcdKjsHfkhB+gPJJUgiM1vRQTRFwku3v7z00Sczq+DwAyO0yMvFYbMRaNJ71Gxeo7oHydrG9/y0Zobi7TGc9VM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y06efXCx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jZa/qDW/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707749404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1+6KCrT2mSKGO1AMbFuzh4cWwf6OZ2ECUnZnbKsA5UM=;
	b=Y06efXCxqXb2P1dOZfB76pIs3h121vxoCKRENhcwh1ZnfuZXj3Qe9Xv9XNTJ2Lh5aKjWak
	MgpGQRaaECIDXhDriSqYjdpXYneWphcQ0/xKE0Pgt1EyPrU4JoBmB3i23wAgY1OeOCathN
	2vST+3SkRPLK/51EvMb51amcy+k/rFag88mrtsXOMB+xH0bNzGld5gGs/VSdqlnStg8JNc
	6JN/IOnl0mc7rl8VymGifutt8bTC//Zx+W0LIpSBaZO4D4CI48VRRfkovXUbutvP7jkLND
	mf8VXexz7SmTBBmRW9jyvpfHbnoEV8radgt+RiiyEg+oBpkCDSjni1FyVA4eIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707749404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1+6KCrT2mSKGO1AMbFuzh4cWwf6OZ2ECUnZnbKsA5UM=;
	b=jZa/qDW/Gp70I9S/6DOp8u7ZzDl+mdgo7P0ji6RJHACgvUSUMV1gK37GVEurjRv683tnIh
	ZnMMfBwaWXn0MzDw==
To: Borislav Petkov <bp@alien8.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Tom Lendacky
 <thomas.lendacky@amd.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 Arjan van de Ven <arjan@linux.intel.com>, Huang Rui <ray.huang@amd.com>,
 Juergen Gross <jgross@suse.com>, Dimitri Sivanich
 <dimitri.sivanich@hpe.com>, Sohil Mehta <sohil.mehta@intel.com>, K Prateek
 Nayak <kprateek.nayak@amd.com>, Kan Liang <kan.liang@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Feng Tang <feng.tang@intel.com>, Andy Shevchenko <andy@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>, "Peter Zijlstra (Intel)"
 <peterz@infradead.org>
Subject: Re: [patch v5 11/19] x86/cpu: Use common topology code for AMD
In-Reply-To: <20240206155830.GPZcJXJkOv8NOtIfHi@fat_crate.local>
References: <20240117115752.863482697@linutronix.de>
 <20240117115909.011311608@linutronix.de>
 <20240206155830.GPZcJXJkOv8NOtIfHi@fat_crate.local>
Date: Mon, 12 Feb 2024 15:50:04 +0100
Message-ID: <87cyt1lotf.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 06 2024 at 16:58, Borislav Petkov wrote:
> On Tue, Jan 23, 2024 at 01:53:47PM +0100, Thomas Gleixner wrote:
>> --- a/arch/x86/kernel/cpu/mce/inject.c
>> +++ b/arch/x86/kernel/cpu/mce/inject.c
>> @@ -433,8 +433,7 @@ static u32 get_nbc_for_node(int node_id)
>>  	struct cpuinfo_x86 *c = &boot_cpu_data;
>>  	u32 cores_per_node;
>>  
>> -	cores_per_node = (c->x86_max_cores * smp_num_siblings) / amd_get_nodes_per_socket();
>> -
>> +	cores_per_node = (c->x86_max_cores * smp_num_siblings) / topology_amd_nodes_per_pkg();
>>  	return cores_per_node * node_id;
>>  }
>
> One more hunk depending on what goes in when and in what order, to fix
> a build issue from the RAS tree:
>
> ERROR: modpost: "amd_get_nodes_per_socket" [drivers/ras/amd/atl/amd_atl.ko] undefined!
> make[2]: *** [scripts/Makefile.modpost:145: Module.symvers] Error 1
> make[1]: *** [/mnt/kernel/kernel/2nd/linux/Makefile:1873: modpost] Error 2
> make: *** [Makefile:240: __sub-make] Error 2

Hrm. That is unfortunate, but we really don't want to mix the RAS
tree. So this needs a fixup in next and in the pull requests.

