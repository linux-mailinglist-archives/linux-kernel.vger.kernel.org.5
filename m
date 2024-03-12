Return-Path: <linux-kernel+bounces-99722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AFB878C3E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5FEC1C211A9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F4E10E3;
	Tue, 12 Mar 2024 01:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="CK2gOGzN"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A045A7E2
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 01:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710206872; cv=none; b=O3ebbxxDK7pcQ2CnZt2RKpWXZtOgPUlcqqWqUNFYiUpEGXfbTEijXVeA5GfGU8Tj0qESClq+ngh8F6ss8n+aA2anLIvQe+QCpGQP1mTPur4vgjbstkbtN8xcg+UphCxy7iWZPNppfVQUJaYquhWhgVB3jjIOfjqVQs5WqDU7IBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710206872; c=relaxed/simple;
	bh=Ic2cF0xSH/QyhwLS/9FJwMuYD7oaUzcuMX32hHgJqV8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ounDp4mwnekfBTdKaqzSwIjrNpNhKwbBY9P/8WubUPUPXiCO2iTG2hRZjvryfUUMsxnzhEOwlQxy367r7sHConHZmUZTi8d6hJMNApyThAZdKn2JOVSlFBO7AfysQ6QQrQCH4z1x2S8bhou5AnDXzkUnMgUNriVrqoTItQ1V/xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=CK2gOGzN; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 42C1Q1kc1082275
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 11 Mar 2024 18:26:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 42C1Q1kc1082275
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024021201; t=1710206764;
	bh=aZNtJKbvwiBbsnZ/2/GhPG+RCGU3s1Hafyp1VbH9Ya0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=CK2gOGzNI4OotmR7tnasLevJ0kZ+6wcq6/2wTmIyK2TxrG/9gmmUaHYyCekJye5GN
	 kKYJhkmkryxZahcZaAFey6gXkSmx+mmuSaVUTCv9U6ehMP2N3YqMzMHXxg8C88vKpP
	 HF86dpb9uLUucVjJJyMxd0soO/vh4jdOJ3ujRTTBxnlkH4iD13Iiv0//fRl/U1uFC/
	 gVHLG2+THu7W83zCzTJ+0PiTtL42i9q4rL3HvBcLFgOAkkQD/oz2It0a7Qy2N1OXF7
	 CZv22XqDlWpS43n9HnmNVXHMpqPgWgBY8XfYE3FXxLnAqMPEBsdIuUDAZ+jWczEtbO
	 yEtAMPPmVSKIw==
Date: Mon, 11 Mar 2024 18:25:56 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Dave Hansen <dave.hansen@intel.com>, Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
CC: Pasha Tatashin <pasha.tatashin@soleen.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Christian Brauner <brauner@kernel.org>,
        bristot@redhat.com, Ben Segall <bsegall@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, dianders@chromium.org,
        dietmar.eggemann@arm.com, eric.devolder@oracle.com, hca@linux.ibm.com,
        "hch@infradead.org" <hch@infradead.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, jpoimboe@kernel.org,
        Joerg Roedel <jroedel@suse.de>, juri.lelli@redhat.com,
        Kent Overstreet <kent.overstreet@linux.dev>, kinseyho@google.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        lstoakes@gmail.com, mgorman@suse.de, mic@digikod.net,
        michael.christie@oracle.com, Ingo Molnar <mingo@redhat.com>,
        mjguzik@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>, vincent.guittot@linaro.org,
        vschneid@redhat.com
Subject: Re: [RFC 11/14] x86: add support for Dynamic Kernel Stacks
User-Agent: K-9 Mail for Android
In-Reply-To: <dd67a2b9-35ef-4cf8-b303-9e6b8692b390@intel.com>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com> <20240311164638.2015063-12-pasha.tatashin@soleen.com> <3e180c07-53db-4acb-a75c-1a33447d81af@app.fastmail.com> <bedfa55b-b1d0-4e59-8c94-dbc5f8485a7f@intel.com> <ef0419dd-9d7b-4b77-b63a-5f11aaefb570@app.fastmail.com> <08EFDEDB-7BBB-4D9C-B7E5-D7370EC609BE@gmail.com> <dd67a2b9-35ef-4cf8-b303-9e6b8692b390@intel.com>
Message-ID: <D4D747C5-2B0E-44B0-A550-BA05BE0AF2FA@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 11, 2024 5:53:33 PM PDT, Dave Hansen <dave=2Ehansen@intel=2Ecom> w=
rote:
>On 3/11/24 16:56, Nadav Amit wrote:
>> So you can look on the dirty-bit, which is not being set
>> speculatively and save yourself one problem=2E
>Define "set speculatively"=2E :)
>
>> If software on one logical processor writes to a page while software
>> on another logical processor concurrently clears the R/W flag in the
>> paging-structure entry that maps the page, execution on some
>> processors may result in the entry=E2=80=99s dirty flag being set (due =
to the
>> write on the first logical processor) and the entry=E2=80=99s R/W flag =
being
>> clear (due to the update to the entry on the second logical
>> processor)=2E
>
>In other words, you'll see both a fault *AND* the dirty bit=2E  The write
>never retired and the dirty bit is set=2E
>
>Does that count as being set speculatively?
>
>That's just the behavior that the SDM explicitly admits to=2E

Indeed; both the A and D bits are by design permissive; that is, the hardw=
are can set them at any time=2E

The only guarantees are:

1=2E The hardware will not set the A bit on a not present late, nor the D =
bit on a read only page=2E

2=2E *Provided that the user has invalidated the page entry in the TLB*, h=
ardware guarantees the respective bits will be set before a dependent memor=
y access is made visible=2E Thus the bits are guaranteed to reflect a stric=
t superset of operations performed architecturally=2E

