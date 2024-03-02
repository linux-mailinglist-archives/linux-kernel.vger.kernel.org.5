Return-Path: <linux-kernel+bounces-89431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E3986F043
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 12:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59D3EB23D2B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 11:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04131171BF;
	Sat,  2 Mar 2024 11:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D+k8uPyE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C2g7laN4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F9E17562
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 11:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709379455; cv=none; b=oLvye2Cuog9SzJp6N4G8isZPMKEeMEgvB+up92cGnMRw+4NmXx7As1K9XM9QGczAtDCFois8avUQO80fCU7vsnDQZ3ddUHpt2EgkzGZaDzmCskkPA1XZ98SUD9lpy9puzY6Xu2br6TitMyJzp/+iRmQ6LWKRAWLHSjzrXXqvYdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709379455; c=relaxed/simple;
	bh=lK4U4ZLcWMRofj4C36viEsAPI2ibBqPBg1dl/C+Vbbc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OsIkAjRZpyagtvleq20eimt6+D7piJ3cjIK+NJWgpxpRE0Poo5z05gWdulO+nJmohlvlpjTH/W5oU27BI3IrRFwDNDFN1I1Q9Jcq3L4kHyrvweE/9WLLbSKV5Qq9GRF2rcoiMQWJyf4hI++I0HfkpA+J92PJO1PGJR6UNTdMJVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D+k8uPyE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C2g7laN4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709379450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kg/HWn0RBgyKR0X6ry85czEeS/YqxSOJwvJfCZhfBZE=;
	b=D+k8uPyEfOjyY7Y0Omj3cDddiEEu8SaBgIHTay1QinYalGHInnrklrlVczSIpdy/E7rQPi
	m6EDAtJ0M/MAisOkml9qRxBTCn5oTE4q3uHL/+ZveRqpuWWIYebRWPokmgQizgjHSs/pEi
	TYKEDPzd04wuvLmlN/XdYx1YV6KsdQ1zKiER/uf/GcyJhY2ktmA2HoBlbj2pqo3LQj4mIQ
	zc2BqjxQMWImomdPstx38eNXjg10lLEj53Vm4c5B2Y7ZK2Pj8ebKn2d85Bg2iHGtHwTZmj
	b5a45iReS/WDwdDzEc46RVscRi9YHSi6pPJNpogyYU8tzATG+wdn2PQODJ/GsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709379450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kg/HWn0RBgyKR0X6ry85czEeS/YqxSOJwvJfCZhfBZE=;
	b=C2g7laN4Pmwh8tpWg9OdccAbRvdNL0XIMpX8TyeXV/MolAmcZZRzkxZ8/SBG5y2yIHM3/C
	1rqICYqY6avmkXCQ==
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, Arjan van
 de Ven <arjan@linux.intel.com>, x86@kernel.org
Subject: Re: arch/x86/include/asm/processor.h:698:16: sparse: sparse:
 incorrect type in initializer (different address spaces)
In-Reply-To: <87a5nhwpus.ffs@tglx>
References: <202403020457.RCJoQ3ts-lkp@intel.com> <87edctwr6y.ffs@tglx>
 <87a5nhwpus.ffs@tglx>
Date: Sat, 02 Mar 2024 12:37:29 +0100
Message-ID: <87y1b0vp8m.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Mar 01 2024 at 23:26, Thomas Gleixner wrote:
> Sorry, my fault. I can reproduce now but it still does not make any
> sense. The code is correct...
>
> Let me put something together which the sparse folks can digest.

Bah. sparse is actually right. I completely missed the fact that this is
an UP build which has:

extern struct cpuinfo_x86	boot_cpu_data;

#define cpu_info		boot_cpu_data

So any access with this_cpu*(), per_cpu*() etc. is actually incorrect from
sparse's point of view.

From a compiler point of view it just works because __percpu dissolves
and the whole thing produces correct code magically.

Most places in x86 use cpu_data(cpu) to access per cpu data which is
defined as per_cpu(cpu_info, cpu) for SMP and boot_cpu_info for UP.

That's fine, but there are places like the MCE code which really needs
raw_cpu_ptr(). Sure we can write ugly wrappers for that and for some
other accessors. But that's all just wrong and ugly.

The proper solution would be to force SMP for x86, but Linus shot it
down when I wanted to do that last time.

Let me think about it.

Thanks,

        tglx

