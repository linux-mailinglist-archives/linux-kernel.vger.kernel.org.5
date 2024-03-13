Return-Path: <linux-kernel+bounces-101866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5534387AC46
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4FF0B2299D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D85D60897;
	Wed, 13 Mar 2024 16:39:31 +0000 (UTC)
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A934DA05;
	Wed, 13 Mar 2024 16:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347971; cv=none; b=KDMovb7BwjLXeAXtGFcwhf0xuQPoSebOw9sUpOdIc0lA6Icf/9BBc4+dumhUX34F1F6we1mLf9ljpsJMaBhcSEnGrdNfZCbA812GoJMaxLbR8eljYqVPlEufEK5cy59v3y4W7FhtOLVRfqWQds0lLYmALoZjhGnF55by3iGmW3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347971; c=relaxed/simple;
	bh=W6R8O4M25dj7O1UDjRAq3AUKBrOJQ+XGzWoFoLCvgPs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DkbxXeJ0Gq7DiUVvCwWHoOOUVZfqnHIyU/VaObOcXW7n3cDkubXyEdRDmSVKMAJI+O50Y1SHDgiCYtJzBJnCOSlgh4eH3SdkSAU1gylnzq2Kz4Aq1bMJz+OgtlCBNDqYtyi0uD6BeNgT2vNkwE52c2aNpW2W/M+2FfMCd2hqsXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id CA6CD40A9B; Wed, 13 Mar 2024 09:39:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id C9A8340941;
	Wed, 13 Mar 2024 09:39:21 -0700 (PDT)
Date: Wed, 13 Mar 2024 09:39:21 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
cc: Sudeep Holla <sudeep.holla@arm.com>, 
    Catalin Marinas <catalin.marinas@arm.com>, 
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
In-Reply-To: <432c1980-b00f-4b07-9e24-0bec52ccb5d6@samsung.com>
Message-ID: <173078dd-3743-2d39-a9ea-015ea5be48f8@linux.com>
References: <37099a57-b655-3b3a-56d0-5f7fbd49d7db@gentwo.org> <CGME20240308140130eucas1p1259c805a0b6491ce2f69c6fca0264b1f@eucas1p1.samsung.com> <c1f2902d-cefc-4122-9b86-d1d32911f590@samsung.com> <Ze9TsQ-qVCZMazfI@arm.com> <9352f410-9dad-ac89-181a-b3cfc86176b8@linux.com>
 <bf1757ca-6d41-87e7-53dd-56146eef5693@linux.com> <ZfCXJRJSMK4tt_Cm@arm.com> <ZfG5oyrgGOkpHYD6@bogus> <432c1980-b00f-4b07-9e24-0bec52ccb5d6@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2114933744-1710347961=:1414196"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2114933744-1710347961=:1414196
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 13 Mar 2024, Marek Szyprowski wrote:

>> I did try to trigger this on FVP by adding OPPs + some hacks to add dummy
>> clock provider to successfully probe this driver. I couldn't hit the issue
>> reported 🙁. It could be that with the hardware clock/regulator drivers, it
>> take a different path in OPP core.
>
> I can fully reproduce this issue on Khadas VIM3 and Odroid-N2 boards.
> Both Meson A311D SoC based.

Hmm... Would it trigger on Orangepi5plus? With some effort I can get that 
board up at home.

Could you reboot with some memory diagnostics so that we are sure that 
nothing gets corrupted?

F.e. specify a command line parameter "slub_debug" to enable redzoning. 
That way we may see potential memory corruption.

--8323329-2114933744-1710347961=:1414196--

