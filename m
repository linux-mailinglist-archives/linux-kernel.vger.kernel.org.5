Return-Path: <linux-kernel+bounces-673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F1D814446
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998BF1F226F7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8111A713;
	Fri, 15 Dec 2023 09:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hD7BQDIP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A27E1A702;
	Fri, 15 Dec 2023 09:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EjQVaMh5tZJ+7a0UpE9iUFxun+60dNm7eqO8aieQnhM=; b=hD7BQDIPvu5gi57uCMbykn/8Tk
	o0WUo7Cu49RqeqmA1Ix/Yr6c4TUQIslJVZcQoYr+vpKgM14NxpQY36QIK9m1++aZPLXj6NaNkgghP
	f1bQSuOB3wGuyTcQzLEA3MRYpCLbVKenLVMnWAVKL9D4YFFERCly61XQbaFBXO7YJcadimNi0VSGM
	g326RtxEjSrUjr7dKyB7LXgzDWKC9Na8aE8Ex1pSoN4LnSsoJvmH87tdDPE0JTMUVqcTLil3nw7Is
	crw9/G/+7fQmajUvMbhUM5AmrBj2rPwIikoTJ5FMs8XsacJXJQlCvZ6U/UQCACKFRN7bMka7K0nYL
	Ek5U1nCQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rE4De-009r2i-1m;
	Fri, 15 Dec 2023 09:10:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7324330049D; Fri, 15 Dec 2023 10:10:53 +0100 (CET)
Date: Fri, 15 Dec 2023 10:10:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, paul.gortmaker@windriver.com,
	x86@kernel.org, regressions@leemhuis.info,
	richard.purdie@linuxfoundation.org, regressions@lists.linux.dev
Subject: Re: [patch 0/2] x86/alternatives: Prevent crash in NOP optimizer
Message-ID: <20231215091053.GI36716@noisy.programming.kicks-ass.net>
References: <ZXCXc+BtnLzqMbFv@windriver.com>
 <ZUEgAAGDVqXz2Seo@windriver.com>
 <0adb772c-e8d2-4444-92b0-00cbfdaf1fac@leemhuis.info>
 <87r0k9ym0y.ffs@tglx>
 <20231207193859.961361261@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207193859.961361261@linutronix.de>

On Thu, Dec 07, 2023 at 08:49:22PM +0100, Thomas Gleixner wrote:
> The following series addresses the regression report from Paul on behalf of
> the yocto project. It turns out that the recent changes to alternatives
> opened a race window where interrupts are enabled and NOPs are optimized in
> place. An interrupt hitting into the modification will observe inconsistent
> text and crash and burn.
> 
> A 32bit QEMU crashes w/o these fixes reliably within about 50 boot
> attempts. With the fix applied it survived close to 600 attempts by
> now.
> 
> Thanks to Paul for providing all the information!

Urgh and D'0h.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

