Return-Path: <linux-kernel+bounces-28310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B04BB82FCD1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 624AF1F2D6B5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47985FDAA;
	Tue, 16 Jan 2024 21:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="R4TMM6cY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7ED35294
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 21:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705440909; cv=none; b=nRa0O/G+qxuYfYh7y2bQgWXn6BL4UPsR3aJtr5OLX6TceB4KAwXUGBfQQrLNExEp4HfvDhL/yPVkvAbMHvX3vPG4rmcNlqZsXyCAbn9sN59PD5m9ol4fUsixMThZhFLXtYGFIO3XEalN/cH+3sEj4oYg3kCygoCzbCDPlhHKOkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705440909; c=relaxed/simple;
	bh=bPen2UlJBQHqlE5Ug6ywd00xGmHMjUIJMoNwx2nzRs8=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding; b=cr78csN/99jpmmdKKD6EJVhzT7o2iFxkzsGY9BwutNhUIwjlHTC8DLeCRiUfwdc+ydKfJblaFjhk0KH5RbvmIjLTNt4KGtY4wdkHOsfaME3jkjhv+CzM1D3PkT+Ee4uGgYAc9/VRMpP5G+O2LDPLx47JZTMDfHOJgV98f+xtpcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=R4TMM6cY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078C3C433C7;
	Tue, 16 Jan 2024 21:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1705440908;
	bh=bPen2UlJBQHqlE5Ug6ywd00xGmHMjUIJMoNwx2nzRs8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R4TMM6cYbYJ6c+IO6jgzz2hg7i3Wdcfr68C0CGqHuWeTiOtSD/q+pfKhJTU3KvReL
	 oLztrJzfYcnzY1pK4BhyAtmaEDL4VCYQNE3z9lHMMqbYJhfm2yOj5sgSjQBvMnj+DU
	 xDATszVOytHlHxzq0miFlHmn8NFyU34NeQOHVvh4=
Date: Tue, 16 Jan 2024 13:35:03 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, Johannes Weiner
 <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>, Christoph Hellwig
 <hch@infradead.org>, Nhat Pham <nphamcs@gmail.com>, Domenico Cerasuolo
 <cerasuolodomenico@gmail.com>, konrad.wilk@oracle.com,
 vitaly.wool@konsulko.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: kill frontswap
Message-Id: <20240116133503.4fb4ea28db43989795a6915d@linux-foundation.org>
In-Reply-To: <CAJD7tkZRnywCj4ha2hMcjQU7OjfR8DQ-Pi8K89NADxObCXvsMA@mail.gmail.com>
References: <20230714194610.828210-1-hannes@cmpxchg.org>
	<ZLIVleBYOm4HIGTZ@casper.infradead.org>
	<20230717141250.GA866068@cmpxchg.org>
	<901409ed-504b-9500-54d8-e42f832e07b0@suse.cz>
	<20230717160227.GA867137@cmpxchg.org>
	<20240116120944.01f25e65d13f0fc7e2a2df34@linux-foundation.org>
	<ZabknuNmymSP0XgG@casper.infradead.org>
	<CAJD7tkZRnywCj4ha2hMcjQU7OjfR8DQ-Pi8K89NADxObCXvsMA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 16 Jan 2024 12:22:03 -0800 Yosry Ahmed <yosryahmed@google.com> wrote:

> On Tue, Jan 16, 2024 at 12:18 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Jan 16, 2024 at 12:09:44PM -0800, Andrew Morton wrote:
> > > On Mon, 17 Jul 2023 12:02:27 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > > The only user of frontswap is zswap, and has been for a long
> > > > time. Have swap call into zswap directly and remove the indirection.
> > >
> > > This falls afoul of "mm: zswap: multiple zpools support".  Could we
> > > please have a version against mm-unstable or linux-next?
> >
> > Did this email get caught in a timewarp?  Or is it referring to
> > something that isn't commit 42c06a0e8ebe from six months ago?
> 
> +1. Both of these changes have been in Linus's tree for a while now.
> Perhaps Andrew had this email prepared a while ago and never sent it,
> and ended up fixing the problem himself.

erp, sorry, Flushing out the drafts folder after a long flight.  On a
wifi-free airline, wtf.

