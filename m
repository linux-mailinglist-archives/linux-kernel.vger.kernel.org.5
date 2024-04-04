Return-Path: <linux-kernel+bounces-132069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA34D898F52
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74A1B287C1A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBDB13473D;
	Thu,  4 Apr 2024 20:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="v3ZDjcx2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5705D134439
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 20:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712260866; cv=none; b=ee07MmtxMnN8mpaF508yJKi2DbFnOwDaxbw4NJmjh9aJj0I+80oWGFuH0BNzC51Eage9S2/ZgSFgdTchhtJvC1xsdOuhLE9aFJPAUG85PDUlWVf7nAhtKLht6nsBGVrK8hbP7XTm+Q4lPQhHSMvnaLtIqPrz3sHRMHHGIjfXbfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712260866; c=relaxed/simple;
	bh=jDgRvDUXquf8+1TaLuMSDg9OKMhNKkoBxWlEmTKp85E=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pQ3+up/+563YCIVNqIvbxvREZ8kjRBbdmlyCYWH0yHRS8PzukWJ72DeWnJCs7qXF+8P815jMG+8MhYJT5hSqbT/Myzo27OcFXKNP19khUMHusx41SksNnNTawOy3pQG4ufNPXWh07TmOW2jE+wNH519HH0qf55XnYwkWZeoXSFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=v3ZDjcx2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37915C433F1;
	Thu,  4 Apr 2024 20:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712260865;
	bh=jDgRvDUXquf8+1TaLuMSDg9OKMhNKkoBxWlEmTKp85E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=v3ZDjcx2JDn180LtBtTUY0btLp75KXzlujdo9T4C8aNGCv0gHU1XYnl09OcNjXzsv
	 MxprMsVHDbcCEy7oF5q3Tc/g3dZIs8phM8mN/U0d1LRHN2+YhVANRC5jroDLIwWA5/
	 KlIjzseq8tJWn951wgdkSfWHObVQ00Hj0SNj83CI=
Date: Thu, 4 Apr 2024 13:01:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas
 Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>, Borislav
 Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
 <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Fei Li
 <fei1.li@intel.com>, Nathan Chancellor <nathan@kernel.org>, Wupeng Ma
 <mawupeng1@huawei.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 2/3] x86/mm/pat: fix VM_PAT handling in COW mappings
Message-Id: <20240404130104.858c02d23216eb82438444d9@linux-foundation.org>
In-Reply-To: <bced0912-4e30-4354-93f3-d6075952b5b5@redhat.com>
References: <20240403212131.929421-1-david@redhat.com>
	<20240403212131.929421-3-david@redhat.com>
	<20240403151249.0f4fc5b4f8c07630fbbb6338@linux-foundation.org>
	<bced0912-4e30-4354-93f3-d6075952b5b5@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Apr 2024 21:20:06 +0200 David Hildenbrand <david@redhat.com> wrote:

> >> Reported-by: Wupeng Ma <mawupeng1@huawei.com>
> >> Closes: https://lkml.kernel.org/r/20240227122814.3781907-1-mawupeng1@huawei.com
> >> Fixes: b1a86e15dc03 ("x86, pat: remove the dependency on 'vm_pgoff' in track/untrack pfn vma routines")
> >> Fixes: 5899329b1910 ("x86: PAT: implement track/untrack of pfnmap regions for x86 - v3")
> > 
> > These are really old.  Should we backport this?
> 
> I was asking that question myself.
> 
> With the reproducer, the worst thing that happens on most systems is the 
> warning. On !RAM and with PAT, there could be memory leaks and other 
> surprises.
> 
> Likely, we should just backport it to stable. Should not be too hard to 
> backport to stable kernels I guess/hope.

OK, thanks, I added the cc:stable tag.

