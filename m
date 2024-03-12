Return-Path: <linux-kernel+bounces-100706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6682879C38
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFB391C21ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D55F142642;
	Tue, 12 Mar 2024 19:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kc6QvLyI"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FCB139584
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 19:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710271383; cv=none; b=PzM8dGMO3sGnyAtI7HUsdleSsP725yYgO0biHIQt8HS6sKIC7oV3TvzY/sTHRS2Rwhbiy/a5vjiikb9n7Rno2ctmGuAGXkZcFRjUKx4HHp8F/EpZndV18BC4fgmZYegy7ifv0RRZj8YOcVFWUYQHJoDsL3dlPb9OV62zeXnjRBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710271383; c=relaxed/simple;
	bh=wGe4NtRVvq65gwI+YLU+QcE40ieDr/r4U/4hul+164M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvQuJdS3C06j8iIEs/ITR7ngrtvSgqgmNcRdLKn1KSAy6gqCFOu2MewO/YAV57/Vzdkhj4RoY+chGkogMuda2+r4EQu0PQWxYMhJawxQu4ND52BL42jUMRwUYwsighsbq+i1QYzogSGcv6AWHg30Vep0GiMBsiyCqBUbrnEvU5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Kc6QvLyI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hOqhR5v2VNSn/TDffh5ABY/7jmiPiJOXuY0ZoZRPkdY=; b=Kc6QvLyI32dNT8583+E0evpKxC
	P3MEsW7OzbyTuRmIglSx1a0xMyy5smgbQDiCws+YwaPWLa1jyaqLkYiFJQy18SwzLHrwMLfaHjuHs
	Vux4YUNU9xYpCeflwFEteBcqMrs1q/zxhPOS5Tob/5NgA/nE5YrIHNYw4AcTw311qXnqx9e6HCFBK
	sjYnpKt6GwaLk5aJDKXpO3HboZffKmLHVKAhDM17dmeXO7UfUFyRQ7Ad0JkMZvU2umSGf5TmsJ7cg
	PMciUfgrqDpV0CbPl1tjrMh26aUqeTDLwPjeNc4MkNuB8UAvHcE7P+FbRX2mdotJqMPdbLnzAwyOr
	RjZCNNfQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk7iC-00000003j7D-0qvF;
	Tue, 12 Mar 2024 19:22:56 +0000
Date: Tue, 12 Mar 2024 19:22:56 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	Wupeng Ma <mawupeng1@huawei.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1] x86/mm/pat: fix VM_PAT handling in COW mappings
Message-ID: <ZfCrkL-Aieer2EAg@casper.infradead.org>
References: <20240312181118.318701-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312181118.318701-1-david@redhat.com>

On Tue, Mar 12, 2024 at 07:11:18PM +0100, David Hildenbrand wrote:
> PAT handling won't do the right thing in COW mappings: the first PTE
> (or, in fact, all PTEs) can be replaced during write faults to point at
> anon folios. Reliably recovering the correct PFN and cachemode using
> follow_phys() from PTEs will not work in COW mappings.

I guess the first question is: Why do we want to support COW mappings
of VM_PAT areas?  What breaks if we just disallow it?

