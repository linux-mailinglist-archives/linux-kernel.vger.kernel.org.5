Return-Path: <linux-kernel+bounces-139100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB3689FE8B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046BF1F24CAF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEAE17BB20;
	Wed, 10 Apr 2024 17:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2tp3er/+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ueGVZeT3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D39717BB1A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712770186; cv=none; b=KxAA950yie48X2/3DvGajgMiIz6et+ob/NX4Hx2r3ZI0s13vcr6n3P79vn1C66Y2EAr4gN3Zck+kmk9UY4pjH38NNVultL0okmo9mFiA2ggrRkFPuYEqDdQu++eNTs0UnfvU8BfPMhKQA4CZ5zvKT1mCjTqx3lsEDfTEDHk7wAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712770186; c=relaxed/simple;
	bh=P2JBJACvCVGQrY77erYLB2cWSst06ja15a6M8xosGaw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GfAVAdaBTqmhKlbiNfwRahVyqdoNob5cBoiT18S1Xhy0SFHG89P4qFoGNtOd8IML5h7Zrw4kkSdNm0844E1DBmfG1xwYx/OIO9VrTNkWFNE0En8YOBL8xr5nOEsCdGSFqLljqIOYzuR5jTHfMVrtL8TAmMpcPdTf3kBSn9/gsx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2tp3er/+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ueGVZeT3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712770183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P2JBJACvCVGQrY77erYLB2cWSst06ja15a6M8xosGaw=;
	b=2tp3er/+dLcFnLG8mk1ZZTArXyFsXUEo5VSJv7Tt/s4CW0t10dwKn3v7RDdbcdZYWm1zUq
	Z5jBBjGgQW37B3kSgGvpSyp8b4deFjoqW0XgPr/3G0+kjd35NAEfhWa7gVUXJXc9kub8dD
	bG+rOuCx+DRrxFGfWciJ34B9UIH8uQz+5iQzZ3ehULQD4uujuAhiMyNVezk2FnTdpiJIru
	fSQJm9KADHF64cYWUQfllM3CFcKYbCqGW5YvBUH/Oi3oplWjwifkDH9gPwwdzoPK5C46bB
	MDfBnuxBt/y2jz5v7v7V0PO4Rx1nUONAMnFMabE1D//p/htiBwoLBZojb5ApHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712770183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P2JBJACvCVGQrY77erYLB2cWSst06ja15a6M8xosGaw=;
	b=ueGVZeT3llAneaalbZgqNVdd1qHRrYR7LJT6s9i72mvIordFFN5ynxXXE1gAxDoo2W4Jmo
	eucZpsA1aiBf4WBw==
To: "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Cc: LKML <linux-kernel@vger.kernel.org>, xiangfeix.ma@intel.com, Dongli
 Zhang <dongli.zhang@oracle.com>, Linux kernel regressions list
 <regressions@lists.linux.dev>
Subject: Re: Call Trace when adding vCPU to guest
In-Reply-To: <842fde07-d532-4c9e-8b4e-3447509e040e@leemhuis.info>
References: <b4929457-23b8-4ad4-8324-cc1cde5ecece@leemhuis.info>
 <87bk6h49tq.ffs@tglx> <b9e54d33-7f5e-45a5-b215-d3f9daef5a8e@leemhuis.info>
 <871q7d46e7.ffs@tglx> <842fde07-d532-4c9e-8b4e-3447509e040e@leemhuis.info>
Date: Wed, 10 Apr 2024 19:29:43 +0200
Message-ID: <87msq12kjc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Apr 10 2024 at 18:25, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 10.04.24 16:52, Thomas Gleixner wrote:
> I can reproduce as well. But the callstack is different. It finally
> reaches at topo_set_cpuids().

That looks about right.

> I am not able to reproduce with the below:
>
> x86/topology: Don't update cpu_possible_map in topo_set_cpuids()
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/urgent&id=a9025cd1c673a8d6eefc79d911075b8b452eba8f

Yes, that's the fix for the crash you saw.

