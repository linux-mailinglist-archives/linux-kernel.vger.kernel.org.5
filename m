Return-Path: <linux-kernel+bounces-106287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0521587EBF7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 540B0B2196D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FA74F1FB;
	Mon, 18 Mar 2024 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GCTFw8mP"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D354EB55
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710775200; cv=none; b=nToSGs2aALITllRt+b+IXyyJuTD7A6nOmyptyWJStKjYPfumXMIhKRskc2eJ7XOIuoj3ZZj873SUDnE1jpwYoUWxwhAvYxkBMqUhokItaZ9vfkPdfIuIJ76/ypBe1pzSSPDFLaBluxdhUIXNPt5SrVsViI0I+RhnfMqAGIIlk90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710775200; c=relaxed/simple;
	bh=2Cg99J9ypIQesVjvEc6hc5B4sZc8qtrJtdq4K6UXCFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZ3cznDXOK/gksPGCShBI7KEyWXOEOcPt0rKlApkwuDYfdCN8SkhhUKWmo1m5pgEBdYnlT3zTcSqUYxh7HIIZwYeMf+xmcP7t4C83iLWh0f3MXXvxHf9eqUHAUzNZLXQ9hShAoj9tihft15TNA0ihVPqNmYF9NnvX9K+2g/rH+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GCTFw8mP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rayCM2prt2//9KKvtSxS+IFFDRjg7qyBPxuMRQQtlQg=; b=GCTFw8mPDwozA5wqrfuTAhT5Oz
	Ruhi2mLN6L8F4/1OiORKj4bu5CoFp8GQ6y/4nvZK2VeGi5aBS1FfGMcVan4ia5IxP0xsiz31nabSv
	PHtpbVNvKBK3DR29b+8dhwxA/8J9hGSchtqopAfa7Pzz0FRollz3Br0VPHqudDXvyHPelWr203Kxb
	lxabtQS26yYMqUsANvtP/91eTCxMLDLTp4W6+UANLwoxX0IAQpQ9i4f0YDFWVGYoncx72SoJzrs/E
	qm+tFyxkWkZDNsZSvO+AgRJUjrm6RQo+0qBR3NGguVAh2V0SG4d2DljCNf/KoGYWMmj2m/T6gyMiY
	t0uS0nbw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmEmE-0000000HPue-3X4m;
	Mon, 18 Mar 2024 15:19:50 +0000
Date: Mon, 18 Mar 2024 15:19:50 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: David Laight <David.Laight@aculab.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"bristot@redhat.com" <bristot@redhat.com>,
	"bsegall@google.com" <bsegall@google.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"dianders@chromium.org" <dianders@chromium.org>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"eric.devolder@oracle.com" <eric.devolder@oracle.com>,
	"hca@linux.ibm.com" <hca@linux.ibm.com>,
	"hch@infradead.org" <hch@infradead.org>,
	"jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"jroedel@suse.de" <jroedel@suse.de>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"kinseyho@google.com" <kinseyho@google.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"lstoakes@gmail.com" <lstoakes@gmail.com>,
	"luto@kernel.org" <luto@kernel.org>,
	"mgorman@suse.de" <mgorman@suse.de>,
	"mic@digikod.net" <mic@digikod.net>,
	"michael.christie@oracle.com" <michael.christie@oracle.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"mjguzik@gmail.com" <mjguzik@gmail.com>,
	"mst@redhat.com" <mst@redhat.com>,
	"npiggin@gmail.com" <npiggin@gmail.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"pmladek@suse.com" <pmladek@suse.com>,
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"surenb@google.com" <surenb@google.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"urezki@gmail.com" <urezki@gmail.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"vschneid@redhat.com" <vschneid@redhat.com>
Subject: Re: [RFC 00/14] Dynamic Kernel Stacks
Message-ID: <Zfhblk609XJn5clL@casper.infradead.org>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <2cb8f02d-f21e-45d2-afe2-d1c6225240f3@zytor.com>
 <ZfNTSjfE_w50Otnz@casper.infradead.org>
 <2qp4uegb4kqkryihqyo6v3fzoc2nysuhltc535kxnh6ozpo5ni@isilzw7nth42>
 <ZfNWojLB7qjjB0Zw@casper.infradead.org>
 <CA+CK2bAmOj2J10szVijNikexFZ1gmA913vvxnqW4DJKWQikwqQ@mail.gmail.com>
 <39F17EC4-7844-4111-BF7D-FFC97B05D9FA@zytor.com>
 <CA+CK2bDothmwdJ86K1LiKWDKdWdYDjg5WCwdbapL9c3Y_Sf+kg@mail.gmail.com>
 <bb203717ab644362a8eafe78aff23947@AcuMS.aculab.com>
 <CA+CK2bAuNLXq4p8pjwAatuw2KuadhKjD6JRwJN8ZvSEd1d7ntA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bAuNLXq4p8pjwAatuw2KuadhKjD6JRwJN8ZvSEd1d7ntA@mail.gmail.com>

On Mon, Mar 18, 2024 at 11:09:47AM -0400, Pasha Tatashin wrote:
> The TLB load is going to be exactly the same as today, we already use
> small pages for VMA mapped stacks. We won't need to have extra
> flushing either, the mappings are in the kernel space, and once pages
> are removed from the page table, no one is going to access that VA
> space until that thread enters the kernel again. We will need to
> invalidate the VA range only when the pages are mapped, and only on
> the local cpu.

No; we can pass pointers to our kernel stack to other threads.  The
obvious one is a mutex; we put a mutex_waiter on our own stack and
add its list_head to the mutex's waiter list.  I'm sure you can
think of many other places we do this (eg wait queues, poll(), select(),
etc).


