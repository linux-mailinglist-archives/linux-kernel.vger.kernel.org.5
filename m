Return-Path: <linux-kernel+bounces-111379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0246886B80
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65B81285FAB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514973F9F9;
	Fri, 22 Mar 2024 11:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="PO68oDHX"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D243EA73
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 11:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711108104; cv=none; b=BQ29qgRFuhX4UzFaWCKQ9taidw0keQcWZRUuwr+yuTNOSyY/5Ibla2Q+/W9QjA17IRRLcGi0FjPy94UzAsPNu7GYN1faER+sKYLYCmlbRJhizGxGKgs5RYsbdQCpZuMODtqipoFXRCCcfcgii9w7y2g6458OpGIcG4fuoZ+dQbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711108104; c=relaxed/simple;
	bh=weeDT9K7Y6HUDulSoarZnb5GuxaJf2xg5889qw/8vZk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=L5Ua/EYWGoknYr9b2iLOksIZOnU7j1BcJZCSz2Pe60WbtszQuqZZDVeTJnDRLVwzH1wy3IAgpEnUH0I3IYRPE24FEJOhtbsSDQpXmWhqfz6S4hqmXD+HszV/TUr3vzUDJVvfoL0W+HsA0tTQkZ2WfhZYv/KMdxiUcpN6J3jS5wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=PO68oDHX; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 42MBlt4a3433616
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 22 Mar 2024 04:47:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 42MBlt4a3433616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024031401; t=1711108076;
	bh=OtLNc0oX57gAqGdjW3QRgqHA4Lu2KLBpIAXsn5rERmo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=PO68oDHXGWbfI1NUSq/qtxxmDzK793oR7WDbrc1iIZl9rAEtOwNvCd4lUtPPjhbZl
	 DZrmId4mjMFSHHjNBwPpgmibtpZKTxzBJPgtlto9hLNIko1F9W7UhuQHE7yOA9/+gG
	 eQ7sRb6YjJLPoAy3pAokpMXdb3hPLkmzq0jwPOGSVZB1x+zyHkWLz4o188BJE/PZ8e
	 zk6TbDzRhJPBuC1PwvBrG8+6hmby+VYdz1jL5oW3QzcouI/zORBPolDIsytQa4IfkO
	 cXtqm6oteQJpfsk5MG/2SVa37OcOLDmVJxknPpKDOUzPO7xGOO2AVcJLfnnl3BNSNk
	 BQLqo8UC9xL9Q==
