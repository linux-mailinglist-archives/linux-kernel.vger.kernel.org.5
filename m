Return-Path: <linux-kernel+bounces-63265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0828F852D08
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B5BE1C26FDE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB0836AE4;
	Tue, 13 Feb 2024 09:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0Nz8nFGK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cgXmH3Pk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC63364B6;
	Tue, 13 Feb 2024 09:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817767; cv=none; b=rQOq/ev0ynoij+3xu7mD9YfwAXVYaVHEe76bwwOcsvG+zbF6M3KUfCx9eWbyoJE5cg4GiRP/pwp1TQa0am+7Kjo62TmT6gLHkZPo6JQakKpz4bkiREyf2GDRJwPQH4ti+sRLA48hmpEGjEWu1bNAl6HLnL3G0pJvmUSiPbEiHSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817767; c=relaxed/simple;
	bh=mfaHbcvnNJcXr43nudKodXIwxm8SgK0GLMoUzSXL0L8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A/VDkuL3IjYVdKDhL2obvcH9cVZbIO7EAa1j1Md2QXoe4Uhu05IbNy7n2RNim6PG/4F4NnZYX/fFBomn9ashMxZiPoIpvY5MEDHB3XJAWaSGPGGj/Tj1kj5oB5WXchXGxAFodrw/BWqGafiy4cUC49vVgiiz7h0ngK56Ib0w8CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0Nz8nFGK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cgXmH3Pk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707817763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mfaHbcvnNJcXr43nudKodXIwxm8SgK0GLMoUzSXL0L8=;
	b=0Nz8nFGKEfobSe0raaN2CaulvkaWmnnba1RyMNH0Kum2TULqRyMIwk8hnwifPY1KMu/CEs
	UkYyh52pSf2ToVWFAw8ufV01Z+rmK6uEQ3noPh5y9jlvr0GrzN9TOWjrFT5QWxCEysV31g
	xk5O5nA0Qfib3Kj7nkGKPZNPJ1z8qm4PqN49YjJgHK5S+fHrfOwqb4r/wVrJwNJhyVfcR+
	HM4crbbg7ysmW5sboIOIeD0a/YPHtjQYT/IOhN7w1clIiq+KSHg58p6h8ZtiGaW9sCLw0c
	an2SDP9QY1wu2TI1jOK/xPrFOUwJPxoPEGso/iVsGc7z7CJjXdVPU/ULnBEDpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707817763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mfaHbcvnNJcXr43nudKodXIwxm8SgK0GLMoUzSXL0L8=;
	b=cgXmH3PkuHEaJhfEjT1zsn++EIYQ1vzaKNKcu56EY8U1y/t/yg4Kmy8RVJOJ3FR1ZOfNRt
	A1q8P0aVDxs+9DBg==
To: Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, Sergey
 Shtylyov <s.shtylyov@omp.ru>, lvjianmin@loongson.cn
Subject: Re: [PATCH v5 3/3] irqchip/loongson-eiointc: Refine irq affinity
 setting during resume
In-Reply-To: <20240130082722.2912576-4-maobibo@loongson.cn>
References: <20240130082722.2912576-1-maobibo@loongson.cn>
 <20240130082722.2912576-4-maobibo@loongson.cn>
Date: Tue, 13 Feb 2024 10:49:23 +0100
Message-ID: <87a5o4iti4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 30 2024 at 16:27, Bibo Mao wrote:
> During suspend and resume, CPUs except CPU0 can be hot-unpluged and IRQs
> will be migrated to CPU0. So it is not necessary to restore irq affinity
> for eiointc irq controller when system resumes.

That's not the reason. The point is that eiointc_router_init() which is
invoked in the resume path affines all interrupts to CPU0, so the
restore operation is redundant, no?

> This patch removes this piece of code about irq affinity restoring in
> function eiointc_resume().

Again. 'This patch' is pointless because we already know that this is a
patch, no?


