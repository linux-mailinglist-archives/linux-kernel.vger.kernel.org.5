Return-Path: <linux-kernel+bounces-110413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA5E885EE2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DCE71F22A2C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279E113777B;
	Thu, 21 Mar 2024 16:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vIULKn7g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yQGTe0bF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB4B137759;
	Thu, 21 Mar 2024 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039775; cv=none; b=JyNSXYQVroxwgR9rWQDcImpLfQwiKYBe1aZYvC2JD31Pfg6UtzByDJPxQv2s3+7Alg4SM9nl2LSLeTsT2iMXYJLIwMnH84vUUzIxS2WnVEqhNpflU9OqDv//uDV3zWnGG9rssiLL1Djb9YcfLqN1z8BIMhg51P8X5kaqyvwI4oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039775; c=relaxed/simple;
	bh=DNdeAKw7uELy4zMBalpWTXvLgNXIKhXj6p88O9pPK+A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G+ZQR8S1YLjILy2vDfYmV5aBjqL4e3gk78gn5ZXX8stIHPHF4eVmIdD0mj+DIF2Kfn6ccfseChId6+EzPJSqq5yESUKqqtE70sKLa/NKkyGCGcehDAIGk3YmCJj8aT3lPinNf3LR2JcmqoLGW4VRIMGeFbjpqg0zOxtKGm38fJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vIULKn7g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yQGTe0bF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711039770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pRTKoYKpDL9uP3VmcYe9zAlkKfXwqveFCpdlfcoPKqY=;
	b=vIULKn7gGYUlHYUr5NGRuXsOBuv2sYqRHn1ixq/RV7f1SFRJlb8IBLu4m5KosJ3fG+k8xM
	B9ZXsnqQnFOj859bZUXT8IrxRxNlIrvl/Nj/RJAkkb0FA/3L3l/JiZ+XeWQi43t5wkz8/Y
	VrzJSvH5LahtIpx2ygq5wnY3Uo+JCN+lO3seergnxOdlS2fQLdNEylFSJW+WJaxqyiIudQ
	3pX1esf5oJuLmUpSdVqiezb0Y0ep3islMEBlGY2CTCgVer8QNXO/FqaZd+9da8EBsGvZFp
	4VGbkU/3f+9gwvrbFyuCa++KTn+yKxa5Vdth24ZIs1AtdXU07vN/isGsuyH2kQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711039770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pRTKoYKpDL9uP3VmcYe9zAlkKfXwqveFCpdlfcoPKqY=;
	b=yQGTe0bFW9Vrf8XcmSDjcK4H4swmy/xSLqKu7PgW82bS5G5ATik3xigt0icjawEUzYWKwk
	jwVAAQZdJ/N6IUCg==
To: Guenter Roeck <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Linus Torvalds
 <torvalds@linuxfoundation.org>, Uros Bizjak <ubizjak@gmail.com>,
 linux-sparse@vger.kernel.org, lkp@intel.com, oe-kbuild-all@lists.linux.dev
Subject: Re: [patch 5/9] x86: Cure per CPU madness on UP
In-Reply-To: <86796005-f1d9-4c8c-80d8-f1f88ca220ba@roeck-us.net>
References: <20240303235029.555787150@linutronix.de>
 <20240304005104.622511517@linutronix.de>
 <e20d88d0-5fb9-4307-be67-88b04ae9a188@roeck-us.net> <87bk79i8km.ffs@tglx>
 <d51ec9a1-5221-4005-9980-8258df8b5102@roeck-us.net> <87r0g3hm5o.ffs@tglx>
 <86796005-f1d9-4c8c-80d8-f1f88ca220ba@roeck-us.net>
Date: Thu, 21 Mar 2024 17:49:30 +0100
Message-ID: <87il1fh6n9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Mar 21 2024 at 07:06, Guenter Roeck wrote:
> On 3/21/24 04:14, Thomas Gleixner wrote:
>> If so can you please provide a full dmesg and then apply the patch below
>> and provide the resulting full dmesg too?
>
> You'll find everything at http://server.roeck-us.net/qemu/x86-nosmp/

Thanks for providing this.

> The crash is gone after applying your patch. The difference is:
>
> +       /*
> +        * If there was no APIC registered, then the map check below would
> +        * fail. With no APIC this is guaranteed to be an UP system and
> +        * therefore all topology levels have only one entry and their
> +        * logical ID is obviously 0.
> +        */
> +       if (topo_info.boot_cpu_apic_id == BAD_APICID) {
> +               pr_info("#### topo_info.boot_cpu_apic_id == BAD_APICID\n");
>                  ^^^^ I added this
> +               return 0;
> +       }
> +
>
> I see the "#### topo_info.boot_cpu_apic_id == BAD_APICID" message
> twice in the log. See patched.log at the page pointed to above.

I can see why this is emitted. That happens on the initial CPUID
evaluation of the boot CPU very early during boot.

[    0.000000] Command line: console=ttyS0
[    0.000000] CPU topo: APIC logical ID: 0 0 6
[    0.000000] CPU topo: #### topo_info.boot_cpu_apic_id == BAD_APICID
[    0.000000] CPU topo: APIC logical ID: 0 0 4
[    0.000000] CPU topo: #### topo_info.boot_cpu_apic_id == BAD_APICID

The later full CPUID evaluation happens after the ACPI enumeration and
way before the affected RAPL driver is initialized:

[    0.088029] CPU topo: APIC logical ID: 0 0 6
[    0.088084] CPU topo: APIC logical ID: 0 0 4

This invocation has the boot APIC registered as your extra print does
not show up.

..

[    0.585850] RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters, 10737418240 ms ovfl timer

So even without that guard (which we need anyway for the non APIC case)
topology_logical_die_id() == cpu_data(cpu).topo.logical_die_id must have
the correct value in that RAPL initialization and CPU hotplug callback
code.

But our absolutely convoluted startup logic prevents that because:

    identify_cpu_early()      operates on boot_cpu_data
    smp_prepare_boot_cpu()    copies boot_cpu_data to per CPU cpu data
    identify_boot_cpu()       operates on boot_cpu_data

identify_boot_cpu() is the one which gets the correct logical die info,
but that never gets copied over to the per CPU data instance on which
the RAPL code and everything else works on.

I'll cook up a patch later.

Thanks for providing the info!

       tglx


