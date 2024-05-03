Return-Path: <linux-kernel+bounces-167872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309A38BB093
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 607871C209D2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A14155339;
	Fri,  3 May 2024 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDHJj670"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CF4155321;
	Fri,  3 May 2024 16:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714752504; cv=none; b=rPu4t4T8/xVGwWIMgAcCXDg2M71wmKYiMHtXvGXmK5ZiwIMjmitnQ4dYCmY9GzxUI68IBp0aofshX9De9ELrDBbJI3cKse3jvGWwzjhAqhLBPAqt6SBeg9InW4dL9HErvOn8WdKklfhcJ3yn1yez/tlTRGXe3uv15F/SU065TbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714752504; c=relaxed/simple;
	bh=Op1fwSHEx5VUMYnhUE1pmFnrDf64oFwBqfLu6MjJiGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxPzYmAJldtZO8zgwDF1S0Q4QYO9juqftHVUwg1C9dVw1JSK273jh5wHY9mgU1yCGk+Ff4nv0EjyIwuSxLGKgSeIMyxyvf3RLsvHYzOFdQGwtGw7wu+0mwrk7YjVe6hdvmdbS86iZhB6Jum8feIm80qCDGLlzcLyfe88dIsT4x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDHJj670; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2C2C116B1;
	Fri,  3 May 2024 16:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714752504;
	bh=Op1fwSHEx5VUMYnhUE1pmFnrDf64oFwBqfLu6MjJiGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hDHJj670+u4EudbKqjlYrFhMEQ+DkMYCstxBrVboCyhLYRGS0YHQkCoXlQC0CmB/b
	 yOVnRxKraKTtqBMDsOc2e13JJBxpx0FvQgmSu/HFEIXWspIn1oaSjUxxQRPfIItKdc
	 qxtjxZQAUm2azBafIErhdPJvylutd9zIW+Gonbqq+rvkkZaKgukRihbrpKjvuBXfqA
	 y+0oGYHBrgGwMZodjCgeSxGtYy6d7xN0raodKgWt839+OEwU+i+n1PGq64QPlRyVmT
	 4elwlDcZxOtkxHgL7R4CBZQu3vlvP6c+AHFqJj0ec8kTcDd7mUXwVn+rjHKcA+2lw7
	 bFy5iBEPazORw==
Date: Fri, 3 May 2024 09:08:21 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, akpm@linux-foundation.org,
	Liam.Howlett@oracle.com, ndesaulniers@google.com, morbo@google.com,
	justinstitt@google.com, linux-kernel@vger.kernel.org,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	llvm@lists.linux.dev, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH] maple_tree: Fix build failure with W=1 and LLVM=1
Message-ID: <20240503160821.GB3960118@thelio-3990X>
References: <20240503095027.747838-1-visitorckw@gmail.com>
 <ZjTWkM9hTnoIhzqV@casper.infradead.org>
 <ZjTgEsuxYF29AVFJ@visitorckw-System-Product-Name>
 <ZjTmqM4ePSZgSt9_@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjTmqM4ePSZgSt9_@casper.infradead.org>

On Fri, May 03, 2024 at 02:29:12PM +0100, Matthew Wilcox wrote:
> On Fri, May 03, 2024 at 09:01:06PM +0800, Kuan-Wei Chiu wrote:
> > On Fri, May 03, 2024 at 01:20:32PM +0100, Matthew Wilcox wrote:
> > > On Fri, May 03, 2024 at 05:50:27PM +0800, Kuan-Wei Chiu wrote:
> > > > When compiling library code using "make W=1 LLVM=1 lib/", clang
> > > > generated the following compilation errors:
> > > > 
> > > > lib/maple_tree.c:351:21: error: unused function 'mte_set_full' [-Werror,-Wunused-function]
> > > > static inline void *mte_set_full(const struct maple_enode *node)
> > > 
> > > Uh, clang is wrong to flag these as an error.  They're just not used
> > > yet.
> > 
> > I think it's because the kernel defaults to treating all compilation
> > warnings as errors. If you turn off the option to treat compilation
> > warnings as errors, they will be treated as warnings instead. Should I
> > update my commit message to change compilation errors to compilation
> > warnings?
> 
> just don't use W=1 and clang.

This patch has effectively been sent four times now:

https://lore.kernel.org/all/20220914101829.82000-1-jiapeng.chong@linux.alibaba.com/
https://lore.kernel.org/all/20230217084647.50471-1-jiapeng.chong@linux.alibaba.com/
https://lore.kernel.org/all/20230319132903.1702426-1-trix@redhat.com/
https://lore.kernel.org/all/20240503095027.747838-1-visitorckw@gmail.com/ (this change obviously)

Your first comment from the 2022 patch:

  They're not used now, but they will be in a release or two.

I think a few releases have passed since then :) I don't personally care
if there is a solution here or not, as I don't test with W=1 (there's
enough to do at W=0 :P), but maybe it is time for either __maybe_unused
(as that strikes at the heart of the issue) or at the very least a
comment saying "hey, these functions are currently unused but there are
plans for them to be used, so don't remove them", rather than just
saying the status quo?

Cheers,
Nathan

