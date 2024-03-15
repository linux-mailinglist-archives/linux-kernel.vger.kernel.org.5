Return-Path: <linux-kernel+bounces-104996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0794287D76D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 00:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F071C213F6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24A55A4CF;
	Fri, 15 Mar 2024 23:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b3/1Rq+m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XmTWXAk7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9396B59B7C;
	Fri, 15 Mar 2024 23:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710546692; cv=none; b=UBYmXeMv4g0yw0IijaE1p6wqs4P3LKIoJdovPvsfjN4v9iJl3aFrXTLZ01FL0HuO58ZIVjsZeToJSqHR2ixv6MkALgViCD541yrNAUJxD3I4FM50ZPRFWGJTlMD/9NZ07iA4FVySgHcPNHrPVvqoD9vTa6QwsRB0LeVlQHxXiCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710546692; c=relaxed/simple;
	bh=SrFivRdWVjM7gMC+uIcPBoDVT6y0kS6ywMihLVjkIjM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TymW6Ck0rg9EYw831HqGsZjzNXsERqA3jAHMC67rty0EiqhOF12ZbIV5ekEeBTGMIN4YBBZG5TwTuWWOd9G1rKxH/GX7qa0KpJeZaUnLxD4SB7qxByHH0ikJ7nEpUpMiK27RXpTGwFyUG/mD1XIY86S/oQBB/lcS+S2Xf2sxLOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b3/1Rq+m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XmTWXAk7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710546688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Miou2k+UhGYGY4SJcmQw585wT8SSQhHvWDGf+ECF8+o=;
	b=b3/1Rq+mPFr7G3wtb7+wYHB2LiWKrlY7QVudbKeM8fs2DP7nI8gKDbdjS7HpjASZ0t0CIY
	KS4jwvvcUqG8pKGbiLgctdTz+Z/JHzvO3gQ79sMSPqgTAvcBPHyscsXsOOLvQvqCqUtoQE
	OqmAVthRG8X2NbB7CLrFhs/vrgYSNY3zoMjh/teUa0C/qwiPF654hWZ2AYtKJmRuKBtnms
	08Wm2IxibS1vzUQjzzMkJB+jMRHKZigu0IknS+vsyMwnRPyuavxCSOuQDKVUfRMlR03bKu
	ZQbCDGLAdJNQwXrK5ucbbtxjZAkfrrZeOHD+ivqxAqDE+cxpYGVO5CEDJcZCpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710546688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Miou2k+UhGYGY4SJcmQw585wT8SSQhHvWDGf+ECF8+o=;
	b=XmTWXAk7jPDIJ9p3Z19L+CuwDaBuDDNc6y+XNbmOlsC4vNgPLaSm6cmW3ASyZvXnuNNb+H
	f5k9vDGESvQ/3BAA==
To: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>
Cc: Vignesh Balasubramanian <vigbalas@amd.com>,
 linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
 mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
 aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com,
 ebiederm@xmission.com, keescook@chromium.org, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 jinisusan.george@amd.com, matz@suse.de, binutils@sourceware.org,
 jhb@freebsd.org, felix.willgerodt@intel.com
Subject: Re: [PATCH 1/1] x86/elf: Add a new .note section containing
 Xfeatures information to x86 core files
In-Reply-To: <20240314162954.GAZfMmAnYQoRjRbRzc@fat_crate.local>
References: <20240314112359.50713-1-vigbalas@amd.com>
 <20240314112359.50713-2-vigbalas@amd.com>
 <dd54d6de-0bcc-4b2e-a420-b1a429b06246@intel.com>
 <20240314160824.GDZfMg-J1VOyjxIMiV@fat_crate.local>
 <6ce6aa20-25d2-4784-823f-2a18f592e002@intel.com>
 <20240314162954.GAZfMmAnYQoRjRbRzc@fat_crate.local>
Date: Sat, 16 Mar 2024 00:51:28 +0100
Message-ID: <87cyrvjbpb.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Mar 14 2024 at 17:29, Borislav Petkov wrote:
> On Thu, Mar 14, 2024 at 09:19:15AM -0700, Dave Hansen wrote:
>> Are you envisioning an *XSAVE* state component that's not described by
>> CPUID?
>
> I want to be prepared. You can imagine some of the short cuts and
> corners cutting hw guys would do so I'd want to be prepared there and
> not tie this to CPUID.

Anything which is not enumerated in CPUID does not exist in
XSTATE. Period and end of story.

Stop paving the way for hardware people to have an excuse for being
stupid.

Aside of that XSTATE is a dead end as we all know.

Thanks,

        tglx

