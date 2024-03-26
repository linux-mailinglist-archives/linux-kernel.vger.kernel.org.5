Return-Path: <linux-kernel+bounces-118307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B8688B784
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 076001C35B52
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082551D53C;
	Tue, 26 Mar 2024 02:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yzb+hCzp"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127CD57314
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 02:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711420696; cv=none; b=fGe4EHajW/7zL5OZXpTmXY+Zmg9WsXKvcz4vgEErusrTjymtx25AehPLBHSqIgOIS11uGrA0g4lsB0FaO0//UgpVXOzOtjoZDrL2mqAr3GlZEDYNQqevCtYYACleow2Ye8/2UZ9pDwoEShimAWB9EusDcby0RDMggxIPvPmkhr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711420696; c=relaxed/simple;
	bh=HnFm+A9qW3Sao+BRj4HydAB/I6+qsg4Ok7mMrweomOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukLq/efp2Gpjl9WUYMV3IG1W25uIAavbi7HUDeCzoP3FTq5rkwyHX1zPNnjYwYUgU5B+aWWZwJbPaHSYwIeo13qRz9vZTJIEeBv3vUGfE5ExAb5Qqj9CHkoFDuauCaDfWq6X+lr5TELkXIzpEYDjI+YlJJESdR0kGQlsnY0zv10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Yzb+hCzp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=W3EmlvMxvmSCZUfAMehehHFG2uVjyj7K2eHcds6LHvI=; b=Yzb+hCzpAwApFvOQV2sw1RYBun
	R1RMqIjoSN+VO36z8aaEhs5nrl5cLdArIfBSmof4cSjhQJ6KVwqTcrsKYRvi7bsCdHo2DhgmWHgDY
	a/AMF1vblqSf7IJN8W1wNXpggEWCuU6Vk/b/pWSRpi185A8fzF+Ctneg4Wgq+42G+WA8b+Xx9FzUI
	gfIh7VM35q1rdwRfFBwE1Rd3zXbVsKbq8c87TZ57Ua6A95ZnEsTqL3Z7KnRFy1fFGOAVkfpzR2Wsr
	0yOjl2lUEh0Q4Asp/gPIioO11SbuKAGslI40NyL6vuUnkLdcTMEdsBnUB/uut6MCdS4XKWaFRqC/N
	Adowfrug==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rowhM-00000000HwW-3xaQ;
	Tue, 26 Mar 2024 02:38:01 +0000
Date: Tue, 26 Mar 2024 02:38:00 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, muchun.song@linux.dev
Subject: Re: [PATCH 4/5] mm: Make pgoff non-const in struct vm_fault
Message-ID: <ZgI1CF2dw-mauoIZ@casper.infradead.org>
References: <20240325223339.169350-1-vishal.moola@gmail.com>
 <20240325223339.169350-5-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325223339.169350-5-vishal.moola@gmail.com>

On Mon, Mar 25, 2024 at 03:33:38PM -0700, Vishal Moola (Oracle) wrote:
> Hugetlb calculates addresses and page offsets differently from the rest of
> mm. In order to pass struct vm_fault through the fault pathway we will let
> hugetlb_fault() and __handle_mm_fault() set those variables themselves
> instead.

I don't think this is a great idea.  I'd rather not do patch 5 than do
patch 4+5.  If you look at the history, commits 742d33729a0df11 and
5857c9209ce58f show that drivers got into the bad habit of changing
address & pgoff, so they got made const to prevent that.

So can we make hugetlbfs OK with using addresses & pgoffsets that aren't
aligned to HPAGE boundaries?  Worth playing with for a bit to see how
deep that assumption runs.