Date: Fri, 22 Mar 2024 04:47:51 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
CC: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Xin Li <xin@zytor.com>
Subject: Re: [PATCH] x86/boot: Simplify boot stack setup
User-Agent: K-9 Mail for Android
In-Reply-To: <20240321180506.89030-1-brgerst@gmail.com>
References: <20240321180506.89030-1-brgerst@gmail.com>
Message-ID: <933A5029-7ACC-4261-B2D4-0B76DDE6AF46@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 21, 2024 11:05:06 AM PDT, Brian Gerst <brgerst@gmail=2Ecom> wrote:
>Define the symbol __top_init_kernel_stack instead of duplicating
>the offset from __end_init_task in multiple places=2E
>
>Signed-off-by: Brian Gerst <brgerst@gmail=2Ecom>
>---
> arch/x86/include/asm/processor=2Eh |  6 ++----
> arch/x86/kernel/head_32=2ES        | 11 +----------
> arch/x86/kernel/head_64=2ES        |  2 +-
> arch/x86/kernel/vmlinux=2Elds=2ES    |  3 +++
> arch/x86/xen/xen-head=2ES          |  2 +-
> 5 files changed, 8 insertions(+), 16 deletions(-)
>
>diff --git a/arch/x86/include/asm/processor=2Eh b/arch/x86/include/asm/pr=
ocessor=2Eh
>index 438c0c8f596a=2E=2E89ed5237e79f 100644
>--- a/arch/x86/include/asm/processor=2Eh
>+++ b/arch/x86/include/asm/processor=2Eh
>@@ -636,12 +636,10 @@ static __always_inline void prefetchw(const void *x=
)
> #define KSTK_ESP(task)		(task_pt_regs(task)->sp)
>=20
> #else
>-extern unsigned long __end_init_task[];
>+extern unsigned long __top_init_kernel_stack[];
>=20
> #define INIT_THREAD {							\
>-	=2Esp	=3D (unsigned long)&__end_init_task -			\
>-		  TOP_OF_KERNEL_STACK_PADDING -				\
>-		  sizeof(struct pt_regs),				\
>+	=2Esp	=3D (unsigned long)&__top_init_kernel_stack,		\
> }
>=20
> extern unsigned long KSTK_ESP(struct task_struct *task);
>diff --git a/arch/x86/kernel/head_32=2ES b/arch/x86/kernel/head_32=2ES
>index b50f3641c4d6=2E=2Ea9de527ba5c4 100644
>--- a/arch/x86/kernel/head_32=2ES
>+++ b/arch/x86/kernel/head_32=2ES
>@@ -44,9 +44,6 @@
> #define X86_CAPABILITY	new_cpu_data+CPUINFO_x86_capability
> #define X86_VENDOR_ID	new_cpu_data+CPUINFO_x86_vendor_id
>=20
>-
>-#define SIZEOF_PTREGS 17*4
>-
> /*
>  * Worst-case size of the kernel mapping we need to make:
>  * a relocatable kernel can live anywhere in lowmem, so we need to be ab=
le
>@@ -488,13 +485,7 @@ SYM_DATA_END(initial_page_table)
>=20
> =2Edata
> =2Ebalign 4
>-/*
>- * The SIZEOF_PTREGS gap is a convention which helps the in-kernel unwin=
der
>- * reliably detect the end of the stack=2E
>- */
>-SYM_DATA(initial_stack,
>-		=2Elong init_thread_union + THREAD_SIZE -
>-		SIZEOF_PTREGS - TOP_OF_KERNEL_STACK_PADDING)
>+SYM_DATA(initial_stack, =2Elong __top_init_kernel_stack)
>=20
> __INITRODATA
> int_msg:
>diff --git a/arch/x86/kernel/head_64=2ES b/arch/x86/kernel/head_64=2ES
>index d8198fbd70e5=2E=2Eb11526869a40 100644
>--- a/arch/x86/kernel/head_64=2ES
>+++ b/arch/x86/kernel/head_64=2ES
>@@ -66,7 +66,7 @@ SYM_CODE_START_NOALIGN(startup_64)
> 	mov	%rsi, %r15
>=20
> 	/* Set up the stack for verify_cpu() */
>-	leaq	(__end_init_task - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE)(%rip=
), %rsp
>+	leaq	__top_init_kernel_stack(%rip), %rsp
>=20
> 	/* Setup GSBASE to allow stack canary access for C code */
> 	movl	$MSR_GS_BASE, %ecx
>diff --git a/arch/x86/kernel/vmlinux=2Elds=2ES b/arch/x86/kernel/vmlinux=
=2Elds=2ES
>index a20409b0a3f2=2E=2Ed430880175f2 100644
>--- a/arch/x86/kernel/vmlinux=2Elds=2ES
>+++ b/arch/x86/kernel/vmlinux=2Elds=2ES
>@@ -167,6 +167,9 @@ SECTIONS
> 		/* init_task */
> 		INIT_TASK_DATA(THREAD_SIZE)
>=20
>+		/* equivalent to task_pt_regs(&init_task) */
>+		__top_init_kernel_stack =3D __end_init_task - TOP_OF_KERNEL_STACK_PADD=
ING - PTREGS_SIZE;
>+
> #ifdef CONFIG_X86_32
> 		/* 32 bit has nosave before _edata */
> 		NOSAVE_DATA
>diff --git a/arch/x86/xen/xen-head=2ES b/arch/x86/xen/xen-head=2ES
>index 04101b984f24=2E=2E758bcd47b72d 100644
>--- a/arch/x86/xen/xen-head=2ES
>+++ b/arch/x86/xen/xen-head=2ES
>@@ -49,7 +49,7 @@ SYM_CODE_START(startup_xen)
> 	ANNOTATE_NOENDBR
> 	cld
>=20
>-	leaq	(__end_init_task - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE)(%rip=
), %rsp
>+	leaq	__top_init_kernel_stack(%rip), %rsp
>=20
> 	/* Set up %gs=2E
> 	 *
>
>base-commit: e1826833c3a9abb9d1fe4b938eca0e25eeafb39f

Acked-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>

