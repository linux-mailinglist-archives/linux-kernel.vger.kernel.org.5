Return-Path: <linux-kernel+bounces-72229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E9C85B0FE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E67285086
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCB836102;
	Tue, 20 Feb 2024 02:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eoq6woNU"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5705510785
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708397729; cv=none; b=Lh1wSv3TZBQ8UkrY6i3H2PScRgw7W+3hseneiwmxTsK3cqu/IfrxHW3FvnL0eydZ3/2HEiku2avWphS5oCLAXQHWHV4WcB+6Ti3KmSVUd5sWgNq58dXkLUI/75E9M6n8APAkxgbvSMU8km7sfEr+pRFXITfPsrz8mDmCxnXy+Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708397729; c=relaxed/simple;
	bh=GWKiOBaI1NXNEeTj4/i0Fubm8+QDhv/MlOX8mgicbwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciTnijyaBATTfGcP9vEnC4isWyMkBnAXFmsc9PDuPaEsOzF39oxkVYEWfTxTZ9A+DvhA8G7kBmf54yez9+1pnLLm9BfZipag2IC90AnpKDa9iFgZZctEUB7Yl/Dmt62iG7CirCXjJZPFpyRKayujaJZhPdfMcUoOv/Jh4ibjseM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eoq6woNU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=1E5koHXnFE7yumxwYTorkvd0LXLJ4Nm9WirUlUAc9Pg=; b=eoq6woNUCQ8IdWXFKWSuL7LzpY
	nN3krH6BPAkPmjI+H/isne2ul5IkYpkNumdZNoLJUKa0cXB39rZ3X5nuUF0t4sbt2ggVxE+IjYPji
	rHEl73hk0rvuwQ0pRIIw29gfp+EuQos8mQMUoL2lAepuSaaBRYLum2KWtFvVyXytfJqMbfTWkpVL+
	MWi6ovQTAo1Ou/NTNYijLFg2xcw0RTiqxRRjEqbpPQe4WBkessjZRUzWqH6j/c8lzCv6/3JTheHmp
	YaRo+zzFE+dRlSMQ63bDMozLUDFq7/mbXbwhnai2WZuzvEhd2e3tT6NhNPoDAdhPkIpNIAN663n2y
	QO7X3IrQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcGHx-0000000ESL2-2C4x;
	Tue, 20 Feb 2024 02:55:21 +0000
Date: Tue, 20 Feb 2024 02:55:21 +0000
From: Matthew Wilcox <willy@infradead.org>
To: =?utf-8?B?5p2O5Z+56ZSL?= <lipeifeng@oppo.com>
Cc: akpm@linux-foundation.org, david@redhat.com, osalvador@suse.de,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	v-songbaohua@oppo.com, gregkh@google.com, tkjos@google.com
Subject: Re: [PATCH 0/2] Support kshrinkd
Message-ID: <ZdQUmWxYuuP24w_1@casper.infradead.org>
References: <20240219141703.3851-1-lipeifeng@oppo.com>
 <ZdOG-135dLP0IeU8@casper.infradead.org>
 <a642d9dc-6d48-016c-7007-c08ce8933d18@oppo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a642d9dc-6d48-016c-7007-c08ce8933d18@oppo.com>

On Tue, Feb 20, 2024 at 10:04:33AM +0800, 李培锋 wrote:
> Monkey-test in phone with 16G-ram for 300 hours shows that almost one-third
> 
> of the contended-pages can be freed successfully next time, putting back
> those
> 
> folios to LRU's head would break the rules of inative-LRU.

You talk about "the rules of inactive LRU" like we care.  The LRU is
an approximation at best.  What are the *consequences*?  Is there a
benchmark that executes more operations per second as a result of
this patch?


