Return-Path: <linux-kernel+bounces-101717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0511387AAF3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4780281576
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF7A482EE;
	Wed, 13 Mar 2024 16:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uxeIdiLT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yjeooXvy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FD947A6F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710346348; cv=none; b=ZP5EfRC4in3p/7hYLUtf4Pwm2Y0ldlYVOe6/rQ/zFQoWcLSPkpCWsoUnn9NH6UwJSIbIM2wyC8kDufN8/Gy7xQHAu6VUiWJLuSL9EACoxqS8BDzEQnsLzU6/icZNOUhYQo5jpunl/LF3vSEfYPfdlProVulJVP8m3xi7Rs9mAf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710346348; c=relaxed/simple;
	bh=qwbK5/S7vYbbhHeQ/u/hwshLHnXQkLbIYmk7RsWVsm0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DRSIvHSzjW3ZzzqnP9YhO6Bsnzm+MJ3M5f8It+jC8ib7y2NM40ifRgZHWKv3xTFH9QkGwZapGcgUPv7Zhrqvqb0gINSV1R2gD5vOlya9GYOSPuUVqE+Ol3XwNvPzYsAxcEp77Vp6T52y3tYBHH1glzo6x3KuMpbr7brzsNxofNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uxeIdiLT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yjeooXvy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710346343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ASMOFY2sHU4OyVeGqn7miLbsJxTIjNV+5Rjhy3Yhwt8=;
	b=uxeIdiLTBehtjVMz8KjE1Nc2jouZX5CS5uE5zfYl0LBe1P2LmwXbd5CiYggMdxt9esUxhH
	jq5Ct5lERrSu7Gk7E+1ezzIHfvCptt8/i5JiDNokOpTgVQtEGvJ8ySbUIQDWeflywEk1Z9
	BrVR6oGlEq8vheF+fer4luM0E+HXgiGn7g5AXCeTip6/hakrSotVG59VPL5mkBiJ5BHaTI
	XAyMF7yJX275e1tl9pcqbPFv+wNua/EbFmG2vecK00tNIgnr3ou8EYwBOq0j7RfFs/j30e
	UcVmqaBO1eMFvgJxj3NqUteStfu4hHQZTNRenxxdjFt6n4Gt/Ooq2JnXysW4BA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710346343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ASMOFY2sHU4OyVeGqn7miLbsJxTIjNV+5Rjhy3Yhwt8=;
	b=yjeooXvyK1MtxUh1k6wG7KADFqd04eTFHuGgg08pp6BfDI4+3bz+UO7KKP8kHyHCSXO3dv
	/A5skhfMOJTzGsCA==
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 akpm@linux-foundation.org, x86@kernel.org, bp@alien8.de,
 brauner@kernel.org, bristot@redhat.com, bsegall@google.com,
 dave.hansen@linux.intel.com, dianders@chromium.org,
 dietmar.eggemann@arm.com, eric.devolder@oracle.com, hca@linux.ibm.com,
 hch@infradead.org, hpa@zytor.com, jacob.jun.pan@linux.intel.com,
 jgg@ziepe.ca, jpoimboe@kernel.org, jroedel@suse.de, juri.lelli@redhat.com,
 kent.overstreet@linux.dev, kinseyho@google.com,
 kirill.shutemov@linux.intel.com, lstoakes@gmail.com, luto@kernel.org,
 mgorman@suse.de, mic@digikod.net, michael.christie@oracle.com,
 mingo@redhat.com, mjguzik@gmail.com, mst@redhat.com, npiggin@gmail.com,
 peterz@infradead.org, pmladek@suse.com, rick.p.edgecombe@intel.com,
 rostedt@goodmis.org, surenb@google.com, urezki@gmail.com,
 vincent.guittot@linaro.org, vschneid@redhat.com
Subject: Re: [RFC 11/14] x86: add support for Dynamic Kernel Stacks
In-Reply-To: <CA+CK2bAzJuCe06g_TEOh3B-hK+dXfUaGaOSTgzyxkN4zqpSU_A@mail.gmail.com>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <20240311164638.2015063-12-pasha.tatashin@soleen.com>
 <87v85qo2fj.ffs@tglx>
 <CA+CK2bBgeK=rW3=RJSx8zxST8xnJ-VXSSYmKPVK9gHX3pxEWuQ@mail.gmail.com>
 <CA+CK2bAzJuCe06g_TEOh3B-hK+dXfUaGaOSTgzyxkN4zqpSU_A@mail.gmail.com>
Date: Wed, 13 Mar 2024 17:12:22 +0100
Message-ID: <87bk7inmah.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13 2024 at 11:28, Pasha Tatashin wrote:
> On Wed, Mar 13, 2024 at 9:43=E2=80=AFAM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
>> Here's a potential solution that is fast, avoids locking, and ensures at=
omicity:
>>
>> 1. Kernel Stack VA Space
>> Dedicate a virtual address range ([KSTACK_START_VA - KSTACK_END_VA])
>> exclusively for kernel stacks. This simplifies validation of faulting
>> addresses to be part of a stack.
>>
>> 2. Finding the faulty task
>> - Use ALIGN(fault_address, THREAD_SIZE) to calculate the end of the
>> topmost stack page (since stack addresses are aligned to THREAD_SIZE).
>> - Store the task_struct pointer as the last word on this topmost page,
>> that is always present as it is a pre-allcated stack page.
>>
>> 3. Stack Padding
>> Increase padding to 8 bytes on x86_64 (TOP_OF_KERNEL_STACK_PADDING 8)
>> to accommodate the task_struct pointer.
>
> Alternatively, do not even look-up the task_struct in
> dynamic_stack_fault(), but only install the mapping to the faulting
> address, store va in the per-cpu array, and handle the rest in
> dynamic_stack() during context switching. At that time spin locks can
> be taken, and we can do a find_vm_area(addr) call.
>
> This way, we would not need to modify TOP_OF_KERNEL_STACK_PADDING to
> keep task_struct in there.

Why not simply doing the 'current' update right next to the stack
switching in __switch_to_asm() which has no way of faulting.

That needs to validate whether anything uses current between the stack
switch and the place where current is updated today. I think nothing
should do so, but I would not be surprised either if it would be the
case. Such code would already today just work by chance I think,

That should not be hard to analyze and fixup if necessary.

So that's fixable, but I'm not really convinced that all of this is safe
and correct under all circumstances. That needs a lot more analysis than
just the trivial one I did for switch_to().

Thanks,

        tglx

