Return-Path: <linux-kernel+bounces-103665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 986CF87C29E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32175B21D2A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A7374BFE;
	Thu, 14 Mar 2024 18:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vGhQHSyC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yuhs32qs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8F31A38D0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 18:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710440775; cv=none; b=DcALtWugWDF+bHpU2owTzHkvD2wzZ05QPmwObi5XI9XCI755ROdYao+AWzPyiub8wNorhJpkjIIUANJMITIB2DH5upLJLmnzQrrkhKpF4sP345xWZ9Wjq1BaU3ZBziDFY7eRo/BXIcYAZKDKtIdkv72MiJ5csh5q3ds85AHf7Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710440775; c=relaxed/simple;
	bh=osRkPii/Ul1NhhSqCxFUuSOok2Fv+oo6eZSyDcMKXjU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CKMb5POuOBTokNz8Kg5xmZfEkTDlQOMU4F5sK9IrmmW5gz24/jAaur8MjaJrXr0DFZ90f6bRd+FKPTyhmQ6nrOaROaUN9E+x5FMvm8NZSOM/bPGziHgeoX+WHkrbKY3bypKoj5Cn8Hpp/oKk8xSltP6chqEInvfTBQjPg54WrMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vGhQHSyC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yuhs32qs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710440769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OT14uNtw6W0ZjCQ33RZUVgtWubWcRnNaxohmLkNQdCc=;
	b=vGhQHSyCkQ0VUh5HYVjZVY8hylof6whCFJs79bZ5Lt0/fTGSh3dZ5z3y/GoxFxfehu8CSz
	bqRZgCKXGr0xSC9T4RmgKrT1ivs81KeAQ/ZVpbZWG6rV3bx62N/RtzgElCySvi62plzY0v
	JH0Q1trQw1LjwKaQv3gwl++w4PGKCFm3zXOH8FOkSWJ8cDx3JMkfjZUFW46hiLM7f/Jldk
	jqBq1Ugk5W1v5VpUB7Butgr1eWGtfIo9/kQo5T99WvhjvG1DNXWv/tudj9xFRf2qtUwHix
	r8ZtYQ9pmB4y12/mjXhaYV8CCNBPYcrD35j6DO5dkkg5Z7NfMM1CiJG+cbgS9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710440769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OT14uNtw6W0ZjCQ33RZUVgtWubWcRnNaxohmLkNQdCc=;
	b=yuhs32qsRTZnBHrQkpPUXoqiyigddgGgWFc3xDguGV11mBHpyuFVQtHxsHdAzZXLBoTCDl
	UPdtLeS1DC9pP0AQ==
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
In-Reply-To: <CA+CK2bC=6GOkCOwJdhH25r-9hb1BQVoLK7LLAgpm2AKqdmStrg@mail.gmail.com>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <20240311164638.2015063-12-pasha.tatashin@soleen.com>
 <87v85qo2fj.ffs@tglx>
 <CA+CK2bBgeK=rW3=RJSx8zxST8xnJ-VXSSYmKPVK9gHX3pxEWuQ@mail.gmail.com>
 <CA+CK2bAzJuCe06g_TEOh3B-hK+dXfUaGaOSTgzyxkN4zqpSU_A@mail.gmail.com>
 <87bk7inmah.ffs@tglx>
 <CA+CK2bC=6GOkCOwJdhH25r-9hb1BQVoLK7LLAgpm2AKqdmStrg@mail.gmail.com>
Date: Thu, 14 Mar 2024 19:26:09 +0100
Message-ID: <871q8cmzzy.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14 2024 at 10:03, Pasha Tatashin wrote:
> On Wed, Mar 13, 2024 at 12:12=E2=80=AFPM Thomas Gleixner <tglx@linutronix=
de> wrote:
>> That needs to validate whether anything uses current between the stack
>> switch and the place where current is updated today. I think nothing
>> should do so, but I would not be surprised either if it would be the
>> case. Such code would already today just work by chance I think,
>>
>> That should not be hard to analyze and fixup if necessary.
>>
>> So that's fixable, but I'm not really convinced that all of this is safe
>> and correct under all circumstances. That needs a lot more analysis than
>> just the trivial one I did for switch_to().
>
> Agreed, if the current task pointer can be switched later, after loads
> and stores to the stack, that would be a better solution. I will
> incorporate this approach into my next version.

No. You need to ensure that there is neither a load or store on the
stack between:

        movq    %rsp, TASK_threadsp(%rdi)
        movq    TASK_threadsp(%rsi), %rsp

and update_current(). IOW, you need to move the update of
pcpu_hot.current to ASM right after the RSP switch.

> I also concur that this proposal necessitates more rigorous analysis.

Glad we agree here :)

Thanks,

        tglx

