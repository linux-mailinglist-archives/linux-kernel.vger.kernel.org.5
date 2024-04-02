Return-Path: <linux-kernel+bounces-128117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7C0895655
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FB941C22A6F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9222486146;
	Tue,  2 Apr 2024 14:12:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7998405F;
	Tue,  2 Apr 2024 14:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712067131; cv=none; b=N0YIKZ8DghqKfwsmFfsafLdrveWTA497EuvQkcV5rLjLCqwtZCnmf1BKEaq4arQ1dGs+Z39OF3OeGX1tjwuw3I8w0swYwT0qDnK9x3cGTm4dm97fImz1RkSP11tRDRjnRK4MI+FTtXEYMjC26yS3RZvtE9AGteRgnH2Ch7u8RNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712067131; c=relaxed/simple;
	bh=sBOdmheLZ2gGf5kKDBuAKPcg2oBCHcIwa/Kgod/gHsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oB9iZ/Qmn1MBjFyOB5xPSAlc/nW5vPnwDntfsPpPp9EEUcJHfe9NaT3ViWJ/ibA71WClVfAsz9TMvF8CuyUeIMN+X/igl08pJxxf6ziNevovgqb6wiwDRu593yWAZfehDXKMQie+4nQF/20EPLKoyDkUy4F1LjCeIKP1IKChmI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75B9A2F4;
	Tue,  2 Apr 2024 07:12:40 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E93503F64C;
	Tue,  2 Apr 2024 07:12:06 -0700 (PDT)
Date: Tue, 2 Apr 2024 15:12:04 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Mediouni, Mohamed" <mediou@amazon.de>
Cc: David Woodhouse <dwmw2@infradead.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>, "Saidi, Ali" <alisaidi@amazon.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>,
	Saket Dumbre <saket.dumbre@intel.com>
Subject: Re: [PATCH 2/2] arm64: acpi: Honour firmware_signature field of
 FACS, if it exists
Message-ID: <ZgwSNLmQw-TrDsaZ@bogus>
References: <20240312134148.727454-1-dwmw2@infradead.org>
 <20240312134148.727454-2-dwmw2@infradead.org>
 <dbd60df4632e5ea9cef13cdc1a406b47bd8629da.camel@infradead.org>
 <ZgveD6Hb2HbTNYNO@bogus>
 <70B4B352-08A5-4922-93A0-7F420374A831@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70B4B352-08A5-4922-93A0-7F420374A831@amazon.de>

On Tue, Apr 02, 2024 at 12:17:22PM +0000, Mediouni, Mohamed wrote:
> 
> > On 2. Apr 2024, at 12:29, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > 
> > I think it is OK as a temporary solution for now. But there was some
> > investigation last year as part of some work in Linaro to enable
> > "drivers/acpi/sleep.c" into the build cleaning up some x86-ness in there.
> > acpi_sleep_hibernate_setup() already does this but enabling sleep.c need
> > some careful investigation so that it doesn't break any existing arm64/x86
> > platforms and made need some wordings clarification in the ACPI spec.
> > Today system suspend work via psci std path bypassing the ACPI paths which
> > may not be ideal as none of the ACPI methods are honoured. Some arm64
> > platforms may implement them and expect to be executed in the future,
> > maybe ?
> Current Windows on Arm platforms (seen on SC8280XP) don’t have _GTS
> or _PTS methods, and don’t have sleeping objects either.
>

IMO, SC8280XP is not a very good model platform for ACPI firmware reference.
It uses PEP which Linux doesn't support for good reason and that make it
hard to follow everything on that platform.

> As such, I don’t expect any users for that potential functionality.

I am not 100% sure

> Am I missing something or hibernation signalling to firmware (on ARM64)
> can be made PSCI only indefinitely?

Also bypassing certain operation taken care in sleep.c might result in
missing certain features. Few things IIRC(might be missing things myself
or misunderstood as it has been a while since I looked at the code in
detail): handing of GPE for wakeup, power resource handling during the
resume, power button event to mention few.

--
Regards,
Sudeep

