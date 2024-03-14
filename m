Return-Path: <linux-kernel+bounces-103343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 482AA87BE54
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 051AC28464C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399A06F53E;
	Thu, 14 Mar 2024 14:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="p3mjRBYP"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98C66F06D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710425075; cv=none; b=H4P6MzAJ8w62qKaqVQqp+CxlTxF6qs7/DKvCUEiRlhJZ610yCC5hqOl+3m7khdX00SZ0mFnPqfLSLzdOQFEIxc66GZFVcAG6rFcc3zoWT4lWkddRweQSJDpfOwF2ZqlOGf6OjaqHu/FfdaOEAi+bo2A858eA9ESTLpDHag9QMBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710425075; c=relaxed/simple;
	bh=Hmgq8CAaz4Ke0Zq2nDCvEYSHRExJjsASTSq1J5x5BSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkwWG59yzCNfBNkETtHsUH1NKfhRkqN2DSt2Mv5kUOS7b+MPzP2D+8ccfLHwO3rIECQGlDKTnfENJgK3ErYUfDu/LXcDskQvW0yw9CkqoRxlFLVl3/wyfHoZMgGswRL/HWqJdCvb9LS3LsUn7LPPI1hmMy0hdL4NmoAQe6M6PJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=p3mjRBYP; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42ee2012bf0so7588361cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710425072; x=1711029872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hmgq8CAaz4Ke0Zq2nDCvEYSHRExJjsASTSq1J5x5BSo=;
        b=p3mjRBYPhLUUdYAypUwm0kLzF2CS5qINen/EX/lmllYe9fBAJ2vTsLPa+uRR4ljjeU
         trgDMBeXsw64talNInyxsNzE4tWpPNXRgnuleARZnPCg4q81rBSI7Cd77bN/i+p5kmaI
         sFG9S/mOkegctQwCXe5YAszyB995JRLFMKEb+AOMDyYGAE41LOpfBZG6r1pff2JmyZEl
         XCorfQqMDbE0T9d6fJyuKBAZMiqt5CBDmr8r9HdW+riytbPFuue+iMIlGIiFlUq03RzR
         PTjPV0H5tmI4a2VHxjXyJBZIRtb5z3vGLMZQB2TBzLeKEGE1+eZJfxUjlcOD2Fip/590
         iqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710425072; x=1711029872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hmgq8CAaz4Ke0Zq2nDCvEYSHRExJjsASTSq1J5x5BSo=;
        b=k4KOkmlv19zl3L33zFMcbaBxhofx7gTvr4ydVONTvFIeJA1gGDseEwnbGQDrMdy6ip
         JVAOP3SbErqP8cOoeVapSmAuRGX+0C+hl+SKaOkhI9Vw3DywflXwbihU0gAzv/9CtQi1
         aEPUfVtofzmcDkfdVExD3iFbAJpay+NCNP/PWJ/KtwoPAcBa8ol+PsffTEsi5yV07D8w
         KAkrlqlVx6LWFOJOppemhGhj3DKeLvn9tz4qSxpn2S9x6Knx79ql9fLEVNmjeZl7BJ5J
         IYnjCiqe05UFSbSITzEaKhy6dc960GxHnuowSIBdGRsvTK1sLTAfSnITTUjTQ3WSsVlx
         l2nQ==
X-Gm-Message-State: AOJu0YzQEmSUFYsIaE5y47n4SZFWDPvkndRs/Rw291cDIxx/RQyTB4he
	fxmiZ9DlXYGzFkFJbVwcOaqqEhZzKJVB/imFJ6NBrnSb+nNFXHkrtg7+9GqiTC9qSVz5E65sJld
	1sF32tMhgKTKUv9975qZema2pEHbDiv+OzgVVhQ==
X-Google-Smtp-Source: AGHT+IF1WiEU4N3Z6Uqdf3j6rNjBbma5Y0Jff1HtPv863Egdopl6dhLMAJDdICC3crqwRhHV2ZHM33uBwxoDyrFBoss=
X-Received: by 2002:a05:622a:1816:b0:42e:db75:3cf9 with SMTP id
 t22-20020a05622a181600b0042edb753cf9mr8873826qtc.27.1710425072462; Thu, 14
 Mar 2024 07:04:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <20240311164638.2015063-12-pasha.tatashin@soleen.com> <87v85qo2fj.ffs@tglx>
 <CA+CK2bBgeK=rW3=RJSx8zxST8xnJ-VXSSYmKPVK9gHX3pxEWuQ@mail.gmail.com>
 <CA+CK2bAzJuCe06g_TEOh3B-hK+dXfUaGaOSTgzyxkN4zqpSU_A@mail.gmail.com> <87bk7inmah.ffs@tglx>
