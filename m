Return-Path: <linux-kernel+bounces-105315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D4087DC21
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 01:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 529E8B2187B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 00:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14A7139F;
	Sun, 17 Mar 2024 00:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="z41yZ42K"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013CF37E
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 00:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710636602; cv=none; b=joFKcAoNoTiiRnDFWCWSMp+atBODswFOsYGkckS8ApGFifiBuCrQd2+itkylBdtAGePX+Zca5b7gV3muohxWIe/7qpZrq9GI+q8ge0HgyD7gkFwcr3kVWzUNDDCopkmRnQqO1+How7l2FgUGHUR8ibFHPbbBQhFKkiZ79XfZwnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710636602; c=relaxed/simple;
	bh=98BFSV3Znre67JUYSWC+ceP/C1TEtiXtw5xCvvIxQFs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=hwH3pN3dGqjRre6q1KzS4SXO2i6/93vqtrw6s9KJataQMIhWyEYkVBaglku7p1xzD2TdZmwCMoiS3MXdRe58u38DGBnQePtPnj42FiSVhnq63NzVYut9TQzFRs5zSr3DCs82KdwE/iEK90P7xG+nDB+wGgcGyfC3kguvQAuMI2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=z41yZ42K; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 42H0lK2R189356
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 16 Mar 2024 17:47:20 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 42H0lK2R189356
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024031401; t=1710636443;
	bh=rmzZOkxjUewxpWdmHy83RYimgSmj73ySRleyMzLtqbI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=z41yZ42KGUScTcXJ2MOe+aqXnWr/IYbXDlaSZqYmRMADbKGNn+vcvWpAcMgFKUlqX
	 K/+7j7M1nBDD3MQNrBy1XxfNVgW+1+WnwOLcYN+dI8zhhbGRgIXDeewuHZxOBodhnb
	 puVsURclHdgwcQzVQv2jCwh6TdGY2JZyy3rA57FCKiC7I1B4AquJZ9gFIFE+sOpgAK
	 SEWFs7YTv1bcXncbPVoGUPVAeP59Z1biYUJpNgQTqClswne2A97EL3NwvDzHFnbJql
	 mr22nMh51JH4MsZIOQ2XILXMQNZ9/mW0ndK9HU0Gb8Duq9tfFQa4qyghbUU4avDHD8
	 pF1Qbr51F37TQ==
Date: Sat, 16 Mar 2024 17:47:18 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Matthew Wilcox <willy@infradead.org>
CC: Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, x86@kernel.org,
        bp@alien8.de, brauner@kernel.org, bristot@redhat.com,
        bsegall@google.com, dave.hansen@linux.intel.com, dianders@chromium.org,
        dietmar.eggemann@arm.com, eric.devolder@oracle.com, hca@linux.ibm.com,
        hch@infradead.org, jacob.jun.pan@linux.intel.com, jgg@ziepe.ca,
        jpoimboe@kernel.org, jroedel@suse.de, juri.lelli@redhat.com,
        kent.overstreet@linux.dev, kinseyho@google.com,
        kirill.shutemov@linux.intel.com, lstoakes@gmail.com, luto@kernel.org,
        mgorman@suse.de, mic@digikod.net, michael.christie@oracle.com,
        mingo@redhat.com, mjguzik@gmail.com, mst@redhat.com, npiggin@gmail.com,
        peterz@infradead.org, pmladek@suse.com, rick.p.edgecombe@intel.com,
        rostedt@goodmis.org, surenb@google.com, tglx@linutronix.de,
        urezki@gmail.com, vincent.guittot@linaro.org, vschneid@redhat.com
Subject: Re: [RFC 00/14] Dynamic Kernel Stacks
User-Agent: K-9 Mail for Android
In-Reply-To: <ZfNTSjfE_w50Otnz@casper.infradead.org>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com> <2cb8f02d-f21e-45d2-afe2-d1c6225240f3@zytor.com> <ZfNTSjfE_w50Otnz@casper.infradead.org>
Message-ID: <0EE22907-1D81-4FA6-823B-13F7A94D3F85@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 14, 2024 12:43:06 PM PDT, Matthew Wilcox <willy@infradead=2Eorg> w=
rote:
>On Tue, Mar 12, 2024 at 10:18:10AM -0700, H=2E Peter Anvin wrote:
>> Second, non-dynamic kernel memory is one of the core design decisions i=
n
>> Linux from early on=2E This means there are lot of deeply embedded assu=
mptions
>> which would have to be untangled=2E
>
>I think there are other ways of getting the benefit that Pasha is seeking
>without moving to dynamically allocated kernel memory=2E  One icky thing
>that XFS does is punt work over to a kernel thread in order to use more
>stack!  That breaks a number of things including lockdep (because the
>kernel thread doesn't own the lock, the thread waiting for the kernel
>thread owns the lock)=2E
>
>If we had segmented stacks, XFS could say "I need at least 6kB of stack",
>and if less than that was available, we could allocate a temporary
>stack and switch to it=2E  I suspect Google would also be able to use thi=
s
>API for their rare cases when they need more than 8kB of kernel stack=2E
>Who knows, we might all be able to use such a thing=2E
>
>I'd been thinking about this from the point of view of allocating more
>stack elsewhere in kernel space, but combining what Pasha has done here
>with this idea might lead to a hybrid approach that works better; allocat=
e
>32kB of vmap space per kernel thread, put 12kB of memory at the top of it=
,
>rely on people using this "I need more stack" API correctly, and free the
>excess pages on return to userspace=2E  No complicated "switch stacks" AP=
I
>needed, just an "ensure we have at least N bytes of stack remaining" API=
=2E

This is what stack probes basically does=2E It provides a very cheap "API"=
 that goes via the #PF (not #DF!) path in the slow case, but synchronously =
at a well-defined point, but is virtually free in the common case=2E As a s=
ide benefit, they can be compiler-generated, as some operating systems requ=
ire them=2E

