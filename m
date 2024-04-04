Return-Path: <linux-kernel+bounces-131881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAC4898D1B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6FD1F258CC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD9212D1ED;
	Thu,  4 Apr 2024 17:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B8SNxWDv"
Received: from merlin.infradead.org (merlin.infradead.org [178.238.156.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F57912B82;
	Thu,  4 Apr 2024 17:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.156.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712251046; cv=none; b=IXVonOJRiFqmT6AS9OvP9Ud68uI5xjXej9HsjChFHcIrRJcLZt1ctgVqGRpaIB5TtDFod+nmIp32pP6oFnkDE5NyV6whNQlG+yXKk6JOVEogz+q1LI6QZ1ellhU5YeNfd0D4SxQyoDmNxU6S9Xd0dLR/rCAGwdqiMrmKxHTlDZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712251046; c=relaxed/simple;
	bh=gcvJrvXgQyaZQSS7uTs9ltp/mFfw8fzNyR20mYGy9vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slXKfXrPrYROWDnV1DsZpeVZ5P8RdKVeU15VI2BiJpgBq2KurRlZ1DyqJ+ddrDf3k0vypFuzedwzVuTY8Ui9CuLwIZZ9TQIZUjX9hStZayh3qgQ4E2vb5P6eIEv++3pHpfWZKgaAgLBWHZtrMx8pZYJddwFq1oqi6Ebgy9jO+wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B8SNxWDv; arc=none smtp.client-ip=178.238.156.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ScSQs4d+rDTfELeZWche4AJihoLV+Vg3lVZPViVwPu4=; b=B8SNxWDvnBeKDZ9MhqKkMekJ7O
	Zc3M1yZYlr44Cqhhwa2v9i/PAK7oIsq+fGYN296QLJqd2qALwL8FdFv6gYGtLnp39E/gob0XHZMRQ
	TxofCwl3Hw/3P2KZrP48ADqL2SGsxDCe8/H4FlxyKUbjJ6EipFf0pn7dADO10gJ06qVMcApsU9hL0
	nTXcMJZF237e/QFuUyp+urbWjhBQx8IKFa0FJSyA4Cr0Sk4ffGdhtYfORHAquxHIIGdB4RV2KczJP
	rL+qLiPA8Urp6RmT1vrItfiLI5JD87Wg6Gl62fqaST4XHWdDDFtFtUB19H38CIrXCpiqEekxGXktc
	3pNy3GtQ==;
Received: from kyle by merlin.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsQiF-00000007Pea-09Ef;
	Thu, 04 Apr 2024 17:17:19 +0000
Date: Thu, 4 Apr 2024 13:17:19 -0400
From: Kyle McMartin <kyle@infradead.org>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Kyle McMartin <kyle@infradead.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org, kernel-team@fb.com,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] therm_throt: test bits as we build
 therm_intr_core_clear_mask
Message-ID: <Zg7gn2ATm_NMiw_2@merlin.infradead.org>
References: <Zg3GhhTZotBNvlRR@merlin.infradead.org>
 <8b4cb4ad67032fad69f29df8e6b83054c7fa15db.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b4cb4ad67032fad69f29df8e6b83054c7fa15db.camel@linux.intel.com>

On Wed, Apr 03, 2024 at 06:15:47PM -0700, srinivas pandruvada wrote:
> > On Broadwell and Broadwell-DE, the HWP flag is not set, but writing
> > these bits does not trap.
> > 
> > On our Skylake-DE, Skylake, and Cooper Lake platforms, the HWP flag
> > is
> > set in CPUID, and writing 1 to these bits traps attempting to write
> > 0xAAA8 to MSR 0x19C (THERM_STATUS). Writing 0xAA8 from userspace
> > works
> > as expected to un-stick PROCHOT_LOG.
> 
> I think this issue happens only on Skylake, Cascade Lake, Cooper Lake
> and not on any other systems.
> 
> Please verify:
> GP# happens only when bit13 (Current Limit Log) or bit15 (Cross Domain
> Limit Log) is 1.
> 

Yeah, if either of the bits are set, we'll trap and fail the WRMSRL.

> Basically writing 0x2000 or 0x8000  or A000 will cause this issue.
> Are you using the latest BIOS with microcode?
> Please confirm your microcode version, I can check internally.
> 

