Return-Path: <linux-kernel+bounces-130670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A24D897B78
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BBA81C25B3D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BA015698D;
	Wed,  3 Apr 2024 22:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KfvaZ5i/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D513415697B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 22:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712182370; cv=none; b=l3RSAWXkb5oK26hMeudE6fgnSBZVxuNp9U5VDUY0pFXoumJoZ9+MkN2UamCwv52oZ8Hs8l138F5zubCPaHSDg5pQVvN8+ybkx+xX8f2mCgDdQyYkf4AAcqa2jxMh7jDpPLd9SesK1X2VfcNPq7KC9z9ED8/5gdCrIxtYiwK3XFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712182370; c=relaxed/simple;
	bh=roWU9RuueugFHJ+VZi2kPiMpLoS/48KqVlv8GvhGgkg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UH47b9FuUZm3F9/46wC4dQ3MsClkyiX+d31k+mY4CF4mAUkbI/KYLzwm59Q6MB/Z/E4iBbA5W0zD2gBG0Su30HhYajCYuWonUp9XoecLoDtxo9Ny3RPzDboiIgH7DNvbEbErNBY1pF3GUk+nAkPY0MaQjNEMVFY234ltR2//HNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KfvaZ5i/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C35C433C7;
	Wed,  3 Apr 2024 22:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712182370;
	bh=roWU9RuueugFHJ+VZi2kPiMpLoS/48KqVlv8GvhGgkg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KfvaZ5i/irPWoKLIwbxSJu5us9boUGd7c13hto//1WOxmJEBxAS0AHDzhUhL/sKvw
	 7tt34LuWK1rREpZXtS6Z5AaufOT+N8BOh+ulQg2dWe+a4271x3hOIcsFabHeQhOpTa
	 tGhWU8H4JNBLo9e07aKh0zpuH7Ag1zXDrJNIbmtI=
Date: Wed, 3 Apr 2024 15:12:49 -0700
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
Message-Id: <20240403151249.0f4fc5b4f8c07630fbbb6338@linux-foundation.org>
In-Reply-To: <20240403212131.929421-3-david@redhat.com>
References: <20240403212131.929421-1-david@redhat.com>
	<20240403212131.929421-3-david@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Apr 2024 23:21:30 +0200 David Hildenbrand <david@redhat.com> wrote:

> PAT handling won't do the right thing in COW mappings: the first PTE
> (or, in fact, all PTEs) can be replaced during write faults to point at
> anon folios. Reliably recovering the correct PFN and cachemode using
> follow_phys() from PTEs will not work in COW mappings.
> 
> ...
> 
> Reported-by: Wupeng Ma <mawupeng1@huawei.com>
> Closes: https://lkml.kernel.org/r/20240227122814.3781907-1-mawupeng1@huawei.com
> Fixes: b1a86e15dc03 ("x86, pat: remove the dependency on 'vm_pgoff' in track/untrack pfn vma routines")
> Fixes: 5899329b1910 ("x86: PAT: implement track/untrack of pfnmap regions for x86 - v3")

These are really old.  Should we backport this?


