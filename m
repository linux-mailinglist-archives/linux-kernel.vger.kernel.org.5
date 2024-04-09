Return-Path: <linux-kernel+bounces-136549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2866589D578
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9DB41F23530
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3CF7F482;
	Tue,  9 Apr 2024 09:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d4qqSS7f"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DEE2B2DD
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654678; cv=none; b=pHrbhTstNZ9eK9b5akBHu++HasFyT5ENJvWYjQQsxKcIHCbCfMsD1g0WFiOxoRhmgGrnjFfGkkZ5mSmbr4VGRlj23hHV/NODF+A7thua+mgp17eOZNoMidLKLe0kREeZsokqvZSrSnctQHV7DV8k6Zgnn7gNhzqUo2qR37sXWd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654678; c=relaxed/simple;
	bh=pDn91/LDDz2c2pSp6ASDfLb6o0elyl6boAw4QkMt+m8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JN6GviYxXhborJDvN3jAi0+C4lgvfeI3nHXBrBZM6xg705vXG1qd7Qod1m4cYY6Z4cno2LnnuY26ehKytu9ojJS8rn32Pljnkq7ng6ZP8fgvscnIGPgDR6fy2NbbGQbgqreTkt6wA8ycdRfu2b3rYMsbxo9Q0PDR0LJDKemgW8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d4qqSS7f; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EnEcIvvsEn/85gou4VnazrjdRGksKJ0kBm/xoUbL+Go=; b=d4qqSS7fXgczE2PAuj2E9kOS6B
	yRrNOwOJa39nanc8mM3bA3h/Zlb67DPnMlFoPd0v7XCeRkS7ZRQBeMsWS9F3Rhcc16l2ZhbDd1pY5
	1CzM4/cuV3N4d6oi1pN+ZuwOUQ41srjk7nMrfIg0/AzKjPMmCkbkRFW93v+jxue5WOboY8Ub6o7Ue
	VLPKPkgjnZ+htifX7l6gY/bF3zb+5b7ZIKlxJDx5yC/UV8gkSkLyZu7jx1XBJ6Nn2SAneZMMD1SZi
	mUtsRP2rDnVFGUfosT7O1FZ5GkOrwEV+TtQjyyYmd+TFFjhe4lDq4jQDMnZWnV5tCNy/xVx8EQ9Nw
	anfQYvrw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ru7iC-00000001o6u-1VQN;
	Tue, 09 Apr 2024 09:24:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 080B730040C; Tue,  9 Apr 2024 11:24:16 +0200 (CEST)
Date: Tue, 9 Apr 2024 11:24:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Alexey Dobriyan <adobriyan@gmail.com>, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, linux-kernel@vger.kernel.org,
	Jonathan.Cameron@huawei.com, linuxarm@huawei.com,
	linux@roeck-us.net
Subject: Re: [PATCH 1/2] x86/cpu/topology: don't write to immutable
 cpu_present_mask
Message-ID: <20240409092415.GB2665@noisy.programming.kicks-ass.net>
References: <20240407152643.3245-1-adobriyan@gmail.com>
 <87ttkc6kwx.ffs@tglx>
 <ZhT/ZTdRN+Gxfe8S@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhT/ZTdRN+Gxfe8S@gmail.com>

On Tue, Apr 09, 2024 at 10:42:13AM +0200, Ingo Molnar wrote:
> 
> * Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > On Sun, Apr 07 2024 at 18:26, Alexey Dobriyan wrote:
> > > Workaround the following oops:
> > >
> > > 	topology_hotplug_apic
> > > 	topo_set_cpuids
> > > 		set_cpu_possible(cpu, true);
> > > 		// write to __ro_after_init section after init
> > 
> > Duh, yes.
> > 
> > > adobriyan: I'm not sure what's going on, can it set unset bit here?
> > > If not, then why does it repeat the job and set already set bits.
> > >
> > > Anyhow, let's not oops peoples' machines for now.
> > 
> > Adding a bandaid to paper over the non-understood real problem is
> > definitely not a good plan. I take this patch as a bug report.
> > 
> > Proper fix below.
> 
> BTW., independently of the fix, warning about a too late set_cpu_possible() 
> might still make sense - clearly it *can* be called too late by 
> architecture init code :-)

Make the function __init ? Then it goes away right when the data becomes
RO.