On SkylakeDE, 6-85-4 we've got 0x2006e08 and 0x2006e05 as the most commonly
deployed microcodes. On Skylake, 6-85-4 we've got 0x2006e05 and 0x2000065.
Finally, on Cooper Lake, 6-85-11, we have 0x700001f and are in the process
of rolling out 0x7002503.

Rolling out new firmware is a pretty slow process... Since we're not
clearing those bits anywhere in the kernel we're deploying, I just
stubbed out setting BIT(13) and BIT(15) on those platforms for now while
we discuss a more durable fix.

Thanks for following up! --kyle

> Thanks,
> Srinivas
> 
> 
> > 
> > On our Sapphire Rapids platforms, the HWP flag is set, and writing 1
> > to
> > these bits is successful.
> > 
> >  drivers/thermal/intel/therm_throt.c | 29 ++++++++++++++++++++++-----
> > --
> >  1 file changed, 22 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/thermal/intel/therm_throt.c
> > b/drivers/thermal/intel/therm_throt.c
> > index e69868e868eb..3058d8fcfcef 100644
> > --- a/drivers/thermal/intel/therm_throt.c
> > +++ b/drivers/thermal/intel/therm_throt.c
> > @@ -196,8 +196,14 @@ static const struct attribute_group
> > thermal_attr_group = {
> >  static u64 therm_intr_core_clear_mask;
> >  static u64 therm_intr_pkg_clear_mask;
> >  
> > +/* Probe each addition to the mask to ensure that our wrmsrl
> > + * won't fail to clear bits.
> > + */
> >  static void thermal_intr_init_core_clear_mask(void)
> >  {
> > +       u64 bits = 0;
> > +       u64 mask = 0;
> > +
> >         if (therm_intr_core_clear_mask)
> >                 return;
> >  
> > @@ -211,25 +217,34 @@ static void
> > thermal_intr_init_core_clear_mask(void)
> >          * Bit 1, 3, 5: CPUID.01H:EDX[22] = 1. This driver will not
> >          * enable interrupts, when 0 as it checks for
> > X86_FEATURE_ACPI.
> >          */
> > -       therm_intr_core_clear_mask = (BIT(1) | BIT(3) | BIT(5));
> > +       mask = (BIT(1) | BIT(3) | BIT(5));
> >  
> >         /*
> >          * Bit 7 and 9: Thermal Threshold #1 and #2 log
> >          * If CPUID.01H:ECX[8] = 1
> >          */
> > -       if (boot_cpu_has(X86_FEATURE_TM2))
> > -               therm_intr_core_clear_mask |= (BIT(7) | BIT(9));
> > +       bits = BIT(7) | BIT(9);
> > +       if (boot_cpu_has(X86_FEATURE_TM2) &&
> > +           wrmsrl_safe(MSR_IA32_THERM_STATUS, mask | bits) >= 0)
> > +               mask |= bits;
> > +
> >  
> >         /* Bit 11: Power Limitation log (R/WC0) If CPUID.06H:EAX[4] =
> > 1 */
> > -       if (boot_cpu_has(X86_FEATURE_PLN))
> > -               therm_intr_core_clear_mask |= BIT(11);
> > +       bits = BIT(11);
> > +       if (boot_cpu_has(X86_FEATURE_PLN) &&
> > +           wrmsrl_safe(MSR_IA32_THERM_STATUS, mask | bits) >= 0)
> > +               mask |= bits;
> >  
> >         /*
> >          * Bit 13: Current Limit log (R/WC0) If CPUID.06H:EAX[7] = 1
> >          * Bit 15: Cross Domain Limit log (R/WC0) If CPUID.06H:EAX[7]
> > = 1
> >          */
> > -       if (boot_cpu_has(X86_FEATURE_HWP))
> > -               therm_intr_core_clear_mask |= (BIT(13) | BIT(15));
> > +       bits = BIT(13) | BIT(15);
> > +       if (boot_cpu_has(X86_FEATURE_HWP) &&
> > +           wrmsrl_safe(MSR_IA32_THERM_STATUS, mask | bits) >= 0)
> > +               mask |= bits;
> > +
> > +       therm_intr_core_clear_mask = mask;
> >  }
> >  
> >  static void thermal_intr_init_pkg_clear_mask(void)
> 

