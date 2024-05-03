Return-Path: <linux-kernel+bounces-167705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D07FB8BADB8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89EA128326A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5E6153815;
	Fri,  3 May 2024 13:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vyLLstx7"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF70115357A;
	Fri,  3 May 2024 13:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714742961; cv=none; b=Ph4Ss778ZBNp8xojyTytcXoEVoBhfkhdWxCTYnd4DG35boGk0Rta4vM2MkJjLBJYRiTcdBSPVoIR2Hm11oBeKhNvnaAgQbhQn6Q5hUp/3BEXW1DtaNx85CVQzmz/BKTEbOBw4Z/9a7XanBMNhOhuSpdfSuMluj5SvsS/JzsfIFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714742961; c=relaxed/simple;
	bh=EpMKjbaB80+4IW6xe42kSBS3TKnJUW1btmMLZFFNbK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTYvBQWJA1RsYVBUuo41d5sLOgG+hFSy/dcF0ESYN4A2wug5qZUF5odKmt6eJLQZOpshnOlxpf9VaVUU1SgQdBduK6aE4gnrW7Llt4BFqEiHhm8fabjJnf1NqeJ+HBM3f5dM6/wdFsVuWpHjVVgnFer+Q+rPy1coNCbNCp2728Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vyLLstx7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=B4vGEHzdNP0JI6MVfnMEc2HH+iREkCFMbJn5Sb6HqFk=; b=vyLLstx71zYQ4dLqtph2CDUj+p
	4fnR6BL+Okz+uf4nf849UeSXiDvMt+xq7tyKuk0lm914JHid160ckzKjMqDnGRrB92NX/rV4DG/4J
	DdQZ2cFbc7fMdr1eLEOpLfXaDJb42IX9fPpf8TfE+uib6H2/eY22UbRTA/SH8GTX68ufvPrAch9EE
	ABPi6BKh+FehylrEaqHRW5UPjwlPUztLXVkmasu812PxMNZ3gNcKg15FrNpj3d/EikJ/f1qJ+jLkG
	RuzWOMg4g3xEY1B6oOy6K9m2VBMDGLXDOqgcAcN2A+ORCVk0u5/AspambjlJfRt9TROFVnZaox04h
	NKMaPoIw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2syO-00000004AOu-3hKo;
	Fri, 03 May 2024 13:29:13 +0000
Date: Fri, 3 May 2024 14:29:12 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, nathan@kernel.org,
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
	linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
	linux-mm@kvack.org, llvm@lists.linux.dev, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH] maple_tree: Fix build failure with W=1 and LLVM=1
Message-ID: <ZjTmqM4ePSZgSt9_@casper.infradead.org>
References: <20240503095027.747838-1-visitorckw@gmail.com>
 <ZjTWkM9hTnoIhzqV@casper.infradead.org>
 <ZjTgEsuxYF29AVFJ@visitorckw-System-Product-Name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjTgEsuxYF29AVFJ@visitorckw-System-Product-Name>

On Fri, May 03, 2024 at 09:01:06PM +0800, Kuan-Wei Chiu wrote:
> On Fri, May 03, 2024 at 01:20:32PM +0100, Matthew Wilcox wrote:
> > On Fri, May 03, 2024 at 05:50:27PM +0800, Kuan-Wei Chiu wrote:
> > > When compiling library code using "make W=1 LLVM=1 lib/", clang
> > > generated the following compilation errors:
> > > 
> > > lib/maple_tree.c:351:21: error: unused function 'mte_set_full' [-Werror,-Wunused-function]
> > > static inline void *mte_set_full(const struct maple_enode *node)
> > 
> > Uh, clang is wrong to flag these as an error.  They're just not used
> > yet.
> 
> I think it's because the kernel defaults to treating all compilation
> warnings as errors. If you turn off the option to treat compilation
> warnings as errors, they will be treated as warnings instead. Should I
> update my commit message to change compilation errors to compilation
> warnings?

just don't use W=1 and clang.

