Return-Path: <linux-kernel+bounces-92390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8FD871F6B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECFACB2661F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7458485920;
	Tue,  5 Mar 2024 12:40:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA12485640;
	Tue,  5 Mar 2024 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709642429; cv=none; b=DswLCgxUWMhFlBETX84Vg1SxMfS9wB9yV7RBc4jot5WyoTbAH4j6S7pCh5Sjw77LwjHV1ud2+5tJdnqHIOt+C0hDv/6Sno6yGo4Oi6gKbPapLOWDdRyl+6+UFVIRHVaA99JJ18cY75TOYVxnY7nWb+Ct30vJbEE6kPlFmexkxZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709642429; c=relaxed/simple;
	bh=0nCnavvNQviHwSY+c1UlWiFdurAhvuqMgaFxZ6NBAZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6+1S9moEtS19wJDSoQCpipZxwrsKzCmwwlnpC1DOsxR+CQMheZKHe+A600oegJZnkDLkRD5mZyLHbbbb47gL4JMAnxfqH2yto1vgWc0mkQQJKgbgvEijDgPYFlfyN56WVHCwqY60OcXbSUMu/ZPB73ES/FuoXMUljN1ubUlm3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DE291FB;
	Tue,  5 Mar 2024 04:41:02 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.69.116])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15EF33F73F;
	Tue,  5 Mar 2024 04:40:23 -0800 (PST)
Date: Tue, 5 Mar 2024 12:40:20 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Yang Jialong =?utf-8?B?5p2o5L2z6b6Z?= <jialong.yang@shingroup.cn>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/s390/perf: Register cpumf_pmu with type =
 PERF_TYPE_RAW
Message-ID: <ZecStMBA4YgQaBEZ@FVFF77S0Q05N>
References: <20240304022701.7362-1-jialong.yang@shingroup.cn>
 <ZeWVi6pua5QVqz_y@FVFF77S0Q05N>
 <ACE696AA8DB8D91B+458ebdd8-6951-4f72-a188-b21dc9863b90@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ACE696AA8DB8D91B+458ebdd8-6951-4f72-a188-b21dc9863b90@shingroup.cn>

On Tue, Mar 05, 2024 at 09:43:16AM +0800, Yang Jialong 杨佳龙 wrote:
> 在 2024/3/4 17:34, Mark Rutland 写道:
> > On Mon, Mar 04, 2024 at 10:27:01AM +0800, JiaLong.Yang wrote:
> > > The struct pmu cpumf_pmu has handled generic events. So it need some
> > > flags to tell core this thing.
> > 
> > It's not necessary to register as PERF_TYPE_RAW in order to handle raw events,
> > and PERF_TYPE_RAW is not a flag.
> > 
> > Have you encountered a functional problem, or was this found by inspection?
> 
> As you expected, I'm trying to confirm which one pmu has the capability to
> handle generic events in registering pmus instead of test generic events in
> each pmus when opening.

If we want to do that, then we need a new flag on struct pmu to restrict which
events we try to open on a PMU.

If you want to do that, you need to Cc the perf maintainers and discuss that
rather than point-hacking individual drivers.

> We can confirm that before using. We have pay more in handling them when
> opening.
> So most driver developers use PERF_TYPE_RAW. x86 and arm use
> PERF_PMU_CAP_EXTENDED_HW_TYPE. Others use struct pmu::task_ctx_nr =
> perf_hw_context.
> I think PERF_TYPE_RAW will be a easily accepted way. So ...

No, this is a hack, and it doesn't solve the problem you describe above.

If we want to remove the need for most PMUs to look at perf_event_attr::type,
then we should have a new PERF_PMU_CAP_ flag on the PMU to say "this PMU
supports generic events" (or separate flags for the generic RAW/HW/CACHE
types), and update all relevant PMUs accordingly.

Please do not try to overload pmu::type with additional semantics; it's messy
enough as-is.

Mark. 

