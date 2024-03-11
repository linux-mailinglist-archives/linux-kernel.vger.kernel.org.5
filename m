Return-Path: <linux-kernel+bounces-99663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11006878B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 896E6B211DC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0FE58AD7;
	Mon, 11 Mar 2024 23:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vS+l3KuH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0gFjP9gc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570FA58AC0
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 23:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710200042; cv=none; b=kwcB65mjmRpxTksZROjJr4d19MJ61Jy2AfAh9WrUXMSbc56hAgVlX4yjZXhLBMUUujYTZV3m91btPNPVyvHYqALiyt5nwpPcycsTZwOP6cnBiNIqAdlSouP9Nab4DeVWMvEVkLyeaqTC9J+BpBQXjiCQRXFJvwnIdqKPNc1X+H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710200042; c=relaxed/simple;
	bh=hPCi7ihbEkOSNP09ah/2V2E0qHDA6/vPKx1XuJCvf6s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KkmU8FFZDwJgk9QhsrS7ZwjOXY2RVTld36wYvf1annlUAPMaoF8vyQXgP8+84BijvdppbNv86+es66AsORj1A/9komxzuxt+GFKxsij26ft2jUVZexo3dLoByxYa27DGDVH/YNOQr1HZRR3DcK/8I2qJa0DBk0Ug+g9qdEuZQ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vS+l3KuH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0gFjP9gc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710200039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MIw7l9VNfGqq4sdtjnnvblmtZxj6z+GMUpQZ0ibxA1g=;
	b=vS+l3KuHzoSjIJCPO78146fytSCTpgzxWZpwCYU0EKZZ6BRtn39CDliyzMHbnSwf/0TunE
	qF4ufjYpyeAgtYiakoJbJE9MnGRMr1rBRzeET/7jyHHt8yOaui6tx5+mykEGQddq5C/ipr
	OS/E/sTYB2TB7vItXhDJoe4nhNmS/4SIVM3pPTanCpMe2E468a9cVwPw17E+bwuj9P53Os
	quyrRc4PM7VKgLi/iSdA3FMb5t2JhxHtMlgFlTcAzaW/dpousjiqYmqIj3Act51yRe+InE
	ynd6WUwN/T7VPLGAqmpSJ8Bm50EWMOrNrb0XnYuybMHVjwH5OsqaiQPY1NI25w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710200039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MIw7l9VNfGqq4sdtjnnvblmtZxj6z+GMUpQZ0ibxA1g=;
	b=0gFjP9gcUjMNAgXkt9mSb0rnWrsmA2k/IePHaBi5pmWDDtFJiK/evfEKL0E61XQ/7bd2js
	Nk6xXc8jSkwIigDA==
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Andy Lutomirski
 <luto@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, the
 arch/x86 maintainers <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Christian Brauner <brauner@kernel.org>, bristot@redhat.com, Ben Segall
 <bsegall@google.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 dianders@chromium.org, dietmar.eggemann@arm.com, eric.devolder@oracle.com,
 hca@linux.ibm.com, "hch@infradead.org" <hch@infradead.org>, "H. Peter
 Anvin" <hpa@zytor.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, jpoimboe@kernel.org, Joerg Roedel
 <jroedel@suse.de>, juri.lelli@redhat.com, Kent Overstreet
 <kent.overstreet@linux.dev>, kinseyho@google.com, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, lstoakes@gmail.com, mgorman@suse.de,
 mic@digikod.net, michael.christie@oracle.com, Ingo Molnar
 <mingo@redhat.com>, mjguzik@gmail.com, "Michael S. Tsirkin"
 <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, "Peter Zijlstra
 (Intel)" <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, Rick P
 Edgecombe <rick.p.edgecombe@intel.com>, Steven Rostedt
 <rostedt@goodmis.org>, Suren Baghdasaryan <surenb@google.com>, Uladzislau
 Rezki <urezki@gmail.com>, vincent.guittot@linaro.org, vschneid@redhat.com
Subject: Re: [RFC 11/14] x86: add support for Dynamic Kernel Stacks
In-Reply-To: <CA+CK2bA22AP2jrbHjdN8nYFbYX2xJXQt+=4G3Rjw_Lyn5NOyKA@mail.gmail.com>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <20240311164638.2015063-12-pasha.tatashin@soleen.com>
 <3e180c07-53db-4acb-a75c-1a33447d81af@app.fastmail.com>
 <CA+CK2bA22AP2jrbHjdN8nYFbYX2xJXQt+=4G3Rjw_Lyn5NOyKA@mail.gmail.com>
Date: Tue, 12 Mar 2024 00:33:58 +0100
Message-ID: <87frwwpcm1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11 2024 at 19:10, Pasha Tatashin wrote:
> On Mon, Mar 11, 2024 at 6:17=E2=80=AFPM Andy Lutomirski <luto@kernel.org>=
 wrote:
>> Also, I think the whole memory allocation concept in this whole
>> series is a bit odd.  Fundamentally, we *can't* block on these stack
>> faults -- we may be in a context where blocking will deadlock.  We
>> may be in the page allocator.  Panicing due to kernel stack
>> allocation would be very unpleasant.
>
> We never block during handling stack faults. There's a per-CPU page
> pool, guaranteeing availability for the faulting thread. The thread
> simply takes pages from this per-CPU data structure and refills the
> pool when leaving the CPU. The faulting routine is efficient,
> requiring a fixed number of loads without any locks, stalling, or even
> cmpxchg operations.

Is this true for any context including nested exceptions and #NMI?

Thanks,

        tglx

