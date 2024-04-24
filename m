Return-Path: <linux-kernel+bounces-157732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F238B1523
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD61F1F24505
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18056156C57;
	Wed, 24 Apr 2024 21:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M8WWLQWq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579E913C9DE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713993611; cv=none; b=fe4W0182iOX+3NEnYRXXLVnaW/eRGkNjjQkVhLqwP18kZjceajCwlQJO14mhwPVTCJFle4LmFGqihSP2JV7SfJPQDgWUHMEw/zqkajQ3FmtFGwWnI8eI7H7gEKjp9e4D2VCcmSr437CwA7YxORcaCR3GVYPO3N8rirgn29g3QKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713993611; c=relaxed/simple;
	bh=GrjNEdck+k+VpT+CPfrPUvz7/fnE4GeQWJaxKgyyI7Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aP23N7qdme4xqUrKAb4XitcFWPlMiY+g0a8qNE5qj4sMOoSSytAR26PZpBwaehjYxs8kVXS7Sb9hGNnqlb4kWJnqM7MkBYrRJkXaVjPW96BacLjPQ0QPL+N6Dccy0bjFytlwhBEz7SR12im/32ddJBb7+AdKhuHAwpTZdzX84oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=M8WWLQWq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D60C113CD;
	Wed, 24 Apr 2024 21:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1713993610;
	bh=GrjNEdck+k+VpT+CPfrPUvz7/fnE4GeQWJaxKgyyI7Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M8WWLQWqXAGC5AJWDe0qHoNDaRU9IdxcFIfG2aL6YAUWd30ejte+TtJWWSE88qtJ3
	 AFiACzTGRSUgx/NraUv6oh9V7pvfQnkLZksYEP/Y4xPD3mi56ORmSnVPxS37oPBa6p
	 WrcBJ6ufW+tUtZEDuL3sEjWZCPe0zEYeByuKo56s=
Date: Wed, 24 Apr 2024 14:20:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lance Yang <ioworker0@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, maskray@google.com,
 ziy@nvidia.com, ryan.roberts@arm.com, david@redhat.com, 21cnbao@gmail.com,
 mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com,
 shy828301@gmail.com, xiehuan09@gmail.com, wangkefeng.wang@huawei.com,
 songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mm/vmscan: avoid split PMD-mapped THP during
 shrink_folio_list()
Message-Id: <20240424142009.149eb988cca33822ce0fd0f1@linux-foundation.org>
In-Reply-To: <CAK1f24kaHcKOS1ajfLney-1+Pqrwrk_0LWqRr2DmZ+41YBzXug@mail.gmail.com>
References: <20240422055213.60231-1-ioworker0@gmail.com>
	<ZiiHSwG_bnLJbwfb@casper.infradead.org>
	<CAK1f24kaHcKOS1ajfLney-1+Pqrwrk_0LWqRr2DmZ+41YBzXug@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 24 Apr 2024 23:46:59 +0800 Lance Yang <ioworker0@gmail.com> wrote:

> On Wed, Apr 24, 2024 at 12:15 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, Apr 22, 2024 at 01:52:13PM +0800, Lance Yang wrote:
> > > When the user no longer requires the pages, they would use
> > > madvise(MADV_FREE) to mark the pages as lazy free. IMO, they would not
> > > typically rewrite to the given range.
> > >
> > > At present, PMD-mapped THPs that are marked as lazyfree during
> > > shrink_folio_list() are unconditionally split, which may be unnecessary.
> > > If the THP is clean, its PMD is also clean, and there are no unexpected
> 
> "If the THP is clean, its PMD is also clean" can be confusing - sorry. It should
> be modified to "If the THP and its PMD are both marked as clean".

I made that changelog edit.

