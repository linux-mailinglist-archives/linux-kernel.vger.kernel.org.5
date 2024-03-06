Return-Path: <linux-kernel+bounces-94607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B7687420F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F781B20F5E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAE01B94D;
	Wed,  6 Mar 2024 21:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WnGdPuGj"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B1C1B59C;
	Wed,  6 Mar 2024 21:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709760888; cv=none; b=hRKQu+/dRObGg5JhSUh5jQfQ17wyd5Zw0ckxFYYrZl8kng9PtuwG8ivw0ZHTA1Mn1FEoTnkiQcA1mB/SvnptbOuAgbAClRPOszlRv9c9DaEDSEs7BJyBWm07gnVJXwmtxrhB/VVDoeZALc/OZVjxgX/WprNouawjIROfp+kZtTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709760888; c=relaxed/simple;
	bh=EENCLqG5V3ac8guut1rXuephqedDKNfSA+GEUUm2Ldc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvGu2waQrdDdT1k39KKMJWdGVOtf8bEw6f2tXLI+r3hu8X9ARbY50pSMhGyCqsFReMaprWQ7uzTJMuZWKHBtCdsr2OfEDSuP+UEHRney6mKyeesfIyLVJ7r5CLgnew8FjUBdx8U01DxlBsctNRqs0zlNyNusSoDHdvXhQzb2UQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WnGdPuGj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Pnrclyp8qd04tGL+paauReWhMqljiQ5BhKgBB0WcrGc=; b=WnGdPuGjK0DJWslO+RClJS5y4I
	5B8C5YAmXsTC55hIAo8YMFhw2q8p4bch0h7B8wC2w9wScUcSlicDw2Ngd+HVnDWZ6M2t62VKOQr3g
	xa19j5fyo9dOSgZvD1Tt3Ne44oT/0bK1MLvxnP257sEIFzNoQntAvUhfGNCF6rV7A0jhQNMkdPwew
	tUYo716dQGB0rZx09USyxW2Kdi0cFIyWXhsw3MTC4w9MJnsAXxPFCd64pW7Yt4RekRpDZwzegFOyr
	2fOR7osn7I78XruxsHsT6Hd7MBR3Uhc6sFCu0yxbe1ZAbILzWusyPeZ/Ainmpv63ADEiA/z79WTyH
	IjW4rvbQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhyuO-00000001xdj-0ljc;
	Wed, 06 Mar 2024 21:34:40 +0000
Date: Wed, 6 Mar 2024 13:34:40 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Calvin Owens <jcalvinowens@gmail.com>, Song Liu <song@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	David S Miller <davem@davemloft.net>,
	Thomas Gleixner <tglx@linutronix.de>, bpf@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/4] Make bpf_jit and kprobes work with
 CONFIG_MODULES=n
Message-ID: <ZejhcP_r5QJZcS6j@bombadil.infradead.org>
References: <cover.1709676663.git.jcalvinowens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1709676663.git.jcalvinowens@gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Wed, Mar 06, 2024 at 12:05:07PM -0800, Calvin Owens wrote:
> Hello all,
> 
> This patchset makes it possible to use bpftrace with kprobes on kernels
> built without loadable module support.

This is a step in the right direction for another reason: clearly the
module_alloc() is not about modules, and we have special reasons for it
now beyond modules. The effort to share a generalize a huge page for
these things is also another reason for some of this but that is more
long term.

I'm all for minor changes here so to avoid regressions but it seems a
rename is in order -- if we're going to all this might as well do it
now. And for that I'd just like to ask you paint the bikeshed with
Song Liu as he's been the one slowly making way to help us get there
with the "module: replace module_layout with module_memory",
and Mike Rapoport as he's had some follow up attempts [0]. As I see it,
the EXECMEM stuff would be what we use instead then. Mike kept the
module_alloc() and the execmem was just a wrapper but your move of the
arch stuff makes sense as well and I think would complement his series
nicely.

If you're gonna split code up to move to another place, it'd be nice
if you can add copyright headers as was done with the kernel/module.c
split into kernel/module/*.c

Can we start with some small basic stuff we can all agree on?

[0] https://lwn.net/Articles/944857/

  Luis

