Return-Path: <linux-kernel+bounces-141585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C47A8A2054
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5CA7284E9F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFB31C294;
	Thu, 11 Apr 2024 20:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="V6EvwT/B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1F4199B9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 20:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712868155; cv=none; b=nP0ejkxaza5/oRe7ZSIFXWgkOyVzQd8+RWibPBBI/wU/FW3B0ho0dr1/ka2hleJo21lxScdZjrPr5sl2IBw9ndGBPkEKpzxd6kWj6s8yXrlJtvUXZynYtLf/VC4fIaaYOH0n1BnCc8TGs8tRSy6kBME4GJCwfj8iTHp30qyCoTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712868155; c=relaxed/simple;
	bh=RUpCOmxxQLYhny5QSsaGDLDBRwT82ixFwRhLg360/4U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bv57Ra6c+Hxw6DBQiLkDscr0uYRT5rXnI8P5UWFwBSsNF2GCfOZCs3/FDkO5VvAGQC1MkRs+7lN/wr4dF6pc/yWLjtlBJzqJ6psmupDCXZ7qvLfNBicX+zY4di7vvBqi6z3XefYETaAtGRpVD3AFkEcDtDDN5+V+wgqUolsqhL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=V6EvwT/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AF0C072AA;
	Thu, 11 Apr 2024 20:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712868155;
	bh=RUpCOmxxQLYhny5QSsaGDLDBRwT82ixFwRhLg360/4U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V6EvwT/BrScs+PjqKRsxFJSoFDvE1Z2RqEMa3vf/gpBb1vNWnbPLoPvqw368a7/xj
	 9SQvkz0bpRsVMN3JNHV7X7Bu6sTrpdhC2tZMeCPmnr1NbEJ54YC6Vs/BtbGS56KJW1
	 zi6Bux8l92d8uSMLnLElzEyrK8Q/aEH0h0SHXmqc=
Date: Thu, 11 Apr 2024 13:42:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: Alex Shi <seakeel@gmail.com>, alexs@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, zik.eidus@ravellosystems.com,
 willy@infradead.org, aarcange@redhat.com, hughd@google.com,
 chrisw@sous-sol.org
Subject: Re: [PATCH v5 09/10] mm/ksm: rename get_ksm_page_flags() to
 ksm_get_folio_flags
Message-Id: <20240411134234.09920cdb641b3aa001526284@linux-foundation.org>
In-Reply-To: <47686d5e-efd3-4431-b72c-620f749faeaa@redhat.com>
References: <20240411061713.1847574-1-alexs@kernel.org>
	<20240411061713.1847574-10-alexs@kernel.org>
	<192aaa5c-3ff3-40c1-b12a-b674518bf5de@redhat.com>
	<add08bec-f474-476e-a985-9017dbb33a88@gmail.com>
	<47686d5e-efd3-4431-b72c-620f749faeaa@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Apr 2024 13:46:23 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 11.04.24 13:42, Alex Shi wrote:
> > 
> > 
> > On 4/11/24 3:51 PM, David Hildenbrand wrote:
> >> On 11.04.24 08:17, alexs@kernel.org wrote:
> >>> From: David Hildenbrand <david@redhat.com>
> >>>
> >>> As we are removing get_ksm_page_flags(), make the flags match the new
> >>> function name.
> >>>
> >>> Signed-off-by: David Hildenbrand <david@redhat.com>
> >>> Reviewed-by: Alex Shi <alexs@kernel.org>
> >>> ---
> >>
> >> s/get_ksm_page_flags()/get_ksm_page_flags/ in title, otherwise LGTM.
> >>
> > 
> > Uh, for this trivial issue, do I need to sent a new version? or left to maintainer for a quick fix?
> 
> I'm sure Andrew can fix that up :)

He indeed can.  Although he prefers foo() to foo.  Those two characters
have a good information-per-byte ratio.

Also I added Alex's Signed-off-by to this.

        (c) The contribution was provided directly to me by some other
            person who certified (a), (b) or (c) and I have not modified
            it.