In-Reply-To: <87bk7inmah.ffs@tglx>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 14 Mar 2024 10:03:55 -0400
Message-ID: <CA+CK2bC=6GOkCOwJdhH25r-9hb1BQVoLK7LLAgpm2AKqdmStrg@mail.gmail.com>
Subject: Re: [RFC 11/14] x86: add support for Dynamic Kernel Stacks
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, x86@kernel.org, bp@alien8.de, brauner@kernel.org, 
	bristot@redhat.com, bsegall@google.com, dave.hansen@linux.intel.com, 
	dianders@chromium.org, dietmar.eggemann@arm.com, eric.devolder@oracle.com, 
	hca@linux.ibm.com, hch@infradead.org, hpa@zytor.com, 
	jacob.jun.pan@linux.intel.com, jgg@ziepe.ca, jpoimboe@kernel.org, 
	jroedel@suse.de, juri.lelli@redhat.com, kent.overstreet@linux.dev, 
	kinseyho@google.com, kirill.shutemov@linux.intel.com, lstoakes@gmail.com, 
	luto@kernel.org, mgorman@suse.de, mic@digikod.net, 
	michael.christie@oracle.com, mingo@redhat.com, mjguzik@gmail.com, 
	mst@redhat.com, npiggin@gmail.com, peterz@infradead.org, pmladek@suse.com, 
	rick.p.edgecombe@intel.com, rostedt@goodmis.org, surenb@google.com, 
	urezki@gmail.com, vincent.guittot@linaro.org, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 12:12=E2=80=AFPM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> On Wed, Mar 13 2024 at 11:28, Pasha Tatashin wrote:
> > On Wed, Mar 13, 2024 at 9:43=E2=80=AFAM Pasha Tatashin
> > <pasha.tatashin@soleen.com> wrote:
> >> Here's a potential solution that is fast, avoids locking, and ensures =
atomicity:
> >>
> >> 1. Kernel Stack VA Space
> >> Dedicate a virtual address range ([KSTACK_START_VA - KSTACK_END_VA])
> >> exclusively for kernel stacks. This simplifies validation of faulting
> >> addresses to be part of a stack.
> >>
> >> 2. Finding the faulty task
> >> - Use ALIGN(fault_address, THREAD_SIZE) to calculate the end of the
> >> topmost stack page (since stack addresses are aligned to THREAD_SIZE).
> >> - Store the task_struct pointer as the last word on this topmost page,
> >> that is always present as it is a pre-allcated stack page.
> >>
> >> 3. Stack Padding
> >> Increase padding to 8 bytes on x86_64 (TOP_OF_KERNEL_STACK_PADDING 8)
> >> to accommodate the task_struct pointer.
> >
> > Alternatively, do not even look-up the task_struct in
> > dynamic_stack_fault(), but only install the mapping to the faulting
> > address, store va in the per-cpu array, and handle the rest in
> > dynamic_stack() during context switching. At that time spin locks can
> > be taken, and we can do a find_vm_area(addr) call.
> >
> > This way, we would not need to modify TOP_OF_KERNEL_STACK_PADDING to
> > keep task_struct in there.
>
> Why not simply doing the 'current' update right next to the stack
> switching in __switch_to_asm() which has no way of faulting.
>
> That needs to validate whether anything uses current between the stack
> switch and the place where current is updated today. I think nothing
> should do so, but I would not be surprised either if it would be the
> case. Such code would already today just work by chance I think,
>
> That should not be hard to analyze and fixup if necessary.
>
> So that's fixable, but I'm not really convinced that all of this is safe
> and correct under all circumstances. That needs a lot more analysis than
> just the trivial one I did for switch_to().

Agreed, if the current task pointer can be switched later, after loads
and stores to the stack, that would be a better solution. I will
incorporate this approach into my next version.

I also concur that this proposal necessitates more rigorous analysis.
This work remains in the investigative phase, where I am seeking a
viable solution to the problem.

The core issue is that kernel stacks consume excessive memory for
certain workloads. However, we cannot simply reduce their size, as
this leads to machine crashes in the infrequent instances where stacks
do run deep.

Thanks,
Pasha

