Return-Path: <linux-kernel+bounces-127729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBCC895012
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4FEC285664
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C495D47B;
	Tue,  2 Apr 2024 10:29:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756345B5D6;
	Tue,  2 Apr 2024 10:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712053783; cv=none; b=b5RtPfDTyYrh8l/vj7pKNe2H1NWqXS2n6WaR8x8tHM0NaU06NqF4G3bgeRfvp38PXPsW33pWSSUN3ZpyQq4DxICqt7aUAVv3UfO1SQ+glEVfu5Q4Qy05UnU6CIl9iTIVCAVcdw8lh4oj0zxlyWh907kjA+NQwRtRE6H2igX7WQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712053783; c=relaxed/simple;
	bh=0PLxVVExlBoCSyhGw16os7pDNVu9PcLykdvcokxzKlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhFdQb2kiZpg28fEIBeAJX7tHl4glEibNGguKyqi3OU6uwJ4k+iidZMWWJ3gP8Alt9M7lMMpVrEN/MQJRFFMJQsn9l0Sj8ap8nYSqE9BDwc2jLqvneAxGmTExrm8xr8dWEYNKK8ieVTjxEn6iPofRNgdezCPEowRBA4hHH8FS/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C811DFEC;
	Tue,  2 Apr 2024 03:30:11 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BBAE3F766;
	Tue,  2 Apr 2024 03:29:38 -0700 (PDT)
Date: Tue, 2 Apr 2024 11:29:35 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>, mediou@amazon.de, alisaidi@amazon.com,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev, Saket Dumbre <saket.dumbre@intel.com>
Subject: Re: [PATCH 2/2] arm64: acpi: Honour firmware_signature field of
 FACS, if it exists
Message-ID: <ZgveD6Hb2HbTNYNO@bogus>
References: <20240312134148.727454-1-dwmw2@infradead.org>
 <20240312134148.727454-2-dwmw2@infradead.org>
 <dbd60df4632e5ea9cef13cdc1a406b47bd8629da.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dbd60df4632e5ea9cef13cdc1a406b47bd8629da.camel@infradead.org>

On Tue, Apr 02, 2024 at 10:29:57AM +0100, David Woodhouse wrote:
> On Tue, 2024-03-12 at 13:41 +0000, David Woodhouse wrote:
> > From: David Woodhouse <dwmw@amazon.co.uk>
> > 
> > If the firmware_signature changes then OSPM should not attempt to resume
> > from hibernate, but should instead perform a clean reboot. Set the global
> > swsusp_hardware_signature to allow the generic code to include the value
> > in the swsusp header on disk, and perform the appropriate check on resume.
> > 
> > Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> 
> Ping?
> 
> > ---
> >  arch/arm64/kernel/acpi.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> > index dba8fcec7f33..e0e7b93c16cc 100644
> > --- a/arch/arm64/kernel/acpi.c
> > +++ b/arch/arm64/kernel/acpi.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/libfdt.h>
> >  #include <linux/smp.h>
> >  #include <linux/serial_core.h>
> > +#include <linux/suspend.h>
> >  #include <linux/pgtable.h>
> >  
> >  #include <acpi/ghes.h>
> > @@ -227,6 +228,15 @@ void __init acpi_boot_table_init(void)
> >                 if (earlycon_acpi_spcr_enable)
> >                         early_init_dt_scan_chosen_stdout();
> >         } else {
> > +#ifdef CONFIG_HIBERNATION
> > +               struct acpi_table_header *facs = NULL;
> > +               acpi_get_table(ACPI_SIG_FACS, 1, &facs);
> > +               if (facs) {
> > +                       swsusp_hardware_signature =
> > +                               ((struct acpi_table_facs *)facs)->hardware_signature;
> > +                       acpi_put_table(facs);
> > +               }
> > +#endif

I think it is OK as a temporary solution for now. But there was some
investigation last year as part of some work in Linaro to enable
"drivers/acpi/sleep.c" into the build cleaning up some x86-ness in there.
acpi_sleep_hibernate_setup() already does this but enabling sleep.c need
some careful investigation so that it doesn't break any existing arm64/x86
platforms and made need some wordings clarification in the ACPI spec.
Today system suspend work via psci std path bypassing the ACPI paths which
may not be ideal as none of the ACPI methods are honoured. Some arm64
platforms may implement them and expect to be executed in the future,
maybe ?

So, until that happens, I see this as an possible alternative and
temporary solution.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep

