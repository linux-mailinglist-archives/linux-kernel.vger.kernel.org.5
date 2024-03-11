Return-Path: <linux-kernel+bounces-99546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFBB8789D2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AB66B2131D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BD156473;
	Mon, 11 Mar 2024 21:07:13 +0000 (UTC)
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC45240866;
	Mon, 11 Mar 2024 21:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710191233; cv=none; b=oQnqLVsUF+Nybc6yT/USORrJqat5YP8GTkhyp9sP6JewLo+kd44upyQUt79Xe/kGjqtZRNCdbnKB0ACCwQ9ki3I/AaiQ1+JYkjUyBjvhbtRFWl2/UsRLsMqf9KpQ9N8V0OGH0E2PHxVqA7OrgDJbxlNzQ0zqizr8qlbtQHbofIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710191233; c=relaxed/simple;
	bh=6OgwzesHM65rSXWdsn8D+IVbWJE6jtaACKtpcjezFqA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gdRBA/WLw5iqomMukOYiHCGmggXcvK83Qb+GYB1E4/gGDrD2M6IS4jEYQ53K2N902WUZ0R43SzkjAd/uOyH81zd1vWOKkcv7g2brL++gKRjfJhDi2ES7FwVUrUOT5pa1Gl25P1XzViywZZ5KhVhboAGMnirVTR2581MHtMrNLis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id 84FD440940; Mon, 11 Mar 2024 14:07:04 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 83FD84093E;
	Mon, 11 Mar 2024 14:07:04 -0700 (PDT)
Date: Mon, 11 Mar 2024 14:07:04 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Catalin Marinas <catalin.marinas@arm.com>
cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
    Mark Rutland <mark.rutland@arm.com>, 
    "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <vireshk@kernel.org>, 
    Will Deacon <will@kernel.org>, Jonathan.Cameron@huawei.com, 
    Matteo.Carlini@arm.com, Valentin.Schneider@arm.com, 
    akpm@linux-foundation.org, anshuman.khandual@arm.com, 
    Eric Mackay <eric.mackay@oracle.com>, dave.kleikamp@oracle.com, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, linux@armlinux.org.uk, robin.murphy@arm.com, 
    vanshikonda@os.amperecomputing.com, yang@os.amperecomputing.com, 
    Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3] ARM64: Dynamically allocate cpumasks and increase
 supported CPUs to 512
In-Reply-To: <Ze9TsQ-qVCZMazfI@arm.com>
Message-ID: <9352f410-9dad-ac89-181a-b3cfc86176b8@linux.com>
References: <37099a57-b655-3b3a-56d0-5f7fbd49d7db@gentwo.org> <CGME20240308140130eucas1p1259c805a0b6491ce2f69c6fca0264b1f@eucas1p1.samsung.com> <c1f2902d-cefc-4122-9b86-d1d32911f590@samsung.com> <Ze9TsQ-qVCZMazfI@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 11 Mar 2024, Catalin Marinas wrote:

>> This patch landed in today's linux-next as commit 0499a78369ad ("ARM64:
>> Dynamically allocate cpumasks and increase supported CPUs to 512").
>> Unfortunately it triggers the following warning during boot on most of
>> my ARM64-based test boards. Here is an example from Odroid-N2 board:
>
> I spent a big part of this afternoon going through the code paths but
> there's nothing obvious that triggered this problem. My suspicion is
> some memory corruption, algorithmically I can't see anything that could
> go wrong with CPUMASK_OFFSTACK. Unfortunately I could not reproduce it
> yet to be able to add some debug info.
>
> So I decided to revert this patch. If we get to the bottom of it during
> the merging window, I can still revive it. Otherwise we'll add it to
> linux-next post -rc1.

I also looked through the opp source and I cannot find even anything that
even uses the functionality changed by the OFFSTACK option.

This could be an issue in the ARM64 arch code itself where there maybe 
an assumption elsewhere that a cpumask can always store up to NR_CPU cpus 
and not only nr_cpu_ids as OFFSTACK does.

How can I exercise the opp driver in order to recreate the problem?

I assume the opp driver is ARM specific? x86 defaults to OFFSTACK so if 
there is an issue with OFFSTACK in opp then it should fail with kernel 
default configuration on that platform.


